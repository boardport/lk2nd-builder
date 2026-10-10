# 📦 BoardPort — Сборщик lk2nd

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![Project: BoardPort](https://img.shields.io/badge/Project-BoardPort-green.svg)](https://github.com/boardport)
[![Upstream: lk2nd](https://img.shields.io/badge/Upstream-lk2nd-00d7d7.svg)](https://github.com/msm8916-mainline/lk2nd)
[![Markdownlint](https://github.com/boardport/lk2nd-builder/actions/workflows/markdownlint.yml/badge.svg)](https://github.com/boardport/lk2nd-builder/actions/workflows/markdownlint.yml)

Модульный сборщик модифицированных образов загрузчиков lk2nd и lk1st на основе внешних оверлеев для встраиваемых плат, 4G/LTE-модемов и мобильных устройств.

Репозиторий входит в экосистему **[BoardPort](https://github.com/boardport)** и предоставляет чистый слой адаптации
поверх штатной сборочной среды lk2nd без отслеживания тяжелых кодовых баз апстрима и засорения базовых исходников.

> 🤖 **Примечание для AI-ассистентов:** Автономные агенты и LLM-ассистенты обязаны ознакомиться с правилами проекта
> в файле [AGENTS_RU.md](./AGENTS_RU.md) перед началом работы в этом репозитории.

---

## 📚 Центр документации проекта

- 📖 **[Обзор проекта](./docs/overview.ru.md)** — миссия, поддерживаемые платформы и форматы образов загрузчика.
- 🏛️ **[Архитектура системы](./docs/architecture.ru.md)** — системный дизайн, иерархия OCI-контейнеров и матрица версий.
- 🛠️ **[Руководство по разработке и сборке](./docs/development.ru.md)** — сценарии сборки с Make, параметры и отладка.
- 🐳 **[Документация подмодуля Docker](./docker/README_RU.md)** — архитектура контейнеров, тулчейны и стадии сборки.
- 🧩 **[Документация подмодуля Overlay](./overlay/README_RU.md)** — иерархия оверлея, таргеты и каталог адаптаций.
- 🤖 **[Регламент для AI-ассистентов](./AGENTS_RU.md)** — операционные правила и ограничения для автономных агентов.
- 🤝 **[Руководство контрибьютора](./.github/CONTRIBUTING_RU.md)** — стандарты коммитов, разработка и требования к PR.
- 🔒 **[Политика безопасности](./.github/SECURITY_RU.md)** — конфиденциальное информирование об уязвимостях.
- 💬 **[Ресурсы поддержки](./.github/SUPPORT_RU.md)** — каналы связи сообщества и правила обращений.

---

## 📄 Лицензия и благодарности

- Сборочные рецепты, документация и скрипты автоматизации распространяются под лицензией **[MIT](./LICENSE)**.
- Проект lk2nd распространяется преимущественно под лицензиями Little Kernel (MIT/BSD-style) и GPL-2.0.
  Выражаем благодарность сообществу lk2nd и Little Kernel.
