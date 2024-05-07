<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Hello, ${username}!</title>
    <link rel="shortcut icon" href="/icon.jpg">
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
        /* Стили для модального окна */
.modal {
    display: none; /* по умолчанию скрыто */
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgb(0,0,0);
    background-color: rgba(0,0,0,0.4);
}

.modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
}

.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

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
        #profile-form {
            margin-right: 10px; /* добавьте отступ справа, чтобы разделить кнопки */
        }
        .buttonbell {
    width: 50px;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: rgb(44, 44, 44);
    border-radius: 50%;
    cursor: pointer;
    transition-duration: .3s;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.13);
    border: none;
}

.bell {
    width: 18px;
}

.bell path {
    fill: white;
}

.buttonbell:hover {
    background-color: rgb(56, 56, 56);
}

.buttonbell:hover .bell {
    animation: bellRing 0.9s both;
}

/* bell ringing animation keyframes*/
@keyframes bellRing {
    0%,
    100% {
        transform-origin: top;
    }

    15% {
        transform: rotateZ(10deg);
    }

    30% {
        transform: rotateZ(-10deg);
    }

    45% {
        transform: rotateZ(5deg);
    }

    60% {
        transform: rotateZ(-5deg);
    }

    75% {
        transform: rotateZ(2deg);
    }
}

.buttonbell:active {
    transform: scale(0.8);
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
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" style="text-align: center; width: 100%" >
            Выйти из аккаунта
        </button>
    </form>
</div>
<div id="requestsModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <div id="requestsList"></div>
    </div>
</div>
<div id="image-container">
    <form id="profile-form" action="/profile" method="get">
        <button type="submit" style="border: none; background: none; padding: 0; margin: 0;">
            <img id="circular-image" src="data:image/png;base64,${base64Image}" alt="avatar">
        </button>
    </form>
    <button id="showRequestsButton" class="buttonbell">
        <svg viewBox="0 0 448 512" class="bell"><path d="M224 0c-17.7 0-32 14.3-32 32V49.9C119.5 61.4 64 124.2 64 200v33.4c0 45.4-15.5 89.5-43.8 124.9L5.3 377c-5.8 7.2-6.9 17.1-2.9 25.4S14.8 416 24 416H424c9.2 0 17.6-5.3 21.6-13.6s2.9-18.2-2.9-25.4l-14.9-18.6C399.5 322.9 384 278.8 384 233.4V200c0-75.8-55.5-138.6-128-150.1V32c0-17.7-14.3-32-32-32zm0 96h8c57.4 0 104 46.6 104 104v33.4c0 47.9 13.9 94.6 39.7 134.6H72.3C98.1 328 112 281.3 112 233.4V200c0-57.4 46.6-104 104-104h8zm64 352H224 160c0 17 6.7 33.3 18.7 45.3s28.3 18.7 45.3 18.7s33.3-6.7 45.3-18.7s18.7-28.3 18.7-45.3z"></path></svg>
    </button>
</div>
<script>
    var username = "UserNickname";
    var titleElement = document.getElementById("username");
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
    // Добавляем обработчик события на клик по кнопке
// Добавляем обработчик события на клик по кнопке
document.getElementById('showRequestsButton').addEventListener('click', function() {
    fetchFriendInvitations();
});

// Добавляем обработчик события на нажатие клавиши Enter
document.addEventListener('keypress', function(event) {
    if (event.key === 'Enter') {
        fetchFriendInvitations();
    }
});

// Функция для получения приглашений в друзья
function fetchFriendInvitations() {
    fetch('/friend-invitations')
        .then(response => response.json())
        .then(data => {
            displayRequests(data);
        })
        .catch(error => {
            console.error('Error fetching friend invitations:', error);
        });
}

function displayRequests(data) {
    console.log(data);
    var csrfTokenValue = "${_csrf.token}";
    const requestsList = document.getElementById('requestsList');
    data.forEach(request => {
        const requestItem = document.createElement('div');
        const senderName = request.login;
        requestsList.innerHTML = '';
        requestItem.textContent = senderName + ' хочет добавить вас в друзья.';

        // Создаем кнопку "Добавить в друзья"
        const addButton = document.createElement('button');
        addButton.textContent = 'Добавить в друзья';
        addButton.addEventListener('click', function() {
            fetch('/accept-friend', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': csrfTokenValue
                },
                body: JSON.stringify({ friendUsername: request.login })
            })
            .then(response => {
                if (response.ok) {
                    console.log('Пользователь ' + request.login + ' добавлен в друзья.');
                    addButton.style.display = 'none';
                    rejectButton.style.display = 'none';
                    // Показываем сообщение
                    const message = document.createElement('span');
                    message.textContent = 'Пользователь ' + request.login + ' добавлен в друзья.';
                    requestItem.appendChild(message);
                    // Здесь можно обновить интерфейс, например, удалить элемент списка приглашений
                    // requestsList.removeChild(requestItem);
                } else {
                    console.error('Ошибка при добавлении в друзья:', response.statusText);
                }
            })
            .catch(error => {
                console.error('Ошибка при отправке запроса:', error);
            });
        });

        // Создаем кнопку "Не добавлять"
        const rejectButton = document.createElement('button');
        rejectButton.textContent = 'Не добавлять';
        rejectButton.addEventListener('click', function() {
            fetch('/reject-invitation', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': csrfTokenValue
                },
                body: JSON.stringify({ friendUsername: request.login })
            })
            .then(response => {
                if (response.ok) {
                    console.log('Приглашение от ' + request.login + ' отклонено.');
                    // Скрываем кнопки после нажатия
                     addButton.style.display = 'none';
                     rejectButton.style.display = 'none';
                     // Показываем сообщение
                     const message = document.createElement('span');
                     message.textContent = 'Приглашение от ' + request.login + ' отклонено.';
                    requestItem.appendChild(message);
                    } else {
                    console.error('Ошибка при отклонении приглашения:', response.statusText);
                }
            })
            .catch(error => {
                console.error('Ошибка при отправке запроса:', error);
            });
        });

        requestItem.appendChild(addButton);
        requestItem.appendChild(rejectButton);
        requestsList.appendChild(requestItem);
    });

    // Отображаем модальное окно
    const modal = document.getElementById('requestsModal');
    modal.style.display = 'block';

    // Добавляем обработчик события для закрытия модального окна при клике на кнопку закрытия
    const closeBtn = document.getElementsByClassName('close')[0];
    closeBtn.onclick = function() {
        modal.style.display = 'none';
    };

    // Добавляем обработчик события для закрытия модального окна при клике вне его
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = 'none';
        }
    };
}

</script>
</body>
</html>
