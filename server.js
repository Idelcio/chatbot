// Wrapper Express para compatibilidade com Hostinger
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Iniciar o chatbot em background
require('./chatbot.js');

// Rota de health check
app.get('/', (req, res) => {
    res.json({
        status: 'online',
        message: 'Chatbot WhatsApp - Otimizare está rodando!',
        timestamp: new Date().toISOString()
    });
});

app.get('/health', (req, res) => {
    res.json({
        status: 'ok',
        uptime: process.uptime(),
        memory: process.memoryUsage()
    });
});

app.listen(PORT, () => {
    console.log(`🌐 Servidor Express rodando na porta ${PORT}`);
    console.log(`🤖 Chatbot WhatsApp iniciado em background`);
});
