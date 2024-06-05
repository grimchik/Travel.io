<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="utf-8" />
    <title>
        Your Travels!
    </title>
    <link rel="shortcut icon" href="/icon.jpg">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

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
        .Btn {
  display: flex;
  align-items: center;
  justify-content: flex-start;
  width: 40px;
  height: 40px;
  border: none;
  border-radius: 50%;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition-duration: 0.3s;
  box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.199);
  background-color: rgb(161, 255, 20);
}
.bg-rgb-menu {
  background-color: rgb(161, 255, 20);
}
/* plus sign */
.sign {
  width: 100%;
  transition-duration: 0.3s;
  display: flex;
  align-items: center;
  justify-content: center;
}

.sign svg {
  width: 18px;
}

.sign svg path {
  fill: black;
}
/* text */
.text {
  position: absolute;
  right: 0%;
  width: 0%;
  opacity: 0;
  color: black;
  font-size: 1.2em;
  font-weight: 600;
  transition-duration: 0.3s;
}
/* hover effect on button width */
.Btn:hover {
  width: 155px;
  border-radius: 40px;
  transition-duration: 0.3s;
}

.Btn:hover .sign {
  width: 30%;
  transition-duration: 0.3s;
  padding-left: 20px;
}
/* hover effect button's text */
.Btn:hover .text {
  opacity: 1;
  width: 70%;
  transition-duration: 0.3s;
  padding-right: 10px;
}
/* button click effect*/
.Btn:active {
  transform: translate(2px, 2px);
}
.button2 {
  width: 220px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: flex-start;
  gap: 10px;
  background-color: rgb(161, 255, 20);
  border-radius: 30px;
  color: rgb(19, 19, 19);
  font-weight: 600;
  border: none;
  position: relative;
  cursor: pointer;
  transition-duration: .2s;
  box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.116);
  padding-left: 8px;
  transition-duration: .5s;
}

.svgIcon {
  height: 25px;
  transition-duration: 1.5s;
}

.bell2 path {
  fill: rgb(19, 19, 19);
}

.button2:hover {
  background-color: rgb(192, 255, 20);
  transition-duration: .5s;
}

.button2:active {
  transform: scale(0.97);
  transition-duration: .2s;
}

.button2:hover .svgIcon {
  transform: rotate(250deg);
  transition-duration: 1.5s;
}


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
            width: 150px;
            height: 150px;
        }

        #image-container {
            position: absolute;
            top: 20px;
            right: 20px;
            border-radius: 50%;
        }
        #map {
          width: 70%;
          height: 70vh;
          margin-bottom: 10px;
          border-radius: 10px;
        }

        .button-container {
          position: absolute;
          bottom: 20px;
        }
        #profile-form {
            margin-right: 10px;
        }
        .buttonbell {
    width: 30px;
    height: 30px;
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
        .navbar-brand img {
            width: 30px;
            height: 30px;
        }

        .nav-link {
            font-family: 'Arial', sans-serif; /* Измените на нужный шрифт */
            font-size: 16px; /* Измените размер шрифта по вашему желанию */
            color: black
        }

        .nav-item + .nav-item {
            border-left: 2px solid black; /* Добавление границы слева у всех элементов, кроме первого */
            padding-left: 15px; /* Отступ слева, чтобы граница не касалась текста */
        }

        .bg-rgb-menu {
            background-color: rgb(192, 255, 20);
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <nav class="navbar navbar-expand-lg navbar-light bg-rgb-menu fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <img src="/LogoWeb.png" alt="" class="d-inline-block align-top">Voyage
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="display: flex; align-items: center;">
                    <li class="nav-item">
                        <a class="nav-link" href="/hello">Главная</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/your-travels">Ваши Путешествия</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/friends-list">Список Друзей</a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0" style="display: flex; align-items: center;">
                    <li class="nav-item">
                        <button id="showRequestsButton" class="buttonbell">
                            <svg viewBox="0 0 448 512" class="bell"><path d="M224 0c-17.7 0-32 14.3-32 32V49.9C119.5 61.4 64 124.2 64 200v33.4c0 45.4-15.5 89.5-43.8 124.9L5.3 377c-5.8 7.2-6.9 17.1-2.9 25.4S14.8 416 24 416H424c9.2 0 17.6-5.3 21.6-13.6s2.9-18.2-2.9-25.4l-14.9-18.6C399.5 322.9 384 278.8 384 233.4V200c0-75.8-55.5-138.6-128-150.1V32c0-17.7-14.3-32-32-32zm0 96h8c57.4 0 104 46.6 104 104v33.4c0 47.9 13.9 94.6 39.7 134.6H72.3C98.1 328 112 281.3 112 233.4V200c0-57.4 46.6-104 104-104h8zm64 352H224 160c0 17 6.7 33.3 18.7 45.3s28.3 18.7 45.3 18.7s33.3-6.7 45.3-18.7s18.7-28.3 18.7-45.3z"></path></svg>
                        </button>
                    </li>
                    <li class="nav-item" style="margin-right: auto;">
                        <form id="profile-form" action="/profile" method="get" style="display: flex; align-items: center;">
                            <button type="submit" class="btn" style="border: none; background: none; padding: 0; margin: 0;" disabled>
                                <img id="circular-image" src="data:image/png;base64,${base64Image}" alt="avatar" style="width: 50px; height: 50px;">
                            </button>
                            <a class="nav-link" href="/profile">Профиль</a>
                        </form>
                    </li>
                    <li class="nav-item">
                        <form action="/logout" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button class="btn" type="submit">
                                <div class="sign">
                                    <svg viewBox="0 0 512 512">
                                        <path d="M377.9 105.9L500.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L377.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1-128 0c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM160 96L96 96c-17.7 0-32 14.3-32 32l0 256c0 17.7 14.3 32 32 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32l-64 0c-53 0-96-43-96-96L0 128C0 75 43 32 96 32l64 0c17.7 0 32 14.3 32 32s-14.3 32-32 32z"></path>
                                    </svg>
                                </div>
                                <div class="text">Logout</div>
                            </button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-6">
            <h2>Ваши Путешествия</h2>
            <table class="table">
                <thead>
                <tr>
                    <th>Название</th>
                    <th>Администратор</th>
                    <th>Количество участников</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <#list travels as trip>
                <tr>
                    <td><a href="/travel/${trip.name}">${trip.name}</a></td>
                    <td>${trip.administrator}</td>
                    <td>${trip.count}</td>
                    <td>
                        <form action="/delete-travel" method="get">
                            <input type="hidden" name="travelId" value="${trip.name}" />
                            <button type="submit" class="btn btn-danger">Удалить Путешествие</button>
                        </form>
                    </td>
                </tr>
                </#list>
                </tbody>
            </table>
        </div>
    </div>
</div>
<div id="requestsModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <div id="requestsList"></div>
    </div>
</div>

<!-- Подключение необходимых JS файлов -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<script>
    document.querySelector('.buttonbell').addEventListener('click', function() {
        console.log("CHECK");
        fetchFriendInvitations();
    });

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
        requestsList.innerHTML = ''; // Очистка списка перед добавлением новых элементов
        data.forEach(request => {
            const requestItem = document.createElement('div');
            const senderName = request.login;
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