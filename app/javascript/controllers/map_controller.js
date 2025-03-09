import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { hiveLat: Number, hiveLng: Number };

  connect() {
    // const lat = parseFloat(this.element.dataset.mapLat);
    // const lng = parseFloat(this.element.dataset.mapLng);
    const lat = this.hiveLatValue;
    const lng = this.hiveLngValue;
    console.log(lat, lng);

    if (!lat || !lng) {
      console.error("Invalid map coordinates");
      return;
    }

    const map = L.map(this.element).setView([lat, lng], 15);
    console.log(map);

    L.tileLayer("https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png", {
      attribution: "© <a href='https://carto.com/'>Carto</a>",
    }).addTo(map);

    L.DomUtil.addClass(map._container,'bee-cursor-enabled');

    L.marker([lat, lng]).addTo(map)
      .bindPopup("Your Hive 🐝")
      .openPopup();
    
    map.on("click", (e) => {
      this.calculateDistance(e.latlng.lat, e.latlng.lng);
    });
    // const hiveIcon = L.icon({
    //   iconUrl: "/assets/hive.svg",
    //   iconSize: [32, 32], // Size in pixels
    //   iconAnchor: [16, 32], // Where the "tip" of the icon is
    //   popupAnchor: [0, -32], // Adjusts popup position
    // });
    
    // L.marker([lat, lng], { icon: hiveIcon }).addTo(map)
    //   .bindPopup("Your Hive 🐝")
    //   .openPopup();
  }

  async calculateDistance(lat, lng) {
    const response = await fetch(`/hives/distance?lat=${lat}&lng=${lng}`);
    if (response.ok) {
      const data = await response.json();
      document.querySelector("#distance-value").textContent = `${data.distance} km`;
      document.querySelector("#bee-flight-time").textContent = `${data.bee_flight_time} seconds`;
    } else {
      console.error("Failed to calculate distance");
    }
  }
}
