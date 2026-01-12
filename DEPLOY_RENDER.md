# 🚀 Deploy no Render.com - Guia Completo

## ✅ Por que Render.com?

- ✅ **Gratuito** (plano free)
- ✅ **Suporta Puppeteer/Chrome** nativamente
- ✅ **Fácil de usar**
- ✅ **Deploy automático** via GitHub
- ✅ **Logs em tempo real**

---

## 📋 PASSO A PASSO:

### **1️⃣ Criar conta no GitHub (se não tiver)**

1. Acesse: https://github.com
2. Clique em "Sign up"
3. Crie sua conta

### **2️⃣ Criar repositório no GitHub**

1. Acesse: https://github.com/new
2. Nome do repositório: `chatbot-otimizare`
3. Deixe como **Private** (privado)
4. Clique em "Create repository"

### **3️⃣ Fazer upload do código para o GitHub**

No seu PC, abra o PowerShell na pasta do projeto:

```powershell
cd C:\Users\Forest\Projetos\Node\chatbot

# Inicializar Git (se ainda não fez)
git init

# Adicionar todos os arquivos
git add .

# Fazer commit
git commit -m "Initial commit - Chatbot WhatsApp"

# Conectar ao repositório remoto (substitua SEU-USUARIO)
git remote add origin https://github.com/SEU-USUARIO/chatbot-otimizare.git

# Enviar para o GitHub
git branch -M main
git push -u origin main
```

**Nota:** Você vai precisar fazer login no GitHub quando pedir.

### **4️⃣ Conectar Render.com ao GitHub**

1. No Render.com, clique em **"New Web Service"**
2. Clique em **"Connect GitHub"**
3. Autorize o Render a acessar seus repositórios
4. Selecione o repositório **"chatbot-otimizare"**

### **5️⃣ Configurar o Web Service**

Preencha os campos:

- **Name:** `chatbot-otimizare`
- **Region:** `Oregon (US West)` (mais próximo)
- **Branch:** `main`
- **Root Directory:** (deixe vazio)
- **Environment:** `Node`
- **Build Command:** `npm install`
- **Start Command:** `npm start`
- **Plan:** **Free** ✅

### **6️⃣ Variáveis de Ambiente (opcional)**

Se precisar, adicione:
- `NODE_ENV` = `production`
- `PORT` = `3000`

### **7️⃣ Clicar em "Create Web Service"**

O Render vai:
1. Clonar seu repositório
2. Instalar dependências (`npm install`)
3. Iniciar o servidor (`npm start`)

### **8️⃣ Aguardar o Deploy (5-10 minutos)**

Você verá logs em tempo real:
```
==> Installing dependencies...
==> Building...
==> Starting server...
✅ Deployment successful!
```

### **9️⃣ Acessar os Logs para ver o QR Code**

1. No painel do Render, clique em **"Logs"**
2. Procure pelo QR Code:
```
📲 Escaneie o QR Code abaixo:
█████████████████████████████
```
3. Escaneie com WhatsApp

### **🔟 Testar**

Envie uma mensagem para o número e deve receber o menu!

---

## 🔄 Atualizações Futuras

Sempre que você modificar o código:

```powershell
git add .
git commit -m "Descrição da mudança"
git push
```

O Render vai fazer **deploy automático**!

---

## 📊 Monitoramento

No painel do Render:
- **Logs:** Ver logs em tempo real
- **Metrics:** CPU, memória, requisições
- **Settings:** Configurações do serviço

---

## 🆘 Troubleshooting

### ❌ QR Code não aparece
- Vá em "Logs" no painel do Render
- Procure por erros
- O QR Code deve aparecer nos logs

### ❌ Deploy falhou
- Verifique os logs de build
- Certifique-se que `package.json` está correto

### ❌ Serviço parou
- Plano gratuito tem 750 horas/mês
- Após 15 minutos de inatividade, o serviço "dorme"
- Acorda automaticamente quando recebe requisição

---

## 💡 Dicas

- **Logs em tempo real:** Use a aba "Logs"
- **Reiniciar:** Clique em "Manual Deploy" → "Clear build cache & deploy"
- **Domínio:** Render fornece um domínio gratuito (.onrender.com)

---

## ✅ Checklist

- [ ] Conta no GitHub criada
- [ ] Repositório criado
- [ ] Código enviado para GitHub
- [ ] Render conectado ao GitHub
- [ ] Web Service criado
- [ ] Deploy concluído
- [ ] QR Code escaneado
- [ ] Chatbot testado

---

## 🎉 Pronto!

Seu chatbot agora está rodando 24/7 na nuvem, gratuitamente! 🚀
