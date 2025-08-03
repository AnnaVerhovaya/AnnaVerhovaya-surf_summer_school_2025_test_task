

https://github.com/user-attachments/assets/c72cbdc4-4009-4a38-b47d-dc3bc07ccf20

# 🌍 Places Explorer

<img src="https://img.shields.io/badge/Flutter-3.13.9-blue?logo=flutter" alt="Flutter Version">
<img src="https://img.shields.io/badge/Dart-3.1.5-blue?logo=dart" alt="Dart Version">
<img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-green" alt="Architecture">

Мобильное приложение для просмотра интересных мест с возможностью добавления в избранное и просмотра карты. Разработано в рамках тестового задания.

## 🏗 Архитектура

```plaintext
lib/
├── core/           # Общие утилиты и константы
├── data/           # Работа с данными
│   ├── database/   # Локальное хранилище
│   └── http/       # Сетевые запросы
├── domain/         # Бизнес-логика
│   └── interfaces/ # Абстракции
├── di/             # DI контейнер
└── features/       # Фичи приложения
    ├── favorites/  # Избранное
    ├── places/     # Список мест
    └── map/        # Карта

## 🛠 Технологии

### Основные пакеты

| Пакет               | Назначение                     | Версия       |
|---------------------|--------------------------------|--------------|
| `flutter_bloc`      | Управление состоянием          | ^9.1.1       |
| `auto_route`        | Навигация                      | ^10.1.0+1    |
| `yandex_mapkit`     | Интерактивные карты            | ^4.1.0       |
| `sqflite`           | Локальная база данных SQLite   | ^2.4.2       |
| `dio`               | HTTP-клиент для API запросов   | ^5.8.0+1     |


### Ключевые особенности

✔ **Чистая архитектура** с разделением на слои  
✔ **Работа с картами** через Yandex MapKit  
✔ **Оффлайн-режим** с SQLite и синхронизацией  
