import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/melaurore/ckp484rvd83wp18k8nuf0zqfx',
    });


    const markers = JSON.parse(mapElement.dataset.markers);

    if (markers.length === 0) return;
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window); // add this
      new mapboxgl.Marker()
      .setLngLat([marker.longitude, marker.latitude])
      .setPopup(popup) // add this
      .addTo(map);
    });
    addGeolocMarker(map)
    fitMapToMarkers(map, markers);
  }
};

const addGeolocMarker = (map) => {
  map.addControl(
    new mapboxgl.GeolocateControl({
      positionOptions: {
        enableHighAccuracy: true
      },
      fitBoundsOptions: { maxZoom: 8 },
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


