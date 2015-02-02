// Chess by Palmer Paul and Josh Verscheslieser

/* Piece IDs
 Black  White  Piece
 1      7      Rook
 2      8      Knight
 3      9      Bishop
 4      10     Queen
 5      11     King
 6      12     Pawn
 0      0      Blank
 */

int[] board = new int[64];
PImage[] reps = new PImage[12];
int moving_id, moving_loc;
boolean turn = true;

void setup() {
  size(480, 480);
  noStroke();

  reps[0] = loadImage("Black_Rook.png");
  reps[1] = loadImage("Black_Knight.png");
  reps[2] = loadImage("Black_Bishop.png");
  reps[3] = loadImage("Black_Queen.png");
  reps[4] = loadImage("Black_King.png");
  reps[5] = loadImage("Black_Pawn.png");
  reps[6] = loadImage("White_Rook.png");
  reps[7] = loadImage("White_Knight.png");
  reps[8] = loadImage("White_Bishop.png");
  reps[9] = loadImage("White_Queen.png");
  reps[10] = loadImage("White_King.png");
  reps[11] = loadImage("White_Pawn.png");

  // Makes pieces
  for (int i = 0; i < 8; i++) {
    board[i] = i+1;
    board[i+8] = 6;
    board[i+48] = 12;
    board[i+56] = i+7;
  }
  board[5] = 3;
  board[6] = 2;
  board[7] = 1;
  board[61] = 9;
  board[62] = 8;
  board[63] = 7;

  drawBoard(#222222, #888888);

  for (int i = 0; i < board.length; i++) {
    int id = board[i];
    if (id != 0) {
      image(reps[id-1], (i%8)*width/8 + width/48, (i/8)*height/8 + height/48, width/12, height/12);
    }
  }
}

void draw() {
}

void mousePressed() {
  moving_loc = 8*(8*mouseY/height) + 8*mouseX/width;
  moving_id = board[moving_loc];
  if ((turn && moving_id < 7) || (!turn && moving_id > 6)) {
    moving_id = 0;
  }
}

void mouseReleased() {
  int mouse_loc = 8*(8*mouseY/height) + 8*mouseX/width;
  if (moving_id != 0 && moving_loc != mouse_loc) {
    board[mouse_loc] = moving_id;
    board[moving_loc] = 0;
    turn = !turn;
  }

  drawBoard(#222222, #888888);

  for (int i = 0; i < board.length; i++) {
    int id = board[i];
    if (id != 0) {
      image(reps[id-1], (i%8)*width/8 + width/48, (i/8)*height/8 + height/48, width/12, height/12);
    }
  }
}

void drawBoard(color c1, color c2) {
  boolean tileShift = false;
  fill(c1);
  background(c2);

  for (int w = 0; w < width; w += width/4) {
    for (int h = 0; h < height; h += height/8) {
      if (tileShift) {
        rect(w, h, width/8, height/8);
      } else {
        rect(w+height/8, h, width/8, height/8);
      }
      tileShift = !tileShift;
    }
  }
}
