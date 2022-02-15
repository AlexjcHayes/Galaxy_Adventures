class Lvl1_Leacher extends Lvl1_Enemies
{
  Lvl1_Leacher(float x, float y)
  {   
    super(x, y);
    //curHealth=60;
    //  maxHealth=60;
   if (numWorld==1)
    {
      curHealth=60;
      maxHealth=60;
    } else if (numWorld==2)
    {
      curHealth=80;
      maxHealth=80;
    } else if (numWorld==3)
    {
      curHealth=120;
      maxHealth=120;
    }
    xSpeed = 3;
    ySpeed = 0;
    image = Leacher ;
  }
  void act()
  {
    super.act();
    if (x>width)
    {
      x=random(-10, -5);
      y=random(height-450);
    }
    if (eTimer==0)
    {
      objects.add(new orangeShot(x+130, y+55));  

      if (objects.size()>2)
      {
        for (int i=0; i<10; i++)
        {
          objects.remove(new orangeShot(x+130, y+55));
        }
      }
      eTimer=50;
    }
  }
}
