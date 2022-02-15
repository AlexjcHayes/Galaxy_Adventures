/****************************************************\
 
 Game Object
 (the super class of player, enemy, and projectiles)
 
 \****************************************************/

abstract class GameObject
{
  ArrayList<GameObject> collisions;

  protected int timer;
  PImage image;
  protected boolean isAlive;
  protected float curHealth;
  protected float curShield;
  protected float curShield2;
  protected float maxHealth;
  protected float damage;
  protected float ultaBossX;
  protected float ultaBossY;
  protected float x;
  protected float y;
  protected float w;
  protected float h;
  protected float xSpeed;
  protected float ySpeed;
  protected int playerInvulnerabilityDuration=200;
  protected int amount;
  boolean invulnerable=false;
  boolean cInvulnerable=false;//companion invulnerability
  public float getX() 
  {
    return x;
  }
  public float getY() 
  { 
    return y;
  }
  public float getWidth() 
  { 
    return w;
  }
  public float getHeight() 
  { 
    return h;
  }

  public float getDamage()
  {
    return damage;
  }

  public float getCurHealth()
  {
    return curHealth;
  }

  // This method does not work the way it's supposed to!
  // Player should LOSE HEALTH equal to "amount"
  // Player only dies if it has too little health!
  // Make sure health never drops below zero
  public void takeDamage(float amount)
  {
    die();
  }

  GameObject(float x, float y, float w, float h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    isAlive = true;
    collisions = new ArrayList<GameObject>();
    image = defaultImage;
    curHealth = 1;
    maxHealth = 1;
    timer = 0;
    damage = 0;
  }

  boolean containsPoint(float xPos, float yPos)
  {   
    return xPos >= x && xPos <= x+w && yPos >= y && yPos <= y+h;
  }   

  boolean isCollision(GameObject o)
  {
    if (this == o) return false;

    if (containsPoint(o.x, o.y))
    {
      return true;
    }
    if (containsPoint(o.x+o.w, o.y))   
    {
      return true;
    }
    if (containsPoint(o.x, o.y+o.h)) 
    {
      return true;
    }
    if (containsPoint(o.x+o.w, o.y+o.h)) 
    {
      return true;
    }

    return false;
  }

  boolean mouseOver()
  {
    return containsPoint(mouseX, mouseY);
  }

  void render()
  {
    image(image, x, y, w, h);
  }

  public abstract void reactions();

  void act()
  {

    if (!collisions.isEmpty())
    {
      reactions();
      collisions.clear();
    }
    timer++;
    x = x + xSpeed;
    y = y + ySpeed;
  }

  void addCollision(GameObject o)
  {
    if (!o.isAlive)
    {
      return;
    }
    for (GameObject c : collisions)
    {
      if (o == c)
      {
        return;
      }
    }
    collisions.add(o);
  }
  void die()
  {
    curHealth = 0;
    isAlive = false;
  }

  void cleanUp()
  {
    if (!isAlive)
    {
      objects.remove(this);
    }
  }
  Enemy nearestEnemy( int x2, int y2)
  {
    double dis1;
    double dis2=Integer.MAX_VALUE;
    Enemy closest=null;
    for (GameObject o : objects)
    {

      if (o instanceof Enemy)
      {
        dis1=getDistanceBetween(o.x, o.y, x2, y2);


        if (dis1<dis2)
        {
          dis2=dis1;
          try {
            closest=(Enemy) o;
          }
          catch(Exception e)
          {
            e.printStackTrace();
          }
        }
      }
    }

    return closest;
  }
  Player nearestPlayer( int x2, int y2)
  {
    double dis1;
    double dis2=Integer.MAX_VALUE;
    Player closest=null;
    for (GameObject o : objects)
    {

      if (o instanceof Player)
      {
        dis1=getDistanceBetween(o.x, o.y, x2, y2);


        if (dis1<dis2)
        {
          dis2=dis1;
          try {
            closest=(Player) o;
          }
          catch(Exception e)
          {
            e.printStackTrace();
          }
        }
      }
    }

    return closest;
  }
  Companion nearestCompanion( int x2, int y2)
  {
    double dis1;
    double dis2=Integer.MAX_VALUE;
    Companion closest=null;
    for (GameObject o : objects)
    {

      if (o instanceof Companion)
      {
        dis1=getDistanceBetween(o.x, o.y, x2, y2);


        if (dis1<dis2)
        {
          dis2=dis1;
          try {
            closest=(Companion) o;
          }
          catch(Exception e)
          {
            e.printStackTrace();
          }
        }
      }
    }

    return closest;
  }
  ///////////////////////////////////////////
  public double getDistanceBetween(float startX, float startY, float endX, float endY) {
    return Math.sqrt((Math.pow((endX - startX), 2)) + (Math.pow((endY - startY), 2)));
  }
  ////////////////////
}
