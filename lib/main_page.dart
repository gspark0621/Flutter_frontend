import 'package:flutter/material.dart';
import 'CameraPage.dart';
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메인 페이지'),
        automaticallyImplyLeading: false, // 뒤로가기 버튼을 숨깁니다.
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50), // 버튼의 최소 크기를 설정
              ),
              child: const Text('등록',
                style: TextStyle(
                  fontSize:16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50), // 버튼의 최소 크기를 설정
              ),
              child: const Text('확인',
                style: TextStyle(
                  fontSize:16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
