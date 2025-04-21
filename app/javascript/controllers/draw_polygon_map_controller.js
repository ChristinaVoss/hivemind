import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    hiveLat: Number,
    hiveLng: Number,
    points: [[Number]]
  }

  static targets = ["map", "saveButton"]

  connect() {
    this.points = [] // for display only. pointsValue is the one that will be sent to the server

    this.map = L.map(this.mapTarget).setView([this.hiveLatValue, this.hiveLngValue], 15)

    L.tileLayer("https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png", {
      attribution: '&copy; OpenStreetMap & CartoDB'
    }).addTo(this.map)

    // If a user clicks the map, add a point for that location to the points array
    this.map.on("click", (e) => this.addPoint(e.latlng))
  }

  addPoint(latlng) {
    // Store the point in the pointsValue array (for use in save)
    this.pointsValue.push([latlng.lat, latlng.lng])

    // Add point to the map to display for user as they draw
    this.points.push([latlng.lat, latlng.lng])

    // Add marker to the map
    const marker = L.marker([latlng.lat, latlng.lng]).addTo(this.map)

    if (this.polygon) {
      this.map.removeLayer(this.polygon)
    }

    // Draw the polygon with the points on the map
    this.polygon = L.polygon(this.points, { color: "purple" }).addTo(this.map)
  }

  save(event) {
    event.preventDefault()

    if (this.pointsValue.length < 4) {
      // Initial point in the array is undefined, so the array must have 3 valid points plus the undefined one (which we will remove)
      alert("A flower patch must have at least 3 points.")
      return
    }

    this.pointsValue.shift() // Remove the first point (the one that was clicked to create the polygon)
    this.pointsValue.push(this.pointsValue[0]) // Close the polygon by adding the first point again

    const geojson = {
      type: "Polygon",
      coordinates: [this.pointsValue.map(([lat, lng]) => [lng, lat])] // GeoJSON uses [lng, lat]
    }

    // Send the points to the server (POST to /flower_patches, so create method in the controller)
    fetch("/flower_patches", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content")
      },
      body: JSON.stringify({ flower_patch: { area: geojson } })
    }).then(response => {
      if (response.ok) {
        console.log("Flower patch saved successfully");
        window.location.href = "/dashboard";
      } else {
        response.json().then(data => {
          alert(`Failed to save flower patch: ${data.errors.join(", ")}`);
        });
      }
    });
  }
}
