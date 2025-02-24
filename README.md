# nia_ov

## 🚀 Установка и запуск

### 1️⃣ Клонирование репозитория
```sh
git clone https://github.com/andrew9128/nia_ov.git
cd nia_ov
```

### 2️⃣ Настройка переменных окружения
Создайте файл `.env` в корневой директории проекта и добавьте в него следующие параметры:

```ini
# MySQL
MYSQL_ROOT_PASSWORD='root_password_here'
MYSQL_USER=chat_user
MYSQL_PASSWORD='password_here'
MYSQL_DATABASE=bot_app

# Ollama
OLLAMA_API_URL=http://ollama:11434

# vLLM
VLLM_API_URL=http://127.0.0.1:8000/v1
```

- Переменные `.env` используются в `docker-compose.yml` для настройки контейнеров базы данных и сервисов.
- Эти параметры задают учетные данные MySQL, а также URL API Ollama и vLLM, что позволяет правильно подключаться к моделям.

### 3️⃣ Сборка и запуск контейнеров
```sh
docker-compose up --build -d
```

**Проверка запущенных контейнеров:**
```sh
docker ps
```

---

## 🛠️ Настройка базы данных

### 4️⃣ Подключение к MySQL в контейнере
Выполните команду, чтобы войти в MySQL:
```sh
docker exec -it nia_ov-db-1 mysql -u root -p
```
Пароль: что и в файле `.env`

### 5️⃣ Проверка базы данных
```sql
SHOW DATABASES;
```
Вы должны увидеть `bot_app` в списке баз данных.

### 6️⃣ Подключение к базе `bot_app`
```sql
USE bot_app;
```

### 7️⃣ Добавление пользователей в таблицу `users`
```sql
INSERT INTO users (username, password) VALUES
    ('admin', 'admin_pass'),
    ('user', 'pass');
```

**Выход из MySQL:**
```sh
exit
```

---

## 🔥 Запуск LLM серверов

**⚡ Ollama**

Запустите Ollama локально:
```sh
ollama run `model_here`
ollama serve
```
Или разверните в Docker:
```sh
docker run --rm -p 11434:11434 ollama/ollama
```

**⚡ vLLM**

Запуск vLLM с Hugging Face моделью и параметрами:
```sh
docker run --runtime nvidia --gpus all \
    -v ~/.cache/huggingface:/root/.cache/huggingface \
    --env "HUGGING_FACE_HUB_TOKEN=" \
    -p 8000:8000 --ipc=host vllm/vllm-openai:latest \
    --model `model_here` \
    --gpu-memory-utilization 0.5 \
    --cpu_offload_gb 3 \
    --max_seq_len_to_capture 512 \
    --max_num_seqs 16 \
    --num_lookahead_slots 0 \
    --kv_cache_dtype fp8 \
    --max_num_batched_tokens 512 \
    --num_gpu_blocks_override 256 \
    --max_model_len 512 \
    --disable_async_output_proc
```

---
