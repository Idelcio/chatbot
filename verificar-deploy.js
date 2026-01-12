#!/usr/bin/env node

/**
 * Script de verificação pré-deploy
 * Verifica se todos os arquivos necessários estão presentes
 * e se as configurações estão corretas
 */

const fs = require('fs');
const path = require('path');

console.log('🔍 Verificando configuração para deploy na Hostinger...\n');

let erros = 0;
let avisos = 0;

// Arquivos obrigatórios
const arquivosObrigatorios = [
    'chatbot.js',
    'package.json',
    'ecosystem.config.js',
    'README.md',
    'DEPLOY_HOSTINGER.md'
];

// Arquivos que NÃO devem ser enviados
const arquivosProibidos = [
    'node_modules',
    '.wwebjs_auth',
    '.wwebjs_cache'
];

console.log('📋 Verificando arquivos obrigatórios...');
arquivosObrigatorios.forEach(arquivo => {
    if (fs.existsSync(arquivo)) {
        console.log(`  ✅ ${arquivo}`);
    } else {
        console.log(`  ❌ ${arquivo} - FALTANDO!`);
        erros++;
    }
});

console.log('\n🚫 Verificando arquivos que não devem ser enviados...');
arquivosProibidos.forEach(arquivo => {
    if (fs.existsSync(arquivo)) {
        console.log(`  ⚠️  ${arquivo} - Não envie para o servidor!`);
        avisos++;
    } else {
        console.log(`  ✅ ${arquivo} - OK (não existe localmente)`);
    }
});

// Verificar package.json
console.log('\n📦 Verificando package.json...');
try {
    const packageJson = JSON.parse(fs.readFileSync('package.json', 'utf8'));

    if (packageJson.name) {
        console.log(`  ✅ Nome: ${packageJson.name}`);
    } else {
        console.log('  ❌ Nome não definido!');
        erros++;
    }

    if (packageJson.scripts && packageJson.scripts.start) {
        console.log(`  ✅ Script start: ${packageJson.scripts.start}`);
    } else {
        console.log('  ❌ Script start não definido!');
        erros++;
    }

    if (packageJson.scripts && packageJson.scripts['pm2:start']) {
        console.log(`  ✅ Script pm2:start: ${packageJson.scripts['pm2:start']}`);
    } else {
        console.log('  ❌ Script pm2:start não definido!');
        erros++;
    }

    if (packageJson.engines && packageJson.engines.node) {
        console.log(`  ✅ Node.js version: ${packageJson.engines.node}`);
    } else {
        console.log('  ⚠️  Versão do Node.js não especificada');
        avisos++;
    }

    const dependenciasNecessarias = ['whatsapp-web.js', 'qrcode-terminal', 'pm2'];
    dependenciasNecessarias.forEach(dep => {
        if (packageJson.dependencies && packageJson.dependencies[dep]) {
            console.log(`  ✅ Dependência: ${dep}`);
        } else {
            console.log(`  ❌ Dependência faltando: ${dep}`);
            erros++;
        }
    });

} catch (error) {
    console.log(`  ❌ Erro ao ler package.json: ${error.message}`);
    erros++;
}

// Verificar ecosystem.config.js
console.log('\n⚙️  Verificando ecosystem.config.js...');
try {
    const ecosystem = require('./ecosystem.config.js');

    if (ecosystem.apps && ecosystem.apps.length > 0) {
        console.log(`  ✅ Configuração PM2 encontrada`);
        const app = ecosystem.apps[0];

        if (app.name) {
            console.log(`  ✅ Nome da aplicação: ${app.name}`);
        }

        if (app.script) {
            console.log(`  ✅ Script: ${app.script}`);
        }

        if (app.autorestart) {
            console.log(`  ✅ Auto-restart habilitado`);
        }

    } else {
        console.log('  ❌ Configuração PM2 inválida!');
        erros++;
    }

} catch (error) {
    console.log(`  ❌ Erro ao ler ecosystem.config.js: ${error.message}`);
    erros++;
}

// Verificar chatbot.js
console.log('\n🤖 Verificando chatbot.js...');
try {
    const chatbotCode = fs.readFileSync('chatbot.js', 'utf8');

    if (chatbotCode.includes('whatsapp-web.js')) {
        console.log('  ✅ Importação do whatsapp-web.js encontrada');
    } else {
        console.log('  ❌ Importação do whatsapp-web.js não encontrada!');
        erros++;
    }

    if (chatbotCode.includes('LocalAuth')) {
        console.log('  ✅ LocalAuth configurado');
    } else {
        console.log('  ⚠️  LocalAuth não encontrado - sessão não será salva');
        avisos++;
    }

    if (chatbotCode.includes('--no-sandbox')) {
        console.log('  ✅ Puppeteer configurado para servidor');
    } else {
        console.log('  ⚠️  Configuração do Puppeteer pode não funcionar no servidor');
        avisos++;
    }

} catch (error) {
    console.log(`  ❌ Erro ao ler chatbot.js: ${error.message}`);
    erros++;
}

// Resumo
console.log('\n' + '='.repeat(50));
console.log('📊 RESUMO DA VERIFICAÇÃO');
console.log('='.repeat(50));

if (erros === 0 && avisos === 0) {
    console.log('\n✅ Tudo pronto para o deploy! 🚀');
    console.log('\nPróximos passos:');
    console.log('1. Leia o arquivo DEPLOY_HOSTINGER.md');
    console.log('2. Faça upload dos arquivos obrigatórios');
    console.log('3. Conecte via SSH e execute: npm install');
    console.log('4. Inicie com: npm run pm2:start');
    console.log('5. Escaneie o QR Code');
} else {
    if (erros > 0) {
        console.log(`\n❌ ${erros} erro(s) encontrado(s)!`);
        console.log('Corrija os erros antes de fazer o deploy.');
    }

    if (avisos > 0) {
        console.log(`\n⚠️  ${avisos} aviso(s) encontrado(s).`);
        console.log('Os avisos não impedem o deploy, mas devem ser revisados.');
    }
}

console.log('\n' + '='.repeat(50));

process.exit(erros > 0 ? 1 : 0);
