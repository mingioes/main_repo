import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Color Diagnosis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PersonalColorScreen(),
    );
  }
}

class PersonalColorScreen extends StatefulWidget {
  @override
  _PersonalColorScreenState createState() => _PersonalColorScreenState();
}

class _PersonalColorScreenState extends State<PersonalColorScreen> {
  final String question = '당신과 어울리는 색을 선택해주세요:';

  final List<List<Color>> options = [
    [Colors.lightBlue[100] ?? Colors.blue, Colors.deepPurple[100] ?? Colors.purple], // 쿨톤 흰 끼 도는 색
    [Colors.blue[800] ?? Colors.blueAccent, Colors.purple[800] ?? Colors.deepPurple], // 쿨톤 채도가 깊은 색
    [Colors.yellowAccent[100] ?? Colors.yellow, Colors.pink[100] ?? Colors.pinkAccent], // 웜톤 흰 끼 도는 색
    [Colors.orange[800] ?? Colors.orange, Colors.yellow[800] ?? Colors.yellow], // 웜톤 채도가 깊은 색
    [Colors.deepPurple[100] ?? Colors.deepPurple, Colors.purpleAccent[100] ?? Colors.purple], // 쿨톤 흰 끼 도는 색
    [Colors.lightBlue[100] ?? Colors.lightBlue, Colors.lightBlueAccent[800] ?? Colors.blueAccent], // 쿨톤 채도가 깊은 색
    [Color(0xFFFFFDE7) ?? Colors.yellow, Colors.amber[100] ?? Colors.amber], // 웜톤 흰 끼 도는 색
    [Colors.orange[800] ?? Colors.orange, Color(0xFFF57F17) ?? Colors.orange], // 웜톤 채도가 깊은 색
    [Color(0xEBC8FFFF) ?? Colors.lightBlue, Colors.lightBlue[100] ?? Colors.lightBlue], // 쿨톤 흰 끼 도는 색
    [Colors.orange[800] ?? Colors.orange, Colors.yellow[800] ?? Colors.yellow], // 웜톤 채도가 깊은 색
  ];

  int currentQuestionIndex = 0;
  List<int> selectedColorIndices = [];

  void nextQuestion(int selectedIndex) {
    setState(() {
      if (selectedIndex >= 0 && selectedIndex < options[currentQuestionIndex].length) {
        selectedColorIndices.add(selectedIndex);
        if (currentQuestionIndex < options.length - 1) {
          currentQuestionIndex++;
        } else {
          showResultDialog();
        }
      } else {
        print('Invalid value: $selectedIndex is not in the inclusive range 0..${options[currentQuestionIndex].length - 1}');
      }
    });
  }

  void showResultDialog() {
    String result = diagnose(selectedColorIndices);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('진단 결과'),
        content: Text('당신의 퍼스널 컬러는 $result 입니다!'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetDiagnosis();
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  void resetDiagnosis() {
    setState(() {
      currentQuestionIndex = 0;
      selectedColorIndices.clear();
    });
  }

  String diagnose(List<int> selectedColorIndices) {
    int coolLightCount = selectedColorIndices.where((index) => index == 0 || index == 4 || index == 8).length;
    int coolDeepCount = selectedColorIndices.where((index) => index == 1 || index == 5).length;
    int warmLightCount = selectedColorIndices.where((index) => index == 2 || index == 6).length;
    int warmDeepCount = selectedColorIndices.where((index) => index == 3 || index == 7 || index == 9).length;

    if (coolLightCount > 4) {
      return '여름 쿨톤';
    } else if (coolDeepCount > 4) {
      return '겨울 쿨톤';
    } else if (warmLightCount > 4) {
      return '봄 웜톤';
    } else if (warmDeepCount > 4) {
      return '가을 웜톤';
    }
    return '진단 결과 없음';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 퍼스널 컬러 진단'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                question,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              for (int i = 0; i < options[currentQuestionIndex].length; i++)
                GestureDetector(
                  onTap: () => nextQuestion(i),
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: options[currentQuestionIndex][i],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
