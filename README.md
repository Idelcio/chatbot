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

## 🌐 Deploy no Render.com

Este projeto está configurado com **deploy automático** no Render.com.

### Como funciona:

1. **Faça suas alterações** no código localmente
2. **Commit e push** para o GitHub:
   ```bash
   git add .
   git commit -m "Descrição das alterações"
   git push
   ```
3. **Deploy automático** - O Render detecta o push e faz o deploy automaticamente!

### Primeira configuração (já feita):

O serviço já está configurado no Render.com com:
- ✅ Repositório GitHub conectado
- ✅ Deploy automático habilitado
- ✅ Build command: `npm install`
- ✅ Start command: `npm start`

### Monitorar o deploy:

1. Acesse: https://dashboard.render.com
2. Faça login
3. Clique no serviço do chatbot
4. Veja a aba **"Events"** para histórico de deploys
5. Veja a aba **"Logs"** para logs em tempo real

### Escanear QR Code (primeira vez):

Na primeira execução ou após limpar a sessão:

1. Acesse os **Logs** no dashboard do Render
2. Procure pelo QR Code (será exibido como caracteres ASCII)
3. Abra o WhatsApp no celular
4. Vá em **Configurações** → **Aparelhos conectados**
5. Toque em **Conectar um aparelho**
6. Escaneie o QR Code que apareceu nos logs

### Para mais detalhes:

Veja o arquivo [DEPLOY.md](DEPLOY.md) para instruções completas.

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
Acesse os logs no dashboard do Render:
1. Vá para https://dashboard.render.com
2. Clique no serviço do chatbot
3. Aba "Logs"
4. Procure pelo QR Code nos logs

### Bot não responde
1. Verifique se o serviço está rodando no dashboard do Render
2. Veja os logs para identificar erros
3. Se necessário, faça um redeploy manual:
   - No dashboard, clique em "Manual Deploy" → "Deploy latest commit"

### Erro de memória
O Render monitora automaticamente o uso de memória. Se houver problemas:
1. Verifique os logs
2. Entre em contato com o suporte do Render se necessário

### Desconexão do WhatsApp
Se o WhatsApp desconectar, o bot tentará reconectar automaticamente. Verifique os logs no dashboard do Render para mais informações.

## 📞 Contatos Configurados

- **Lucas Morim** - Diretor Comercial: (51) 9292-2628
- **João Soares** - Gestor Comercial SP: (19) 99718-8587
- **Email RH**: recrutamento@otimizare.com

## ⚠️ Importante

- Mantenha o WhatsApp conectado no celular
- Não use o mesmo número em múltiplos dispositivos
- Faça backup regular da pasta `.wwebjs_auth/`
- Monitore os logs regularmente
