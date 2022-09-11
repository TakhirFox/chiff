# chiff

В качестве менеджера зависимостей используется CocoaPods.
Верстка на UIKit, кодом, частично с Autolayout, частично с переходом на SnapKit.
Важные данные, такие как токен пользователя хранится в кейчейне. Для удобства используется SwiftKeychainWrapper.
Для кеширования изображений используется Kingfisher.

Возможности
- Просмотр товаров
- Просмотр детальной информации товара
- Возможность добавить товар
- Возможность вести переписку
- Просмотр своего профиля, профиля продавца
- Изменение личной информации

Известные проблемы
- При добавлении еще одного товара, не прогружаются категории на экране добавления товара
~~- При добавлении товара, путается цена с названием~~
- Нельзя начать переписку с продавцом (для теста существует переписка с уже созданными чатами)
- Нельзя создавать нового пользователя из МП
- Редизайн
- Правильный выбор категории, при создании товара

Планируется
- Показывать ошибки
- Добавить возможность указания адреса
- Добавить экран Карты
- Переписка с использованием протокола websocket
- Оценки пользователя