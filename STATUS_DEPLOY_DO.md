# 📊 Status do Deploy na DigitalOcean

## ✅ O QUE JÁ FOI FEITO

### 1. Servidor Criado
- ✅ Droplet criado: **chatbot-whatsapp**
- ✅ IP: **157.245.164.185**
- ✅ Sistema: Ubuntu 24.04 LTS
- ✅ Senha configurada: `ChatBot@DO2026!`

### 2. Software Instalado
- ✅ Node.js v20.19.6
- ✅ npm 10.8.2
- ✅ Git 2.43.0
- ✅ PM2 (gerenciador de processos)

### 3. Código do Chatbot
- ✅ Repositório clonado: `https://github.com/Idelcio/chatbot.git`
- ✅ Dependências npm instaladas (358 pacotes)

### 4. PM2 Configurado
- ✅ Chatbot iniciado com PM2
- ✅ Nome do processo: `whatsapp-bot`
- ✅ Status: Online

### 5. Bibliotecas do Sistema
- ✅ Instaladas várias bibliotecas para Puppeteer:
  - libatk, libcups, libdrm, libgbm
  - libgtk-3, libnss3, libxss1, libxtst6
  - E muitas outras...

---

## ⚠️ PROBLEMA ATUAL

O chatbot está iniciando, mas o **Puppeteer** (usado pelo whatsapp-web.js) está com erro de biblioteca faltando.

**Erro:** `cannot open shared object file`

---

## 🔧 PRÓXIMOS PASSOS PARA RESOLVER

### Opção 1: Instalar TODAS as dependências do Chromium (Recomendado)

```bash
# Conectar ao servidor
ssh root@157.245.164.185
# Senha: ChatBot@DO2026!

# Instalar dependências completas
apt install -y gconf-service libasound2t64 libatk1.0-0t64 libatk-bridge2.0-0t64 libc6 libcairo2 libcups2t64 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf-2.0-0 libglib2.0-0 libgtk-3-0t64 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator3-1 libnss3 lsb-release xdg-utils wget

# Reiniciar o chatbot
cd /root/chatbot
pm2 restart whatsapp-bot

# Ver logs
pm2 logs whatsapp-bot
```

### Opção 2: Usar Chromium via Snap (Alternativa)

```bash
# Instalar Chromium via snap
snap install chromium

# Configurar whatsapp-web.js para usar o Chromium do sistema
# (Requer modificação no código)
```

### Opção 3: Aumentar RAM (Se necessário)

O servidor tem apenas **512MB de RAM**. O WhatsApp Web + Chromium pode precisar de mais memória.

Considere fazer upgrade para **1GB** se o bot continuar crashando.

---

## 📋 COMANDOS ÚTEIS

### Conectar ao Servidor
```bash
ssh root@157.245.164.185
# Senha: ChatBot@DO2026!
```

### Gerenciar o Chatbot
```bash
# Ver status
pm2 status

# Ver logs
pm2 logs whatsapp-bot

# Reiniciar
pm2 restart whatsapp-bot

# Parar
pm2 stop whatsapp-bot

# Iniciar
pm2 start chatbot.js --name "whatsapp-bot"
```

### Configurar Inicialização Automática
```bash
# Salvar configuração do PM2
pm2 save

# Configurar PM2 para iniciar no boot
pm2 startup
# Execute o comando que aparecer na tela
```

---

## 🎯 QUANDO FUNCIONAR

Quando o chatbot estiver funcionando, você verá nos logs:

1. **QR Code** - Escaneie com o WhatsApp
2. **"Client is ready!"** - Bot autenticado
3. Mensagens sendo recebidas e respondidas

---

## 💡 DICAS

1. **Memória**: Se o bot crashar por falta de memória, faça upgrade do droplet
2. **Firewall**: Não precisa abrir portas, o bot faz conexões de saída
3. **Backup**: A pasta `.wwebjs_auth` contém a sessão do WhatsApp - faça backup!
4. **Logs**: Use `pm2 logs` para debug

---

## 📞 INFORMAÇÕES DO SERVIDOR

- **IP:** 157.245.164.185
- **Usuário:** root
- **Senha:** ChatBot@DO2026!
- **Pasta do projeto:** /root/chatbot
- **Processo PM2:** whatsapp-bot

---

**Última atualização:** 13/01/2026 - 13:15 BRT
