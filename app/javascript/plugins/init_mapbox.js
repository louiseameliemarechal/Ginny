import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  // Create the map & center it
  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      // style: 'mapbox://styles/mapbox/light-v11',
      style: 'mapbox://styles/melaurore/ckp484rvd83wp18k8nuf0zqfx',
      // center: [-90.96, -0.47],
      center: [2.35, 48.85],
      // Paris coordinates
      zoom: 11
    });

    const markers = JSON.parse(mapElement.dataset.markers);

    if (markers.length === 0) return;
    markers.forEach((marker) => {
       // Place the markers on the map
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);
      const el = document.createElement('div') ;
      el.className = marker.icon ;
      new mapboxgl.Marker(el)
      .setLngLat([marker.longitude, marker.latitude])
      .setPopup(popup)
      .addTo(map);
    });
    addGeolocMarker(map)
    // fitMapToMarkers(map, markers);
  }

};

// Add the geolocalisation button
const addGeolocMarker = (map) => {
  map.addControl(
    new mapboxgl.GeolocateControl({
      positionOptions: {
        enableHighAccuracy: true
      },
      fitBoundsOptions: { maxZoom: 13 },
      trackUserLocation: true
    })
  )
};


const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([marker.longitude, marker.latitude]));
  map.fitBounds(bounds, { padding: 0, maxZoom: 10, duration: 0 });
};


export { initMapbox };


