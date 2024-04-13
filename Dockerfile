# Use a imagem oficial do Python como base
FROM python:3.10 AS main

# Define o diretório de trabalho no container
WORKDIR /app

# Instala pandoc e netcat
RUN apt-get update \
    && apt-get install -y pandoc netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Copia o arquivo de requisitos e instala as dependências do Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Cria o diretório de uploads e define as permissões
RUN mkdir -p /app/uploads && chmod 777 /app/uploads

# Cria o diretório de cache e define as permissões
RUN mkdir -p /app/.cache && chmod 777 /app/.cache

# Copia todos os arquivos necessários para o diretório de trabalho
COPY . .

# Define o comando para executar a aplicação
CMD ["python", "main.py"]

# Expõe a porta 8000
EXPOSE 8000
