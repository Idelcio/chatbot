# 🚀 Guia de Deploy no Render.com

## ✅ Sobre o Deploy

Este chatbot está hospedado no **Render.com** com deploy automático configurado.

**Deploy automático significa:** Sempre que você fizer um `git push` para a branch `main`, o Render automaticamente:
- 📦 Baixa o código mais recente
- 🔧 Instala as dependências
- 🚀 Reinicia o serviço
- ✅ Aplica as alterações

---

## 📝 Como Fazer Deploy de Alterações

### Passo 1: Fazer as alterações no código
Edite os arquivos necessários (ex: `chatbot.js`)

### Passo 2: Commit e Push
```bash
# Adicionar alterações
git add .

# Fazer commit
git commit -m "Descrição das alterações"

# Enviar para o GitHub
git push
```

### Passo 3: Aguardar o Deploy Automático
- O Render detecta automaticamente o push
- O deploy inicia em segundos
- Leva cerca de 1-3 minutos para completar

---

## 🔍 Verificar Status do Deploy

### Opção 1: Dashboard do Render
1. Acesse: https://dashboard.render.com
2. Faça login com sua conta
3. Clique no serviço do chatbot
4. Veja a aba **"Events"** para histórico de deploys
5. Veja a aba **"Logs"** para logs em tempo real

### Opção 2: Notificações
O Render envia notificações por email quando:
- ✅ Deploy concluído com sucesso
- ❌ Deploy falhou

---

## 📊 Monitoramento

### Ver Logs em Tempo Real
1. Acesse o dashboard do Render
2. Clique no seu serviço
3. Vá na aba **"Logs"**
4. Os logs são atualizados automaticamente

### Verificar Status do Serviço
No dashboard você pode ver:
- 🟢 **Live** - Serviço rodando normalmente
- 🟡 **Deploying** - Deploy em andamento
- 🔴 **Failed** - Erro no deploy ou serviço parado

---

## 🔄 Comandos Úteis (Git)

### Ver status das alterações
```bash
git status
```

### Ver histórico de commits
```bash
git log --oneline -10
```

### Desfazer alterações não commitadas
```bash
git restore arquivo.js
```

### Ver diferenças antes de commitar
```bash
git diff
```

---

## 🐛 Troubleshooting

### ❌ Problema: Deploy falhou
**Solução:**
1. Verifique os logs no dashboard do Render
2. Procure por erros de sintaxe no código
3. Verifique se o `package.json` está correto
4. Tente fazer um novo commit com a correção

### ❌ Problema: Chatbot não responde após deploy
**Solução:**
1. Verifique os logs no Render
2. Pode ser necessário reconectar o WhatsApp (escanear QR code novamente)
3. Verifique se há erros de autenticação nos logs

### ❌ Problema: QR Code não aparece nos logs
**Solução:**
1. Acesse a aba "Logs" no dashboard do Render
2. Procure pela mensagem "📲 Escaneie o QR Code"
3. Se não aparecer, pode ser que já esteja conectado
4. Para forçar nova conexão, você pode limpar a sessão (via variáveis de ambiente ou suporte do Render)

### ❌ Problema: Mudanças não aparecem após push
**Solução:**
1. Verifique se o push foi bem-sucedido: `git log`
2. Verifique no dashboard do Render se um novo deploy foi iniciado
3. Aguarde o deploy completar (pode levar alguns minutos)
4. Limpe o cache do WhatsApp se necessário

---

## 🔒 Variáveis de Ambiente

Se você precisar configurar variáveis de ambiente:

1. Acesse o dashboard do Render
2. Clique no seu serviço
3. Vá em **"Environment"**
4. Adicione as variáveis necessárias
5. Clique em **"Save Changes"**
6. O serviço será reiniciado automaticamente

---

## 📱 Primeira Conexão do WhatsApp

Na primeira vez que o serviço é iniciado (ou após limpar a sessão):

1. Acesse os **Logs** no dashboard do Render
2. Procure pelo QR Code (será exibido como caracteres ASCII)
3. Abra o WhatsApp no celular
4. Vá em **Configurações** → **Aparelhos conectados**
5. Toque em **Conectar um aparelho**
6. Escaneie o QR Code que apareceu nos logs
7. Aguarde a mensagem: `✅ Tudo certo! WhatsApp conectado.`

---

## ✅ Checklist de Deploy

Antes de fazer push:
- [ ] Código testado localmente (se possível)
- [ ] Commit com mensagem descritiva
- [ ] Push para a branch `main`

Após o push:
- [ ] Verificar no dashboard do Render que o deploy iniciou
- [ ] Aguardar conclusão do deploy (1-3 minutos)
- [ ] Verificar logs para confirmar que está rodando
- [ ] Testar o chatbot enviando uma mensagem

---

## 🎯 Estrutura do Projeto

```
chatbot/
├── chatbot.js              # Código principal do bot
├── package.json            # Dependências e scripts
├── ecosystem.config.js     # Configuração do PM2 (se usar)
├── README.md              # Documentação do projeto
├── DEPLOY.md              # Este arquivo
└── .gitignore             # Arquivos ignorados pelo Git
```

### Arquivos que NÃO devem estar no Git:
```
❌ node_modules/           # Dependências (instaladas automaticamente)
❌ .wwebjs_auth/          # Sessão do WhatsApp
❌ .wwebjs_cache/         # Cache do WhatsApp
❌ package-lock.json      # Gerado automaticamente
```

---

## 📞 Suporte

### Problemas com o Render
- Documentação: https://render.com/docs
- Suporte: https://render.com/support

### Problemas com o Código
1. Verifique os logs no dashboard
2. Teste localmente se possível
3. Revise as últimas alterações feitas

---

## 🎉 Resumo

**Para fazer deploy:**
```bash
git add .
git commit -m "Sua mensagem"
git push
```

**Para verificar:**
- Acesse https://dashboard.render.com
- Veja os logs e o status do serviço

**Simples assim!** O Render cuida do resto automaticamente. 🚀
