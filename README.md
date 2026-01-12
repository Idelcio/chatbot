# Chatbot WhatsApp - Otimizare

Chatbot de atendimento automático para WhatsApp da Otimizare.

## 📋 Pré-requisitos

- Node.js 18 ou superior
- Conta WhatsApp Business (recomendado)

## 🚀 Instalação Local

```bash
# Instalar dependências
npm install

# Executar o chatbot
npm start
```

Na primeira execução, um QR Code será exibido no terminal. Escaneie com seu WhatsApp para conectar.

## 🌐 Deploy na Hostinger

### 1. Fazer upload dos arquivos

Faça upload dos seguintes arquivos para o servidor Hostinger:
- `chatbot.js`
- `package.json`
- `ecosystem.config.js`

**NÃO** faça upload de:
- `node_modules/` (será instalado no servidor)
- `.wwebjs_auth/` (será criado no servidor)
- `.wwebjs_cache/` (será criado no servidor)

### 2. Conectar via SSH

Acesse o terminal SSH da Hostinger através do painel de controle.

### 3. Instalar dependências

```bash
cd ~/domains/seu-dominio.com/public_html/chatbot
npm install
```

### 4. Iniciar com PM2

```bash
# Iniciar o chatbot
npm run pm2:start

# Verificar status
pm2 status

# Ver logs
npm run pm2:logs

# Parar o chatbot
npm run pm2:stop

# Reiniciar o chatbot
npm run pm2:restart
```

### 5. Escanear QR Code

Na primeira execução, você precisa escanear o QR Code:

```bash
# Ver os logs para encontrar o QR Code
pm2 logs chatbot-otimizare
```

O QR Code aparecerá nos logs. Escaneie com seu WhatsApp.

### 6. Configurar PM2 para iniciar automaticamente

```bash
# Salvar a configuração atual do PM2
pm2 save

# Configurar PM2 para iniciar no boot
pm2 startup
```

## 📝 Scripts Disponíveis

- `npm start` - Inicia o chatbot
- `npm run dev` - Inicia em modo desenvolvimento
- `npm run pm2:start` - Inicia com PM2
- `npm run pm2:stop` - Para o PM2
- `npm run pm2:restart` - Reinicia o PM2
- `npm run pm2:logs` - Visualiza os logs

## 🔧 Estrutura do Projeto

```
chatbot/
├── chatbot.js           # Código principal do bot
├── package.json         # Dependências e scripts
├── ecosystem.config.js  # Configuração do PM2
├── .gitignore          # Arquivos ignorados pelo Git
└── README.md           # Este arquivo
```

## 📱 Funcionalidades

O chatbot possui um menu interativo com as seguintes opções:

1. **Serviços e equipamentos** - Encaminha para o gestor regional
2. **Questões administrativas/financeiras** - Encaminha para o diretor comercial
3. **Envio de currículos** - Fornece email de RH

### Recursos:
- ✅ Saudação personalizada (bom dia/tarde/noite)
- ✅ Menu interativo por regiões (RS, SC, SP, Outras)
- ✅ Comando "voltar" para retornar ao menu
- ✅ Bloqueio de mídias (áudio, foto, vídeo)
- ✅ Expiração de sessão após 2 horas de inatividade
- ✅ Apenas mensagens privadas (ignora grupos)

## 🐛 Troubleshooting

### QR Code não aparece
```bash
pm2 logs chatbot-otimizare --lines 100
```

### Bot não responde
```bash
pm2 restart chatbot-otimizare
pm2 logs chatbot-otimizare
```

### Erro de memória
O PM2 está configurado para reiniciar automaticamente se usar mais de 500MB de RAM.

### Desconexão do WhatsApp
Se o WhatsApp desconectar, o bot tentará reconectar automaticamente. Verifique os logs:
```bash
pm2 logs chatbot-otimizare
```

## 📞 Contatos Configurados

- **Lucas Morim** - Diretor Comercial: (51) 9292-2628
- **João Soares** - Gestor Comercial SP: (19) 99718-8587
- **Email RH**: recrutamento@otimizare.com

## ⚠️ Importante

- Mantenha o WhatsApp conectado no celular
- Não use o mesmo número em múltiplos dispositivos
- Faça backup regular da pasta `.wwebjs_auth/`
- Monitore os logs regularmente
