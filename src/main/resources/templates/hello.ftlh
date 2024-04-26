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
        #circular-image {
            border-radius: 50%;
            width: 100px;
            height: 100px;
        }

        #image-container {
            position: absolute;
            top: 20px;
            right: 20px;
            border-radius: 50%;
        }
        #map {
          width: 80%;
          height: 80vh;
          margin-bottom: 20px;
        }

        .button-container {
          position: absolute;
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
    <form action="/newtravel" method="get">
        <button class="button">
            <svg viewBox="0 0 512 512" height="1em" xmlns="http://www.w3.org/2000/svg"><path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zm50.7-186.9L162.4 380.6c-19.4 7.5-38.5-11.6-31-31l55.5-144.3c3.3-8.5 9.9-15.1 18.4-18.4l144.3-55.5c19.4-7.5 38.5 11.6 31 31L325.1 306.7c-3.2 8.5-9.9 15.1-18.4 18.4zM288 256a32 32 0 1 0 -64 0 32 32 0 1 0 64 0z"/></svg>
            Начать новое путешествие!
        </button>
    </form>
</div>
<script>
    var longitude = parseFloat([[${longitude}]]);
    var latitude = parseFloat([[${latitude}]]);
    mapboxgl.accessToken = 'pk.eyJ1IjoiZ3JpbWNoaWsiLCJhIjoiY2x1YmlyNmJ6MGZ4MTJwcGdkMW4wajFtdyJ9.DQjm2ZXzV6ggKJCKbNdlMw';
    const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v11',
        center: [longitude, latitude],
        zoom: 10
    });

    /*const geocoder = new MapboxGeocoder({
        accessToken: mapboxgl.accessToken,
        mapboxgl: mapboxgl,
        marker: false,
        placeholder: 'Search...',
    });

    // Add the geocoder to the map
    map.addControl(geocoder);
    */
    // Add Geolocate control to the map.
    map.addControl(new mapboxgl.NavigationControl());
    map.addControl(new mapboxgl.GeolocateControl({
        positionOptions: {
            enableHighAccuracy: true
        },
        trackUserLocation: true
    }));

    let marker2;

// Добавляем обработчик события щелчка мышью на карте
    /*map.on('contextmenu', function(e) {
    // Проверяем, существует ли уже маркер
    /if (!marker2) {
        // Если маркера нет, создаем новый маркер и добавляем его на карту
        marker2 = new mapboxgl.Marker({ color: 'rgb(161, 255, 20)' })
            .setLngLat(e.lngLat)
            .addTo(map);
    } else {
        // Если маркер уже существует, обновляем его координаты
        marker2.setLngLat(e.lngLat);
    }
    });*/

    // Button click event to reset map to the initial location
    document.querySelector('.button').addEventListener('click', function() {
        map.flyTo({
            center: [longitude, latitude],
            zoom: 10
        });
    });
</script>
<div id="image-container">
    <form id="profile-form" action="/profile" method="get">
        <button type="submit" style="border: none; background: none; padding: 0; margin: 0;">
            <img id="circular-image" src="data:image/png;base64,${base64Image}" alt="avatar">
        </button>
    </form>
</div>
</body>
</html>
