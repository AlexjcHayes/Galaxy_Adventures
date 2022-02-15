class lvl2boss extends Lvl1_Enemies
{
  lvl2boss(float x, float y)
  {   
    super(x, y);
    curHealth=3000;
    maxHealth=3000;
    xSpeed = 0;
    ySpeed = 5;
    eTimer=10;
    eTimer2=4;
    image = Lvl2_boss ;
  }
  void act()
  {
    super.act();
    if (eTimer>0)
    {
      eTimer--;
    }
    if (eTimer2>0)
    {
      eTimer2--;
    }
    if (y<0)
    {
      ySpeed=-ySpeed;
    }
    if (y>height-150)
    {
      ySpeed=-ySpeed;
    }
    if (eTimer2==0)
    {
      //objects.add(new RedShot(x+105, y+65));
      //objects.add(new RedShot(x+105, y+40));
      for(int i=0;i<5;i++)
      {
      objects.add(new RedShot2(x+105, y+65));
      objects.add(new RedShot2(x+105, y+40));
      }
      if(curHealth<maxHealth/2)
      {
        eTimer2=4;
      }else
      {
      eTimer2=40;
      }
    }
    if (eTimer==0)
    {
      objects.add(new plasmaShot2(x+40, y+40));
      if(curHealth<maxHealth/2)
      {
       eTimer=10;
      }else
      {
      eTimer=100;
      }
    }
    ///////////////////////
    //println(curHealth);
    //println(PLAYER_SHOT_DAMAGE);
  }
}
