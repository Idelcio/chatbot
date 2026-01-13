# 🚀 Deploy do Chatbot WhatsApp na DigitalOcean

## 📋 Informações do Servidor

- **IP do Droplet:** `157.245.164.185`
- **Sistema Operacional:** Ubuntu 24.04 LTS x64
- **Usuário:** root
- **Autenticação:** SSH Key

---

## 1️⃣ CONECTAR AO SERVIDOR

Abra o PowerShell e conecte ao servidor:

```powershell
ssh root@157.245.164.185
```

Se aparecer uma mensagem perguntando sobre autenticidade do host, digite `yes`.

---

## 2️⃣ ATUALIZAR O SISTEMA

Após conectar, execute:

```bash
# Atualizar lista de pacotes
apt update

# Atualizar pacotes instalados
apt upgrade -y
```

---

## 3️⃣ INSTALAR NODE.JS

```bash
# Instalar Node.js 20.x (LTS)
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

# Verificar instalação
node --version
npm --version
```

---

## 4️⃣ INSTALAR DEPENDÊNCIAS DO PUPPETEER

O `whatsapp-web.js` precisa do Chrome/Chromium e suas dependências:

```bash
# Instalar dependências necessárias
apt install -y \
  gconf-service \
  libasound2 \
  libatk1.0-0 \
  libc6 \
  libcairo2 \
  libcups2 \
  libdbus-1-3 \
  libexpat1 \
  libfontconfig1 \
  libgcc1 \
  libgconf-2-4 \
  libgdk-pixbuf2.0-0 \
  libglib2.0-0 \
  libgtk-3-0 \
  libnspr4 \
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
  ca-certificates \
  fonts-liberation \
  libappindicator1 \
  libnss3 \
  lsb-release \
  xdg-utils \
  wget \
  chromium-browser

# Instalar Git
apt install -y git
```

---

## 5️⃣ INSTALAR PM2 (GERENCIADOR DE PROCESSOS)

```bash
# Instalar PM2 globalmente
npm install -g pm2

# Verificar instalação
pm2 --version
```

---

## 6️⃣ CRIAR DIRETÓRIO E FAZER UPLOAD DO CÓDIGO

### Opção A: Usando Git (Recomendado)

Se seu código está no GitHub:

```bash
# Criar diretório
cd /root
mkdir chatbot
cd chatbot

# Clonar repositório (substitua pela URL do seu repo)
git clone https://github.com/seu-usuario/seu-repo.git .
```

### Opção B: Upload Manual via SCP

No seu **PC Windows** (PowerShell), execute:

```powershell
# Navegar até a pasta do projeto
cd C:\Users\Forest\Projetos\Node\chatbot

# Fazer upload dos arquivos (exceto node_modules)
scp -r * root@157.245.164.185:/root/chatbot/
```

---

## 7️⃣ INSTALAR DEPENDÊNCIAS DO PROJETO

No servidor:

```bash
cd /root/chatbot

# Instalar dependências
npm install

# Isso vai instalar whatsapp-web.js, qrcode-terminal, etc.
```

---

## 8️⃣ CONFIGURAR VARIÁVEIS DE AMBIENTE (se necessário)

Se você usa arquivo `.env`:

```bash
# Criar arquivo .env
nano .env
```

Cole suas variáveis, salve (Ctrl+O, Enter) e saia (Ctrl+X).

---

## 9️⃣ INICIAR O CHATBOT COM PM2

```bash
# Iniciar o chatbot
pm2 start chatbot.js --name "whatsapp-bot"

# Ver logs em tempo real
pm2 logs whatsapp-bot

# Salvar configuração do PM2
pm2 save

# Configurar PM2 para iniciar automaticamente no boot
pm2 startup
# Execute o comando que aparecer na tela
```

---

## 🔟 AUTENTICAR O WHATSAPP

1. Após iniciar o bot, veja os logs:
   ```bash
   pm2 logs whatsapp-bot
   ```

2. Um **QR Code** aparecerá nos logs
3. **Escaneie o QR Code** com o WhatsApp do seu celular:
   - Abra WhatsApp
   - Vá em **Configurações** → **Aparelhos Conectados**
   - Toque em **Conectar um aparelho**
   - Escaneie o QR Code que apareceu nos logs

4. Após autenticar, o bot estará funcionando!

---

## 📊 COMANDOS ÚTEIS DO PM2

```bash
# Ver status dos processos
pm2 status

# Ver logs
pm2 logs whatsapp-bot

# Parar o bot
pm2 stop whatsapp-bot

# Reiniciar o bot
pm2 restart whatsapp-bot

# Remover do PM2
pm2 delete whatsapp-bot

# Ver informações detalhadas
pm2 show whatsapp-bot

# Monitorar em tempo real
pm2 monit
```

---

## 🔒 SEGURANÇA ADICIONAL (RECOMENDADO)

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

Quando precisar atualizar:

```bash
# Se usando Git
cd /root/chatbot
git pull

# Reinstalar dependências (se necessário)
npm install

# Reiniciar o bot
pm2 restart whatsapp-bot
```

Se usando SCP, faça upload novamente e reinicie.

---

## 🐛 TROUBLESHOOTING

### Bot não inicia

```bash
# Ver logs de erro
pm2 logs whatsapp-bot --err

# Verificar se todas as dependências estão instaladas
npm install
```

### QR Code não aparece

```bash
# Limpar sessão antiga
rm -rf .wwebjs_auth

# Reiniciar o bot
pm2 restart whatsapp-bot
```

### Erro de memória

O plano de 512MB pode ser limitado. Considere:
- Upgrade para 1GB RAM
- Ou otimizar o código para usar menos memória

---

## 📞 TESTAR O BOT

Após autenticar, envie uma mensagem para o número conectado e teste os comandos!

---

## ✅ CHECKLIST

- [ ] Conectar ao servidor via SSH
- [ ] Atualizar sistema
- [ ] Instalar Node.js
- [ ] Instalar dependências do Puppeteer
- [ ] Instalar PM2
- [ ] Fazer upload do código
- [ ] Instalar dependências do projeto
- [ ] Iniciar bot com PM2
- [ ] Autenticar WhatsApp (escanear QR Code)
- [ ] Testar funcionamento
- [ ] Configurar PM2 startup
- [ ] Configurar firewall

---

## 🎉 PRONTO!

Seu chatbot WhatsApp está rodando na DigitalOcean! 🚀

**IP do Servidor:** `157.245.164.185`
