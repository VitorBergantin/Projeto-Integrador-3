class GameAssets {
  static const campusMap = 'assets/images/mapas/mapa-campus.png';
  static const viniNeutro = 'assets/images/expressoes/vini_neutro.png';
  static const viniAlegre = 'assets/images/expressoes/vini_alegre.png';
  static const viniBravo = 'assets/images/expressoes/vini_bravo.png';
  static const viniPensativo = 'assets/images/expressoes/vini_pensativo.png';
  static const viniSerio = 'assets/images/expressoes/vini_serio.png';
  static const viniSurpreso = 'assets/images/expressoes/vini_surpreso.png';
  static const magoNeutro = 'assets/images/expressoes/mago_neutro.png';
  static const magoAtento = 'assets/images/expressoes/mago_atento.png';
  static const magoSurpreso = 'assets/images/expressoes/mago_surpreso.png';
  static const hamburguerNeutro =
      'assets/images/expressoes/mrhamburgão_neutro.png';
  static const hamburguerJoia = 'assets/images/expressoes/mrhamburgao_joia.png';
  static const duendeNeutro = 'assets/images/expressoes/duende_neutro.png';
  static const duendeIdeia = 'assets/images/expressoes/duende_ideia.png';
  static const duendePensando = 'assets/images/expressoes/duende_pensando.png';
  static const duendeSorrindo = 'assets/images/expressoes/duende_sorrindo.png';
  static const duendeSurpreso = 'assets/images/expressoes/duende_surpreso.png';
  static const malignoNeutro = 'assets/images/expressoes/maligno_neutro.png';
  static const malignoBravo = 'assets/images/expressoes/maligno_bravo.png';
  static const malignoRindo = 'assets/images/expressoes/maligno_rindo.png';
  static const malignoSorrindo =
      'assets/images/expressoes/maligno_sorrindo.png';
  static const viniBattlePose = 'assets/images/battle/vini-pose-combate.png';

  static const loginMusic = 'audio/music/MUSICA TELA DE LOGIN.mpeg';
  static const menuMusic = 'audio/music/MUSICA MENU.mpeg';
  static const dialogueMagoMusic = 'audio/music/musica_dialogo_mago.mp3';
  static const victoryMusic = 'audio/music/VITÓRIA.mp3';
  static const defeatMusic = 'audio/music/DERROTA.mp3';

  static const _regionMusic = <int, String>{
    0: 'audio/music/MUSICA MENU.mpeg',
    1: 'audio/music/H15.mpeg',
    2: 'audio/music/MANACAS.mpeg',
    3: 'audio/music/BIBLIOTECA.mpeg',
    4: 'audio/music/CAPELA.mpeg',
  };

  static const _maps = <int, String>{
    0: 'assets/images/mapas/mapa-refeitorio.jpeg',
    1: 'assets/images/mapas/mapa-h15.jpeg',
    2: 'assets/images/mapas/mapa-manacas.jpeg',
    3: 'assets/images/mapas/mapa-biblioteca.jpeg',
    4: 'assets/images/mapas/mapa-capela.jpeg',
  };

  static const _entities = <String, String>{
    'refeitorio_zelador': 'assets/images/refeitorio/refeitorio-zelador.png',
    'refeitorio_maria': 'assets/images/refeitorio/refeitorio-maria.png',
    'refeitorio_dantas': 'assets/images/refeitorio/refeitorio-dantas.png',
    'refeitorio_bug_sintaxe':
        'assets/images/refeitorio/refeitorio-bug-sintaxe.png',
    'refeitorio_nullpointer':
        'assets/images/refeitorio/refeitorio-nullpointer.png',
    'refeitorio_hamburgao': 'assets/images/refeitorio/refeitorio-hamburgao.png',
    'h15_monitor_lucas': 'assets/images/h15/rev-estudante lucas.png',
    'h15_veterana_ana': 'assets/images/h15/rev-veteranaana.png',
    'h15_loop_infinito': 'assets/images/h15/rev-loop.png',
    'h15_stack_overflow': 'assets/images/h15/rev-stackoverflow.png',
    'h15_recursao_selvagem': 'assets/images/h15/rev - recursão.png',
    'manacas_dba_marcos': 'assets/images/manacas/rev-marcosdba.png',
    'manacas_estudante_lua': 'assets/images/manacas/rev-estudantelua.png',
    'manacas_sql_injection': 'assets/images/manacas/rev-injectionsql.png',
    'manacas_deadlock': 'assets/images/manacas/rev-deadlock.png',
    'manacas_corrupcao': 'assets/images/manacas/rev-corrupcaodados.png',
    'biblioteca_vera': 'assets/images/biblioteca/biblioteca-vera.png',
    'biblioteca_pedro': 'assets/images/biblioteca/biblioteca-pedro.png',
    'biblioteca_virus': 'assets/images/biblioteca/rev-virus.png',
    'biblioteca_phishing': 'assets/images/biblioteca/rev-phishing.png',
    'biblioteca_firewall': 'assets/images/biblioteca/rev-firewall.png',
    'capela_padre_algoritmo': 'assets/images/capela/rev-padre-algortimo.png',
    'capela_dra_silva': 'assets/images/capela/rev-pesquisadora.png',
    'capela_neural_network': 'assets/images/capela/rev-neuralnetwork.png',
    'capela_overfitting': 'assets/images/capela/rev-overfittin.png',
    'capela_guardiao_final': 'assets/images/capela/capela-maligno-idle.png',
  };

  static String mapForRegion(int regionIndex) =>
      _maps[regionIndex] ?? _maps[1]!;

  static String musicForRegion(int regionIndex) =>
      _regionMusic[regionIndex] ?? menuMusic;

  static String? entityForId(String entityId) => _entities[entityId];
}
