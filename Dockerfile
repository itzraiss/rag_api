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

# Cria o diretório de cache para o Hugging Face e define as permissões
RUN mkdir -p /app/.cache/huggingface && chmod 777 /app/.cache/huggingface

# Copia todos os arquivos necessários para o diretório de trabalho
COPY . .

# Define as variáveis de ambiente para a conexão com o banco de dados
ENV DB_HOST=dpg-cocmp0q0si5c73aln2bg-a.ohio-postgres.render.com
ENV DB_PORT=5432
ENV POSTGRES_USER=itzraiss
ENV POSTGRES_PASSWORD=QNAqonq1Wi3Vfz6zE628ehQAZaPlgvf1
ENV POSTGRES_DB=librechat

# Define o comando para executar a aplicação
CMD ["python", "main.py"]

# Expõe a porta 8000
EXPOSE 8000
