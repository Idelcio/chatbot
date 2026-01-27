# 🛡️ Sistema de Proteção e Monitoramento do Chatbot

## 📋 O que foi implementado?

### 1️⃣ **Melhorias no Código (chatbot.js)**

#### ✅ Proteção contra loops de QR Code
- **Limite de 3 tentativas** de geração de QR code
- **Timeout de 60 segundos** por tentativa
- Reinício automático se exceder o limite

#### ✅ Limpeza automática de processos Chrome
- Remove processos Chrome órfãos ao conectar
- Remove processos Chrome órfãos ao desconectar
- Previne acúmulo de processos

#### ✅ Tratamento inteligente de erros
- **Ignora erro `markedUnread`** (não é crítico)
- **Retry automático** em caso de falha no envio
- Logs mais informativos

#### ✅ Reconexão automática
- Reinicia automaticamente em caso de desconexão
- Limpa recursos antes de reiniciar
- PM2 gerencia o processo

---

### 2️⃣ **Script de Limpeza Automática (cleanup-chatbot.sh)**

O script monitora e limpa automaticamente:

- ✅ **Processos Chrome órfãos** (limite: 5 processos)
- ✅ **Uso de CPU** (reinicia se > 80%)
- ✅ **Logs antigos** (remove logs com +7 dias)
- ✅ **Espaço em disco** (alerta se > 80%)
- ✅ **Chatbot parado** (inicia automaticamente)

---

## 🚀 Como Instalar no Servidor

### **Passo 1: Fazer upload dos arquivos**

```bash
# Conectar ao servidor
ssh root@46.202.148.205

# Ir para a pasta do chatbot
cd /root/chatbot

# Os arquivos já foram modificados localmente
# Agora vamos fazer upload via git ou scp
```

### **Passo 2: Dar permissão de execução ao script**

```bash
chmod +x cleanup-chatbot.sh
```

### **Passo 3: Testar o script manualmente**

```bash
./cleanup-chatbot.sh

# Verificar o log
tail -20 /var/log/chatbot-cleanup.log
```

### **Passo 4: Configurar execução automática (Cron)**

```bash
# Editar crontab
crontab -e

# Adicionar esta linha (executa todo dia às 3h da manhã)
0 3 * * * /root/chatbot/cleanup-chatbot.sh

# OU executar a cada 6 horas:
0 */6 * * * /root/chatbot/cleanup-chatbot.sh

# Salvar e sair (Ctrl+X, depois Y, depois Enter)
```

### **Passo 5: Verificar se o cron foi configurado**

```bash
crontab -l
```

### **Passo 6: Reiniciar o chatbot com o novo código**

```bash
cd /root/chatbot

# Parar o chatbot
pm2 stop chatbot-otimizare

# Limpar processos Chrome órfãos
pkill -f chrome

# Iniciar o chatbot com o novo código
pm2 start chatbot-otimizare

# Verificar logs
pm2 logs chatbot-otimizare --lines 30
```

---

## 📊 Monitoramento

### **Ver logs do script de limpeza**
```bash
tail -f /var/log/chatbot-cleanup.log
```

### **Ver logs do chatbot**
```bash
pm2 logs chatbot-otimizare
```

### **Verificar processos Chrome**
```bash
ps aux | grep chrome | wc -l
```

### **Verificar uso de CPU**
```bash
top -b -n 1 | head -20
```

---

## 🔧 Configurações Personalizáveis

### No arquivo `chatbot.js`:
```javascript
const MAX_QR_ATTEMPTS = 3;      // Máximo de tentativas de QR code
const QR_TIMEOUT_MS = 60000;    // Timeout por tentativa (60s)
```

### No arquivo `cleanup-chatbot.sh`:
```bash
MAX_CPU_PERCENT=80              # Reinicia se CPU > 80%
MAX_CHROME_PROCESSES=5          # Limpa se Chrome > 5 processos
```

---

## ❓ Perguntas Frequentes

### **Vou precisar ler o QR code novamente?**
Não! As melhorias mantêm a sessão do WhatsApp. Você só precisará ler o QR code se:
- Deletar manualmente as pastas `.wwebjs_auth` ou `.wwebjs_cache`
- Deslogar o dispositivo no WhatsApp

### **O que acontece se o chatbot travar?**
O script de limpeza vai:
1. Detectar o alto uso de CPU
2. Limpar processos Chrome órfãos
3. Reiniciar o chatbot automaticamente
4. **Manter a sessão do WhatsApp**

### **Com que frequência o script roda?**
Depende da configuração do cron:
- **Recomendado**: A cada 6 horas (`0 */6 * * *`)
- **Alternativa**: Todo dia às 3h (`0 3 * * *`)

### **Posso executar o script manualmente?**
Sim! Basta rodar:
```bash
/root/chatbot/cleanup-chatbot.sh
```

---

## 🎯 Benefícios

✅ **Previne CPU em 100%**
✅ **Evita acúmulo de processos Chrome**
✅ **Mantém a sessão do WhatsApp**
✅ **Reinício automático em caso de problemas**
✅ **Logs para diagnóstico**
✅ **Limpeza automática de recursos**

---

## 📝 Notas Importantes

1. **Backup da sessão**: As pastas `.wwebjs_auth` e `.wwebjs_cache` são preservadas
2. **PM2 gerencia restarts**: O chatbot reinicia automaticamente se cair
3. **Logs rotativos**: Logs antigos são deletados automaticamente
4. **Monitoramento contínuo**: O script verifica saúde do sistema

---

## 🆘 Suporte

Se algo der errado:

1. Verificar logs: `pm2 logs chatbot-otimizare`
2. Verificar script: `tail -50 /var/log/chatbot-cleanup.log`
3. Verificar processos: `ps aux | grep -E "chrome|node"`
4. Reiniciar manualmente: `pm2 restart chatbot-otimizare`

---

**Última atualização**: 27/01/2026
**Versão**: 2.0 (com proteções anti-loop)
