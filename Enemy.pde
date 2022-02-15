/****************************************************\
 
 Enemy
 (a subclass of GameObject)
 
 \****************************************************/

abstract class Enemy extends GameObject
{
  Enemy(float x, float y, float w, float h)
  {
    super(x, y, w, h);
    curHealth = 20;
    maxHealth = 50;
  }

  public void act()
  {
    super.act();
  }

  public void reactions()
  {
    for (int x = 0; x < collisions.size(); x++)
    {
      GameObject o = collisions.get(x);
      // is [variablename] an instance of the class [classname]
      if (o instanceof PlayerShotBasic)
      {
        if (curHealth>0)
        {
          curHealth-=PLAYER_SHOT_DAMAGE;
        }
        if (curHealth==0||curHealth<0)
        {
          numCredits+=5;
          takeDamage(o.getDamage());
          numCredits+=5;
        }
      }
      if (o instanceof playerMissle)
      {
        if (curHealth>0)
        {
          //numLives+=1;
          curHealth-=playerMissleDamage;
        }
        if (curHealth==0||curHealth<0)
        {
          //numLives+=100; // this works!!!!!!!!! now make it so that the rest of the enemies work off of this template
          // int size=50;
          //float boomSize = size * boomScale;
          //for (int i=0; i<5; i++)
          //{
          //  booms.add(new Boom(x+random(-10, 10), y+random(-10, 10), boomSize, boomDuration));
          //}
          takeDamage(o.getDamage());
          //numLives+=1;
          addCredits(10);
        }
      }
    }
  }
}
