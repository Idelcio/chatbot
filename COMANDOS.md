# 🎯 Comandos Úteis - Chatbot

## 🚀 Deploy Rápido

### Fazer deploy de alterações
```bash
# Adicionar todas as alterações
git add .

# Commit com mensagem
git commit -m "Descrição das alterações"

# Enviar para o GitHub (deploy automático)
git push
```

### Deploy em um único comando
```bash
git add . && git commit -m "Atualização" && git push
```

---

## 📝 Git - Comandos Essenciais

### Ver status do repositório
```bash
git status
```

### Ver histórico de commits
```bash
# Últimos 10 commits
git log --oneline -10

# Histórico completo
git log
```

### Ver diferenças antes de commitar
```bash
# Ver todas as alterações
git diff

# Ver alterações de um arquivo específico
git diff chatbot.js
```

### Desfazer alterações
```bash
# Desfazer alterações não commitadas em um arquivo
git restore chatbot.js

# Desfazer todas as alterações não commitadas
git restore .
```

### Ver branches
```bash
# Listar branches
git branch

# Criar nova branch
git branch nome-da-branch

# Mudar de branch
git checkout nome-da-branch

# Criar e mudar para nova branch
git checkout -b nome-da-branch
```

---

## 🔍 Verificação e Monitoramento

### Verificar deploy no Render
1. Acesse: https://dashboard.render.com
2. Veja a aba "Events" para status
3. Veja a aba "Logs" para logs em tempo real

### Ver logs do chatbot
- Acesse o dashboard do Render
- Clique no serviço
- Aba "Logs"

---

## 🧪 Testes Locais (Opcional)

### Instalar dependências
```bash
npm install
```

### Rodar localmente
```bash
node chatbot.js
```

### Rodar com PM2 (se instalado)
```bash
# Iniciar
pm2 start chatbot.js --name chatbot

# Ver status
pm2 status

# Ver logs
pm2 logs chatbot

# Parar
pm2 stop chatbot

# Reiniciar
pm2 restart chatbot
```

---

## 📦 NPM - Gerenciamento de Pacotes

### Instalar nova dependência
```bash
npm install nome-do-pacote
```

### Instalar dependência de desenvolvimento
```bash
npm install --save-dev nome-do-pacote
```

### Atualizar dependências
```bash
npm update
```

### Ver dependências instaladas
```bash
npm list --depth=0
```

### Verificar pacotes desatualizados
```bash
npm outdated
```

---

## 🔧 Manutenção

### Limpar cache do npm
```bash
npm cache clean --force
```

### Reinstalar dependências
```bash
# Deletar node_modules e package-lock.json
rm -rf node_modules package-lock.json

# Reinstalar
npm install
```

### Verificar versão do Node
```bash
node --version
```

### Verificar versão do npm
```bash
npm --version
```

---

## 📱 WhatsApp - Comandos do Bot

Comandos que os usuários podem usar no bot:

- **voltar** - Volta ao menu principal
- **1** - Opção 1 do menu
- **2** - Opção 2 do menu
- **3** - Opção 3 do menu
- **4** - Opção 4 do menu

---

## 🎨 Atalhos do VS Code

### Formatação
- `Shift + Alt + F` - Formatar documento
- `Ctrl + K, Ctrl + F` - Formatar seleção

### Navegação
- `Ctrl + P` - Buscar arquivo
- `Ctrl + Shift + F` - Buscar em todos os arquivos
- `Ctrl + G` - Ir para linha

### Edição
- `Ctrl + D` - Selecionar próxima ocorrência
- `Alt + Seta` - Mover linha
- `Shift + Alt + Seta` - Duplicar linha
- `Ctrl + /` - Comentar/descomentar

### Terminal
- `Ctrl + '` - Abrir/fechar terminal
- `Ctrl + Shift + '` - Novo terminal

---

## 🔄 Workflow Completo

### 1. Fazer alterações no código
```bash
# Editar arquivo (ex: chatbot.js)
code chatbot.js
```

### 2. Testar localmente (opcional)
```bash
node chatbot.js
```

### 3. Commitar e fazer deploy
```bash
git add .
git commit -m "Descrição clara da alteração"
git push
```

### 4. Verificar deploy
- Acessar dashboard do Render
- Verificar logs
- Testar o bot no WhatsApp

---

## 💡 Dicas

### Mensagens de commit descritivas
```bash
# ✅ Bom
git commit -m "Adiciona validação de CPF no cadastro"
git commit -m "Corrige erro no menu de opções"
git commit -m "Atualiza mensagem de boas-vindas"

# ❌ Ruim
git commit -m "fix"
git commit -m "update"
git commit -m "changes"
```

### Verificar antes de commitar
```bash
# Ver o que mudou
git status
git diff

# Adicionar apenas arquivos específicos
git add chatbot.js
git add package.json

# Depois commitar
git commit -m "Mensagem descritiva"
```

### Desfazer último commit (sem perder alterações)
```bash
git reset --soft HEAD~1
```

### Desfazer último commit (perdendo alterações)
```bash
git reset --hard HEAD~1
```

---

## 🚨 Comandos de Emergência

### Reverter para commit anterior
```bash
# Ver histórico
git log --oneline

# Reverter para commit específico
git revert <hash-do-commit>
```

### Forçar push (use com cuidado!)
```bash
git push --force
```

### Limpar tudo e voltar ao último commit
```bash
git reset --hard HEAD
git clean -fd
```

---

## 📚 Recursos Úteis

- **Git Docs**: https://git-scm.com/doc
- **Render Docs**: https://render.com/docs
- **WhatsApp Web.js**: https://wwebjs.dev/
- **Node.js Docs**: https://nodejs.org/docs

---

## ⚡ Comandos Mais Usados (Resumo)

```bash
# Deploy completo
git add . && git commit -m "Atualização" && git push

# Ver status
git status

# Ver logs
git log --oneline -10

# Desfazer alterações
git restore .

# Atualizar dependências
npm install
```

---

**Salve este arquivo para referência rápida!** 📌
