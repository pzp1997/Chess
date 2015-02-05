// Chess by Palmer Paul and Josh Verscheslieser

/* TODO
   * Finish writing piece restrictions
   * Detect for checkmate/check
   * Stop pieces from jumping over others (except for Knight)
 */

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

int[][] board = new int[8][8];
PImage[] reps = new PImage[12];
int[] moving = new int[3];
boolean turn = true;

void setup() {
  size(480, 480);
  noStroke();

  reps[0] = loadImage("Black_Rook1.png");
  reps[1] = loadImage("Black_Knight1.png");
  reps[2] = loadImage("Black_Bishop1.png");
  reps[3] = loadImage("Black_Queen1.png");
  reps[4] = loadImage("Black_King1.png");
  reps[5] = loadImage("Black_Pawn1.png");
  reps[6] = loadImage("White_Rook1.png");
  reps[7] = loadImage("White_Knight1.png");
  reps[8] = loadImage("White_Bishop1.png");
  reps[9] = loadImage("White_Queen1.png");
  reps[10] = loadImage("White_King1.png");
  reps[11] = loadImage("White_Pawn1.png");

  // Makes pieces
  for (int i = 0; i < 8; i++) {
    board[i][0] = i+1;
    board[i][1] = 6;
    board[i][6] = 12;
    board[i][7] = i+7;
  }
  board[5][0] = 3;
  board[6][0] = 2;
  board[7][0] = 1;
  board[5][7] = 9;
  board[6][7] = 8;
  board[7][7] = 7;

  drawBoard(#222222, #888888);
  drawPieces();
}

void draw() {
}

void mousePressed() {
  moving[0] = constrain(8*mouseX/width, 0, 7);
  moving[1] = constrain(8*mouseY/height, 0, 7);
  moving[2] = board[moving[0]][moving[1]];
  if ((turn && moving[2] < 7) || (!turn && moving[2] > 6)) {
    moving[2] = 0;
  }
}

void mouseReleased() {
  int[] mouse_loc = { constrain(8*mouseX/width, 0, 7), constrain(8*mouseY/height, 0, 7) };
  int dc = abs(moving[0] - mouse_loc[0]);
  int dr = abs(moving[1] - mouse_loc[1]);
  boolean valid = false;
  switch(moving[2]) {
    case 1:
    case 7:
      // Rook
      if (dc == 0 || dr == 0) {
        valid = true;
      }
      break;
    case 2:
    case 8:
      // Knight
      break;
    case 3:
    case 9:
      // Bishop
      if (dc == dr) {
        valid = true;
      }
      break;
    case 4:
    case 10:
      // Queen
      if (dc == dr || (dc == 0 || dr == 0)) {
        valid = true;
      }
      break;
    case 5:
    case 11:
      // King
      if (dc < 2 && dr < 2) {
        valid = true;
      }
      break;
    case 6:
    case 12:
      // Pawn
        // TODO: diagnol to take and 2 on first move
      if (dc == 0 && ((turn && moving[1] - mouse_loc[1] == 1) || (!turn && mouse_loc[1] - moving[1] == 1))) {
        valid = true;
      }
      break;
  }
  if (valid && (dc != 0 || dr != 0)) {
    board[mouse_loc[0]][mouse_loc[1]] = moving[2];
    board[moving[0]][moving[1]] = 0;
    turn = !turn;

    drawBoard(#222222, #888888);
    drawPieces();
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

void drawPieces() {
  for (int c = 0; c < board.length; c++) {
    for (int r = 0; r < board[c].length; r++) {
      int id = board[c][r];
      if (id != 0) {
        image(reps[id-1], c*width/8 + width/48, r*height/8 + height/48, width/12, height/12);
      }
    }
  }
}
