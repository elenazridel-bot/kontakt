# Бот-сборщик контактов в Excel

Telegram-бот, который принимает сообщения с контактами и описанием того,
чем человек может помочь, и складывает их в один Excel-файл.

## Как пользоваться

Отправьте боту сообщение в формате:

```
Имя, телефон или юзернейм
Чем может помочь
```

Можно в одну строку — бот попробует сам отделить контакт от описания.
Также можно отправить контакт через кнопку «Скрепка → Контакт».

Команда `/export` в любой момент присылает текущий накопленный файл
`contacts.xlsx`.

## Установка и запуск

1. Создайте бота через [@BotFather](https://t.me/BotFather) и получите токен.
2. Установите зависимости:
   ```bash
   pip install -r requirements.txt
   ```
3. Скопируйте `.env.example` в `.env` и впишите токен:
   ```bash
   cp .env.example .env
   ```
4. Запустите бота:
   ```bash
   python bot.py
   ```

Файл с контактами (`contacts.xlsx` по умолчанию, путь задаётся в `.env`
через `EXCEL_FILE`) создаётся автоматически рядом с `bot.py` и пополняется
при каждом новом сообщении.

Чтобы бот работал постоянно (24/7), разверните его на сервере/VPS одним
из способов ниже — так процесс будет автоматически перезапускаться при
сбоях и после перезагрузки сервера.

## Постоянный запуск через Docker (рекомендуется)

1. На сервере установите Docker и Docker Compose.
2. Склонируйте репозиторий и перейдите в его папку.
3. Создайте `.env` на основе `.env.example` и впишите токен.
4. Запустите:
   ```bash
   docker compose up -d --build
   ```

Файл с контактами будет сохраняться в `./data/contacts.xlsx` на хосте
(том `/data` смонтирован в контейнер) — данные переживут пересборку
и перезапуск контейнера.

Полезные команды:
```bash
docker compose logs -f    # логи бота
docker compose restart    # перезапуск
docker compose down       # остановка
```

## Постоянный запуск через systemd (без Docker)

1. Склонируйте репозиторий на сервер, например в `/opt/kontakt`.
2. Создайте виртуальное окружение и установите зависимости:
   ```bash
   cd /opt/kontakt
   python3 -m venv venv
   ./venv/bin/pip install -r requirements.txt
   ```
3. Создайте `.env` на основе `.env.example` и впишите токен.
4. Скопируйте пример юнита и поправьте в нём пути и пользователя:
   ```bash
   sudo cp deploy/telegram-bot.service /etc/systemd/system/telegram-bot.service
   sudo nano /etc/systemd/system/telegram-bot.service
   ```
5. Включите и запустите сервис:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable --now telegram-bot
   ```

Проверить статус и логи:
```bash
sudo systemctl status telegram-bot
sudo journalctl -u telegram-bot -f
```
