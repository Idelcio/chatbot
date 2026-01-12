# 🚀 Guia de Deploy na Hostinger - Passo a Passo

## ✅ Checklist Pré-Deploy

Antes de fazer o deploy, certifique-se de que você tem:
- [ ] Acesso SSH habilitado no painel da Hostinger
- [ ] Node.js instalado no servidor (versão 18 ou superior)
- [ ] Credenciais SSH em mãos

---

## 📦 Passo 1: Preparar os Arquivos

### Arquivos que DEVEM ser enviados:
```
✅ chatbot.js
✅ package.json
✅ ecosystem.config.js
✅ README.md
✅ .gitignore
```

### Arquivos que NÃO devem ser enviados:
```
❌ node_modules/
❌ .wwebjs_auth/
❌ .wwebjs_cache/
❌ package-lock.json (opcional, será gerado no servidor)
```

---

## 🌐 Passo 2: Fazer Upload via FTP/SFTP

### Opção A: Usando FileZilla ou WinSCP
1. Conecte-se ao servidor via SFTP
2. Navegue até a pasta do seu domínio (geralmente `~/domains/seu-dominio.com/public_html/`)
3. Crie uma pasta chamada `chatbot`
4. Faça upload dos arquivos listados acima

### Opção B: Usando o File Manager da Hostinger
1. Acesse o painel da Hostinger
2. Vá em "Files" → "File Manager"
3. Navegue até `public_html`
4. Crie uma pasta `chatbot`
5. Faça upload dos arquivos

---

## 🔌 Passo 3: Conectar via SSH

1. No painel da Hostinger, vá em "Advanced" → "SSH Access"
2. Copie o comando SSH fornecido (algo como):
   ```bash
   ssh u123456789@seu-dominio.com -p 65002
   ```
3. Cole no seu terminal (PowerShell, CMD, ou Git Bash)
4. Digite a senha quando solicitado

---

## 📥 Passo 4: Instalar Dependências

Após conectar via SSH:

```bash
# Navegar até a pasta do chatbot
cd ~/domains/seu-dominio.com/public_html/chatbot

# OU se estiver em outro local:
cd ~/chatbot

# Verificar se os arquivos estão lá
ls -la

# Instalar as dependências
npm install
```

**Aguarde a instalação concluir** (pode levar alguns minutos).

---

## 🚀 Passo 5: Iniciar o Chatbot com PM2

```bash
# Iniciar o chatbot
npm run pm2:start

# OU diretamente:
pm2 start ecosystem.config.js

# Verificar se está rodando
pm2 status
```

Você deve ver algo como:
```
┌─────┬──────────────────────┬─────────┬─────────┬──────────┐
│ id  │ name                 │ status  │ restart │ uptime   │
├─────┼──────────────────────┼─────────┼─────────┼──────────┤
│ 0   │ chatbot-otimizare    │ online  │ 0       │ 0s       │
└─────┴──────────────────────┴─────────┴─────────┴──────────┘
```

---

## 📱 Passo 6: Escanear QR Code

**IMPORTANTE:** Na primeira execução, você precisa conectar o WhatsApp.

```bash
# Ver os logs em tempo real
pm2 logs chatbot-otimizare

# OU ver apenas as últimas 50 linhas
pm2 logs chatbot-otimizare --lines 50
```

### O que você verá:
```
📲 Escaneie o QR Code abaixo:
█████████████████████████████
█████████████████████████████
█████████████████████████████
...
```

### Como escanear:
1. Abra o WhatsApp no seu celular
2. Vá em **Configurações** → **Aparelhos conectados**
3. Toque em **Conectar um aparelho**
4. Escaneie o QR Code que apareceu no terminal

### Após escanear:
Você verá a mensagem:
```
✅ Tudo certo! WhatsApp conectado.
```

**Pressione `Ctrl + C` para sair dos logs** (o bot continuará rodando em background).

---

## 🔄 Passo 7: Configurar Auto-Start (Opcional mas Recomendado)

Para o chatbot iniciar automaticamente se o servidor reiniciar:

```bash
# Salvar a configuração atual
pm2 save

# Configurar para iniciar no boot
pm2 startup

# Copie e execute o comando que aparecer (algo como):
# sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u seu-usuario --hp /home/seu-usuario
```

---

## 🎯 Comandos Úteis

### Gerenciar o Chatbot
```bash
# Ver status
pm2 status

# Ver logs em tempo real
pm2 logs chatbot-otimizare

# Ver logs (últimas 100 linhas)
pm2 logs chatbot-otimizare --lines 100

# Reiniciar
pm2 restart chatbot-otimizare

# Parar
pm2 stop chatbot-otimizare

# Deletar do PM2
pm2 delete chatbot-otimizare

# Ver informações detalhadas
pm2 show chatbot-otimizare
```

### Monitoramento
```bash
# Monitor em tempo real (CPU, memória)
pm2 monit

# Listar todos os processos
pm2 list
```

---

## 🐛 Troubleshooting

### ❌ Problema: "npm: command not found"
**Solução:** Node.js não está instalado. Entre em contato com o suporte da Hostinger para instalar Node.js 18+.

### ❌ Problema: "pm2: command not found"
**Solução:** 
```bash
npm install -g pm2
```

### ❌ Problema: QR Code não aparece
**Solução:**
```bash
# Parar o bot
pm2 stop chatbot-otimizare

# Deletar sessão antiga
rm -rf .wwebjs_auth .wwebjs_cache

# Reiniciar
pm2 restart chatbot-otimizare

# Ver logs
pm2 logs chatbot-otimizare
```

### ❌ Problema: Bot desconecta sozinho
**Solução:**
- Verifique se o WhatsApp está conectado no celular
- Não use o mesmo número em múltiplos dispositivos
- Verifique os logs: `pm2 logs chatbot-otimizare`

### ❌ Problema: "Error: ENOSPC: System limit for number of file watchers reached"
**Solução:**
```bash
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

### ❌ Problema: Memória insuficiente
**Solução:** O PM2 está configurado para reiniciar se usar mais de 500MB. Você pode aumentar:
```bash
# Editar ecosystem.config.js
nano ecosystem.config.js

# Alterar: max_memory_restart: "1G"
```

---

## 📊 Verificar se está Funcionando

1. **Envie uma mensagem** para o número do WhatsApp conectado
2. **Você deve receber** o menu de boas-vindas automaticamente
3. **Teste as opções** do menu (1, 2, 3)
4. **Teste o comando** "voltar"

---

## 🔒 Segurança

### Backup da Sessão do WhatsApp
É importante fazer backup regular da pasta de autenticação:

```bash
# Criar backup
tar -czf wwebjs_auth_backup_$(date +%Y%m%d).tar.gz .wwebjs_auth

# Baixar via SFTP ou mover para local seguro
```

### Restaurar Backup
```bash
# Extrair backup
tar -xzf wwebjs_auth_backup_YYYYMMDD.tar.gz
```

---

## 📞 Suporte

Se tiver problemas:
1. Verifique os logs: `pm2 logs chatbot-otimizare`
2. Verifique o status: `pm2 status`
3. Reinicie: `pm2 restart chatbot-otimizare`
4. Entre em contato com o suporte da Hostinger se for problema de servidor

---

## ✅ Checklist Pós-Deploy

- [ ] Chatbot está rodando (`pm2 status` mostra "online")
- [ ] QR Code foi escaneado
- [ ] WhatsApp está conectado (mensagem "✅ Tudo certo!")
- [ ] Teste enviando mensagem e recebendo menu
- [ ] PM2 configurado para auto-start (`pm2 save` executado)
- [ ] Backup da pasta `.wwebjs_auth` criado

---

## 🎉 Pronto!

Seu chatbot agora está rodando 24/7 na Hostinger! 🚀

Para qualquer atualização futura:
1. Faça upload do arquivo modificado
2. Execute: `pm2 restart chatbot-otimizare`
