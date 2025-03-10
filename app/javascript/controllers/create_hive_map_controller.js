import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["map", "button"];
  static values = { lat: Number, lng: Number };

  connect() {
    this.map = L.map(this.mapTarget).setView([54.5, -4], 5);

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: '© OpenStreetMap contributors'
    }).addTo(this.map);

    this.map.on("click", (e) => {
      this.latValue = e.latlng.lat;
      this.lngValue = e.latlng.lng;
      if (this.marker) {
        this.map.removeLayer(this.marker);
      }
      this.marker = L.marker([this.latValue, this.lngValue]).addTo(this.map);
    });

    this.buttonTarget.addEventListener("click", () => this.saveHiveLocation());
  }

  async saveHiveLocation() {
    console.log("Saving hive location:", this.latValue, this.lngValue);
    const response = await fetch("/hives", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content")
      },
      body: JSON.stringify({ hive: { location: [this.lngValue, this.latValue] } })
    });

    if (response.ok) {
      console.log("Hive location saved successfully");
      window.location.href = "/hives";
    } else {
      console.error("Failed to save hive location");
    }
  }
}