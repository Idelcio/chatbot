# ✅ Projeto Preparado para Deploy na Hostinger

## 📁 Estrutura do Projeto

```
chatbot/
├── 📄 chatbot.js                  # Código principal do bot
├── 📄 package.json                # Dependências e scripts
├── 📄 ecosystem.config.js         # Configuração do PM2
├── 📄 verificar-deploy.js         # Script de verificação
├── 📄 .gitignore                  # Arquivos ignorados
│
├── 📖 README.md                   # Documentação geral
├── 📖 DEPLOY_HOSTINGER.md         # Guia completo de deploy
└── 📖 COMANDOS_RAPIDOS.md         # Referência rápida
```

---

## ✅ O que foi feito

### 1. **Atualização do `package.json`**
   - ✅ Adicionado nome, versão e descrição do projeto
   - ✅ Criados scripts úteis (start, dev, verify, pm2:*)
   - ✅ Especificada versão do Node.js (>=18.0.0)
   - ✅ Adicionado PM2 como dependência

### 2. **Configuração do PM2**
   - ✅ Criado `ecosystem.config.js` para gerenciar o processo
   - ✅ Configurado auto-restart
   - ✅ Configurado limite de memória (500MB)
   - ✅ Configurado logs em arquivos

### 3. **Documentação Completa**
   - ✅ `README.md` - Documentação geral do projeto
   - ✅ `DEPLOY_HOSTINGER.md` - Guia passo a passo de deploy
   - ✅ `COMANDOS_RAPIDOS.md` - Referência rápida de comandos

### 4. **Ferramentas de Verificação**
   - ✅ Script `verificar-deploy.js` para validar configuração
   - ✅ `.gitignore` para evitar commit de arquivos sensíveis

### 5. **Instalação de Dependências**
   - ✅ Todas as dependências instaladas localmente
   - ✅ PM2 adicionado para gerenciamento de processos

---

## 🚀 Como Fazer o Deploy

### **Opção 1: Leitura Rápida**
Leia o arquivo `COMANDOS_RAPIDOS.md` para comandos essenciais.

### **Opção 2: Guia Completo**
Leia o arquivo `DEPLOY_HOSTINGER.md` para instruções detalhadas.

---

## 📦 Arquivos para Upload

### ✅ **ENVIAR** para o servidor:
```
✅ chatbot.js
✅ package.json
✅ ecosystem.config.js
✅ README.md
✅ DEPLOY_HOSTINGER.md
✅ COMANDOS_RAPIDOS.md
✅ .gitignore (opcional)
```

### ❌ **NÃO ENVIAR**:
```
❌ node_modules/          # Será instalado no servidor
❌ .wwebjs_auth/          # Será criado no servidor
❌ .wwebjs_cache/         # Será criado no servidor
❌ package-lock.json      # Opcional
❌ verificar-deploy.js    # Apenas para uso local
```

---

## 🔍 Verificação Pré-Deploy

Execute o comando abaixo para verificar se está tudo pronto:

```bash
npm run verify
```

Resultado esperado:
```
✅ Tudo pronto para o deploy! 🚀
```

---

## 📝 Resumo dos Comandos

### **No Servidor (via SSH)**

```bash
# 1. Instalar dependências
npm install

# 2. Iniciar o bot
npm run pm2:start

# 3. Ver logs e escanear QR Code
pm2 logs chatbot-otimizare

# 4. Verificar status
pm2 status

# 5. Configurar auto-start
pm2 save
pm2 startup
```

---

## 🎯 Próximos Passos

1. **Fazer Upload dos Arquivos**
   - Use FTP/SFTP ou File Manager da Hostinger
   - Envie apenas os arquivos listados acima

2. **Conectar via SSH**
   - Acesse o painel da Hostinger
   - Vá em "Advanced" → "SSH Access"
   - Copie e execute o comando SSH

3. **Instalar e Iniciar**
   ```bash
   cd ~/domains/seu-dominio.com/public_html/chatbot
   npm install
   npm run pm2:start
   pm2 logs chatbot-otimizare
   ```

4. **Escanear QR Code**
   - O QR Code aparecerá nos logs
   - Escaneie com WhatsApp → Aparelhos Conectados

5. **Testar**
   - Envie uma mensagem para o número
   - Deve receber o menu automaticamente

---

## 📊 Scripts Disponíveis

| Comando | Descrição |
|---------|-----------|
| `npm start` | Inicia o chatbot |
| `npm run dev` | Inicia em modo desenvolvimento |
| `npm run verify` | Verifica configuração pré-deploy |
| `npm run pm2:start` | Inicia com PM2 |
| `npm run pm2:stop` | Para o PM2 |
| `npm run pm2:restart` | Reinicia o PM2 |
| `npm run pm2:logs` | Visualiza os logs |

---

## 🔧 Dependências Instaladas

- **whatsapp-web.js** (1.34.2) - Biblioteca principal do WhatsApp
- **qrcode-terminal** (^0.12.0) - Exibição do QR Code
- **moment-timezone** (^0.5.45) - Manipulação de datas/horas
- **openai** (^4.78.1) - API da OpenAI (se necessário)
- **pm2** (^5.3.0) - Gerenciador de processos

---

## 🤖 Funcionalidades do Bot

### Menu Principal:
1. **Serviços e equipamentos** → Submenu de regiões
2. **Questões administrativas/financeiras** → Lucas Morim
3. **Envio de currículos** → Email de RH

### Recursos:
- ✅ Saudação personalizada (bom dia/tarde/noite)
- ✅ Menu interativo por regiões (RS, SC, SP, Outras)
- ✅ Comando "voltar" para retornar ao menu
- ✅ Bloqueio de mídias (áudio, foto, vídeo)
- ✅ Expiração de sessão após 2 horas
- ✅ Apenas mensagens privadas (ignora grupos)

---

## 🆘 Suporte

### Problemas Comuns:

**QR Code não aparece:**
```bash
pm2 logs chatbot-otimizare --lines 100
```

**Bot não responde:**
```bash
pm2 restart chatbot-otimizare
pm2 logs chatbot-otimizare
```

**Desconexão do WhatsApp:**
```bash
pm2 stop chatbot-otimizare
rm -rf .wwebjs_auth .wwebjs_cache
pm2 restart chatbot-otimizare
```

---

## 📞 Contatos Configurados

- **Lucas Morim** - Diretor Comercial: (51) 9292-2628
- **João Soares** - Gestor Comercial SP: (19) 99718-8587
- **Email RH**: recrutamento@otimizare.com

---

## ✅ Status

- [x] Código do chatbot funcionando
- [x] Package.json configurado
- [x] PM2 configurado
- [x] Documentação completa
- [x] Script de verificação criado
- [x] Dependências instaladas
- [ ] Upload para servidor (próximo passo)
- [ ] Instalação no servidor (próximo passo)
- [ ] QR Code escaneado (próximo passo)
- [ ] Testes finais (próximo passo)

---

## 🎉 Conclusão

Seu projeto está **100% pronto** para deploy na Hostinger! 

Siga o guia em `DEPLOY_HOSTINGER.md` para fazer o deploy passo a passo.

**Boa sorte! 🚀**
