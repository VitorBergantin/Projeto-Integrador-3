import 'package:flutter/material.dart';
import 'package:projeto_integrador_3/screens/mapa_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nomeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool carregando = false;

  // ─────────────────────────────────────────────
  // Cria documento do jogador caso não exista
  // ─────────────────────────────────────────────
  Future<void> criarJogadorSeNaoExistir(
    String uid,
    String nome,
  ) async {
    final doc = await FirebaseFirestore.instance
        .collection('jogadores')
        .doc(uid)
        .get();

    if (!doc.exists) {
      await FirebaseFirestore.instance
          .collection('jogadores')
          .doc(uid)
          .set({
            'nome': nome,
            'xp': 0,
            'level': 1,

            'progresso': {
              'h15': 0,
              'biblioteca': 0,
              'refeitorio': 0,
              'manacas': 0,
              'capela': 0,
            },

            'createdAt': FieldValue.serverTimestamp(),
          });
    }
  }

  // Login anônimo
  Future<void> entrarAnonimo() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => carregando = true);

    try {
      final nome = nomeController.text.trim();

      final userCredential =
          await FirebaseAuth.instance.signInAnonymously();

      final uid = userCredential.user!.uid;

      await criarJogadorSeNaoExistir(uid, nome);

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const MapaPage(),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao entrar no jogo'),
        ),
      );
    }

    if (mounted) {
      setState(() => carregando = false);
    }
  }

  // Login Google
  Future<void> entrarComGoogle() async {

  if (!_formKey.currentState!.validate()) {
    return;
  }

  try {

    final nome = nomeController.text.trim();

    final GoogleSignIn googleSignIn =
        GoogleSignIn.instance;

    await googleSignIn.initialize();

    final googleUser =
        await googleSignIn.authenticate();

    final googleAuth =
        googleUser.authentication;

    final credential =
        GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance
            .signInWithCredential(credential);

    final uid = userCredential.user!.uid;

    await criarJogadorSeNaoExistir(
      uid,
      nome,
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MapaPage(),
      ),
    );

  } catch (e) {

    debugPrint(
      'Erro Google Login: $e',
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invasão da PUC!'),
        backgroundColor: Colors.red,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Form(
          key: _formKey,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const Text(
                'Bem-vindo ao jogo!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: nomeController,

                decoration: const InputDecoration(
                  labelText: 'Seu nome:',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite seu nome';
                  }

                  if (value.length < 3) {
                    return 'Nome muito curto';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),
              // Botão anônimo
              SizedBox(
                width: double.infinity,

                child: FilledButton.icon(
                  icon: const Icon(Icons.play_arrow),

                  label: carregando
                      ? const CircularProgressIndicator()
                      : const Text('Entrar Anônimo'),

                  onPressed:
                      carregando ? null : entrarAnonimo,
                ),
              ),

              const SizedBox(height: 12),
              // Botão Google
              SizedBox(
                width: double.infinity,

                child: OutlinedButton.icon(
                  icon: const Icon(Icons.login),

                  label: const Text(
                    'Entrar com Google',
                  ),

                  onPressed:
                      carregando ? null : entrarComGoogle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}