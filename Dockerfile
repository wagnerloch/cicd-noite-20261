# --- ESTÁGIO 1: BUILD (Builder) ---
# Usamos uma imagem Node.js completa para construir o app
FROM node:18-alpine AS builder

# Define o diretório de trabalho
WORKDIR /app

# 1. Copia os arquivos de manifesto de pacotes
COPY package.json package-lock.json ./

# 2. Instala TODAS as dependências (incluindo devDependencies)
RUN npm install

# 3. Copia todo o código-fonte
COPY . .

# 4. Compila o TypeScript para JavaScript (salva em /app/dist)
RUN npm run build

# --- ESTÁGIO 2: PRODUÇÃO (Production) ---
# Começamos do zero com uma imagem limpa
FROM node:18-alpine

WORKDIR /app

# 1. Copia os arquivos de manifesto novamente
COPY package.json package-lock.json ./

# 2. Instala SOMENTE as dependências de PRODUÇÃO
RUN npm install --production

# 3. Copia o JS compilado do estágio 'builder'
# Este é o truque! Não copiamos o /src ou node_modules do builder.
COPY --from=builder /app/dist ./dist

# 4. Expõe a porta que o Render espera (embora ele use $PORT)
EXPOSE 3000

# 5. Comando para rodar a aplicação
# Ele vai executar "node dist/index.js"
CMD ["npm", "start"]