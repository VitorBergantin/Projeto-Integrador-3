import '../models/campaign_scene.dart';
import 'game_assets.dart';

const int h15RegionIndex = 1;

const String kViniPortrait = GameAssets.viniNeutro;
const String kMagoPortrait = '🧙‍♂️';
const String kHamburgaoPortrait = '🍔';
const String kDuendePortrait = '🟢';
const String kCantineiroPortrait = '☕';
const String kBibliotecarioPortrait = '📚';
const String kAnjoPortrait = '🪽';
const String kPapaPortrait = '⛪';
const String kMalignoPortrait = 'assets/images/capela/capela-maligno-idle.png';
const String kMensagemPortrait = '✉️';

// Edite este arquivo para moldar a campanha.
// Use CampaignScene.cinematic para tela preta com texto branco.
// Use CampaignScene.dialogue para conversa alternando personagens.
// O último item libera o tutorial de combate do H15.
const List<CampaignScene> campaignScenes = [
  CampaignScene.cinematic(
    title: 'Estacionamento da PUC',
    textPages: [
      'Vini estava no estacionamento da faculdade esperando o horário da aula enquanto a universidade se preparava para a visita do Papa.',
      'De repente, uma explosão gigantesca destrói a igreja perto do Manacás. O chão treme, árvores pegam fogo e todos começam a correr.',
      'No meio do caos, um carro preto passa e joga uma pequena caixa metálica no chão. Curioso, Vini se aproxima.',
      'A caixa se abre sozinha. Um portal surge. Antes que consiga fugir, ele é puxado para dentro.',
    ],
  ),
  CampaignScene.dialogue(
    title: 'Sala do Mago',
    leftName: 'Vini',
    leftPortrait: kViniPortrait,
    rightName: 'Mago',
    rightPortrait: kMagoPortrait,
    dialogue: [
      CampaignDialogueLine(
        speaker: 'Vini',
        portrait: kViniPortrait,
        side: DialogueSide.left,
        text: 'Meu Deus!!! Onde eu tô?',
      ),
      CampaignDialogueLine(
        speaker: 'Mago',
        portrait: kMagoPortrait,
        side: DialogueSide.right,
        text: 'Finalmente você chegou!!!',
      ),
      CampaignDialogueLine(
        speaker: 'Vini',
        portrait: kViniPortrait,
        side: DialogueSide.left,
        text: 'Tá... quem é você? E como eu vim parar aqui?',
      ),
      CampaignDialogueLine(
        speaker: 'Mago',
        portrait: kMagoPortrait,
        side: DialogueSide.right,
        text:
            'Sou apenas conhecido como Mago. E você foi trazido porque este mundo precisa de ajuda.',
      ),
      CampaignDialogueLine(
        speaker: 'Vini',
        portrait: kViniPortrait,
        side: DialogueSide.left,
        text: 'Isso aqui é algum tipo de sonho?',
      ),
      CampaignDialogueLine(
        speaker: 'Mago',
        portrait: kMagoPortrait,
        side: DialogueSide.right,
        text:
            'Infelizmente não. Lords de outras dimensões invadiram este lugar... e capturaram o Papa.',
      ),
      CampaignDialogueLine(
        speaker: 'Vini',
        portrait: kViniPortrait,
        side: DialogueSide.left,
        text: 'Espera. Então aquela explosão foi real?',
      ),
      CampaignDialogueLine(
        speaker: 'Mago',
        portrait: kMagoPortrait,
        side: DialogueSide.right,
        text: 'Foi apenas o começo.',
      ),
    ],
  ),
  CampaignScene.cinematic(
    title: 'O chamado',
    textPages: [
      'O Mago entrega a Vini uma espada poderosa e um escudo vindo de um universo paralelo.',
      'A universidade já mudou. Cinco Lords dividiram a PUC, e cada região agora pertence a um comandante.',
      'Um novo portal se abre. Vini é puxado de volta para o campus transformado.',
    ],
  ),
  CampaignScene.dialogue(
    title: 'Retorno ao H15',
    leftName: 'Vini',
    leftPortrait: kViniPortrait,
    rightName: 'Mago',
    rightPortrait: kMagoPortrait,
    dialogue: [
      CampaignDialogueLine(
        speaker: 'Vini',
        portrait: kViniPortrait,
        side: DialogueSide.left,
        text: 'Então eu tenho que salvar o mundo sozinho??!!!',
      ),
      CampaignDialogueLine(
        speaker: 'Mago',
        portrait: kMagoPortrait,
        side: DialogueSide.right,
        text: 'Sozinho não. Mas o destino depende de você.',
      ),
      CampaignDialogueLine(
        speaker: 'Mago',
        portrait: kMagoPortrait,
        side: DialogueSide.right,
        text: 'Vá. A universidade já mudou.',
      ),
      CampaignDialogueLine(
        speaker: 'Vini',
        portrait: kViniPortrait,
        side: DialogueSide.left,
        text: 'Beleza. Se isso virou prova da faculdade, eu vou passar.',
      ),
    ],
  ),
  CampaignScene.exploration(title: 'Tutorial H15', regionIndex: h15RegionIndex),
];

const Map<int, List<CampaignScene>> regionConclusionScenes = {
  0: [
    CampaignScene.cinematic(
      title: 'Praça libertada',
      textPages: [
        'O lacaio cai. O peso mágico que dominava a Praça de Alimentação começa a desaparecer.',
      ],
    ),
    CampaignScene.dialogue(
      title: 'Comemoração',
      leftName: 'Vini',
      leftPortrait: kViniPortrait,
      rightName: 'Mr. Hamburgão',
      rightPortrait: kHamburgaoPortrait,
      dialogue: [
        CampaignDialogueLine(
          speaker: 'Mr. Hamburgão',
          portrait: kHamburgaoPortrait,
          side: DialogueSide.right,
          text: 'VOCÊ CONSEGUIU! A praça está respirando de novo!',
        ),
        CampaignDialogueLine(
          speaker: 'Vini',
          portrait: kViniPortrait,
          side: DialogueSide.left,
          text:
              'Eu ainda acho estranho receber parabéns de um hambúrguer, mas obrigado.',
        ),
        CampaignDialogueLine(
          speaker: 'Mr. Hamburgão',
          portrait: kHamburgaoPortrait,
          side: DialogueSide.right,
          text:
              'Os outros Lords ainda controlam partes da PUC. Biblioteca, Manacás e H15 precisam de você.',
        ),
      ],
    ),
  ],
  1: [
    CampaignScene.cinematic(
      title: 'H15 em silêncio',
      textPages: [
        'Os computadores do H15 apagam um por um. O corredor deixa de pulsar com a energia do Lord.',
      ],
    ),
    CampaignScene.dialogue(
      title: 'Depois da batalha',
      leftName: 'Vini',
      leftPortrait: kViniPortrait,
      rightName: 'Duende',
      rightPortrait: kDuendePortrait,
      dialogue: [
        CampaignDialogueLine(
          speaker: 'Duende',
          portrait: kDuendePortrait,
          side: DialogueSide.right,
          text: 'Tá bom. Admito. Você foi melhor do que eu esperava.',
        ),
        CampaignDialogueLine(
          speaker: 'Vini',
          portrait: kViniPortrait,
          side: DialogueSide.left,
          text: 'Isso vindo de você quase parece elogio.',
        ),
        CampaignDialogueLine(
          speaker: 'Duende',
          portrait: kDuendePortrait,
          side: DialogueSide.right,
          text:
              'Não relaxa. Enquanto todos os Lords não caírem, a Capela continuará fechada.',
        ),
      ],
    ),
  ],
  2: [
    CampaignScene.cinematic(
      title: 'Manacás restaurado',
      textPages: [
        'As folhas mortas param de girar. Um vento leve atravessa o Manacás como se o lugar voltasse a viver.',
      ],
    ),
    CampaignScene.dialogue(
      title: 'O aviso',
      leftName: 'Vini',
      leftPortrait: kViniPortrait,
      rightName: 'Cantineiro',
      rightPortrait: kCantineiroPortrait,
      dialogue: [
        CampaignDialogueLine(
          speaker: 'Cantineiro',
          portrait: kCantineiroPortrait,
          side: DialogueSide.right,
          text: 'Você abriu caminho onde ninguém conseguia passar.',
        ),
        CampaignDialogueLine(
          speaker: 'Vini',
          portrait: kViniPortrait,
          side: DialogueSide.left,
          text: 'Foi por pouco. Esse lugar tentou me derrubar a cada passo.',
        ),
        CampaignDialogueLine(
          speaker: 'Cantineiro',
          portrait: kCantineiroPortrait,
          side: DialogueSide.right,
          text: 'Então continue andando. Ainda falta salvar o Papa.',
        ),
      ],
    ),
  ],
  3: [
    CampaignScene.cinematic(
      title: 'Luzes na Biblioteca',
      textPages: [
        'Uma fileira de lâmpadas acende no fundo da Biblioteca. Os livros param de tremer nas prateleiras.',
      ],
    ),
    CampaignScene.dialogue(
      title: 'Conhecimento recuperado',
      leftName: 'Vini',
      leftPortrait: kViniPortrait,
      rightName: 'Bibliotecário',
      rightPortrait: kBibliotecarioPortrait,
      dialogue: [
        CampaignDialogueLine(
          speaker: 'Bibliotecário',
          portrait: kBibliotecarioPortrait,
          side: DialogueSide.right,
          text: 'A Biblioteca reconhece sua vitória, Vini.',
        ),
        CampaignDialogueLine(
          speaker: 'Vini',
          portrait: kViniPortrait,
          side: DialogueSide.left,
          text: 'Prefiro quando bibliotecas só emprestam livro, mas aceito.',
        ),
        CampaignDialogueLine(
          speaker: 'Bibliotecário',
          portrait: kBibliotecarioPortrait,
          side: DialogueSide.right,
          text: 'Cada Lord derrotado enfraquece o selo da Capela. Continue.',
        ),
      ],
    ),
  ],
  4: [
    CampaignScene.cinematic(
      title: 'O Maligno derrotado',
      textPages: [
        'O golpe final atravessa a sombra que dominava a Capela. O Maligno cambaleia diante do altar, cercado por rachaduras de luz.',
        'A fumaça negra tenta se recompor, mas a força que aprisionava a PUC paralela começa a perder forma.',
      ],
    ),
    CampaignScene.dialogue(
      title: 'A queda do Maligno',
      leftName: 'Vini',
      leftPortrait: kViniPortrait,
      rightName: 'Maligno',
      rightPortrait: kMalignoPortrait,
      dialogue: [
        CampaignDialogueLine(
          speaker: 'Maligno',
          portrait: kMalignoPortrait,
          side: DialogueSide.right,
          text:
              'Não... eu não posso cair para um aluno perdido com uma arma emprestada!',
        ),
        CampaignDialogueLine(
          speaker: 'Vini',
          portrait: kViniPortrait,
          side: DialogueSide.left,
          text:
              'Você sequestrou o Papa, dividiu a PUC inteira e colocou todo mundo em risco. Acabou.',
        ),
        CampaignDialogueLine(
          speaker: 'Maligno',
          portrait: kMalignoPortrait,
          side: DialogueSide.right,
          text:
              'Eu precisava dele! Enquanto o Papa existisse livre, meu domínio nunca seria completo.',
        ),
        CampaignDialogueLine(
          speaker: 'Maligno',
          portrait: kMalignoPortrait,
          side: DialogueSide.right,
          text:
              'A fé dele mantinha o selo antigo vivo. Eu o prendi para drenar essa luz e transformar a PUC paralela no meu reino.',
        ),
        CampaignDialogueLine(
          speaker: 'Vini',
          portrait: kViniPortrait,
          side: DialogueSide.left,
          text:
              'Então você não queria só vencer. Queria apagar tudo que ainda protegia este mundo.',
        ),
        CampaignDialogueLine(
          speaker: 'Maligno',
          portrait: kMalignoPortrait,
          side: DialogueSide.right,
          text:
              'Eu voltarei. Sempre existe uma falha, uma brecha, um medo esperando para abrir caminho.',
        ),
      ],
    ),
    CampaignScene.cinematic(
      title: 'O selo final',
      textPages: [
        'A tela escurece. Mesmo enfraquecido, o Papa ergue as mãos e invoca a magia que restava no coração da Capela.',
        'A luz envolve o Maligno. O vilão grita, rejeita a derrota e tenta escapar, mas o selo se fecha antes que a sombra encontre uma nova brecha.',
        'Com a magia final do Papa, o Maligno é selado para sempre. Ele nunca mais retornará, e a PUC paralela finalmente é salva.',
      ],
    ),
    CampaignScene.dialogue(
      title: 'A PUC paralela salva',
      leftName: 'Vini',
      leftPortrait: kViniPortrait,
      rightName: 'Papa',
      rightPortrait: kPapaPortrait,
      dialogue: [
        CampaignDialogueLine(
          speaker: 'Papa',
          portrait: kPapaPortrait,
          side: DialogueSide.right,
          text:
              'Vini... eu só consegui selá-lo porque você o enfraqueceu. Sua coragem devolveu esperança a este mundo.',
        ),
        CampaignDialogueLine(
          speaker: 'Vini',
          portrait: kViniPortrait,
          side: DialogueSide.left,
          text:
              'Eu só fiz o que precisava ser feito. Mas confesso que não esperava salvar uma PUC de outra dimensão hoje.',
        ),
        CampaignDialogueLine(
          speaker: 'Papa',
          portrait: kPapaPortrait,
          side: DialogueSide.right,
          text:
              'Os Lords caíram, as regiões foram libertadas e o selo foi restaurado. Tudo saiu como o destino planejou.',
        ),
        CampaignDialogueLine(
          speaker: 'Vini',
          portrait: kViniPortrait,
          side: DialogueSide.left,
          text: 'Então acabou mesmo?',
        ),
        CampaignDialogueLine(
          speaker: 'Papa',
          portrait: kPapaPortrait,
          side: DialogueSide.right,
          text:
              'Acabou. A PUC paralela está salva. Agora volte em paz, protagonista.',
        ),
        CampaignDialogueLine(
          speaker: 'Vini',
          portrait: kViniPortrait,
          side: DialogueSide.left,
          text:
              'Beleza. Mas se isso virar trabalho escrito, eu quero nota máxima.',
        ),
      ],
    ),
  ],
};

const Map<int, String> nextObjectiveByRegion = {
  0: 'Objetivo: escolha Biblioteca, Manacás ou H15 e derrote os Lords restantes.',
  1: 'Objetivo: derrote os Lords restantes. A Capela só abre quando todos caírem.',
  2: 'Objetivo: continue libertando as regiões restantes.',
  3: 'Objetivo: continue libertando as regiões restantes.',
  4: 'Campanha concluída.',
};

const Map<int, RegionIntroScene> regionIntroScenes = {
  0: RegionIntroScene(
    title: 'Praça de Alimentação',
    objective:
        'Objetivo: converse com os NPCs, derrote os lacaios e encontre o boss da praça.',
    leftName: 'Vini',
    leftPortrait: kViniPortrait,
    rightName: 'Mr. Hamburgão',
    rightPortrait: kHamburgaoPortrait,
    dialogue: [
      RegionIntroLine(
        speaker: 'Mr. Hamburgão',
        side: DialogueSide.right,
        text: 'VOCÊ PRECISA AJUDAR A GENTE!',
      ),
      RegionIntroLine(
        speaker: 'Vini',
        side: DialogueSide.left,
        text: '...Você é literalmente um hambúrguer?',
      ),
      RegionIntroLine(
        speaker: 'Mr. Hamburgão',
        side: DialogueSide.right,
        text:
            'Isso não é importante agora! O lacaio dos Lords dominou a praça!',
      ),
      RegionIntroLine(
        speaker: 'Vini',
        side: DialogueSide.left,
        text:
            'Tá bom. Vou explorar, falar com quem puder e derrubar esse lacaio.',
      ),
    ],
  ),
  1: RegionIntroScene(
    title: 'Bloco H15',
    objective:
        'Objetivo: investigue os corredores, reúna pistas e enfrente o Lord do H15.',
    leftName: 'Vini',
    leftPortrait: kViniPortrait,
    rightName: 'Duende',
    rightPortrait: kDuendePortrait,
    dialogue: [
      RegionIntroLine(
        speaker: 'Duende',
        side: DialogueSide.right,
        text: 'Hmmm... então você voltou mesmo.',
      ),
      RegionIntroLine(
        speaker: 'Vini',
        side: DialogueSide.left,
        text:
            'Voltei. E dessa vez eu quero respostas antes do próximo absurdo.',
      ),
      RegionIntroLine(
        speaker: 'Duende',
        side: DialogueSide.right,
        text:
            'Explore o prédio. Os inimigos guardam partes do caminho até o Lord.',
      ),
      RegionIntroLine(
        speaker: 'Vini',
        side: DialogueSide.left,
        text:
            'Beleza. Corredores, NPCs, monstros e chefe. Nada estranho para hoje.',
      ),
    ],
  ),
  2: RegionIntroScene(
    title: 'Manacás',
    objective:
        'Objetivo: avance pelos caminhos tomados, ajude quem ficou para trás e enfrente o Lord do Manacás.',
    leftName: 'Vini',
    leftPortrait: kViniPortrait,
    rightName: 'Cantineiro',
    rightPortrait: kCantineiroPortrait,
    dialogue: [
      RegionIntroLine(
        speaker: 'Cantineiro',
        side: DialogueSide.right,
        text:
            'Ei! Você aí! Cuidado onde pisa. Esse lugar foi tomado faz tempo.',
      ),
      RegionIntroLine(
        speaker: 'Vini',
        side: DialogueSide.left,
        text: 'Tomado por quem? Ou melhor: por que você ainda está aqui?',
      ),
      RegionIntroLine(
        speaker: 'Cantineiro',
        side: DialogueSide.right,
        text: 'Fiquei para avisar quem viesse. Não existe atalho seguro aqui.',
      ),
      RegionIntroLine(
        speaker: 'Vini',
        side: DialogueSide.left,
        text: 'Então vou lutar por cada metro até esse Lord aparecer.',
      ),
    ],
  ),
  3: RegionIntroScene(
    title: 'Biblioteca',
    objective:
        'Objetivo: procure informações, sobreviva às sombras e abra caminho até o Lord da Sabedoria.',
    leftName: 'Vini',
    leftPortrait: kViniPortrait,
    rightName: 'Bibliotecário',
    rightPortrait: kBibliotecarioPortrait,
    dialogue: [
      RegionIntroLine(
        speaker: 'Bibliotecário',
        side: DialogueSide.right,
        text: 'Bem-vindo. Mas te aviso: esse lugar não é mais seguro.',
      ),
      RegionIntroLine(
        speaker: 'Vini',
        side: DialogueSide.left,
        text: 'Seguro? Nada no campus está seguro. O que aconteceu aqui?',
      ),
      RegionIntroLine(
        speaker: 'Bibliotecário',
        side: DialogueSide.right,
        text: 'As luzes apagaram, os sons começaram, e algo espera no fundo.',
      ),
      RegionIntroLine(
        speaker: 'Vini',
        side: DialogueSide.left,
        text: 'Ótimo. Biblioteca de horror. Vou entrar mesmo assim.',
      ),
    ],
  ),
  4: RegionIntroScene(
    title: 'Capela',
    objective:
        'Objetivo: atravesse a Capela e derrote o Maligno, o guardião final.',
    leftName: 'Vini',
    leftPortrait: kViniPortrait,
    rightName: 'Maligno',
    rightPortrait: kMalignoPortrait,
    dialogue: [
      RegionIntroLine(
        speaker: 'Vini',
        side: DialogueSide.left,
        text: 'A Capela está aberta... então é aqui que tudo termina.',
      ),
      RegionIntroLine(
        speaker: 'Maligno',
        side: DialogueSide.right,
        text:
            'Termina? Não. Aqui começa o mundo que eu tentei construir desde que roubei a luz do Papa.',
      ),
      RegionIntroLine(
        speaker: 'Vini',
        side: DialogueSide.left,
        text: 'Você sequestrou ele para controlar a PUC paralela?',
      ),
      RegionIntroLine(
        speaker: 'Maligno',
        side: DialogueSide.right,
        text:
            'O Papa era o coração do selo. Enquanto ele estivesse livre, minhas sombras jamais dominariam todas as regiões.',
      ),
      RegionIntroLine(
        speaker: 'Papa',
        portrait: kPapaPortrait,
        side: DialogueSide.right,
        text:
            'Vini... não escute suas promessas. Ele se alimenta do medo e da desistência.',
      ),
      RegionIntroLine(
        speaker: 'Vini',
        side: DialogueSide.left,
        text: 'Eu cheguei até aqui derrotando cada Lord. Não vou parar agora.',
      ),
      RegionIntroLine(
        speaker: 'Maligno',
        side: DialogueSide.right,
        text:
            'Então venha, protagonista. Mostre se a sua coragem sobrevive ao guardião final.',
      ),
    ],
  ),
};
