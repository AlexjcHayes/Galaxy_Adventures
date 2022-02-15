class Companion extends GameObject
{
  float companionCurHealth;
  int cInvulnerabilityTimer=0;
  int cShieldRegenTimer=80;
  float regenSpeed=.1;
  int shieldState=1;
  //int Credits;
  Companion(float x, float y)
  {   
    super(x, y, pSize, pSize);
    companionCurHealth=100;
    if (cInvulnerabilityTimer>0)
    {
      cInvulnerabilityTimer--;
    }
    if (cInvulnerabilityTimer==0)
    {
      cInvulnerabilityTimer=0;
    }
    if (shieldRegen2Lock2==false&&shieldRegenLock2==false&&shieldLock2==false)
    {
      regenSpeed=.3;
    } else
    {
      regenSpeed=.1;
    }
    if (shieldLock2==false)
    {
      curShield2=100;
    } else
    {
      curShield2=0;
    }
    maxHealth=100;
    //numLives=3;//number of starting lives
    //if (numWorld==2&&Level==4)
    //{

    //  image= playerSide;

    //} else
    //{
    //  image = Player0;
    //}
  }
  void die()
  {
    if (cNumLives>0)
    {
      cInvulnerabilityTimer=playerInvulnerabilityDuration;
      cInvulnerable=true;
      x=width/2;
      y=height-100;
      companionCurHealth=100;
      if (shieldLock2==false)
      {
        curShield2=100;
      }
      cNumLives-=1;
    } else
    {
      companionCurHealth=0;
      isAlive=false;
      companionGameState="gameOver";
    }
  }
  public void act()
  {
    //print(cShieldRegenTimer);
    super.act();
    if (playerGameState=="gameOver")
    {
      imageMode(CENTER);
      textSize(50);
      fill(255);
      text(Level, width/2+90, 95);
      if (survivalMode==false)
      {
        image(WORLD, width/2, 25, 150, 100);
        text(numWorld, width/2+90, 42);
      }
      image(LEVEL, width/2, 75, 150, 100);
      imageMode(CORNER);
    }
    if (shieldLock2==false&&shieldState==1)
    {
      curShield2=100;
      shieldState=2;
    }
    if (cShieldRegenTimer>0)
    {
      cShieldRegenTimer--;
    }
    if (shieldRegenLock2==false&&cShieldRegenTimer==0&&curShield2<maxHealth)
    {
      curShield2+=regenSpeed;
    }
    if (gameMode=="SideScroller")
    {
      if (damageLock2==false)
      {
        image=companionDS;
        PLAYER_SHOT_DAMAGE=8;
      } else if (fireRateLock2==false)
      {
        image= companionS;
        cTime=20;
      } else if (homingLock2==false)
      {
        image=companionS;
      } else
      {
        image= companionS;
      }
    } else
    {
      if (damageLock2==false)
      {
        image=companionD;
        PLAYER_SHOT_DAMAGE=8;
      } else if (fireRateLock2==false)
      {
        image=companion;
        cTime=20;
      } else if (homingLock2==false)
      {
        image=companion;
      } else
      {
        image = companion;
      }
    }
    xSpeed = 0;
    ySpeed = 0;
    //************************ GUI Interface Here************************\\
    noFill();
    noStroke();
    rect(cHealthBarX, cHealthBarY, healthBarWidth, healthBarHeight);
    fill(232, 226, 28);
    rect(cHealthBarX, cHealthBarY, companionCurHealth/maxHealth*healthBarWidth, healthBarHeight);//Health 
    fill(15, 168, 28);
    rect(cHealthBarX, cHealthBarY, curShield2/maxHealth*healthBarWidth, healthBarHeight);//Shield
    image(healthBar, cHealthBarX-26, cHealthBarY-15, healthBarWidth+40, 45);
    imageMode(CENTER);
    //image(WORLD, width-800, 25, 150, 100);
    textSize(50);
    fill(255);
    //text(numWorld, width-700, 42);
    image(Lives, cHealthBarX+285, cHealthBarY+50, 120, 50);
    //image(Lives, blah, 25, 150, 50);
    //image(LEVEL, width-550, 25, 150, 100);
    image(Credits, cHealthBarX+50, cHealthBarY+50, 100, 60);
    textSize(55);
    text(cNumCredits, cHealthBarX+120, cHealthBarY+60);
    if (companionLock2==false&&companionTimer2!=0)
    {
      fill(211, 157, 19);
      //text(companionTimer/60, cHealthBarX+550, 50);
    }
    if (fireRateLock2==false)
    {
      image(blueShot, cHealthBarX+250, 115, 10, 10);
    }
    if (damageLock2==false)
    {
      image(playerD, cHealthBarX+290, 110, 55, 55);
    }
    if (QuadLock2==false)
    {
      textSize(35);
      text("4x", cHealthBarX+315, 125);
    }
    if (shieldLock2==false)
    {
      image(oneUP, cHealthBarX+370, 115, 40, 30);
    }
    if (shieldRegenLock2==false)
    {
      tint(0, 100, 100);
      image(oneUP, cHealthBarX+370, 115, 40, 30);
      tint(255);
    }
    if (shieldRegen2Lock2==false)
    {
      tint(0, 100, 0);
      image(oneUP, cHealthBarX+370, 115, 40, 30);
      tint(255);
    }
    if (homingLock2==false)
    {
      image(playerMissle, cHealthBarX+410, 115, 40, 40);
    }
    if (companionLock2==false)
    {
      image(companion, cHealthBarX+450, 115, 40, 40);
    }
    if (companionLock2==false&&companionTimer2!=0)
    {
      fill(211, 157, 19);
      text(companionTimer2/60, cHealthBarX+550, 50);
    }
    if (cNumLives<=2)
    {
      fill(255, 0, 0);
      textSize(40);
      textFont(font);
      text(cNumLives, cHealthBarX+350, cHealthBarY+60);
      fill(255);
    }
    if (cNumLives>2&&cNumLives<=4)
    {
      fill(227, 133, 39);
      textSize(40);
      textFont(font);
      text(cNumLives, cHealthBarX+350, cHealthBarY+60);
      fill(225);
    } else if (cNumLives>4)
    {
      fill(28, 201, 104);
      textSize(40);
      textFont(font);
      text(cNumLives, cHealthBarX+350, cHealthBarY+60);
      fill(255);
    }
    textSize(50);
    //text(Level, width-450, 43);
    imageMode(CORNER);
    if (cNumLives%2==0)
    {
    }
    if (cInvulnerabilityTimer>0)
    {
      cInvulnerabilityTimer--;
      imageMode(CENTER);
      image(forceField, x+37, y+45, 150, 150);
      if (multiplayer==true)
      {
        textSize(80);
        text(cInvulnerabilityTimer/60, x+17, y+65);
      } else if (!(cInvulnerabilityTimer/60==0))
      {
        if (cNumLives==0)
        {
          image(LASTLIFE, width/2, height/2-100);
        }
        image(GetReady, width/2, height/2);
        textFont(font);
        textSize(120);
        text(cInvulnerabilityTimer/60, width/2-30, height/2+150);
      }
      if (multiplayer==false)
      {
        if (cInvulnerabilityTimer/60==0)
        {
          image(GO, width/2, height/2, 300, 200);
        }
      }
      imageMode(CORNER);
    } else
    {
      cInvulnerable=false;
    }
    if (getKey('j'))
    {     
      if (!(x<0))
      {
        xSpeed -= PLAYER_SPEED;
      }
    }   
    if (getKey('l'))
    {
      if (!(x>width-65))
      {
        xSpeed += PLAYER_SPEED;
      }
    }
    if (getKey('i'))
    {
      if (!(y<-20))
      {
        ySpeed -= PLAYER_SPEED;
      }
    }
    if (getKey('k'))
    {
      if (!(y>height-60))
      {
        ySpeed += PLAYER_SPEED;
      }
    }
    if (getKey('.')&&fireRate2==0&&cInvulnerable==false)
    {
      playSound("Laser.wav");
      if (gameMode=="SideScroller")
      {
        if (QuadLock2==false)
        {
          objects.add(new CompanionShotBasic(x+17, y+40));  //the lasers
          objects.add(new CompanionShotBasic(x+17, y+18));
          objects.add(new CompanionShotBasic(x+23, y+55));  
          objects.add(new CompanionShotBasic(x+23, y+3));
        } else
        {
          objects.add(new CompanionShotBasic(x+17, y+40));  //the lasers
          objects.add(new CompanionShotBasic(x+17, y+18));
        }
        fireRate2=cTime;
      } else
      {
        if (QuadLock2==false)
        {
          objects.add(new CompanionShotBasic(x+17, y+40));  //the lasers
          objects.add(new CompanionShotBasic(x+2, y+50));
          objects.add(new CompanionShotBasic(x+45, y+40));
          objects.add(new CompanionShotBasic(x+60, y+50));
        } else
        {
          objects.add(new CompanionShotBasic(x+27, y+35));
          objects.add(new CompanionShotBasic(x+60, y+35));
        }
        fireRate2=cTime;
      }
    }
    if ((getKey('/')&& cMissleRate==0&& homingLock2==false))
    {
      objects.add(new companionMissle(x+17, y+40, nearestEnemy((int)x, (int) y)));  //the lasers
      objects.add(new companionMissle(x+45, y+40, nearestEnemy((int)x, (int) y)));
      if (gameMode=="SideScroller")
      {
        objects.add(new companionMissle(x+17, y+40, nearestEnemy((int)x, (int) y)));  //the lasers
        objects.add(new companionMissle(x+45, y+40, nearestEnemy((int)x, (int) y)));
        fireRate2=time2;
      } 
      cMissleRate=cTime2;
    }
    if (multiplayer==false)
    {
      if (companionLock2==false)
      {
        if (companionTimer2!=0)//so it stays on the screen for x amount of time
        {
          if (CompPower.size()>0)
          {
            for (CompanionPower cP : CompPower)
            {
              cP.render();
              cP.act();
            }
          }        
          companionDisplay=true;
        } else if (CompPower.size()>0)
        {
          for (int i=0; i<CompPower.size(); i++)
          {
            CompPower.remove(0);
          }
        }
        if (companionTimer2==0)
        {
          if ((getKey(',')&&cNumCredits>=100))
          {
            companionTimer2=960;
            cNumCredits-=100;
            //x=random(width);
            //y=height-50;
            if (gameMode=="SideScroller")
            {  
              CompPower.add(new CompanionPower(60, random(50, height-50)));
            } else 
            {
              CompPower.add(new CompanionPower(random(50, width-50), height-60));
            }
          }
        }
      }
    }
    if (missleRate>0)
    {
      missleRate--;
    }
    if (fireRate2>0)
    {
      fireRate2--;
    }
    //println(isAlive);
  }
  public void reactions()
  {
    for (int x = 0; x < collisions.size (); x++)
    {
      GameObject o = collisions.get(x);
      if (o instanceof EnemyProjectile&&cInvulnerable==false)
      {
        if (shieldLock2==false)
        {
          cShieldRegenTimer=180;
          if (curShield2>0)
          {
            tint(255, 0, 0);
            image(image, this.x, y, w, h);
            tint(255);
            curShield2-=5;
          }
          if (curShield2<=0)
          {
            curShield2=0;
          }
          if (companionCurHealth>0&&curShield2<=0)
          {
            tint(255, 0, 0);
            image(image, this.x, y, w, h);
            tint(255);
            companionCurHealth-=5;
          }
          if (companionCurHealth<=0&&curShield2<=0)
          {
            takeDamage(o.getDamage());
          }
        } else
        {
          if (companionCurHealth>0)
          {
            tint(255, 0, 0);
            image(image, this.x, y, w, h);
            tint(255);
            companionCurHealth-=5;
          }
          if (companionCurHealth<=0)
          {
            takeDamage(o.getDamage());
          }
        }
      }
      if (o instanceof Enemy&&cInvulnerable==false)
      {

        if (shieldLock2==false)
        {
          cShieldRegenTimer=180;
          if (curShield2>0)
          {
            tint(255, 0, 0);
            image(image, this.x, y, w, h);
            tint(255);
            curShield2-=5;
          }
          if (curShield2<=0)
          {
            curShield2=0;
          }
          if (companionCurHealth>0&&curShield2<=0)
          {
            tint(255, 0, 0);
            image(image, this.x, y, w, h);
            tint(255);
            companionCurHealth-=5;
          }
          if (companionCurHealth<=0&&curShield2<=0)
          {
            takeDamage(o.getDamage());
          }
        } else
        {
          if (companionCurHealth>0)
          {
            tint(255, 0, 0);
            image(image, this.x, y, w, h);
            tint(255);
            companionCurHealth-=5;
          }
          if (companionCurHealth<=0)
          {
            takeDamage(o.getDamage());
          }
        }
      }
    }
  }
}
