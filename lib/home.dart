import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTurnO = true;
  int filledboxes = 0;
  bool gameHasResult = false;
  List<String> xORoList = ['', '', '', '', '', '', '', '', ''];

  int scoreX = 0;
  int scoreO = 0;
  int scoreTies = 0;

  String winnerTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF192A32),
      appBar: getAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            _getGridView(),
            getResultButton(),
            SizedBox(height: 20),
            getScoreBoard(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /* AppBar Widget */
  /*               */
  PreferredSizeWidget getAppBar() {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.all(9),
        child: Row(
          children: [
            Image(
              image: AssetImage('assets/x.png'),
              height: 33,
            ),
            SizedBox(width: 4),
            Image(
              image: AssetImage('assets/o.png'),
              height: 33,
            ),
          ],
        ),
      ),
      leadingWidth: 100,
      actions: [
        GestureDetector(
          onTap: () => clearGame(deepClean: true),
          child: Container(
            margin: EdgeInsets.all(9),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Color(0xFFA8BEC9),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.refresh_rounded,
                size: 3 * 8,
                color: Color(0xFF192A32),
              ),
            ),
          ),
        )
      ],
      centerTitle: true,
      title: Container(
        child: getTurn(),
        width: 101,
        height: 38,
        decoration: BoxDecoration(
          color: Color(0xFF1F3540),
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      elevation: 0,
      backgroundColor: Color(0xFF192A32),
    );
  }

  /* tapped function */
  /*                 */
  void tapped(int index) {
    setState(() {
      if (gameHasResult) {
        return;
      }

      if (xORoList[index] != '') {
        return;
      }
      if (isTurnO) {
        xORoList[index] = 'o';
        filledboxes += 1;
      } else {
        xORoList[index] = 'x';
        filledboxes += 1;
      }
      isTurnO = !isTurnO;

      checkWinner();
    });
  }

  /* Program logic to find the winner */
  /*                                  */
  void checkWinner() {
    if (xORoList[0] == xORoList[1] &&
        xORoList[1] == xORoList[2] &&
        xORoList[0] != '') {
      setResult(xORoList[0], 'Winner is ${xORoList[0].toUpperCase()}');
      return;
    }
    if (xORoList[3] == xORoList[4] &&
        xORoList[4] == xORoList[5] &&
        xORoList[3] != '') {
      setResult(xORoList[3], 'Winner is ${xORoList[3].toUpperCase()}');
      return;
    }
    if (xORoList[6] == xORoList[7] &&
        xORoList[7] == xORoList[8] &&
        xORoList[6] != '') {
      setResult(xORoList[6], 'Winner is ${xORoList[6].toUpperCase()}');
      return;
    }
    if (xORoList[0] == xORoList[3] &&
        xORoList[3] == xORoList[6] &&
        xORoList[0] != '') {
      setResult(xORoList[0], 'Winner is ${xORoList[0].toUpperCase()}');
      return;
    }
    if (xORoList[1] == xORoList[4] &&
        xORoList[4] == xORoList[7] &&
        xORoList[1] != '') {
      setResult(xORoList[1], 'Winner is ${xORoList[1].toUpperCase()}');
      return;
    }
    if (xORoList[2] == xORoList[5] &&
        xORoList[5] == xORoList[8] &&
        xORoList[2] != '') {
      setResult(xORoList[2], 'Winner is ${xORoList[2].toUpperCase()}');
      return;
    }
    if (xORoList[0] == xORoList[4] &&
        xORoList[4] == xORoList[8] &&
        xORoList[0] != '') {
      setResult(xORoList[0], 'Winner is ${xORoList[0].toUpperCase()}');
      return;
    }
    if (xORoList[2] == xORoList[4] &&
        xORoList[4] == xORoList[6] &&
        xORoList[2] != '') {
      setResult(xORoList[2], 'Winner is ${xORoList[2].toUpperCase()}');
      return;
    }
    if (filledboxes == 9) {
      setResult('', 'Draw');
    }
  }

  /* Result Button */
  /*               */
  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(280, 67),
          primary: Color(0xFFA8BEC9),
          side: BorderSide(color: Color(0xFFA8BEC9), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        onPressed: () {
          gameHasResult = false;
          clearGame(deepClean: false);
        },
        child: Text(
          '$winnerTitle, Play again!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  /* Get Turn's section Image */
  /*                */
  Widget getTurnImage() {
    if (isTurnO) {
      return Image(
        image: AssetImage('assets/o-grey.png'),
        height: 18,
      );
    } else {
      return Image(
        image: AssetImage('assets/x-grey.png'),
        height: 18,
      );
    }
  }

  /* Get X & O Turn */
  /*                */
  Widget getTurn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getTurnImage(),
        Text(
          isTurnO ? '   TURN' : '   TURN',
          style: TextStyle(
              fontSize: 16,
              color: Color(0xFFA8BEC9),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  /* Get Grid View */
  /*               */
  Widget _getGridView() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(16),
        child: GridView.builder(
          // shrinkWrap: true,
          itemCount: 9,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => tapped(index),
              child: Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF1F3540),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: getImage(index),
              ),
            );
          },
        ),
      ),
    );
  }

  /* Get X & O image */
  /*                 */
  Widget? getImage(index) {
    if (xORoList[index] == 'x') {
      return Image(image: AssetImage('assets/x.png'));
    } else if (xORoList[index] == 'o') {
      return Image(image: AssetImage('assets/o.png'));
    }
    return null;
  }

  /* Score Board Shape Widget */
  /*                          */
  Widget scoreboardShape(Color color, String boardName, String value) {
    return Container(
      height: 67,
      width: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(1),
            child: Text(
              boardName,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(1),
            child: Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  /* Score Board Result */
  /*                    */
  Widget getScoreBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        scoreboardShape(Color(0xFF31C4BE), 'Player X', '$scoreX'),
        scoreboardShape(Color(0xFFA8BEC9), 'TIES', '$scoreTies'),
        scoreboardShape(Color(0xFFF2B237), 'Player O', '$scoreO'),
      ],
    );
  }

  /* SetRresult function */
  /*                     */
  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      winnerTitle = title;

      if (winner == 'x') {
        scoreX += 1;
      } else if (winner == 'o') {
        scoreO += 1;
      } else {
        scoreTies += 1;
      }
    });
  }

  /* Clear Game function */
  /*                     */
  void clearGame({bool deepClean = false}) {
    setState(() {
      for (var i = 0; i < xORoList.length; i++) {
        xORoList[i] = '';
        if (deepClean) {
          scoreX = 0;
          scoreO = 0;
          scoreTies = 0;
          gameHasResult = false;
        }
      }
    });
    filledboxes = 0;
  }
}
