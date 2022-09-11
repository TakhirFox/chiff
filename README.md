# chiff

В качестве менеджера зависимостей используется CocoaPods.
Верстка на UIKit, кодом, частично с Autolayout, частично с переходом на SnapKit.
Важные данные, такие как токен пользователя хранится в кейчейне. Для удобства используется SwiftKeychainWrapper.
Для кеширования изображений используется Kingfisher.

### Возможности
- Просмотр товаров
- Просмотр детальной информации товара
- Возможность добавить товар
- Возможность вести переписку
- Просмотр своего профиля, профиля продавца
- Изменение личной информации

### Известные проблемы
- При добавлении еще одного товара, не прогружаются категории на экране добавления товара
- ~~При добавлении товара, путается цена с названием~~
- Нельзя начать переписку с продавцом (для теста существует переписка с уже созданными чатами)
- Нельзя создавать нового пользователя из МП
- Редизайн
- Правильный выбор категории, при создании товара

### Планируется
- Показывать ошибки
- Добавить возможность указания адреса
- Добавить экран Карты
- Переписка с использованием протокола websocket
- Оценки пользователя
- Возможность переключения между светлым и темным режимом

## Галерея:

#### Главный экран
<img src="https://user-images.githubusercontent.com/60847855/189539469-16179b1b-cdbd-467b-b11c-11d69b3bee15.PNG" width="250" />

#### Детальная информация товара
<img src="https://user-images.githubusercontent.com/60847855/189539545-07f846e4-4dd7-40a9-8b42-d3b836f076ea.PNG" width="250" />
<img src="https://user-images.githubusercontent.com/60847855/189539546-3a5ce0bb-9b75-479f-a278-84f608bf4d75.PNG" width="250" />

#### Создание поста
<img src="https://user-images.githubusercontent.com/60847855/189539536-cbcd4c6c-343c-4bfc-a68a-0d6c90c203d7.PNG" width="250" />

#### Успешное создание поста
<img src="https://user-images.githubusercontent.com/60847855/189539530-4c6d42be-ae0a-453e-a982-b853d64fadf7.PNG" width="250" />

#### Список чатов с продавцами/покупателями
<img src="https://user-images.githubusercontent.com/60847855/189539557-4fc2bd99-2fe3-49b6-92ad-3ad427c64abe.PNG" width="250" />

#### Переписка с с продавцом/покупателем
<img src="https://user-images.githubusercontent.com/60847855/189539563-1e099e6f-0d66-4779-b450-bfda5309bed8.PNG" width="250" />

#### Профиль пользователя
<img src="https://user-images.githubusercontent.com/60847855/189539569-fb79649c-2804-4b94-8a88-2f30888f33f4.PNG" width="250" />
