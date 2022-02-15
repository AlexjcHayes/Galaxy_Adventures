class Lvl3_PyroSkull extends Lvl1_Enemies
{
  int wiggleTimer;
  Lvl3_PyroSkull(float x, float y)
  {   
    super(x, y);
    //curHealth=50;
    //  maxHealth=50;
    curHealth=150;
    maxHealth=150;
    xSpeed = 2;
    ySpeed = 2;
    wiggleTimer=(int)random(60, 150);
    image = PyroSkull ;
  }
  void act()
  {
    super.act();
    if (wiggleTimer>0)
    {
      wiggleTimer--;
    }
    if (wiggleTimer==0)
    {
      ySpeed=-ySpeed;
     wiggleTimer=60;
    }
    if (y>height)
    {
      x=random(100, width-100);
      y=random(-20, 0);
    }
    if(x>width-20||x<0)
    {
      xSpeed=-xSpeed;
    }
    if (eTimer==0)
    {
      objects.add(new FlameBreath(x+40, y+40));  //the lasers
      //objects.add(new RedShot(x+105, y+40));


      //if (objects.size()>2)
      //{
      //  for (int i=0; i<10; i++)
      //  {
      //    objects.remove(new RedShot(x+40, y+40));
      //  }
      //}
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
  //      noStroke();
  //      fill(255, 0, 0, 128);
  //      ellipse(x, y, 150, 150);
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
