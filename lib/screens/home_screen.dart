import 'package:flutter/material.dart';
import 'wardrobe_screen.dart' as wardrobe;
import 'board_screen.dart';
import 'recommendation_screen.dart' as recommendation;
import 'personal_color_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      wardrobe.WardrobeScreen(),
      BoardScreen(),
      HomeScreenContent(onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      }),
      recommendation.RecommendationScreen(),
      PersonalColorScreen(),
    ];
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  final Function(int) onTap;

  HomeScreenContent({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '유저님 안녕하세요!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildShadowedContainer(
              context: context,
              onTap: () => onTap(0),
              icon: Icons.shopping_cart_outlined,
              label: '나만의 옷장',
              color: Colors.black,
              textColor: Colors.white,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRoundedContainer(
                  context: context,
                  onTap: () => onTap(1),
                  icon: Icons.message,
                  label: '게시판',
                  color: Colors.white,
                  borderColor: Colors.black,
                ),
                SizedBox(width: 16),
                _buildRoundedContainer(
                  context: context,
                  onTap: () => onTap(3),
                  icon: Icons.android,
                  label: 'AI 코디하기',
                  color: Colors.pink,
                  textColor: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildShadowedContainer(
              context: context,
              onTap: () => onTap(4),
              icon: Icons.palette,
              label: '내 퍼스널컬러 진단하기',
              color: Color(0xFFFBC02D),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedContainer({
    required BuildContext context,
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    required Color color,
    Color? textColor,
    Color? borderColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 32, // Adjusted width for square shape and spacing
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.0),
          border: borderColor != null ? Border.all(color: borderColor, width: 2.0) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor ?? Colors.black, size: 28),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(color: textColor ?? Colors.black, fontSize: 18), // Adjusted font size
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShadowedContainer({
    required BuildContext context,
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    required Color color,
    Color? textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 16.0), // Centering adjustment
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor ?? Colors.black, size: 28),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(color: textColor ?? Colors.black, fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
