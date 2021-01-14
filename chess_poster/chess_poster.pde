int down, right, down1, right1;//curr move, (down, right)starting pos   (down1,right1)ending pos
int bestl = -1, bestk = -1, besti = -1, bestj = -1;
int p0, p1, p01, p11;//prev move, for en passant
boolean click;//first click select piece, second click moves piece
boolean gameOver;
boolean promote;
PImage wKing, bKing, wQueen, bQueen, wPawn, bPawn, wRook, bRook, wKnight, bKnight, wBishop, bBishop, positionText, positionNumber;
PImage[][] board;

int boardWidth = 500;
int boardHeight = 500;



void setup() {
  size(900, 600);
  background(0);
  noStroke();
  textSize(width/8);
  textAlign(CENTER);

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
  wKing.resize(boardWidth/8, boardHeight/8);
  bKing.resize(boardWidth/8, boardHeight/8);
  wQueen.resize(boardWidth/8, boardHeight/8);
  bQueen.resize(boardWidth/8, boardHeight/8);
  wPawn.resize(boardWidth/8, boardHeight/8);
  bPawn.resize(boardWidth/8, boardHeight/8);
  wRook.resize(boardWidth/8, boardHeight/8);  
  bRook.resize(boardWidth/8, boardHeight/8); 
  wKnight.resize(boardWidth/8, boardHeight/8);
  bKnight.resize(boardWidth/8, boardHeight/8);
  wBishop.resize(boardWidth/8, boardHeight/8);  
  bBishop.resize(boardWidth/8, boardHeight/8);
  
  positionText = loadImage("chess/text.png");
  positionNumber = loadImage("chess/numbers.png");
  positionText.resize(boardWidth-(boardWidth/16)*2, 25);
  positionNumber.resize(20, boardHeight-(boardHeight/16)*2);

  startPosition();
  showBoard();
}
void draw() {
  
 image(positionText, 5+(boardWidth/16) ,520);
 image(positionNumber, 520, 5+(boardHeight/16));
 stroke(255,0,0);
 strokeWeight(5);
 line(10, 10, 10, 510);

}

void showBoard() {
  for (int i = 0; i<8; i++)
    for (int j = 0; j<8; j++) { 
      if ((i+j)%2 == 0) fill(57, 57, 57);
      else fill(255, 255, 255);
      rect(i*(boardWidth/8)+10, j*(boardHeight/8)+10, (boardWidth/8), (boardHeight/8));//chessboard
      if (board[j][i] != null) image(board[j][i], i*(boardWidth/8)+10, j*(boardHeight/8)+10);//piece
    }
}

void startPosition() {
  
  /* FAZER CLASS CHESS PIECE COM POS(X,Y)
  board = new PImage[8][8];

  board[0][0] = bRook;
  bRook (0,0)
  wKnight(7,0)
  for piece in chesspiecelist:
  if piece.pos == 0,0
  pieceName = bRook
  remove-la da lista de peças
  remover a imagem de 0, 0
  adicionar */
  board[0][1] = bKnight;
  board[0][2] = bBishop;
  board[0][3] = bQueen;
  board[0][4] = bKing;
  board[0][5] = bBishop;
  board[2][6] = bKnight;
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

  //global variables
}
