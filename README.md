# Rock 'n' Roll Racing Clone

Web-first клон [Rock 'n' Roll Racing](https://ru.wikipedia.org/wiki/Rock_n%E2%80%99_Roll_Racing) (Blizzard / Interplay, 1993): изометрический combat-racer с рок-саундтреком, поддержкой геймпада и локального split-screen.

Подробный план разработки — [`docs/PLAN_v2.md`](docs/PLAN_v2.md).

## Технологии

- Движок: **Godot 4.3** (GDScript)
- Цель сборки №1: **Web (HTML5)** через GitHub Pages
- Цель сборки №2: **Windows .exe** (позже)
- Управление: геймпад (Xbox / DualSense / generic) + клавиатура + тач для мобильных браузеров

## Как поиграть в текущий билд

После мерджа в `main` HTML5-сборка автоматически публикуется на GitHub Pages:

> `https://<owner>.github.io/rocknroll-game/`

Для PR-веток сборка доступна как артефакт `web-build` на странице GitHub Actions соответствующего workflow run.

> **Один раз нужно вручную включить Pages**: Settings → Pages → Source: **GitHub Actions**.

## Как открыть проект локально

1. Скачать **Godot 4.3** (Standard, без .NET) с [godotengine.org](https://godotengine.org/download).
2. Запустить редактор → **Import** → выбрать `project.godot` из этого репозитория.
3. F5 — запустить главное меню.

Дополнительные пакеты ставить не нужно — всё, что есть в репозитории, открывается «из коробки».

## Структура

```
.
├── docs/PLAN_v2.md       План разработки
├── project.godot         Конфиг Godot
├── icon.svg              Иконка проекта
├── export_presets.cfg    Пресет экспорта в Web
├── scenes/               .tscn — сцены
├── scripts/              .gd — логика
│   ├── core/             Глобальные синглтоны (Game)
│   ├── input/            Менеджер ввода и маппинга
│   ├── ui/               Скрипты UI-сцен
│   ├── race/             (позже) контроллер машины, AI, круги
│   └── weapons/          (позже) ракеты, мины, нитро
├── shaders/              .gdshader — пост-процессинг
├── assets/               Спрайты, звуки, шрифты
└── .github/workflows/    CI: сборка HTML5 + деплой на Pages
```

## Управление по умолчанию (Player 1)

| Действие   | Геймпад (Xbox)  | Клавиатура  |
| ---------- | --------------- | ----------- |
| Газ        | RT              | W / ↑       |
| Тормоз     | LT              | S / ↓       |
| Поворот    | Левый стик X    | A, D / ←, → |
| Стрельба   | A               | Space       |
| Мина       | B               | Shift       |
| Нитро      | X               | E           |
| Пауза      | Start           | Esc         |

Полная схема для PlayStation/Switch и план ремаппинга — в `docs/PLAN_v2.md` §4.

## Статус

**Веха 1**: скелет проекта + CI. Главное меню в финальной палитре, поддержка геймпада в браузере и десктопе, автодеплой на GitHub Pages.

Следующее — Веха 2: полная поддержка контроллеров (DualSense / Switch Pro / generic) и экран ремаппинга.
