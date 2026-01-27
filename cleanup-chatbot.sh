#!/bin/bash

# =====================================
# Script de Limpeza e Monitoramento
# Otimizare Chatbot
# =====================================

LOG_FILE="/var/log/chatbot-cleanup.log"
MAX_CPU_PERCENT=80
MAX_CHROME_PROCESSES=5

echo "========================================" >> "$LOG_FILE"
echo "$(date '+%Y-%m-%d %H:%M:%S') - Iniciando verificação" >> "$LOG_FILE"

# =====================================
# 1. Verificar processos Chrome órfãos
# =====================================
CHROME_COUNT=$(ps aux | grep -c '[c]hrome.*--type=renderer')

if [ "$CHROME_COUNT" -gt "$MAX_CHROME_PROCESSES" ]; then
    echo "⚠️ Encontrados $CHROME_COUNT processos Chrome (limite: $MAX_CHROME_PROCESSES)" >> "$LOG_FILE"
    echo "🧹 Limpando processos Chrome órfãos..." >> "$LOG_FILE"
    
    pkill -f 'chrome.*--type=renderer'
    
    echo "✅ Processos Chrome limpos" >> "$LOG_FILE"
fi

# =====================================
# 2. Verificar uso de CPU do chatbot
# =====================================
CHATBOT_PID=$(pm2 jlist | grep -o '"pid":[0-9]*' | head -1 | grep -o '[0-9]*')

if [ ! -z "$CHATBOT_PID" ]; then
    CPU_USAGE=$(ps -p "$CHATBOT_PID" -o %cpu= | awk '{print int($1)}')
    
    if [ "$CPU_USAGE" -gt "$MAX_CPU_PERCENT" ]; then
        echo "⚠️ CPU do chatbot em ${CPU_USAGE}% (limite: ${MAX_CPU_PERCENT}%)" >> "$LOG_FILE"
        echo "🔄 Reiniciando chatbot..." >> "$LOG_FILE"
        
        # Limpa processos Chrome antes de reiniciar
        pkill -f 'chrome'
        sleep 2
        
        # Reinicia o chatbot via PM2
        pm2 restart chatbot-otimizare
        
        echo "✅ Chatbot reiniciado" >> "$LOG_FILE"
    else
        echo "✅ CPU normal: ${CPU_USAGE}%" >> "$LOG_FILE"
    fi
else
    echo "⚠️ Chatbot não está rodando!" >> "$LOG_FILE"
    echo "🔄 Iniciando chatbot..." >> "$LOG_FILE"
    
    cd /root/chatbot
    pm2 start chatbot-otimizare
    
    echo "✅ Chatbot iniciado" >> "$LOG_FILE"
fi

# =====================================
# 3. Limpar logs antigos (mais de 7 dias)
# =====================================
find /root/.pm2/logs/ -name "*.log" -mtime +7 -delete 2>/dev/null

# =====================================
# 4. Verificar espaço em disco
# =====================================
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$DISK_USAGE" -gt 80 ]; then
    echo "⚠️ Espaço em disco: ${DISK_USAGE}%" >> "$LOG_FILE"
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Verificação concluída" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"
