# 🚀 Deploy na Hostinger - SOLUÇÃO PARA O ERRO

## ❌ Problema Encontrado

A Hostinger está rejeitando o upload porque o projeto não é um dos frameworks suportados (Vite, Next.js, Angular, Express, Vue.js, Parcel, React).

## ✅ Solução Implementada

Criei um **wrapper Express.js** para tornar o projeto compatível com a Hostinger.

---

## 📦 Arquivos Adicionados/Modificados

### ✅ Novo arquivo: `server.js`
- Servidor Express que roda na porta 3000
- Inicia o chatbot em background
- Fornece endpoints de health check

### ✅ Modificado: `package.json`
- Adicionado Express como dependência
- Script `start` agora inicia o `server.js`

---

## 🎯 MÉTODO 1: Deploy via Interface Web (AGORA FUNCIONA!)

### Passo 1: Criar arquivo ZIP

Crie um arquivo `.zip` contendo **APENAS** estes arquivos:

```
✅ server.js
✅ chatbot.js
✅ package.json
✅ ecosystem.config.js
```

**NÃO incluir:**
- ❌ node_modules/
- ❌ .wwebjs_auth/
- ❌ .wwebjs_cache/
- ❌ Arquivos .md

### Passo 2: Fazer Upload

1. Volte para a interface da Hostinger
2. Clique em **"Carregar"**
3. Selecione o arquivo `.zip` que você criou
4. Aguarde o upload e deploy

### Passo 3: Configurar Variáveis de Ambiente (se necessário)

No painel da Hostinger, configure:
- `PORT` = 3000 (ou a porta que a Hostinger fornecer)

### Passo 4: Acessar via SSH para escanear QR Code

Após o deploy, você ainda precisa escanear o QR Code:

```bash
# Conectar via SSH
ssh u123456789@seu-dominio.com -p 65002

# Navegar até a pasta do app
cd ~/domains/seu-dominio.com/public_html

# Ver logs
pm2 logs

# OU se não estiver usando PM2
npm run chatbot
```

---

## 🎯 MÉTODO 2: Deploy via SSH (RECOMENDADO)

Este método é mais direto e você tem mais controle.

### Passo 1: Conectar via SSH

```bash
ssh u123456789@seu-dominio.com -p 65002
```

### Passo 2: Criar pasta e fazer upload via FTP

Use FileZilla, WinSCP ou outro cliente FTP:

1. Conecte-se ao servidor
2. Crie a pasta `~/chatbot`
3. Faça upload dos arquivos:
   - `server.js`
   - `chatbot.js`
   - `package.json`
   - `ecosystem.config.js`

### Passo 3: Instalar dependências

```bash
cd ~/chatbot
npm install
```

### Passo 4: Iniciar o servidor

```bash
# Opção A: Iniciar com PM2 (recomendado)
npm run pm2:start

# Opção B: Iniciar diretamente
npm start
```

### Passo 5: Ver logs e escanear QR Code

```bash
pm2 logs chatbot-otimizare
```

O QR Code aparecerá nos logs. Escaneie com WhatsApp.

---

## 🌐 Endpoints Disponíveis

Após o deploy, você pode acessar:

- `http://seu-dominio.com/` → Status do chatbot
- `http://seu-dominio.com/health` → Health check

---

## 🔧 Comandos Úteis

```bash
# Ver status
pm2 status

# Ver logs
pm2 logs chatbot-otimizare

# Reiniciar
pm2 restart chatbot-otimizare

# Parar
pm2 stop chatbot-otimizare
```

---

## 📝 Criar o arquivo ZIP (Windows)

### Opção 1: Via PowerShell

```powershell
# Navegar até a pasta
cd C:\Users\Forest\Projetos\Node\chatbot

# Criar ZIP com apenas os arquivos necessários
Compress-Archive -Path server.js,chatbot.js,package.json,ecosystem.config.js -DestinationPath chatbot-deploy.zip -Force
```

### Opção 2: Manualmente

1. Selecione os arquivos:
   - `server.js`
   - `chatbot.js`
   - `package.json`
   - `ecosystem.config.js`

2. Clique com botão direito → **"Enviar para"** → **"Pasta compactada"**

3. Renomeie para `chatbot-deploy.zip`

---

## ✅ Verificar se está funcionando

Após o deploy:

1. **Acesse o endpoint**: `http://seu-dominio.com/`
   - Deve mostrar: `{"status":"online","message":"Chatbot WhatsApp - Otimizare está rodando!"}`

2. **Envie uma mensagem** para o número do WhatsApp
   - Deve receber o menu automaticamente

---

## 🆘 Troubleshooting

### ❌ Ainda dá erro na interface web
- Use o **Método 2 (SSH)** que é mais confiável

### ❌ QR Code não aparece
```bash
pm2 logs chatbot-otimizare --lines 100
```

### ❌ Bot não responde
```bash
pm2 restart chatbot-otimizare
pm2 logs chatbot-otimizare
```

---

## 🎉 Conclusão

Agora você tem **2 métodos** para fazer o deploy:

1. **Interface Web** (com o wrapper Express)
2. **SSH** (método tradicional)

Escolha o que preferir e siga os passos acima!

**Boa sorte! 🚀**
