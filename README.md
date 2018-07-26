# Приложение "Мой сад"

![Готовый экран](https://github.com/alexfilimon/My-garden/blob/master/info/images/mainScreen.png)

Это приложение создано во время обучения в школе SurfEducation iOS.

### Главный функционал приложения:
- напоминания о поливе растений

### Дополнительные функции:
- поиск через API информации о растении
- поиск через API картинок растений
- фотографии растения
- пользовательская информация о растении
  - дата посадки
  - предпочитаемое время полива (утро/вечер)
  - возраст цветка
  - вид цветка

### Техническая информация:
- разработка велась в xCode 10 beta (но проект сохранялся в xCode 9.3 совместимости)
- Навигация: `TabBarController -> NavigationController -> ViewController`
- Изменение цвета StatusBar - `UIApplication.shared.statusBarView?.backgroundColor` (statusBarView - extension для AppDelegate)
- Изменение стиля StatusBar - `UIApplication.shared.statusBarStyle = .default` / `.lightContent` - deprecated since iOS 9.0 , но предложенный Apple метод не работал
- Расписание хранилось в строке, и вся работа с ним велась с кастомным классом `Scedule`, который парсил/распарсивал строку и приводил ее в печатный вид
- В изменениии/добавлении цветка использовались кастомные класиатуры с `datePicker` с помощью метода `textField.inputView`, а так же кастомный toolBar над клавиатурой с помощью метода `textField.inputAccessoryView`

## Что дальше?
- сделать прослойку между Realm и приложением - `PlantEntity` и `PlantImageEntity` (начато в ветке `addEntityModel`)
- добавить UserArea и настройки (сейчас есть UserAreaController без реализации)

## Используемые модули:
- [Realm](https://github.com/realm/realm-cocoa) - база данных
- [SKPhotoBrowser](https://github.com/suzuki-0000/SKPhotoBrowser) - просмотрщик фото
- [Alamofire](https://github.com/Alamofire/Alamofire) - запросы к API
- [SDWebImage](https://github.com/rs/SDWebImage) - загрузка фото по ссылке

## Дизайн приложения:
![Главный экран приложения](https://cdn.dribbble.com/users/242402/screenshots/4481432/dribbble_post.png "Главный экран")
![Экран настроек приложения](https://cdn.dribbble.com/users/242402/screenshots/4171362/potted_setting.png "Настройки")

Дизайнер: [Judah Guttmann](https://dribbble.com/guttmnn)
