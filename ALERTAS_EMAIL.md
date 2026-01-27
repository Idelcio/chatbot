# 📧 Sistema de Alertas por Email (Gmail)

## 🎯 O que faz?

O sistema monitora o chatbot e **envia emails automáticos via Gmail** quando:

- 🔴 **Chatbot para** (e não consegue reiniciar)
- ⚠️ **CPU alta** (acima de 90%)
- 🟢 **Chatbot recupera** (volta a funcionar)
- ⚠️ **Chatbot reiniciado automaticamente**

---

## 📋 Pré-requisitos

Você vai precisar de:
1. ✅ Uma conta Gmail
2. ✅ Senha de App do Gmail (vou te ensinar a criar)
3. ✅ Acesso ao servidor (já tem)

---

## 🔑 Passo 1: Criar Senha de App do Gmail

### **1.1 - Ativar verificação em 2 etapas**

1. Acesse: https://myaccount.google.com/security
2. Clique em **"Verificação em duas etapas"**
3. Siga as instruções para ativar (se ainda não tiver)

### **1.2 - Gerar senha de app**

1. Acesse: https://myaccount.google.com/apppasswords
2. Em **"Selecionar app"**, escolha **"Outro (nome personalizado)"**
3. Digite: **"Chatbot Otimizare"**
4. Clique em **"Gerar"**
5. **COPIE A SENHA** (16 caracteres, ex: `abcd efgh ijkl mnop`)
6. ⚠️ **GUARDE ESSA SENHA** - você vai precisar dela!

---

## 🚀 Passo 2: Fazer upload do script

```bash
# No seu computador local
scp monitor-email.sh root@46.202.148.205:/root/chatbot/

# Ou via git (se preferir)
git add monitor-email.sh
git commit -m "feat: adiciona monitoramento com alertas por email"
git push

# No servidor
cd /root/chatbot
git pull
```

### **Passo 3: Configurar seu email**

```bash
# Editar o script no servidor
nano /root/chatbot/monitor-email.sh

# Alterar esta linha (linha 11):
EMAIL_DESTINO="seu-email@exemplo.com"  # ⚠️ ALTERE PARA SEU EMAIL

# Para (exemplo):
EMAIL_DESTINO="contato@otimizare.com"

# Salvar: Ctrl+X, depois Y, depois Enter
```

### **Passo 4: Dar permissão de execução**

```bash
chmod +x /root/chatbot/monitor-email.sh
```

### **Passo 5: Testar o script**

```bash
# Testar manualmente
/root/chatbot/monitor-email.sh

# Verificar o log
tail -20 /var/log/chatbot-monitor.log
```

### **Passo 6: Configurar execução automática (Cron)**

```bash
# Editar crontab
crontab -e

# Adicionar esta linha (verifica a cada 15 minutos):
*/15 * * * * /root/chatbot/monitor-email.sh

# OU verificar a cada 5 minutos (mais rápido):
*/5 * * * * /root/chatbot/monitor-email.sh

# Salvar e sair (Ctrl+X, depois Y, depois Enter)
```

### **Passo 7: Verificar se o cron foi configurado**

```bash
crontab -l
```

Você deve ver algo como:
```
0 */6 * * * /root/chatbot/cleanup-chatbot.sh
*/15 * * * * /root/chatbot/monitor-email.sh
```

---

## 📧 Tipos de Email que Você Vai Receber

### 🔴 **Chatbot Parado (URGENTE)**
```
Assunto: 🚨 URGENTE: Chatbot Otimizare PARADO!

O chatbot parou e NÃO foi possível reiniciar.
AÇÃO NECESSÁRIA: Acesse o servidor e verifique.
```

### ⚠️ **Chatbot Reiniciado Automaticamente**
```
Assunto: ⚠️ Chatbot Otimizare - REINICIADO AUTOMATICAMENTE

O chatbot parou mas foi reiniciado automaticamente.
Está funcionando novamente.
```

### 🟢 **Chatbot Recuperado**
```
Assunto: ✅ Chatbot Otimizare - RECUPERADO

O chatbot voltou a funcionar!
```

### ⚠️ **CPU Alta**
```
Assunto: ⚠️ Chatbot Otimizare - CPU ALTA (95%)

O chatbot está usando muita CPU.
O sistema vai tentar reiniciar automaticamente.
```

---

## 🔧 Configurações Personalizáveis

Edite o arquivo `monitor-email.sh`:

```bash
# Email de destino
EMAIL_DESTINO="seu-email@exemplo.com"

# Nome do chatbot no PM2
NOME_CHATBOT="chatbot-otimizare"

# Limite de CPU para alerta
# (Altere a linha: if [ "$CPU_USAGE" -gt 90 ])
# Exemplo: -gt 80 para alertar com 80%
```

---

## 📊 Monitoramento

### **Ver logs do monitoramento**
```bash
tail -f /var/log/chatbot-monitor.log
```

### **Ver últimos 50 logs**
```bash
tail -50 /var/log/chatbot-monitor.log
```

### **Testar envio de email manualmente**
```bash
echo "Teste" | mail -s "Teste Chatbot" seu-email@exemplo.com
```

---

## ❓ Perguntas Frequentes

### **Não estou recebendo emails. O que fazer?**

1. Verificar se o sendmail está instalado:
   ```bash
   which sendmail
   ```

2. Verificar logs do sendmail:
   ```bash
   tail -50 /var/log/mail.log
   ```

3. Testar envio manual:
   ```bash
   echo "Teste" | sendmail seu-email@exemplo.com
   ```

4. Verificar se o email não está na pasta de spam

### **Com que frequência o script verifica?**

Depende da configuração do cron:
- `*/5 * * * *` = A cada 5 minutos (recomendado)
- `*/15 * * * *` = A cada 15 minutos
- `*/30 * * * *` = A cada 30 minutos

### **Posso receber emails em múltiplos endereços?**

Sim! Altere a linha:
```bash
EMAIL_DESTINO="email1@exemplo.com,email2@exemplo.com"
```

### **O script vai enviar spam de emails?**

Não! O script tem lógica para:
- Só enviar email quando o **estado mudar** (online → offline)
- Não enviar emails repetidos se já estiver offline
- Enviar email de recuperação quando voltar

---

## 🎯 Benefícios

✅ **Notificação instantânea** quando o chatbot parar
✅ **Tentativa automática de reinício** antes de alertar
✅ **Histórico completo** em logs
✅ **Múltiplos tipos de alerta** (parado, CPU alta, recuperado)
✅ **Não envia spam** - só notifica mudanças de estado

---

## 🆘 Troubleshooting

### **Sendmail não funciona**

Alternativa usando **curl + API de email** (ex: SendGrid, Mailgun):

```bash
# Exemplo com SendGrid
curl -X POST https://api.sendgrid.com/v3/mail/send \
  -H "Authorization: Bearer SUA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "personalizations": [{"to": [{"email": "seu-email@exemplo.com"}]}],
    "from": {"email": "noreply@otimizare.com"},
    "subject": "Alerta Chatbot",
    "content": [{"type": "text/plain", "value": "Mensagem"}]
  }'
```

### **Emails vão para spam**

Configure SPF/DKIM no seu domínio ou use um serviço de email transacional (SendGrid, Mailgun, Amazon SES).

---

## 📝 Notas Importantes

1. **Teste primeiro**: Sempre teste o envio de email antes de confiar no sistema
2. **Verifique spam**: Primeiros emails podem ir para spam
3. **Múltiplos destinatários**: Adicione emails separados por vírgula
4. **Logs**: Sempre verifique os logs em `/var/log/chatbot-monitor.log`

---

**Última atualização**: 27/01/2026
**Versão**: 1.0 (Sistema de Alertas por Email)
