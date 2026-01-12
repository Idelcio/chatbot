# 🚀 Comandos Rápidos - Hostinger Deploy

## 📦 Instalação (Primeira vez)

```bash
# 1. Conectar via SSH
ssh u123456789@seu-dominio.com -p 65002

# 2. Navegar até a pasta
cd ~/domains/seu-dominio.com/public_html/chatbot

# 3. Instalar dependências
npm install

# 4. Iniciar com PM2
npm run pm2:start

# 5. Ver logs e escanear QR Code
pm2 logs chatbot-otimizare
```

---

## 🔄 Atualização (Após modificar código)

```bash
# 1. Fazer upload do arquivo modificado via FTP/SFTP

# 2. Conectar via SSH
ssh u123456789@seu-dominio.com -p 65002

# 3. Reiniciar o bot
pm2 restart chatbot-otimizare

# 4. Verificar logs
pm2 logs chatbot-otimizare
```

---

## 📊 Monitoramento

```bash
# Ver status
pm2 status

# Ver logs em tempo real
pm2 logs chatbot-otimizare

# Ver últimas 100 linhas
pm2 logs chatbot-otimizare --lines 100

# Monitor de CPU/Memória
pm2 monit
```

---

## 🛠️ Manutenção

```bash
# Reiniciar
pm2 restart chatbot-otimizare

# Parar
pm2 stop chatbot-otimizare

# Iniciar
pm2 start chatbot-otimizare

# Deletar do PM2
pm2 delete chatbot-otimizare
```

---

## 🔄 Reconectar WhatsApp

```bash
# 1. Parar o bot
pm2 stop chatbot-otimizare

# 2. Deletar sessão antiga
rm -rf .wwebjs_auth .wwebjs_cache

# 3. Reiniciar
pm2 restart chatbot-otimizare

# 4. Ver QR Code nos logs
pm2 logs chatbot-otimizare
```

---

## 💾 Backup

```bash
# Criar backup da sessão
tar -czf wwebjs_backup_$(date +%Y%m%d).tar.gz .wwebjs_auth

# Restaurar backup
tar -xzf wwebjs_backup_YYYYMMDD.tar.gz
```

---

## 🆘 Troubleshooting

```bash
# Ver informações detalhadas
pm2 show chatbot-otimizare

# Ver logs de erro
pm2 logs chatbot-otimizare --err

# Reiniciar tudo
pm2 restart all

# Limpar logs antigos
pm2 flush
```

---

## ⚙️ Configuração Auto-Start

```bash
# Salvar configuração
pm2 save

# Configurar startup
pm2 startup

# Executar o comando que aparecer
```

---

## 📱 Testar Funcionamento

1. Envie uma mensagem para o número do WhatsApp
2. Deve receber o menu automaticamente
3. Teste as opções (1, 2, 3)
4. Teste o comando "voltar"

---

## 📞 Suporte Hostinger

- Painel: https://hpanel.hostinger.com
- Suporte: Chat ao vivo no painel
- Documentação: https://support.hostinger.com
