

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private int NUM_ROWS = 20;
private int NUM_COLS = 20;
private int NUM_BOMBS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined
public boolean gameover;

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[20][20];
  for (int r = 0; r < NUM_ROWS; r++)
    for (int c = 0; c < NUM_COLS; c++)
      buttons[r][c] =new MSButton(r, c);

  setBombs();
}
public void setBombs()
{
  //your code
  while (bombs.size()< NUM_BOMBS)
  {
    int r = (int)(Math.random()*20);
    int c = (int)(Math.random()*20);
    if (bombs.contains(buttons[r][c]) == false) {
      bombs.add(buttons[r][c]);
      System.out.println(r+","+c);
    }
  }
}
public void draw ()
{
  if(gameover==true)
  return;
  background( 0 );
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  //your code here
  for (int r =0; r< NUM_ROWS; r++) {
    for (int c=0; c< NUM_COLS; c++) {
      if (buttons[r][c].isClicked() == false) {
        return false;
      }
    }
  }
  return true;
}
public void displayLosingMessage()
{
  
  //your code here
  for (int r =0; r< NUM_ROWS; r++) {
    for (int c=0; c< NUM_COLS; c++) {
      if ( buttons[r][c].isClicked() == true && bombs.contains(this) ) 
      buttons[NUM_ROWS/2][(NUM_COLS/2-5)].setLabel("");
       buttons[NUM_ROWS/2][(NUM_COLS/2-4)].setLabel("G");
      buttons[NUM_ROWS/2][(NUM_COLS/2-3)].setLabel("A");
      buttons[NUM_ROWS/2][(NUM_COLS/2-2)].setLabel("M");
      buttons[NUM_ROWS/2][(NUM_COLS/2-1)].setLabel("E");
      buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("O");
      buttons[NUM_ROWS/2][(NUM_COLS/2+1)].setLabel("V");
      buttons[NUM_ROWS/2][(NUM_COLS/2+2)].setLabel("E");
      buttons[NUM_ROWS/2][(NUM_COLS/2+3)].setLabel("R");
      
    }
  }
}
public void displayWinningMessage()
{
  //your code here
  if ( isWon() == true ) 
    buttons[NUM_ROWS/2][(NUM_COLS/2-4)].setLabel("Y");
  buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("O");
  buttons[NUM_ROWS/2][(NUM_COLS/2-2)].setLabel("U");
  buttons[NUM_ROWS/2][(NUM_COLS/2-1)].setLabel("");
  buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("W");
  buttons[NUM_ROWS/2][(NUM_COLS/2+1)].setLabel("I");
  buttons[NUM_ROWS/2][(NUM_COLS/2+2)].setLabel("N");
  buttons[NUM_ROWS/2][(NUM_COLS/2+3)].setLabel("!");

}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager

  public void mousePressed () 
  {
    clicked = true;
    //your code here
    if (keyPressed == true|| mousePressed && (mouseButton == RIGHT))
    {

      if (marked == false)
      {
        marked = true;
        clicked = true;
      } 
      else if(gameover==true)
      ;
      else if (marked == true)
      {
        clicked = false;
        marked = false;
      }
    } else if ( bombs.contains(this)&& gameover == false)
    {
      gameover = true;
      displayLosingMessage();
    } else if (countBombs(r, c) > 0)
    {
      setLabel(""+ countBombs(r, c));
    } else {
      if (isValid(r, c-1) && !buttons[r][c-1].isClicked())
        buttons[r][c-1].mousePressed();
      if (isValid(r, c+1) && !buttons[r][c+1].isClicked())
        buttons[r][c+1].mousePressed();
      if (isValid(r-1, c) && !buttons[r-1][c].isClicked())
        buttons[r-1][c].mousePressed();
      if (isValid(r+1, c) && !buttons[r+1][c].isClicked())
        buttons[r+1][c].mousePressed();
      if (isValid(r+1, c-1) && !buttons[r+1][c-1].isClicked())
        buttons[r+1][c-1].mousePressed();
      if (isValid(r+1, c+1) && !buttons[r+1][c+1].isClicked())
        buttons[r+1][c+1].mousePressed();
      if (isValid(r-1, c+1) && !buttons[r-1][c+1].isClicked())
        buttons[r-1][c+1].mousePressed();
      if (isValid(r-1, c-1) && !buttons[r-1][c-1].isClicked())
        buttons[r-1][c-1].mousePressed();
    }
  }


  public void draw () 
  {
    
     if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    //your code here
    if (NUM_ROWS>r && r>= 0&&NUM_COLS>c && c>=0)
      return true;
    return false;
  }

  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    //your code here
    if (isValid(r, c-1) == true && bombs.contains(buttons[r][c-1])) {
      numBombs++;
    }
    if (isValid(r, c+1) == true && bombs.contains(buttons[r][c+1])) {
      numBombs++;
    }
    if (isValid(r-1, c) == true && bombs.contains(buttons[r-1][c])) {
      numBombs++;
    }
    if (isValid(r+1, c) == true && bombs.contains(buttons[r+1][c])) {
      numBombs++;
    }
    if (isValid(r-1, c+1) == true && bombs.contains(buttons[r-1][c+1])) {
      numBombs++;
    }
    if (isValid(r-1, c-1) == true && bombs.contains(buttons[r-1][c-1])) {
      numBombs++;
    }
    if (isValid(r+1, c+1) == true && bombs.contains(buttons[r+1][c+1])) {
      numBombs++;
    }
    if (isValid(r+1, c-1) == true && bombs.contains(buttons[r+1][c-1])) {
      numBombs++;
    }
    return numBombs;
  }
}
