<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        #circular-image {
border-radius: 50%;
width: 100px;
height: 100px;
}

#image-container {
position: absolute;
margin-left: auto;
margin-right: auto;
border-radius: 50%;
}
.Btn {
position: relative;
display: flex;
align-items: center;
justify-content: flex-start;
width: 100px;
height: 40px;
border: none;
padding: 0px 20px;
background-color: rgb(168, 38, 255);
color: white;
font-weight: 500;
cursor: pointer;
border-radius: 10px;
box-shadow: 5px 5px 0px rgb(140, 32, 212);
transition-duration: .3s;
}

.svg {
width: 13px;
position: absolute;
right: 0;
margin-right: 20px;
fill: white;
transition-duration: .3s;
}

.Btn:hover {
color: transparent;
}

.Btn:hover svg {
right: 43%;
margin: 0;
padding: 0;
border: none;
transition-duration: .3s;
}

.Btn:active {
transform: translate(3px , 3px);
transition-duration: .3s;
box-shadow: 2px 2px 0px rgb(140, 32, 212);
}
.modal {
display: none; /* По умолчанию скрыто */
position: fixed;
z-index: 1;
left: 0;
top: 0;
width: 100%;
height: 100%;
overflow: auto;
background-color: rgba(0,0,0,0.4); /* Черный цвет с непрозрачностью 40% */
}

.modal-content {
background-color: #fefefe;
margin: 15% auto;
padding: 20px;
border: 1px solid #888;
width: 80%;
}

/* Кнопка закрытия модального окна */
.close {
color: #aaaaaa;
float: right;
font-size: 28px;
font-weight: bold;
}

.close:hover,
.close:focus {
color: #000;
text-decoration: none;
cursor: pointer;
}
    </style>
</head>
<body>
<div id="image-container">
    <img id="circular-image" src="data:image/png;base64,${base64Image}" alt="avatar">
</div>
<button class="Btn">Edit
    <svg class="svg" viewBox="0 0 512 512">
        <!-- SVG иконка здесь -->
    </svg>
</button>
<button class="button" onclick="openSearchModal()">
    Добавить друга!
</button>

<!-- Модальное окно для поиска пользователя -->
<div id="searchModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeSearchModal()">&times;</span>
        <form id="searchForm" onsubmit="searchUser(); return false;">
            <input type="text" id="searchInput" placeholder="Введите логин пользователя">
            <button type="submit">Искать</button>
        </form>
        <div id="searchResults"></div>
    </div>
</div>

<script>
    // Функция для открытия модального окна
    function openSearchModal() {
        document.getElementById('searchModal').style.display = 'block';
    }

    // Функция для закрытия модального окна
    function closeSearchModal() {
        document.getElementById('searchModal').style.display = 'none';
    }

    // Функция для отправки запроса на поиск пользователя
    function searchUser() {
        var searchInput = document.getElementById('searchInput').value;
        fetch('/search?query=' + searchInput)
            .then(response => response.json())
            .then(data => {
                document.getElementById('searchResults').innerHTML = '';
                data.forEach(function(user) {
                    var userElement = document.createElement('div');
                    userElement.innerHTML = user.username;
                    var addButton = document.createElement('button');
                    addButton.textContent = 'Добавить в друзья';
                    addButton.onclick = function() {
                        addFriend(user.username);
                    };
                    userElement.appendChild(addButton); // Добавляем кнопку к элементу пользователя
                    document.getElementById('searchResults').appendChild(userElement); // Добавляем пользователя на страницу
                });
            })
            .catch(error => console.error('Ошибка при выполнении поиска:', error));
    }

    // Функция для отправки запроса на добавление друга
    function addFriend(username) {
    var csrfTokenValue = "${_csrf.token}";
        fetch('/addFriend', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': csrfTokenValue
            },
            body: JSON.stringify({
                username: username,
            }),
        })
        .then(response => {
            if (response.ok) {
                alert('Отправлена заявка пользователю ' + username + ' для добавления в друзья!');
            } else {
                alert('Не удалось отправить заявку пользователю ' + username + ' для добавления в друзья.');
            }
        })
        .catch(error => console.error('Ошибка при отправке запроса:', error));
    }
</script>
</body>
</html>