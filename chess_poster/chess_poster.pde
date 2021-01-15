import processing.sound.*;
SoundFile movePieceSE;
PFont font;
PImage wKing, bKing, wQueen, bQueen, wPawn, bPawn, wRook, bRook, wKnight, bKnight, wBishop, bBishop, positionText, positionNumber;
PImage[][] board;
boolean check = false;
boolean isCastle = false;
boolean hasStarted = false;
boolean isOver = false;
int indexGameChosen;
String gameName;
String gameStamp;
String gameOpening;


//GAME DATA
String GarryKasparovVSBorisGulko = "D2d4 D7d5 C2c4 D5c4 E2e3 G8f6 F1c4 E7e6 G1f3 C7c5 0e1g1h1f1 A7a6 E3e4 B7b5 C3d3 C8b7 C1g5 C5d4 F3d4 B8d7 B1c3 D7e5 C3b5 E5d3 D1d3 A6b5 F1d1 F8e7 D3b5 D8d7 B5b3 B7e4 D4f5 E4d5 F5g7 E8f8 B3h3 H7h5 H3g3 F8g7 G5f6 G7f6 D1d4 E7d6 G3c3 F6g6 H2h3 D6c7";
String gkVSbgGameName = "Garry Kasparov vs Boris Gulko";
String gkVSbgTimestamp = "12th Soviet Team Cup (1982), Kislovodsk URS, rd 2, Jun-??";
String gkVSbgOpenings = "Queen's Gambit Accepted: Classical Defense. Russian Gambit (D27)";
String gkVSbgMoves = "";
int gkVSbgResult = 1; //0 - white wins 1 - black wins, 2 - draw


String GarryKasparovVSBorisGulko1 = "D2d4 D7d5 C2c4 D5c4 E2e3 G8f6 F1c4 E7e6 G1f3 C7c5 0e1g1h1f1 A7a6 E3e4 B7b5 C3d3 C8b7 C1g5 C5d4 F3d4 B8d7 B1c3 D7e5 C3b5 E5d3 D1d3 A6b5 F1d1 F8e7 D3b5 D8d7 B5b3 B7e4 D4f5 E4d5 F5g7 E8f8 B3h3 H7h5 H3g3 F8g7 G5f6 G7f6 D1d4 E7d6 G3c3 F6g6 H2h3 D6c7";
String gkVSbgGameName1 = "Dionysius Vashr vs Andrew Pelkazysr ";
String gkVSbgTimestamp1 = "12th Soviet Team Cup (1982), Kislovodsk URS, rd 2, Jun-?? sample ";
String gkVSbgOpenings1 = "Queen's Gambit Declined: Marshall Defense (D06)";
String gkVSbgMoves1 = "";
int gkVSbgResult1 = 0; //0 - white wins 1 - black wins, 2 - draw

String GarryKasparovVSBorisGulko2 = "D2d4 D7d5 C2c4 D5c4 E2e3 G8f6 F1c4 E7e6 G1f3 C7c5 0e1g1h1f1 A7a6 E3e4 B7b5 C3d3 C8b7 C1g5 C5d4 F3d4 B8d7 B1c3 D7e5 C3b5 E5d3 D1d3 A6b5 F1d1 F8e7 D3b5 D8d7 B5b3 B7e4 D4f5 E4d5 F5g7 E8f8 B3h3 H7h5 H3g3 F8g7 G5f6 G7f6 D1d4 E7d6 G3c3 F6g6 H2h3 D6c7";
String gkVSbgGameName2 = "Garry Kasparov vs Ana Guiomar";
String gkVSbgTimestamp2 = "12th Soviet Team Cup (1982), Kislovodsk URS, rd 2, Jun-?? sampleeee ";
String gkVSbgOpenings2 = "Queen's Gambit Declined: Modern. Knight Defense (D51)";
String gkVSbgMoves2 = "";
int gkVSbgResult2 = 2; //0 - white wins 1 - black wins, 2 - draw

//LISTS
StringList gameList;
StringList gameMovesList;
StringList gameMovesListDisplay;
StringList gameTimestamps;
StringList gameOpenings;



/*
1.d4 d5 2.c4 dxc4 3.e3 Nf6 4.Bxc4 e6 5.Nf3 c5 6.O-O a6 7.e4 b5
8.Bd3 Bb7 9.Bg5 cxd4 10.Nxd4 Nbd7 11.Nc3 Ne5 12.Ncxb5 Nxd3
13.Qxd3 axb5 14.Rfd1 Be7 15.Qxb5+ Qd7 16.Qb3 Bxe4 17.Nf5 Bd5
18.Nxg7+ Kf8 19.Qh3 h5 20.Qg3 Kxg7 21.Bxf6+ Kxf6 22.Rd4 Bd6
23.Qc3 Kg6 24.h3 Bc7*/




boolean posterText = true;

int timer=0;

int boardWidth = 500;
int boardHeight = 500;

long timeToWait = 1000;// in miliseconds
long lastTime;



void setup() {
  size(1000, 600);
  background(0);
  frameRate(1);
  noStroke();
  textSize(width/8);
  textAlign(CENTER);
  
  //LIST INIT
  gameList = new StringList();
  gameList.append(gkVSbgGameName);
  gameList.append(gkVSbgGameName1);
  gameList.append(gkVSbgGameName2);
  
  gameMovesList = new StringList();
  gameMovesList.append(GarryKasparovVSBorisGulko);
  gameMovesList.append(GarryKasparovVSBorisGulko1);
  gameMovesList.append(GarryKasparovVSBorisGulko2);
  
  gameMovesListDisplay = new StringList();
  gameMovesListDisplay.append(GarryKasparovVSBorisGulko);
  gameMovesListDisplay.append(GarryKasparovVSBorisGulko1);
  gameMovesListDisplay.append(GarryKasparovVSBorisGulko2);
  
  gameTimestamps = new StringList();
  gameTimestamps.append(gkVSbgTimestamp);
  gameTimestamps.append(gkVSbgTimestamp1);
  gameTimestamps.append(gkVSbgTimestamp2);
  
  gameOpenings = new StringList();
  gameOpenings.append(gkVSbgOpenings);
  gameOpenings.append(gkVSbgOpenings1);
  gameOpenings.append(gkVSbgOpenings2);
  
  //
 

  wKing = loadImage("chess/white_king.png");
  bKing = loadImage("chess/black_king.png");
  wQueen = loadImage("chess/white_queen.png");
  bQueen = loadImage("chess/black_queen.png");
  wPawn = loadImage("chess/white_pawn.png");
  bPawn = loadImage("chess/black_pawn.png");
  wRook = loadImage("chess/white_rook.png");
  bRook = loadImage("chess/black_rook.png");
  wKnight = loadImage("chess/white_knight.png");
  bKnight = loadImage("chess/black_knight.png");
  wBishop = loadImage("chess/white_bishop.png");
  bBishop = loadImage("chess/black_bishop.png");
  wKing.resize(boardWidth/11, boardHeight/11);
  bKing.resize(boardWidth/11, boardHeight/11);
  wQueen.resize(boardWidth/11, boardHeight/11);
  bQueen.resize(boardWidth/11, boardHeight/11);
  wPawn.resize(boardWidth/11, boardHeight/11);
  bPawn.resize(boardWidth/11, boardHeight/11);
  wRook.resize(boardWidth/11, boardHeight/11);  
  bRook.resize(boardWidth/11, boardHeight/11); 
  wKnight.resize(boardWidth/11, boardHeight/11);
  bKnight.resize(boardWidth/11, boardHeight/11);
  wBishop.resize(boardWidth/11, boardHeight/11);  
  bBishop.resize(boardWidth/11, boardHeight/11);
  
  positionText = loadImage("chess/text.png");
  positionNumber = loadImage("chess/numbers.png");
  positionText.resize(boardWidth-(boardWidth/16)*2, 25);
  positionNumber.resize(20, boardHeight-(boardHeight/16)*2);
  
  lastTime = millis();
  startPosition();
  
  movePieceSE = new SoundFile(this, "soundtrack/move_piece.wav");
  font = createFont("font/mono.ttf", 20);
  textFont(font);
 
}
void draw() {
 //stroke(255,0,0);
 //strokeWeight(5);
 //line(10, 10, 10, 510);
 showBoard();
 if(hasStarted == false){
    image(positionText, 5+(boardWidth/16) ,520);
    image(positionNumber, 520, 5+(boardHeight/16));
   if(gameList.size() == 0){
     gameList.append(gkVSbgGameName);
     gameList.append(gkVSbgGameName1);
     gameList.append(gkVSbgGameName2);
     
     gameOpenings.append(gkVSbgOpenings);
     gameOpenings.append(gkVSbgOpenings1);
     gameOpenings.append(gkVSbgOpenings2);
    
     gameTimestamps.append(gkVSbgTimestamp);
     gameTimestamps.append(gkVSbgTimestamp1);
     gameTimestamps.append(gkVSbgTimestamp2);
     
     gameMovesListDisplay.append(GarryKasparovVSBorisGulko);
     gameMovesListDisplay.append(GarryKasparovVSBorisGulko1);
     gameMovesListDisplay.append(GarryKasparovVSBorisGulko2);
     
     gameMovesList.append(GarryKasparovVSBorisGulko);
     gameMovesList.append(GarryKasparovVSBorisGulko1);
     gameMovesList.append(GarryKasparovVSBorisGulko2);
    
    
   }
   int currLen = gameList.size();
   indexGameChosen = int(random(0,currLen));
   
   String selectedName = gameList.get(indexGameChosen);
   String selectedTimestamp = gameTimestamps.get(indexGameChosen);
   String selectedOpening = gameOpenings.get(indexGameChosen);
   String selectedMoves = gameMovesListDisplay.get(indexGameChosen);
   fill(255);
   textSize(15);
   text(selectedName, 770, 160);
   textSize(10);
   text(selectedTimestamp, 770, 180);
   textSize(12);
   text(selectedOpening, 770, 200);
   //gameList.remove(indexGameChosen);
   hasStarted = true;
 }
 
  /*if( millis() - lastTime > timeToWait){
    startPosition();
    lastTime = millis();
  }*/
  if(posterText == true){
    textSize(20);
    fill(255);
    text("A Queen's Gambit", 770, 50);
    text("Generative Poster", 770, 85);
    posterText = false;
  }
  /*
  if(isOver == true){
    fill(0);
    rect(550, 120, 300, 20);
    fill(255);
    text("Small example", 650, 140);
  }*/
  playOutGame(GarryKasparovVSBorisGulko);
 
 
}

void playOutGame(String game){
  String[] aux = split(game, " ");
  if(timer<aux.length){
    String seq = aux[timer].toLowerCase();
    IntList convert = new IntList();
    for(int j=0; j<seq.length(); j++){
      char cmp = seq.charAt(j);
      if(cmp == 'a'){
        convert.append(0);
      }
      else if(cmp == 'b'){
        convert.append(1);
      }
      else if(cmp == 'c'){
        convert.append(2);
      }
      else if(cmp == 'd'){
        convert.append(3);
      }
      else if(cmp == 'e'){
        convert.append(4);
      }
      else if(cmp == 'f'){
        convert.append(5);
      }
      else if(cmp == 'g'){
        convert.append(6);
      }
      else if(cmp == 'h'){
        convert.append(7);
      }
      else if(cmp == '0'){
        convert.append(8);
        isCastle=true;
      }
      else{
        int convertPos = abs(int(cmp)-48 - 8);
        convert.append(convertPos);
      }
    }
    movePieceSE.play();
    movePiece(convert);
    timer++;
    if(timer == 4){
      isOver=true;
    }
  }
}

void movePiece(IntList chessMove){
  if(isCastle ==false){
    int s = chessMove.get(0);
    int t = chessMove.get(1);
    int ss = chessMove.get(2);
    int tt = chessMove.get(3);
    board[tt][ss] = board[t][s];
    board[t][s] = null;
   }
   else{
    int s = chessMove.get(1);
    int t = chessMove.get(2);
    int ss = chessMove.get(3);
    int tt = chessMove.get(4);
    int s1 = chessMove.get(5);
    int t1 = chessMove.get(6);
    int ss1 = chessMove.get(7);
    int tt1 = chessMove.get(8);
    
    board[tt][ss] = board[t][s];
    board[t][s] = null;
    board[tt1][ss1] = board[t1][s1];
    board[t1][s1] = null;
    isCastle = false;
   
   }
 }

void showBoard() {
  for (int i = 0; i<8; i++)
    for (int j = 0; j<8; j++) { 
      if ((i+j)%2 == 0) fill(57, 57, 57);
      else fill(255, 255, 255);
      rect(i*(boardWidth/8)+10, j*(boardHeight/8)+10, (boardWidth/8), (boardHeight/8));//chessboard
      if (board[j][i] != null) image(board[j][i], i*(boardWidth/8)+18, j*(boardHeight/8)+20);//piece
    }
}

void startPosition() {
  
  /* FAZER CLASS CHESS PIECE COM POS(X,Y)
  board[0][0] = bRook;
  bRook (0,0)
  wKnight(7,0)
  for piece in chesspiecelist:
  if piece.pos == 0,0
  pieceName = bRook
  remove-la da lista de peças
  remover a imagem de 0, 0
  adicionar */
  
  board = new PImage[8][8];
  
  board[0][0] = bRook;
  board[0][1] = bKnight;
  board[0][2] = bBishop;
  board[0][3] = bQueen;
  board[0][4] = bKing;
  board[0][5] = bBishop;
  board[0][6] = bKnight;
  board[0][7] = bRook;
  board[1][0] = bPawn;
  board[1][1] = bPawn;
  board[1][2] = bPawn; 
  board[1][3] = bPawn;
  board[1][4] = bPawn;
  board[1][5] = bPawn;
  board[1][6] = bPawn;
  board[1][7] = bPawn;

  board[7][0] = wRook;
  board[7][1] = wKnight;
  board[7][2] = wBishop;
  board[7][3] = wQueen;
  board[7][4] = wKing;
  board[7][5] = wBishop;
  board[7][6] = wKnight;
  board[7][7] = wRook;
  board[6][0] = wPawn;
  board[6][1] = wPawn;
  board[6][2] = wPawn;
  board[6][3] = wPawn;
  board[6][4] = wPawn;
  board[6][5] = wPawn;
  board[6][6] = wPawn;
  board[6][7] = wPawn;
  
  
}
