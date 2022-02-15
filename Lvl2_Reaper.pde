class Lvl2_Reaper extends Lvl1_Enemies
{
  Lvl2_Reaper(float x, float y)
  {   
    super(x, y);
    if (numWorld==2)
    {
      curHealth=100;
      maxHealth=100;
    } else if (numWorld==3)
    {
      curHealth=150;
      maxHealth=150;
    }
    xSpeed = EVIL_SQUARE_X_SPEED;
    ySpeed = 5;
    image = Reaper;
  }
  void act()
  {
    super.act();
    if (y>height)
    {
      x=random(100, width-100);
      y=random(-20, 0);
    }
    if (eTimer==0)
    {
      objects.add(new blackLaser(x+40, y+40));  //the lasers
      objects.add(new blackLaser(x+105, y+40));


      if (objects.size()>2)
      {
        for (int i=0; i<10; i++)
        {
          objects.remove(new RedShot(x+40, y+40));
        }
      }
      eTimer=50;
    }
  }

  //public void reactions()
  //{
  //  for (int x = 0; x < collisions.size (); x++)
  //  {
  //    GameObject o = collisions.get(x);

  //    if (o instanceof PlayerProjectile)//|| o instanceof Player)
  //    {
  //      if (curHealth>0)
  //      {
  //        curHealth-=5;
  //      }
  //      if (curHealth==0)
  //      {
  //        takeDamage(o.getDamage());
  //      }
  //    }
  //  }
  //}
}
