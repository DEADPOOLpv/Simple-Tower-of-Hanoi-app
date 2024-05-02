import 'package:flutter/material.dart';

class TowerOfHanoi extends StatefulWidget {
  @override
  _TowerOfHanoiState createState() => _TowerOfHanoiState();
}

class _TowerOfHanoiState extends State<TowerOfHanoi> {
  late List<List<int>> towers;
  late int numberOfDisks;
  late int moves;

  @override
  void initState() {
    super.initState();
    numberOfDisks = 5; // Set the number of disks here
    resetGame();
  }

  void resetGame() {
    towers = List.generate(3, (index) => []);
    for (int i = numberOfDisks; i >= 1; i--) {
      towers[0].add(i);
    }
    moves = 0;
  }

  void moveDisk(int sourceTower, int destinationTower) {
    setState(() {
      int disk = towers[sourceTower].removeLast();
      towers[destinationTower].add(disk);
      moves++;
    });
  }

  Widget buildDisk(int diskSize) {
    double diskWidth = diskSize * 20.0;
    return Container(
      width: diskWidth,
      height: 20.0,
      color: Colors.blue,
    );
  }

  Widget buildTower(int towerIndex) {
    return GestureDetector(
      onTap: () {
        if (towers[towerIndex].isNotEmpty) {
          moveDisk(towerIndex, (towerIndex + 1) % 3);
        }
      },
      child: Container(
        width: 100.0,
        height: 200.0,
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            for (int diskSize in towers[towerIndex])
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: buildDisk(diskSize),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tower of Hanoi'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Moves: $moves',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTower(0),
                buildTower(1),
                buildTower(2),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: resetGame,
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyGame());
}

class MyGame extends StatelessWidget
{
  const MyGame({Key? key}) : super (key : key);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: TowerOfHanoi(),
    );
  }
}