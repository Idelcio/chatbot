#!/bin/bash

# =====================================
# Sistema de Monitoramento com Email (Gmail)
# Otimizare Chatbot
# =====================================

# =====================================
# CONFIGURAÇÕES - EDITE AQUI
# =====================================
EMAIL_DESTINO="idelcioforest@gmail.com"           # Email que vai receber os alertas
EMAIL_REMETENTE="idelcioforest@gmail.com"         # Email do Gmail que vai enviar
SENHA_APP_GMAIL="wqft rvgu kzbo ejjt"             # Senha de app do Gmail

NOME_CHATBOT="chatbot-otimizare"
LOG_FILE="/var/log/chatbot-monitor.log"
ESTADO_FILE="/tmp/chatbot-estado.txt"

# =====================================
# FUNÇÃO: Enviar Email via Gmail SMTP
# =====================================
enviar_email() {
    local ASSUNTO="$1"
    local MENSAGEM="$2"
    
    # Criar arquivo temporário com a mensagem
    local TEMP_MSG="/tmp/email_msg_$$.txt"
    
    cat > "$TEMP_MSG" << EOF
From: Chatbot Monitor <$EMAIL_REMETENTE>
To: $EMAIL_DESTINO
Subject: $ASSUNTO
Content-Type: text/plain; charset=UTF-8

$MENSAGEM
EOF

    # Enviar via curl + Gmail SMTP
    curl --url 'smtps://smtp.gmail.com:465' \
         --ssl-reqd \
         --mail-from "$EMAIL_REMETENTE" \
         --mail-rcpt "$EMAIL_DESTINO" \
         --user "$EMAIL_REMETENTE:$SENHA_APP_GMAIL" \
         --upload-file "$TEMP_MSG" \
         --silent
    
    # Remover arquivo temporário
    rm -f "$TEMP_MSG"
    
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Email enviado: $ASSUNTO" >> "$LOG_FILE"
}

# =====================================
# VERIFICAR SE CHATBOT ESTÁ RODANDO
# =====================================
verificar_chatbot() {
    pm2 jlist | grep -q "\"name\":\"$NOME_CHATBOT\".*\"status\":\"online\""
    return $?
}

# =====================================
# LER ESTADO ANTERIOR
# =====================================
if [ -f "$ESTADO_FILE" ]; then
    ESTADO_ANTERIOR=$(cat "$ESTADO_FILE")
else
    ESTADO_ANTERIOR="online"
fi

# =====================================
# VERIFICAR ESTADO ATUAL
# =====================================
echo "========================================" >> "$LOG_FILE"
echo "$(date '+%Y-%m-%d %H:%M:%S') - Verificando chatbot..." >> "$LOG_FILE"

if verificar_chatbot; then
    ESTADO_ATUAL="online"
    echo "✅ Chatbot está ONLINE" >> "$LOG_FILE"
    
    # Se estava offline e agora está online, notificar recuperação
    if [ "$ESTADO_ANTERIOR" = "offline" ]; then
        MENSAGEM="🟢 CHATBOT RECUPERADO

O chatbot Otimizare voltou a funcionar!

Detalhes:
- Status: ONLINE
- Horário: $(date '+%d/%m/%Y às %H:%M:%S')
- Servidor: $(hostname)

O chatbot foi reiniciado automaticamente pelo sistema de monitoramento.

---
Este é um email automático do sistema de monitoramento."

        enviar_email "✅ Chatbot Otimizare - RECUPERADO" "$MENSAGEM"
    fi
    
else
    ESTADO_ATUAL="offline"
    echo "❌ Chatbot está OFFLINE" >> "$LOG_FILE"
    
    # Tentar reiniciar
    echo "🔄 Tentando reiniciar..." >> "$LOG_FILE"
    cd /root/chatbot
    pm2 restart "$NOME_CHATBOT"
    sleep 5
    
    # Verificar se reiniciou
    if verificar_chatbot; then
        echo "✅ Chatbot reiniciado com sucesso" >> "$LOG_FILE"
        ESTADO_ATUAL="online"
        
        MENSAGEM="⚠️ CHATBOT ESTAVA PARADO (mas foi reiniciado)

O chatbot Otimizare parou de funcionar, mas foi reiniciado automaticamente.

Detalhes:
- Status anterior: OFFLINE
- Status atual: ONLINE (reiniciado)
- Horário da detecção: $(date '+%d/%m/%Y às %H:%M:%S')
- Servidor: $(hostname)

O sistema detectou o problema e reiniciou o chatbot automaticamente.

---
Este é um email automático do sistema de monitoramento."

        enviar_email "⚠️ Chatbot Otimizare - REINICIADO AUTOMATICAMENTE" "$MENSAGEM"
        
    else
        echo "❌ Falha ao reiniciar chatbot" >> "$LOG_FILE"
        
        # Só envia email se mudou de online para offline
        if [ "$ESTADO_ANTERIOR" = "online" ]; then
            MENSAGEM="🔴 ALERTA: CHATBOT PARADO!

O chatbot Otimizare parou de funcionar e NÃO foi possível reiniciar automaticamente.

Detalhes:
- Status: OFFLINE
- Horário da detecção: $(date '+%d/%m/%Y às %H:%M:%S')
- Servidor: $(hostname)
- Tentativa de reinício: FALHOU

AÇÃO NECESSÁRIA:
Por favor, acesse o servidor e verifique o problema:

ssh root@46.202.148.205
pm2 logs $NOME_CHATBOT

---
Este é um email automático do sistema de monitoramento."

            enviar_email "🚨 URGENTE: Chatbot Otimizare PARADO!" "$MENSAGEM"
        fi
    fi
fi

# =====================================
# VERIFICAR CPU ALTA
# =====================================
CHATBOT_PID=$(pm2 jlist | grep -o '"pid":[0-9]*' | head -1 | grep -o '[0-9]*')

if [ ! -z "$CHATBOT_PID" ]; then
    CPU_USAGE=$(ps -p "$CHATBOT_PID" -o %cpu= | awk '{print int($1)}')
    
    if [ "$CPU_USAGE" -gt 90 ]; then
        echo "⚠️ CPU alta detectada: ${CPU_USAGE}%" >> "$LOG_FILE"
        
        MENSAGEM="⚠️ ALERTA: CPU ALTA NO CHATBOT

O chatbot Otimizare está usando muita CPU.

Detalhes:
- Uso de CPU: ${CPU_USAGE}%
- Horário: $(date '+%d/%m/%Y às %H:%M:%S')
- Servidor: $(hostname)

O sistema vai tentar reiniciar o chatbot automaticamente.

---
Este é um email automático do sistema de monitoramento."

        enviar_email "⚠️ Chatbot Otimizare - CPU ALTA (${CPU_USAGE}%)" "$MENSAGEM"
    fi
fi

# =====================================
# SALVAR ESTADO ATUAL
# =====================================
echo "$ESTADO_ATUAL" > "$ESTADO_FILE"

echo "$(date '+%Y-%m-%d %H:%M:%S') - Verificação concluída" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
