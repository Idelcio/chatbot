// =====================================
// IMPORTAÇÕES
// =====================================
const qrcode = require("qrcode-terminal");
const { Client, LocalAuth } = require("whatsapp-web.js");

// =====================================
// CONFIGURAÇÃO DO CLIENTE
// =====================================
const client = new Client({
  authStrategy: new LocalAuth(),
  puppeteer: {
    headless: true,
    args: [
      "--no-sandbox",
      "--disable-setuid-sandbox",
      "--disable-dev-shm-usage",
      "--disable-gpu",
      "--single-process",
    ],
  },
});

// =====================================
// FUNÇÕES UTILITÁRIAS
// =====================================
const delay = (ms) => new Promise((res) => setTimeout(res, ms));

const getSaudacao = () => {
  const hora = new Date().getHours();
  if (hora >= 5 && hora < 12) return "Bom dia";
  if (hora >= 12 && hora < 18) return "Boa tarde";
  return "Boa noite";
};

// =====================================
// ESTADO DO USUÁRIO (FUNIL)
// =====================================
const estadoUsuario = {}; // { "5511...@c.us": "op1_escolhendo_regiao" | null }
const menuEnviado = {}; // { "5511...@c.us": true|false }
const ultimoMenu = {}; // { "5511...@c.us": "texto do menu da etapa" }
const ultimoContato = {}; // { "5511...@c.us": timestamp }

// Expiração por inatividade: 2 horas
const TEMPO_EXPIRACAO_MS = 2 * 60 * 60 * 1000; // 2h

// =====================================
// MENUS (TEXTOS)
// =====================================
const montarMenuPrincipal = () => {
  const saudacao = getSaudacao();
  return (
    `${saudacao}, espero que esteja bem!\n\n` +
    `Eu sou o Assistente Virtual da Otimizare e vou te encaminhar para a pessoa certa.\n\n` +
    `Escolha uma opção abaixo:\n\n` +
    `Apenas digite e envie o número da opção desejada:\n` +
    `1 - Quero saber mais sobre serviços e equipamentos\n` +
    `2 - Já sou cliente da Otimizare e quero resolver questões administrativas ou financeiras\n` +
    `3 - Eu gostaria de enviar um currículo para a Otimizare\n\n` +
    `Se precisar, digite *voltar* a qualquer momento para retornar ao menu.`
  );
};

const MENU_REGIOES =
  "Excelente! Agora só me confirme a sua região para que eu possa te encaminhar ao gestor regional correto.\n\n" +
  "1 - Rio Grande do Sul\n" +
  "2 - Santa Catarina\n" +
  "3 - São Paulo\n" +
  "4 - Outras regiões\n\n" +
  "Basta digitar e enviar o número correspondente.\n\n" +
  "Se precisar, digite *voltar* para retornar ao menu.";

// =====================================
// FUNÇÃO: enviar e memorizar menu da etapa
// =====================================
const enviarEMemorizarMenu = async (to, chat, textoMenu) => {
  ultimoMenu[to] = textoMenu;

  try {
    await delay(300);
    await chat.sendStateTyping();
    await delay(900);

    await chat.sendMessage(textoMenu);
  } catch (error) {
    console.error("Erro ao enviar mensagem:", error.message);
    // Fallback: tenta enviar sem typing
    try {
      await chat.sendMessage(textoMenu);
    } catch (fallbackError) {
      console.error("Erro no fallback:", fallbackError.message);
    }
  }
};

// =====================================
// FUNÇÃO: fallback (não entendi + reenvia menu da etapa atual)
// =====================================
const naoEntendiEReenviaMenuAtual = async (to, chat) => {
  try {
    await delay(300);
    await chat.sendStateTyping();
    await delay(900);

    await chat.sendMessage(
      "Não entendi. 🙂\n\nPor favor, responda usando as opções do menu."
    );

    const menu = ultimoMenu[to] || montarMenuPrincipal();

    await delay(200);
    await chat.sendStateTyping();
    await delay(700);

    await chat.sendMessage(menu);
  } catch (error) {
    console.error("Erro ao enviar mensagem de fallback:", error.message);
  }
};

// =====================================
// QR CODE
// =====================================
client.on("qr", (qr) => {
  console.log("📲 Escaneie o QR Code abaixo:");
  qrcode.generate(qr, { small: true });
});

// =====================================
// WHATSAPP CONECTADO
// =====================================
client.on("ready", () => {
  console.log("✅ Tudo certo! WhatsApp conectado.");
});

// =====================================
// DESCONEXÃO
// =====================================
client.on("disconnected", (reason) => {
  console.log("⚠️ Desconectado:", reason);
});

// =====================================
// INICIALIZA
// =====================================
client.initialize();

// =====================================
// HANDLER PRINCIPAL (SOMENTE PRIVADO)
// =====================================
client.on("message", async (msg) => {
  try {
    if (!msg || !msg.from) return;

    // Ignora grupos
    if (msg.from.endsWith("@g.us")) return;

    const chat = await msg.getChat();
    if (chat.isGroup) return;

    // =====================================
    // EXPIRA CONVERSA APÓS 2 HORAS SEM MENSAGENS
    // =====================================
    const agora = Date.now();
    const ultimo = ultimoContato[msg.from] || 0;

    if (agora - ultimo > TEMPO_EXPIRACAO_MS) {
      estadoUsuario[msg.from] = null;
      menuEnviado[msg.from] = false;
      ultimoMenu[msg.from] = null;
    }

    // Atualiza último contato
    ultimoContato[msg.from] = agora;

    const texto = (msg.body || "").trim().toLowerCase();

    // =====================================
    // BLOQUEIO DE MÍDIAS (ÁUDIO / FOTO / VÍDEO / ETC.)
    // =====================================
    const tiposMidia = ["image", "video", "audio", "ptt", "document", "sticker"];
    if (msg.hasMedia || tiposMidia.includes(msg.type)) {
      estadoUsuario[msg.from] = null;
      menuEnviado[msg.from] = true;

      await delay(300);
      await chat.sendStateTyping();
      await delay(900);

      await chat.sendMessage(
        "No momento eu não consigo reproduzir áudios, fotos ou vídeos. 🙂\n\n" +
        "Por favor, responda usando as opções do *menu*."
      );

      const menu = montarMenuPrincipal();
      await enviarEMemorizarMenu(msg.from, chat, menu);
      return;
    }

    // =====================================
    // COMANDO GLOBAL: "voltar" ou "menu"
    // =====================================
    if (texto === "voltar" || texto === "menu") {
      estadoUsuario[msg.from] = null;
      menuEnviado[msg.from] = true;

      const menu = montarMenuPrincipal();
      await enviarEMemorizarMenu(msg.from, chat, menu);
      return;
    }

    // =====================================
    // PRIMEIRA MENSAGEM (OU APÓS EXPIRAÇÃO): manda o menu SEMPRE
    // =====================================
    if (!menuEnviado[msg.from]) {
      menuEnviado[msg.from] = true;
      estadoUsuario[msg.from] = null;

      const menu = montarMenuPrincipal();
      await enviarEMemorizarMenu(msg.from, chat, menu);
      return;
    }

    // =====================================
    // SUBMENU: REGIÕES (estado op1_escolhendo_regiao)
    // =====================================
    if (estadoUsuario[msg.from] === "op1_escolhendo_regiao") {
      if (texto === "4") {
        await delay(300);
        await chat.sendStateTyping();
        await delay(900);

        await chat.sendMessage(
          "Perfeito! 👌\n\n" +
          "O responsável é:\n\n" +
          "*Lucas Morim*\n" +
          "Diretor Comercial – Otimizare\n" +
          "📞 WhatsApp: (51) 9292-2628\n" +
          "🔗 https://wa.me/555192922628\n\n" +
          "👉 Clique no link acima para falar diretamente com ele.\n\n" +
          "Se precisar, digite *voltar* para retornar ao menu."
        );

        estadoUsuario[msg.from] = null;
        ultimoMenu[msg.from] = montarMenuPrincipal();
        return;
      }

      if (texto === "1") {
        await delay(300);
        await chat.sendStateTyping();
        await delay(900);

        await chat.sendMessage(
          "Perfeito! 👌\n\n" +
          "Para atendimento no *Rio Grande do Sul*, o responsável é:\n\n" +
          "*Lucas Morim*\n" +
          "Diretor Comercial – Otimizare\n" +
          "📞 WhatsApp: (51) 9292-2628\n" +
          "🔗 https://wa.me/555192922628\n\n" +
          "👉 Clique no link acima para falar diretamente com ele.\n\n" +
          "Se precisar, digite *voltar* para retornar ao menu."
        );

        estadoUsuario[msg.from] = null;
        ultimoMenu[msg.from] = montarMenuPrincipal();
        return;
      }


      if (texto === "2") {
        await delay(300);
        await chat.sendStateTyping();
        await delay(900);

        await chat.sendMessage(
          "Perfeito! 👌\n\n" +
          "Para atendimento em *Santa Catarina*, o responsável é:\n\n" +
          "*Lucas Morim*\n" +
          "Diretor Comercial – Otimizare\n" +
          "📞 WhatsApp: (47) 9289-7397\n" +
          "🔗 https://wa.me/554792897397\n\n" +
          "👉 Clique no link acima para falar diretamente com ele.\n\n" +
          "Se precisar, digite *voltar* para retornar ao menu."
        );

        estadoUsuario[msg.from] = null;
        ultimoMenu[msg.from] = montarMenuPrincipal();
        return;
      }


      if (texto === "3") {
        await delay(300);
        await chat.sendStateTyping();
        await delay(900);

        await chat.sendMessage(
          "Perfeito! 👌\n\n" +
          "Para atendimento em *São Paulo*, o responsável é:\n\n" +
          "*João Soares*\n" +
          "Gestor Comercial – Região SP\n" +
          "📞 WhatsApp: (19) 99718-8587\n" +
          "🔗 https://wa.me/5519997188587\n\n" +
          "👉 Clique no link acima para falar diretamente com ele.\n\n" +
          "Se precisar, digite *voltar* para retornar ao menu."
        );

        estadoUsuario[msg.from] = null;
        ultimoMenu[msg.from] = montarMenuPrincipal();
        return;
      }

      // Qualquer coisa fora das opções no submenu -> não entendi + reenvia menu atual
      await naoEntendiEReenviaMenuAtual(msg.from, chat);
      return;
    }

    // =====================================
    // MENU PRINCIPAL (sem estado)
    // =====================================

    // 1 - Serviços e equipamentos
    if (texto === "1") {
      estadoUsuario[msg.from] = "op1_escolhendo_regiao";
      await enviarEMemorizarMenu(msg.from, chat, MENU_REGIOES);
      return;
    }

    // 2 - Cliente (adm/financeiro) -> Lucas
    if (texto === "2") {
      await delay(300);
      await chat.sendStateTyping();
      await delay(900);

      await chat.sendMessage(
        "Perfeito! 👌\n\n" +
        "Para tratar de questões *administrativas ou financeiras*, o responsável é:\n\n" +
        "*Lucas Morim*\n" +
        "Diretor Comercial – Otimizare\n" +
        "📞 WhatsApp: (51) 9292-2628\n" +
        "🔗 https://wa.me/555192922628\n\n" +
        "👉 Clique no link acima para falar diretamente com ele.\n\n" +
        "Se precisar, digite *voltar* para retornar ao menu."
      );

      estadoUsuario[msg.from] = null;
      ultimoMenu[msg.from] = montarMenuPrincipal();
      return;
    }

    // 3 - Currículos
    if (texto === "3") {
      await delay(300);
      await chat.sendStateTyping();
      await delay(900);

      await chat.sendMessage(
        "Perfeito! 👌\n\n" +
        "Envie seu currículo por e-mail para:\n\n" +
        "📧 *recrutamento@otimizare.com*\n\n" +
        "Se possível, envie em PDF, informe a área de interesse e se apresente, fale um pouco sobre você e/ou sua experiência, no corpo do e-mail.\n\n" +
        "Se precisar, digite *voltar* para retornar ao menu."
      );

      estadoUsuario[msg.from] = null;
      ultimoMenu[msg.from] = montarMenuPrincipal();
      return;
    }
    // =====================================
    // FALLBACK GERAL (menu principal):
    // no menu principal, não diz "não entendi", só reenvia o menu
    // =====================================

    // se estiver NO MENU PRINCIPAL (sem estado)
    if (!estadoUsuario[msg.from]) {
      const menu = montarMenuPrincipal();
      await enviarEMemorizarMenu(msg.from, chat, menu);

      return;
    }

    // se estiver em algum estado (ex.: submenu), aí sim usa a mensagem de erro e volta pro início
    estadoUsuario[msg.from] = null;
    const menu = montarMenuPrincipal();
    await chat.sendMessage("Não entendi. 🙂\n\nVamos começar de novo pelo menu principal:");
    await enviarEMemorizarMenu(msg.from, chat, menu);
    return;

  } catch (error) {
    console.error("Erro no handler:", error);
  }
});
