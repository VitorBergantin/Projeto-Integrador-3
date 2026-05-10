import 'package:flutter/material.dart';
import '../models/player.dart';
import '../models/enemy.dart';
import '../models/game_region.dart';

enum GameState {
  cutscene,
  exploring,
  combat,
  victory,
  defeat,
  regionComplete,
  gameComplete,
}

class GameController extends ChangeNotifier {
  Player player = Player(name: '');
  GameState _state = GameState.cutscene;
  int _cutsceneLine = 0;
  Enemy? _currentEnemy;
  int _currentEnemyIndex = 0;
  bool? _lastAnswerCorrect;
  bool _leveledUp = false;
  bool _answerLocked = false;

  GameState get state => _state;
  int get cutsceneLine => _cutsceneLine;
  Enemy? get currentEnemy => _currentEnemy;
  bool? get lastAnswerCorrect => _lastAnswerCorrect;
  bool get leveledUp => _leveledUp;
  bool get answerLocked => _answerLocked;

  GameRegion get currentRegion => gameRegions[player.currentRegion];
  int get totalRegions => gameRegions.length;

  // Mapa de amb.id → índice de região
  static const Map<String, int> _ambienteToRegion = {
    'refeitorio': 0,
    'h15': 1,
    'manacas': 2,
    'biblioteca': 3,
    'capela': 4,
  };

  static int regionIndexForAmbiente(String ambId) =>
      _ambienteToRegion[ambId] ?? 0;

  void init(String playerName) {
    player = Player(name: playerName);
    _state = GameState.cutscene;
    _cutsceneLine = 0;
    _currentEnemyIndex = 0;
    _lastAnswerCorrect = null;
    _leveledUp = false;
    _answerLocked = false;
    notifyListeners();
  }

  // Chamado quando entra num geofence — preserva HP/XP/level do jogador
  void enterRegion(int regionIndex) {
    player.currentRegion = regionIndex;
    _cutsceneLine = 0;
    _currentEnemyIndex = 0;
    _lastAnswerCorrect = null;
    _leveledUp = false;
    _answerLocked = false;
    _state = GameState.cutscene;
    notifyListeners();
  }

  void advanceCutscene() {
    if (_cutsceneLine < currentRegion.cutsceneLines.length - 1) {
      _cutsceneLine++;
    } else {
      _state = GameState.exploring;
    }
    notifyListeners();
  }

  void skipCutscene() {
    _cutsceneLine = currentRegion.cutsceneLines.length - 1;
    _state = GameState.exploring;
    notifyListeners();
  }

  void startBattle() {
    final enemies = currentRegion.enemies;
    _currentEnemy = enemies[_currentEnemyIndex % enemies.length].clone();
    _lastAnswerCorrect = null;
    _answerLocked = false;
    _state = GameState.combat;
    notifyListeners();
  }

  void answerQuestion(int selectedIndex) {
    if (_currentEnemy == null || _state != GameState.combat || _answerLocked) return;

    final question = _currentEnemy!.currentQuestion;
    final isCorrect = selectedIndex == question.correctIndex;
    _lastAnswerCorrect = isCorrect;
    _answerLocked = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (isCorrect) {
        _currentEnemy!.takeDamage(question.attackPower);
      } else {
        player.takeDamage(question.damage);
      }

      if (!player.isAlive) {
        _state = GameState.defeat;
        _answerLocked = false;
        notifyListeners();
        return;
      }

      if (_currentEnemy!.isDefeated) {
        final leveled = player.gainXp(_currentEnemy!.xpReward);
        _leveledUp = leveled;
        _currentEnemyIndex++;

        final allDefeated = _currentEnemyIndex >= currentRegion.enemies.length;
        if (allDefeated) {
          _currentEnemyIndex = 0;
          final isLastRegion = player.currentRegion >= gameRegions.length - 1;
          _state = isLastRegion ? GameState.gameComplete : GameState.regionComplete;
        } else {
          _state = GameState.victory;
        }
      } else {
        _currentEnemy!.nextQuestion();
        _lastAnswerCorrect = null;
      }

      _answerLocked = false;
      notifyListeners();
    });
  }

  void continueAfterVictory() {
    _leveledUp = false;
    _lastAnswerCorrect = null;
    startBattle();
  }

  void moveToNextRegion() {
    player.currentRegion++;
    _cutsceneLine = 0;
    _currentEnemyIndex = 0;
    _leveledUp = false;
    _state = GameState.cutscene;
    notifyListeners();
  }

  void restartAfterDefeat() {
    player.hp = (player.maxHp * 0.6).round();
    _currentEnemyIndex = 0;
    _lastAnswerCorrect = null;
    _state = GameState.exploring;
    notifyListeners();
  }

  void healPlayer() {
    player.heal((player.maxHp * 0.3).round());
    notifyListeners();
  }
}
