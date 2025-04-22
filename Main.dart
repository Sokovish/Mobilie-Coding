import 'package:flutter/material.dart';

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const QuizPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final int correctIndex;

  Question(this.text, this.options, this.correctIndex);
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> questions = [
    Question('Qual é o maior planeta do Sistema solar?', [
      'Saturno',
      'Marte',
      'Urano',
      'Júpiter',
      'Terra',
    ], 3),
    Question('Qual é a capital do Brasil?', [
      'Rio de Janeiro',
      'Brasília',
      'Manaus',
      'São Paulo',
      'Recife',
    ], 1),
    Question('Quanto é 7 x 8?', ['54', '56', '64', '23', '48'], 1),
    Question('Qual linguagem o Flutter usa?', [
      'Java',
      'C++',
      'Dart',
      'Css',
      'Python',
    ], 2),
    Question('Qual é o maior oceano do mundo?', [
      'Atlântico',
      'Índico',
      'Ártico',
      'Pacífico',
      'Antártico',
    ], 3),
    Question('Quem escreveu "Dom Casmurro"?', [
      'José de Alencar',
      'Machado de Assis',
      'Clarice Lispector',
      'Monteiro Lobato',
      'Raul Pompeia',
    ], 1),
    Question('Qual é o nome do presidente dos Estados Unidos em 2021?', [
      'Donald Trump',
      'Barack Obama',
      'Joe Biden',
      'George W. Bush',
      'Bill Clinton',
    ], 2),
    Question('Qual é o símbolo químico do ouro?', [
      'Ag',
      'Fe',
      'Au',
      'Pb',
      'Cu',
    ], 2),
    Question('Em que continente fica o Egito?', [
      'África',
      'Ásia',
      'Europa',
      'América',
      'Oceania',
    ], 0),
    Question('Qual o nome do nosso satélite natural?', [
      'Sol',
      'Lua',
      'Marte',
      'Vênus',
      'Saturno',
    ], 1),
    Question('Em que ano o Brasil se tornou independente?', [
      '1820',
      '1808',
      '1889',
      '1822',
      '1850',
    ], 3),
    Question('Quantos estados o Brasil tem?', [
      '25',
      '27',
      '30',
      '26',
      '24',
    ], 1),
    Question('Qual é a capital da França?', [
      'Londres',
      'Paris',
      'Berlim',
      'Roma',
      'Lisboa',
    ], 1),
    Question('Quem pintou a Mona Lisa?', [
      'Pablo Picasso',
      'Vincent van Gogh',
      'Leonardo da Vinci',
      'Claude Monet',
      'Michelangelo',
    ], 2),
    Question('Quantos ossos tem o corpo humano?', [
      '206',
      '204',
      '210',
      '198',
      '215',
    ], 0),
    Question('Qual é a cor da pedra preciosa esmeralda?', [
      'Azul',
      'Verde',
      'Vermelha',
      'Amarela',
      'Preta',
    ], 1),
    Question('Quem foi o primeiro homem a pisar na lua?', [
      'Yuri Gagarin',
      'Neil Armstrong',
      'Buzz Aldrin',
      'John Glenn',
      'Valentina Tereshkova',
    ], 1),
    Question('Quantos continentes existem no mundo?', [
      '5',
      '6',
      '7',
      '8',
      '4',
    ], 2),
    Question('Qual é o nome da maior floresta do mundo?', [
      'Floresta de Borneo',
      'Floresta Amazônica',
      'Floresta do Congo',
      'Floresta de Taiga',
      'Floresta de Schwarzwald',
    ], 1),
    Question('Qual é o maior deserto do mundo?', [
      'Deserto do Saara',
      'Deserto de Gobi',
      'Deserto da Arábia',
      'Deserto de Atacama',
      'Antártico',
    ], 4),
    Question('O que é a fotossíntese?', [
      'Processo de respiração das plantas',
      'Processo de produção de energia pelas plantas',
      'Processo de absorção de água pelas plantas',
      'Processo de divisão celular das plantas',
      'Processo de secreção das plantas',
    ], 1),
    Question('Qual é a principal fonte de energia da Terra?', [
      'O Sol',
      'A Lua',
      'O vento',
      'O petróleo',
      'A água',
    ], 0),
    Question('Em que país fica a cidade de Marrakech?', [
      'Egito',
      'Marrocos',
      'Tunísia',
      'Argélia',
      'Líbia',
    ], 1),
  ];

  int currentIndex = 0;
  int score = 0;
  int? selectedIndex;

  void nextQuestion() {
    if (selectedIndex == null) return;

    bool isCorrect = selectedIndex == questions[currentIndex].correctIndex;
    String feedback = isCorrect ? 'Muito bem! Você acertou!' : 'Ops! Você errou!';
    
    if (isCorrect) {
      score++;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(feedback),
        duration: const Duration(seconds: 1),
      ),
    );

    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedIndex = null;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Quiz Finalizado!'),
          content: Text('Sua pontuação foi $score de ${questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentIndex = 0;
                  score = 0;
                  selectedIndex = null;
                });
              },
              child: const Text('Jogar novamente!'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 80),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF6A5AE0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Quiz',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    question.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Pergunta ${currentIndex + 1} de ${questions.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ...List.generate(question.options.length, (index) {
            final isSelected = index == selectedIndex;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isSelected
                          ? const Color(0xFF4D42B0)
                          : const Color(0xFF6A5AE0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 502),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Text(
                  question.options[index],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ElevatedButton(
              onPressed: nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C246E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Center(
                child: Text(
                  'Responder',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
