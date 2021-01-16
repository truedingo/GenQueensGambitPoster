import processing.sound.*;
import ddf.minim.*;


SoundFile movePieceSE;

AudioPlayer song;


//Minim
Minim minim;

PFont font;
PImage wKing, bKing, wQueen, bQueen, wPawn, bPawn, wRook, bRook, wKnight, bKnight, wBishop, bBishop, positionText, positionNumber;
PImage[][] board;
boolean isCastle = false;
boolean hasStarted = false;
boolean isPaused = false;
boolean isFirstTime = true;
int indexMusicChosen;
int indexGameChosen;
String gameName;
String gameStamp;
String gameOpening;

float frameRate=0.3;

StringList songNames;
String ost1Name = "Ceiling Games";
String ost2Name = "Main Title";
String ost3Name = "Methuen Home For Children 1957";
String ost4Name = "You're Gloating ";
String ost5Name = "Borgov I";
String ost6Name = "Playing Mr. Ganz";
String ost7Name = "The Green Pills";
String ost8Name = "Top Boards";
String ost9Name = "Kentucky State Championship 1963";

String musicFrom = "The Queen's Gambit (Music from the Netflix Limited Series)";
String musicAuthor = "Carlos Rafael Rivera";

String ost1 = "soundtrack/CeilingGames.wav";
String ost2 = "soundtrack/MainTitle.wav";
String ost3 = "soundtrack/MethuenHomeForChildren1957.wav";
String ost4 = "soundtrack/YouareGloating.wav";
String ost5 = "soundtrack/BorgovI.wav";
String ost6 = "soundtrack/PlayingMrGanz.wav";
String ost7 = "soundtrack/TheGreenPills.wav";
String ost8 = "soundtrack/TopBoards.wav";
String ost9 = "soundtrack/KentuckyStateChampionship1963.wav";

StringList shuffleMusic;

int textTimer=0;


//GAME DATA
String game = "D2d4 D7d5 C2c4 D5c4 E2e3 G8f6 F1c4 E7e6 G1f3 C7c5 0e1g1h1f1 A7a6 E3e4 B7b5 C3d3 C8b7 C1g5 C5d4 F3d4 B8d7 B1c3 D7e5 C3b5 E5d3 D1d3 A6b5 F1d1 F8e7 D3b5 D8d7 B5b3 B7e4 D4f5 E4d5 F5g7 E8f8 B3h3 H7h5 H3g3 F8g7 G5f6 G7f6 D1d4 E7d6 G3c3 F6g6 H2h3 D6c7";
String GameName = "Garry Kasparov vs Boris Gulko";
String GameTimeStamp = "12th Soviet Team Cup (1982), Kislovodsk URS, rd 2, Jun-??";
String GameOpenings = "Queen's Gambit Accepted: Classical Defense. Russian Gambit";
String GameMoves = "d4 d5 c4 dxc4 e3 Nf6 Bxc4 e6 Nf3 c5 O-O a6 e4 b5 Bd3 Bb7 Bg5 cxd4 Nxd4 Nbd7 Nc3 Ne5 Ncxb5 Nxd3 Qxd3 axb5 Rfd1 Be7 Qxb5+ Qd7 Qb3 Bxe4 Nf5 Bd5 Nxg7+ Kf8 Qh3 h5 Qg3 Kxg7 Bxf6+ Kxf6 Rd4 Bd6 Qc3 Kg6 h3 Bc7";
int GameResult = 1; //0 - white wins 1 - black wins

String game1 = "D2d4 d7d5 c2c4 e7e6 b1c3 g8f6 c1g5 b1d7 c4d5 e6d5 c3d5 f6d5 g5d8 f8b4 d1d2 e8d8";
String GameName1 = "Karl Mayet vs Daniel Harrwitz";
String GameTimeStamp1 = "The Oldest Trick in the Book - Berlin (1848), Berlin GER";
String GameOpenings1 = "Queen's Gambit Declined: Modern. Knight Defense ";
String GameMoves1 = "d4 d5 c4 e6 Nc3 Nf6 Bg5 Nbd7 cxd5 exd5 Nxd5 Nxd5 Bxd8 Bb4+ Qd2 Kxd8";

int GameResult1 = 1; //0 - white wins 1 - black wins

String game2 = "D2d4 D7d5 C2c4 D5c4 E2e3 G8f6 F1c4 E7e6 G1f3 C7c5 0e1g1h1f1 A7a6 E3e4 B7b5 C3d3 C8b7 C1g5 C5d4 F3d4 B8d7 B1c3 D7e5 C3b5 E5d3 D1d3 A6b5 F1d1 F8e7 D3b5 D8d7 B5b3 B7e4 D4f5 E4d5 F5g7 E8f8 B3h3 H7h5 H3g3 F8g7 G5f6 G7f6 D1d4 E7d6 G3c3 F6g6 H2h3 D6c7";
String GameName2 = "Garry Kasparov vs Ana Guiomar";
String GameTimeStamp2 = "12th Soviet Team Cup (1982), Kislovodsk URS, rd 2, Jun-?? sampleeee ";
String GameOpenings2 = "Queen's Gambit Declined: Modern. Knight Defense";
String GameMoves2 = "d4 d5 c4 dxc4 e3 Nf6 Bxc4 e6 Nf3 c5 O-O a6 e4 b5 Bd3 Bb7 Bg5 cxd4 Nxd4 Nbd7 Nc3 Ne5 Ncxb5 Nxd3 Qxd3 axb5 Rfd1 Be7 Qxb5+ Qd7 Qb3 Bxe4 Nf5 Bd5 Nxg7+ Kf8 Qh3 h5 Qg3 Kxg7 Bxf6+ Kxf6 Rd4 Bd6 Qc3 Kg6 h3 Bc7";
int GameResult2 = 0; //0 - white wins 1 - black wins

//LISTS
StringList gameList;
StringList gameMovesList;
StringList gameMovesListDisplay;
StringList gameTimestamps;
StringList gameOpenings;
IntList gameResults;


int timer=0;

int boardWidth = 500;
int boardHeight = 500;




void setup() {
  size(1000, 600);
  background(0);
  frameRate(0.3);
  noStroke();
  textSize(width/8);
  textAlign(CENTER);
  
  //LIST INIT
  gameList = new StringList();
  gameList.append(GameName);
  gameList.append(GameName1);
  gameList.append(GameName2);
  
  gameMovesList = new StringList();
  gameMovesList.append(game);
  gameMovesList.append(game1);
  gameMovesList.append(game2);
  
  gameMovesListDisplay = new StringList();
  gameMovesListDisplay.append(GameMoves);
  gameMovesListDisplay.append(GameMoves1);
  gameMovesListDisplay.append(GameMoves2);
  
  gameTimestamps = new StringList();
  gameTimestamps.append(GameTimeStamp);
  gameTimestamps.append(GameTimeStamp1);
  gameTimestamps.append(GameTimeStamp2);
  
  gameOpenings = new StringList();
  gameOpenings.append(GameOpenings);
  gameOpenings.append(GameOpenings1);
  gameOpenings.append(GameOpenings2);
  
  gameResults = new IntList();
  gameResults.append(GameResult);
  gameResults.append(GameResult1);
  gameResults.append(GameResult2);
  
  
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
  startPosition();  
  movePieceSE = new SoundFile(this, "soundtrack/move_piece.wav");
  font = createFont("font/mono.ttf", 20);
  textFont(font);
  
  
  //minim = new Minim(this);
  //song = minim.loadFile("soundtrack/MainTitle.wav");
 
  
  
  songNames = new StringList();
  songNames.append(ost1Name);
  songNames.append(ost2Name);
  songNames.append(ost3Name);
  songNames.append(ost4Name);
  songNames.append(ost5Name);
  songNames.append(ost6Name);
  songNames.append(ost7Name);
  songNames.append(ost8Name);
  songNames.append(ost9Name);
  
  shuffleMusic = new StringList();
  shuffleMusic.append(ost1);
  shuffleMusic.append(ost2);
  shuffleMusic.append(ost3);
  shuffleMusic.append(ost4);
  shuffleMusic.append(ost5);
  shuffleMusic.append(ost6);
  shuffleMusic.append(ost7);
  shuffleMusic.append(ost8);
  shuffleMusic.append(ost9);


 
}
void draw() {
 //stroke(255,0,0);
 //strokeWeight(5);
 //line(10, 10, 10, 510);
 
 //We need to generate a song for the first Time opening the program
 if(isFirstTime == true){
   int currLen = shuffleMusic.size();
   indexMusicChosen = int(random(0, currLen));
   minim = new Minim(this);
   song = minim.loadFile(shuffleMusic.get(indexMusicChosen));
   song.play();
   isFirstTime = false;
 }
 else{
   if(!song.isPlaying()){
     if(shuffleMusic.size() > 0){
       song.close();
       shuffleMusic.remove(indexMusicChosen);
       songNames.remove(indexMusicChosen);
       int currLen = shuffleMusic.size();
       indexMusicChosen = int(random(0, currLen));
       minim = new Minim(this);
       song = minim.loadFile(shuffleMusic.get(indexMusicChosen));
       song.play();
       fill(0);
       rect(600, 420, 300, 20);
       fill(255);
       textSize(20);
       text(songNames.get(indexMusicChosen), 770, 440);
     }
     else{
       songNames = new StringList();
       songNames.append(ost1Name);
       songNames.append(ost2Name);
       songNames.append(ost3Name);
       songNames.append(ost4Name);
      
       shuffleMusic = new StringList();
       shuffleMusic.append(ost1);
       shuffleMusic.append(ost2);
       shuffleMusic.append(ost3);
       shuffleMusic.append(ost4);
      
       song.close();
       shuffleMusic.remove(indexMusicChosen);
       songNames.remove(indexMusicChosen);
       int currLen = shuffleMusic.size();
       indexMusicChosen = int(random(0, currLen));
       minim = new Minim(this);
       song = minim.loadFile(shuffleMusic.get(indexMusicChosen));
       song.play();
     
     }
   }
 }
 
 
 if(isPaused == false){
   if(hasStarted == false){
      image(positionText, 5+(boardWidth/16) ,520);
      image(positionNumber, 520, 5+(boardHeight/16));
     if(gameList.size() == 0){
       gameList = new StringList();
       gameList.append(GameName);
       gameList.append(GameName1);
       gameList.append(GameName2);
       
       
       gameOpenings = new StringList();
       gameOpenings.append(GameOpenings);
       gameOpenings.append(GameOpenings1);
       gameOpenings.append(GameOpenings2);
       
       
       gameTimestamps = new StringList();      
       gameTimestamps.append(GameTimeStamp);
       gameTimestamps.append(GameTimeStamp1);
       gameTimestamps.append(GameTimeStamp2);
       
       gameMovesListDisplay = new StringList();
       gameMovesListDisplay.append(GameMoves);
       gameMovesListDisplay.append(GameMoves1);
       gameMovesListDisplay.append(GameMoves2);
       
       gameMovesList = new StringList();
       gameMovesList.append(game);
       gameMovesList.append(game1);
       gameMovesList.append(game2);
       
       gameResults = new IntList();
       gameResults.append(GameResult);
       gameResults.append(GameResult1);
       gameResults.append(GameResult2);
      
      
     }
     hasStarted = true;
     if(gameList.size()>0){
       int currLen = gameList.size();
       indexGameChosen = int(random(0,currLen));
       
       String selectedName = gameList.get(indexGameChosen);
       String selectedTimestamp = gameTimestamps.get(indexGameChosen);
       String selectedOpening = gameOpenings.get(indexGameChosen);
       
       textSize(30);
       fill(255);
       text("A Queen's Gambit", 740, 50);
       text("Generative Poster", 770, 85);
       fill(255);
       textSize(10);
       text("White", 670, 130);
       text("Black", 850, 130);
       textSize(20);
       text(selectedName, 770, 160);
       textSize(10);
       text(selectedTimestamp, 770, 180);
       textSize(12);
       text(selectedOpening, 770, 200);
       textSize(25);
       text("Move", 770, 250);
       textSize(25);
       text("Currently playing", 770, 400);
       textSize(20);
       text(songNames.get(indexMusicChosen), 770, 440);
       textSize(15);
       text(musicAuthor, 770, 470);
       textSize(10);
       text(musicFrom, 770, 500);
       text("e - increase frame rate | r - reset frame rate | p - pause current game", 250, 580);
       
     
     }
   }
    playOutGame(gameMovesList.get(indexGameChosen));
 }
 else{
   delay(2000);
   timer=0;
   background(0);
   isPaused=false;
   hasStarted=false;
   startPosition();
   showBoard();
   
 }
 
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
    fill(0);
    rect(600, 260, 300, 20);
    fill(255);
    textSize(20);
    String currentMove = getCurrentMove(timer);
    text(currentMove, 770, 280);
    movePieceSE.play();
    movePiece(convert);
    timer++;
  }
  else{
      int getResult = gameResults.get(indexGameChosen);
      if(getResult == 0){
        fill(255);
        textSize(30);
        fill(255);
        text("White Wins", 770, 320);
      }
      else{
        fill(255);
        textSize(30);
        text("Black Wins", 770, 320);
      }
        isPaused=true;
        gameList.remove(indexGameChosen);
        gameMovesList.remove(indexGameChosen);
        gameMovesListDisplay.remove(indexGameChosen);
        gameTimestamps.remove(indexGameChosen);
        gameOpenings.remove(indexGameChosen);
        gameResults.remove(indexGameChosen);
  }
}

String getCurrentMove(int timer){
   String[] aux = split(gameMovesListDisplay.get(indexGameChosen), " ");
   return aux[timer];
}

void movePiece(IntList chessMove){
  if(isCastle ==false){
    int s = chessMove.get(0);
    int t = chessMove.get(1);
    int ss = chessMove.get(2);
    int tt = chessMove.get(3);
    board[tt][ss] = board[t][s];
    board[t][s] = null;
    showBoard();
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
    showBoard();
   
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

void keyPressed(){
  if(key == 'r' || key == 'R'){
    frameRate=0.3;
    frameRate(frameRate);
  }
  if(key == 'e' || key == 'E'){
    frameRate+=0.5;
    frameRate(frameRate);
  }
  if(key == 'p' || key == 'P'){
    if(looping) noLoop();
    else loop();
  }
}
