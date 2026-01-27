# 🚀 Deploy do Chatbot WhatsApp na Hostinger VPS

## 📋 Informações do Servidor

- **IP:** 46.202.148.205
- **Usuário:** root
- **Servidor:** srv1268777
- **Acesso:** SSH com chave pública

---

## 1️⃣ CONECTAR AO SERVIDOR

```bash
ssh root@46.202.148.205
```

---

## 2️⃣ ATUALIZAR O SISTEMA

```bash
apt update
apt upgrade -y
```

---

## 3️⃣ INSTALAR NODE.JS 20.X

```bash
# Adicionar repositório do Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

# Instalar Node.js
apt install -y nodejs

# Verificar instalação
node --version
npm --version
```

---

## 4️⃣ INSTALAR GIT

```bash
apt install -y git

# Verificar instalação
git --version
```

---

## 5️⃣ INSTALAR DEPENDÊNCIAS DO PUPPETEER

```bash
apt install -y \
  ca-certificates \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libc6 \
  libcairo2 \
  libcups2 \
  libdbus-1-3 \
  libexpat1 \
  libfontconfig1 \
  libgbm1 \
  libgcc1 \
  libglib2.0-0 \
  libgtk-3-0 \
  libnspr4 \
  libnss3 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libstdc++6 \
  libx11-6 \
  libx11-xcb1 \
  libxcb1 \
  libxcomposite1 \
  libxcursor1 \
  libxdamage1 \
  libxext6 \
  libxfixes3 \
  libxi6 \
  libxrandr2 \
  libxrender1 \
  libxss1 \
  libxtst6 \
  lsb-release \
  wget \
  xdg-utils
```

---

## 6️⃣ CLONAR O REPOSITÓRIO

```bash
cd /root
git clone https://github.com/Idelcio/chatbot.git
cd chatbot
```

---

## 7️⃣ INSTALAR DEPENDÊNCIAS DO PROJETO

```bash
npm install
```

---

## 8️⃣ INSTALAR PM2

```bash
npm install -g pm2

# Verificar instalação
pm2 --version
```

---

## 9️⃣ INICIAR O CHATBOT

```bash
pm2 start chatbot.js --name "whatsapp-bot"

# Ver logs
pm2 logs whatsapp-bot
```

---

## 🔟 AUTENTICAR O WHATSAPP

1. Nos logs, você verá um **QR Code**
2. Abra o WhatsApp no celular
3. Vá em **Configurações** → **Aparelhos Conectados**
4. Toque em **Conectar um aparelho**
5. **Escaneie o QR Code** que apareceu nos logs

---

## ✅ CONFIGURAR INICIALIZAÇÃO AUTOMÁTICA

```bash
# Salvar configuração do PM2
pm2 save

# Configurar PM2 para iniciar no boot
pm2 startup

# Execute o comando que aparecer na tela
```

---

## 📊 COMANDOS ÚTEIS DO PM2

```bash
# Ver status
pm2 status

# Ver logs em tempo real
pm2 logs whatsapp-bot

# Parar o bot
pm2 stop whatsapp-bot

# Reiniciar o bot
pm2 restart whatsapp-bot

# Remover do PM2
pm2 delete whatsapp-bot

# Monitorar recursos
pm2 monit
```

---

## 🔒 SEGURANÇA (OPCIONAL MAS RECOMENDADO)

### Configurar Firewall

```bash
# Instalar UFW
apt install -y ufw

# Permitir SSH
ufw allow 22/tcp

# Ativar firewall
ufw enable

# Ver status
ufw status
```

### Criar Usuário Não-Root (Opcional)

```bash
# Criar usuário
adduser chatbot

# Adicionar ao grupo sudo
usermod -aG sudo chatbot

# Copiar chave SSH
rsync --archive --chown=chatbot:chatbot ~/.ssh /home/chatbot
```

---

## 🔄 ATUALIZAR O CÓDIGO

Quando precisar atualizar o chatbot:

```bash
cd /root/chatbot

# Fazer backup da sessão do WhatsApp
cp -r .wwebjs_auth .wwebjs_auth.backup

# Atualizar código
git pull

# Reinstalar dependências (se necessário)
npm install

# Reiniciar o bot
pm2 restart whatsapp-bot
```

---

## 🐛 TROUBLESHOOTING

### Bot não inicia

```bash
# Ver logs de erro
pm2 logs whatsapp-bot --err

# Verificar se Node.js está instalado
node --version

# Verificar se as dependências estão instaladas
cd /root/chatbot
npm install
```

### QR Code não aparece

```bash
# Limpar sessão antiga
cd /root/chatbot
rm -rf .wwebjs_auth

# Reiniciar o bot
pm2 restart whatsapp-bot

# Ver logs
pm2 logs whatsapp-bot
```

### Erro de memória

```bash
# Ver uso de memória
free -h

# Ver processos
pm2 monit

# Se necessário, fazer upgrade do VPS
```

### Chromium não funciona

```bash
# Instalar dependências adicionais
apt install -y chromium-browser

# Ou reinstalar dependências do Puppeteer
cd /root/chatbot
npm rebuild
```

---

## 📞 INFORMAÇÕES DO SERVIDOR

- **IP:** 46.202.148.205
- **Usuário:** root
- **Pasta do projeto:** /root/chatbot
- **Processo PM2:** whatsapp-bot
- **Repositório:** https://github.com/Idelcio/chatbot.git

---

## 🎯 CHECKLIST DE INSTALAÇÃO

- [ ] Conectar ao VPS via SSH
- [ ] Atualizar sistema (apt update && upgrade)
- [ ] Instalar Node.js 20.x
- [ ] Instalar Git
- [ ] Instalar dependências do Puppeteer
- [ ] Clonar repositório
- [ ] Instalar dependências do projeto (npm install)
- [ ] Instalar PM2
- [ ] Iniciar bot com PM2
- [ ] Autenticar WhatsApp (escanear QR Code)
- [ ] Testar funcionamento
- [ ] Configurar PM2 startup
- [ ] (Opcional) Configurar firewall

---

## 🎉 PRONTO!

Seu chatbot WhatsApp está rodando na Hostinger VPS!

**Última atualização:** 13/01/2026 - 16:05 BRT
