<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Demo: Local search with the Geocoding API</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://api.tiles.mapbox.com/mapbox-gl-js/v3.1.0/mapbox-gl.js"></script>
    <link
            href="https://api.tiles.mapbox.com/mapbox-gl-js/v3.1.0/mapbox-gl.css"
            rel="stylesheet"
    />
    <script src="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v4.7.0/mapbox-gl-geocoder.min.js"></script>
    <link
            rel="stylesheet"
            href="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-geocoder/v4.7.0/mapbox-gl-geocoder.css"
            type="text/css"
    />
    <style>
        body {
          margin: 0;
          padding: 0;
          display: flex;
          flex-direction: column;
          height: 100vh;
          justify-content: center;
          align-items: center;
        }

        #map {
          width: 50%;
          height: 80vh;
          margin-bottom: 20px;
          margin-right: 420px;
       }

        .button-container {
          position: absolute;
          margin-bottom: 10px;
          bottom: 20px;
        }

        .button {
            width: 200px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: rgb(161, 255, 20);
            border-radius: 30px;
            color: rgb(19, 19, 19);
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition-duration: .2s;
            box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.116);
            font-size: 14px;
            display: block;
            margin-bottom: 5px;
        }

        .button:hover {
            background-color: rgb(192, 255, 20);
            transition-duration: .5s;
        }

        .button:active {
            transform: scale(0.97);
            transition-duration: .2s;
        }
    </style>
</head>
<body>
<div id="map"></div>
<div class="button-container">
    <button id="addMarkerButton" class="button">Добавить маркер</button>
    <button id="buildRouteButton" class="button">Построить маршрут</button>
</div>
<script>
    let markersArray = [];
    var longitude = parseFloat([[${longitude}]]);
    var latitude = parseFloat([[${latitude}]]);
    mapboxgl.accessToken = 'pk.eyJ1IjoiZ3JpbWNoaWsiLCJhIjoiY2x1YmlyNmJ6MGZ4MTJwcGdkMW4wajFtdyJ9.DQjm2ZXzV6ggKJCKbNdlMw';
    const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v11',
        center: [longitude, latitude],
        zoom: 10
    });
    const geocoder = new MapboxGeocoder({
        accessToken: mapboxgl.accessToken,
        mapboxgl: mapboxgl,
        marker: false,
        placeholder: 'Search...',
    });
    map.addControl(geocoder);
    map.addControl(new mapboxgl.NavigationControl());
    map.addControl(new mapboxgl.GeolocateControl({
        positionOptions: {
            enableHighAccuracy: true
        },
        trackUserLocation: true
    }));

    let marker2;

    map.on('contextmenu', function(e) {
    if (!marker2) {
        marker2 = new mapboxgl.Marker({ color: 'rgb(161, 255, 20)' })
            .setLngLat(e.lngLat)
            .addTo(map);
    } else {
        marker2.setLngLat(e.lngLat);
    }
    });
    document.getElementById('addMarkerButton').addEventListener('click', function() {
    const newMarker = new mapboxgl.Marker({ color: 'rgb(161, 255, 20)' })
        .setLngLat(marker2.getLngLat())
        .addTo(map);
    markersArray.push(marker2.getLngLat());
    console.log('Массив координат маркеров:', markersArray);
    });

    function getCoordinates() {
    let coordinates = "";
        if (markersArray.length < 2) {
            console.log('Для построения маршрута необходимо как минимум два маркера');
            return coordinates;
        }
        console.log(markersArray.length);
        if (markersArray.length >= 2) {
            for (let i = 0; i < markersArray.length; i++) {
                coordinates += markersArray[i].lng + ',' + markersArray[i].lat;
                if (i !== markersArray.length - 1) {
                    coordinates += ';';
                }
            }
        }
        return coordinates;
    }
    async function getRoute() {
    console.log('Количество маркеров:', markersArray.length);
    if (markersArray.length < 2) {
        console.log('Для построения маршрута необходимо как минимум два маркера');
        return;
    }

    try {
        for (let i = 0; i < markersArray.length - 1; i++) {
            const query = await fetch(
                'https://api.mapbox.com/directions/v5/mapbox/driving/' +
                markersArray[i].lng + ',' + markersArray[i].lat + ';' +
                markersArray[i + 1].lng + ',' + markersArray[i + 1].lat +
                '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken,
                { method: 'GET' }
            );
            const json = await query.json();
            const data = json.routes[0];
            const route = data.geometry.coordinates;
            const geojson = {
                type: 'Feature',
                properties: {},
                geometry: {
                    type: 'LineString',
                    coordinates: route
                }
            };
            if (map.getSource('route' + i)) {
                map.getSource('route' + i).setData(geojson);
            } else {
                map.addLayer({
                    id: 'route' + i,
                    type: 'line',
                    source: {
                        type: 'geojson',
                        data: geojson
                    },
                    layout: {
                        'line-join': 'round',
                        'line-cap': 'round'
                    },
                    paint: {
                        'line-color': '#3887be',
                        'line-width': 5,
                        'line-opacity': 0.75
                    }
                });
            }
        }
    } catch (error) {
        console.error('Ошибка при построении маршрута:', error);
        alert('Ошибка при построении маршрута. Невозможно построить маршрут!');
    }
}


    document.getElementById('buildRouteButton').addEventListener('click', getRoute);
</script>
</body>
</html>