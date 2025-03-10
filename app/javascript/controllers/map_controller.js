import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { hiveLat: Number, hiveLng: Number };

  connect() {
    const lat = this.hiveLatValue;
    const lng = this.hiveLngValue;

    if (!lat || !lng) {
      console.error("Invalid map coordinates");
      return;
    }

    const map = L.map(this.element).setView([lat, lng], 15);

    L.tileLayer("https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png", {
      attribution: "© <a href='https://carto.com/'>Carto</a>",
    }).addTo(map);

    L.DomUtil.addClass(map._container, 'bee-cursor-enabled');

    L.marker([lat, lng]).addTo(map)
      .bindPopup("Your Hive 🐝")
      .openPopup();

    map.on("click", (e) => {
      this.calculateDistance(e.latlng.lat, e.latlng.lng);
    });
  }

  async calculateDistance(lat, lng) {
    const response = await fetch(`/hives/distance?lat=${lat}&lng=${lng}`);
    if (response.ok) {
      const data = await response.json();
      document.querySelector("#distance-value").textContent = `${data.distance} km`;
      document.querySelector("#bee-flight-time").textContent = formatBeeFlightTime(data.bee_flight_time);
    } else {
      console.error("Failed to calculate distance");
    }
  }
}

function formatBeeFlightTime(seconds) {
  if (seconds < 60) {
    return `${seconds} seconds`;
  } else if (seconds < 3600) {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return `${minutes} minutes and ${remainingSeconds} seconds`;
  } else {
    const hours = Math.floor(seconds / 3600);
    const remainingMinutes = Math.floor((seconds % 3600) / 60);
    const remainingSeconds = seconds % 60;
    return `${hours} hours, ${remainingMinutes} minutes, and ${remainingSeconds} seconds`;
  }
}