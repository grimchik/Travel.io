<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        #image-container {
            text-align: center;
            margin-bottom: 20px;
        }

        #circular-image {
            border-radius: 50%;
            width: 100px;
            height: 100px;
        }
        .user-container {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
}

.avatar-container {
    margin-right: 10px;
}

.avatar {
    width: 50px;
    height: 50px;
    border-radius: 50%;
}

.username-container p {
    margin: 0;
    font-size: 16px;
}

.button-container {
    margin-left: auto;
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
            margin-bottom: 20px;
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

        .button {
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin-top: 20px;
            cursor: pointer;
        }
        #file-input {
            display: none;
        }

    </style>
</head>
<body>
<div id="image-container">
    <img id="circular-image" src="data:image/png;base64,${base64Image}" alt="avatar">
</div>


<button class="Btn" onclick="document.getElementById('file-input').click();">Edit
    <svg class="svg" viewBox="0 0 512 512">
        <!-- SVG иконка здесь -->
    </svg>
</button>
<!-- Элемент input для загрузки файла -->
<input type="file" id="file-input" accept="image/*" onchange="uploadImage(this.files)">
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
<div id="friends-list"></div>
<script>
    window.onload = function() {
        loadFriendsList();
    };

    function loadFriendsList() {
        fetch('/get_friends')
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('Failed to fetch friends list');
                }
            })
            .then(data => {
                displayFriends(data);
            })
            .catch(error => {
                console.error('Error loading friends list:', error);
                alert('Failed to load friends list');
            });
    }

    function displayFriends(friends) {
        var friendsListContainer = document.getElementById('friends-list');
        friends.forEach(function(friend) {
            var friendElement = document.createElement('div');
            friendElement.classList.add('friend');
            friendElement.innerHTML = '<div class="avatar-container">' +
                '<img class="avatar" src="data:image/jpeg;base64,' + friend.image + '" alt="Avatar">' +
                '</div>' +
                '<div class="username-container">' +
                '<p><a href="/profile/' + friend.login + '">' + friend.login + '</a></p>' +
                '</div>';
            friendsListContainer.appendChild(friendElement);
        });
    }
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
        .then(response => {
            console.log('Response status:', response.status);
            return response.json();
        })
        .then(data => {
            console.log('Data received from server:', data);
            document.getElementById('searchResults').innerHTML = '';
            data.forEach(function(user) {
                var userElement = document.createElement('div');
                userElement.innerHTML = '<div class="user-container">' +
                    '<div class="avatar-container">' +
                    '<img class="avatar" src="data:image/jpeg;base64,' + user.image + '" alt="Avatar">' +
                    '</div>' +
                    '<div class="username-container">' +
                    '<p>' + user.login + '</p>' +
                    '</div>' +
                    '<div class="button-container">' +
                    '<button class="add-button" onclick="addFriend(\'' + user.login + '\')">Добавить в друзья</button>' +
                    '</div>' +
                    '</div>';
                document.getElementById('searchResults').appendChild(userElement);
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
    function uploadImage(files) {
    var csrfTokenValue = "${_csrf.token}";
    var file = files[0];
    var reader = new FileReader();
    reader.onload = function(e) {
        document.getElementById('circular-image').src = e.target.result;
        // Теперь здесь нужно отправить файл на бэкенд
        var formData = new FormData();
        formData.append('avatar', file);
        fetch('/upload-avatar', {
            method: 'POST',
            body: formData,
            headers: {
                'X-CSRF-TOKEN': csrfTokenValue
            }
        })
        .then(response => {
            if (response.ok) {
                alert('Avatar uploaded successfully');
            } else {
                alert('Failed to upload avatar');
            }
        })
        .catch(error => {
            console.error('Error uploading avatar:', error);
            alert('Failed to upload avatar');
        });
    };
    reader.readAsDataURL(file);
}

</script>
</body>
</html>
