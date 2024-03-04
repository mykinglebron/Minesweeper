import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS= 10; //final makes it so we cant change 
//it will give error if we try
private final static int NUM_COLS=10;
private final static int NUM_MINES=9;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

int tilesClicked=0;
void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for ( int r=0; r<NUM_ROWS; r++) {
    for (int c=0; c<NUM_COLS; c++) {

      buttons[r][c] = new MSButton(r, c); 
    }
  }
  mines = new ArrayList <MSButton>();



  setMines();
}
public void setMines()
{
  //your code
  while (mines.size()<NUM_MINES) {
    int r = (int) (Math.random()*NUM_ROWS );
    int c = (int) (Math.random()*NUM_COLS );
    if ((mines.contains(buttons[r][c]))==false) {
      mines.add(buttons[r][c]);
     
    }
  }
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}

public boolean isWon()
{

  for (int r = 0; r < NUM_ROWS; r++)
  {
    for (int c = 0; c < NUM_COLS; c++)
    {
      if (!buttons[r][c].isClicked() == true && !mines.contains(buttons[r][c]))
      {
        return false;
      }
    }
  }
  return true;
}
public void displayLosingMessage()
{

  for (int i=0; i<mines.size(); i++)
    if (mines.get(i).isClicked()==false)
      mines.get(i).mousePressed();
  buttons[(NUM_ROWS/2)-1][NUM_COLS/2].setLabel("you");
  buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("Lose");
}
public void displayWinningMessage()
{
  buttons[(NUM_ROWS/2)-1][NUM_COLS/2].setLabel("you");
  buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("Win");
}
public boolean isValid(int r, int c)
{
  //your code here
  return r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  //your code here
  if (isValid(row-1, col) == true && mines.contains(buttons[row-1][col]))
  {
    numMines++;
  }
  if (isValid(row+1, col) == true && mines.contains(buttons[row+1][col]))
  {
    numMines++;
  }
  if (isValid(row, col-1) == true && mines.contains(buttons[row][col-1]))
  {
    numMines++;
  }
  if (isValid(row, col+1) == true && mines.contains(buttons[row][col+1]))
  {
    numMines++;
  }
  if (isValid(row-1, col+1) == true && mines.contains(buttons[row-1][col+1]))
  {
    numMines++;
  }
  if (isValid(row-1, col-1) == true && mines.contains(buttons[row-1][col-1]))
  {
    numMines++;
  }
  if (isValid(row+1, col+1) == true && mines.contains(buttons[row+1][col+1]))
  {
    numMines++;
  }
  if (isValid(row+1, col-1) == true && mines.contains(buttons[row+1][col-1]))
  {
    numMines++;
  }
  return numMines;
}
public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = row;
    c = col; 
    x = r*width;
    y = c*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    clicked = true;
    //your code here

    if (mouseButton== RIGHT) {
      flagged=!flagged;
      if (flagged==false) {
        clicked=false;
      }
    } else if (mines.contains(this)) {
      displayLosingMessage();
    } else if (countMines(r, c)>0) {
      myLabel=""+countMines(r, c);
    } else {
      if (isValid(r-1, c-1) && !buttons[r-1][c-1].isClicked()) {
        buttons[r-1][c-1].mousePressed();
      } 
      if (isValid(r-1, c) && !buttons[r-1][c].isClicked()) {
        buttons[r-1][c].mousePressed();
      }
      if (isValid(r-1, c+1) && !buttons[r-1][c+1].isClicked()) {
        buttons[r-1][c+1].mousePressed();
      }

      if (isValid(r, c-1) && !buttons[r][c-1].isClicked()) {
        buttons[r][c-1].mousePressed();
      }
      if (isValid(r, c+1) && !buttons[r][c+1].isClicked()) {
        buttons[r][c+1].mousePressed();
      }

      if (isValid(r+1, c-1) && !buttons[r+1][c-1].isClicked()) {
        buttons[r+1][c-1].mousePressed();
      }
      if (isValid(r+1, c) && !buttons[r+1][c].isClicked()) {
        buttons[r+1][c].mousePressed();
      }
      if (isValid(r+1, c+1) && !buttons[r+1][c+1].isClicked()) {
        buttons[r+1][c+1].mousePressed();
      }
    }
  }
  public void draw () 
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }

  public boolean isClicked()
  {
    return clicked;
  }
}
