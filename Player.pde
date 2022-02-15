/****************************************************\
 
 Player 
 (a subclass of GameObject)
 
 \****************************************************/


class Player extends GameObject
{
  int invulnerabilityTimer=0;
  int cShieldRegenTimer=80;
  float regenSpeed=.1;
  int shieldState=1;
  float playerCurHealth;
  //int Credits;
  Player(float x, float y)
  {   
    super(x, y, pSize, pSize);
    playerCurHealth=100;
    if (shieldRegen2Lock==false&&shieldRegenLock==false&&shieldLock==false)
    {
      regenSpeed=.3;
    } else
    {
      regenSpeed=.1;
    }
    if (shieldLock==false)
    {
      curShield=100;
    } else
    {
      curShield=0;
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
    if (numLives>0)
    {
      invulnerabilityTimer=playerInvulnerabilityDuration;
      invulnerable=true;
      x=width/2;
      y=height-100;
      playerCurHealth=100;
      if (shieldLock==false)
      {
        curShield=100;
      }
      numLives-=1;
    } else
    {
      if (multiplayer==false)
      {
        playerCurHealth=0;
        isAlive=false;
        playerGameState="gameOver";
      } else
      {
        playerCurHealth=0;
        isAlive=false;
        playerGameState="gameOver";
      }
    }
  }
  public void act()
  {
    println(playerCurHealth);
    super.act();

    if (shieldLock==false&&shieldState==1)
    {
      curShield=100;
      shieldState=2;
    }
    if (cShieldRegenTimer>0)
    {
      cShieldRegenTimer--;
    }
    if (shieldRegenLock==false&&cShieldRegenTimer==0&&curShield<maxHealth)
    {
      curShield+=regenSpeed;
    }
    if (gameMode=="SideScroller")
    {
      if (damageLock==false)
      {
        image=playerDSide;
        PLAYER_SHOT_DAMAGE=12;
      } else if (fireRateLock==false)
      {
        image= playerFRSide;
        time=10;
      } else if (homingLock==false)
      {
        image=playerHSide;
      } else
      {
        image= playerSide;
      }
    } else
    {
      if (damageLock==false)
      {
        image=playerD;
        PLAYER_SHOT_DAMAGE=12;
      } else if (fireRateLock==false)
      {
        image=playerFR;
        time=10;
      } else if (homingLock==false)
      {
        image=playerH;
      } else
      {
        image = Player0;
      }
    }
    xSpeed = 0;
    ySpeed = 0;
    //************************ GUI Interface Here************************\\
    noFill();
    noStroke();
    rect(healthBarX, healthBarY, healthBarWidth, healthBarHeight);
    fill(2, 188, 242);
    rect(healthBarX, healthBarY, playerCurHealth/maxHealth*healthBarWidth, healthBarHeight);//Health 
    fill(15, 240, 159);
    rect(healthBarX, healthBarY, curShield/maxHealth*healthBarWidth, healthBarHeight);//Shield
    image(healthBar, healthBarX-26, healthBarY-15, healthBarWidth+40, 45);
    imageMode(CENTER);
    if (multiplayer==false&&survivalMode==false)
    {
      image(WORLD, width-750, 25, 150, 100);
    } else if(survivalMode==false)
    {
      image(WORLD, width/2, 25, 150, 100);
    }
    textSize(50);
    fill(255);
    if (multiplayer==false&&survivalMode==false)
    {
      text(numWorld, width-650, 42);
    } else if(survivalMode==false)
    {
      text(numWorld, width/2+90, 42);
    }
    if (multiplayer==false)
    {
      image(Lives, width-300, 25, 150, 50);
    } else
    {
      image(Lives, healthBarX+285, healthBarY+50, 120, 50);
    }
    if (multiplayer==false)
    {
      image(LEVEL, width-550, 25, 150, 100);
    } else
    {
      image(LEVEL, width/2, 75, 150, 100);
    }
    image(Credits, healthBarX+50, healthBarY+50, 100, 60);
    textSize(55);
    text(numCredits, healthBarX+120, healthBarY+60);

    if (companionLock==false&&companionTimer!=0)
    {
      fill(211, 157, 19);
      text(companionTimer/60, healthBarX+550, 50);
    }
    if (multiplayer==false)
    {
      if (fireRateLock==false)
      {
        image(blueShot, 280, 65, 10, 10);
      }
      if (damageLock==false)
      {
        image(playerD, 320, 60, 55, 55);
      }
      if (QuadLock==false)
      {
        textSize(35);
        text("4x", 345, 75);
      }
      if (shieldLock==false)
      {
        image(oneUP, 400, 65, 40, 30);
      }
      if (shieldRegenLock==false)
      {
        tint(0, 100, 100);
        image(oneUP, 400, 65, 40, 30);
        tint(255);
      }
      if (shieldRegen2Lock==false)
      {
        tint(0, 100, 0);
        image(oneUP, 400, 65, 40, 30);
        tint(255);
      }
      if (homingLock==false)
      {
        image(playerMissle, 440, 65, 40, 40);
      }
      if (companionLock==false)
      {
        image(companion, 480, 65, 40, 40);
      }
    } else
    {
      if (fireRateLock==false)
      {
        image(blueShot, 280, 115, 10, 10);
      }
      if (damageLock==false)
      {
        image(playerD, 320, 110, 55, 55);
      }
      if (QuadLock==false)
      {
        textSize(35);
        text("4x", 345, 125);
      }
      if (shieldLock==false)
      {
        image(oneUP, 400, 115, 40, 30);
      }
      if (shieldRegenLock==false)
      {
        tint(0, 100, 100);
        image(oneUP, 400, 115, 40, 30);
        tint(255);
      }
      if (shieldRegen2Lock==false)
      {
        tint(0, 100, 0);
        image(oneUP, 400, 115, 40, 30);
        tint(255);
      }
      if (homingLock==false)
      {
        image(playerMissle, 440, 115, 40, 40);
      }
      if (companionLock==false)
      {
        image(companion, 480, 115, 40, 40);
      }
    }
    if (multiplayer==false)
    {
      if (numLives<=2)
      {
        fill(255, 0, 0);
        textSize(40);
        textFont(font);
        text(numLives, width-195, 35);
        fill(255);
      }
      if (numLives>2&&numLives<=4)
      {
        fill(227, 133, 39);
        textSize(40);
        textFont(font);
        text(numLives, width-195, 35);
        fill(225);
      } else if (numLives>4)
      {
        fill(28, 201, 104);
        textSize(40);
        textFont(font);
        text(numLives, width-195, 35);
        fill(255);
      }
    } else
    {
      if (numLives<=2)
      {
        fill(255, 0, 0);
        textSize(40);
        textFont(font);
        text(numLives, healthBarX+350, healthBarY+60);
        fill(255);
      }
      if (numLives>2&&numLives<=4)
      {
        fill(227, 133, 39);
        textSize(40);
        textFont(font);
        text(numLives, healthBarX+350, healthBarY+60);
        fill(225);
      } else if (numLives>4)
      {
        fill(28, 201, 104);
        textSize(40);
        textFont(font);
        text(numLives, healthBarX+350, healthBarY+60);
        fill(255);
      }
    }
    textSize(50);
    if (multiplayer==false)
    {
      text(Level, width-450, 43);
    } else
    {
      text(Level, width/2+90, 95);
    }
    imageMode(CORNER);
    if (numLives%2==0)
    {
    }
    if (invulnerabilityTimer>0)
    {
      invulnerabilityTimer--;
      imageMode(CENTER);
      image(forceField, x+37, y+45, 150, 150);
      if (multiplayer==true)
      {
        textSize(80);
        text(invulnerabilityTimer/60, x+17, y+65);
      } else if (!(invulnerabilityTimer/60==0))
      {
        if (numLives==0)
        {
          image(LASTLIFE, width/2, height/2-100);
        }
        image(GetReady, width/2, height/2);
        textFont(font);
        textSize(120);
        text(invulnerabilityTimer/60, width/2-30, height/2+150);
      }
      if (multiplayer==false)
      {
        if (invulnerabilityTimer/60==0)
        {
          image(GO, width/2, height/2, 300, 200);
        }
      }
      imageMode(CORNER);
    } else
    {
      invulnerable=false;
    }
    if (getKey('a')||getKey('A'))
    {     
      if (!(x<0))
      {
        xSpeed -= PLAYER_SPEED;
      }
    }   
    if (getKey('d')||getKey('D'))
    {
      if (!(x>width-65))
      {
        xSpeed += PLAYER_SPEED;
      }
    }
    if (getKey('w')||getKey('W'))
    {
      if (!(y<-20))
      {
        ySpeed -= PLAYER_SPEED;
      }
    }
    if (getKey('s')||getKey('S'))
    {
      if (!(y>height-60))

      {
        ySpeed += PLAYER_SPEED;
      }
    }
    if (multiplayer==true)
    {
      if (getKey('c')&&fireRate==0&&invulnerable==false)
      {
        playSound("Laser.wav");
        if (gameMode=="SideScroller")
        {
          if (QuadLock==false)
          {
            objects.add(new PlayerShotBasic(x+17, y+40));  //the lasers
            objects.add(new PlayerShotBasic(x+17, y+18));
            objects.add(new PlayerShotBasic(x+23, y+55));  
            objects.add(new PlayerShotBasic(x+23, y+3));
          } else
          {
            objects.add(new PlayerShotBasic(x+17, y+40));  //the lasers
            objects.add(new PlayerShotBasic(x+17, y+18));
          }
          fireRate=time;
        } else
        {
          if (QuadLock==false)
          {
            objects.add(new PlayerShotBasic(x+17, y+40));  //the lasers
            objects.add(new PlayerShotBasic(x+2, y+50));
            objects.add(new PlayerShotBasic(x+45, y+40));
            objects.add(new PlayerShotBasic(x+60, y+50));
          } else
          {
            objects.add(new PlayerShotBasic(x+17, y+40));
            objects.add(new PlayerShotBasic(x+45, y+40));
          }
          fireRate=time;
        }
      }
      if ((getKey('v')||getKey('V'))&& missleRate==0&& homingLock==false)
      {
        objects.add(new playerMissle(x+17, y+40, nearestEnemy((int)x, (int) y)));  //the lasers
        objects.add(new playerMissle(x+45, y+40, nearestEnemy((int)x, (int) y)));
        if (gameMode=="SideScroller")
        {
          objects.add(new playerMissle(x+17, y+40, nearestEnemy((int)x, (int) y)));  //the lasers
          objects.add(new playerMissle(x+45, y+40, nearestEnemy((int)x, (int) y)));
          fireRate=time;
        } 
        missleRate=time2;
      }
    } else
    {
      if (getKey(' ')&&fireRate==0&&invulnerable==false)
      {
        playSound("Laser.wav");
        if (gameMode=="SideScroller")
        {
          if (QuadLock==false)
          {
            objects.add(new PlayerShotBasic(x+17, y+40));  //the lasers
            objects.add(new PlayerShotBasic(x+17, y+18));
            objects.add(new PlayerShotBasic(x+23, y+55));  
            objects.add(new PlayerShotBasic(x+23, y+3));
          } else
          {
            objects.add(new PlayerShotBasic(x+17, y+40));  //the lasers
            objects.add(new PlayerShotBasic(x+17, y+18));
          }
          fireRate=time;
        } else
        {
          if (QuadLock==false)
          {
            objects.add(new PlayerShotBasic(x+17, y+40));  //the lasers
            objects.add(new PlayerShotBasic(x+2, y+50));
            objects.add(new PlayerShotBasic(x+45, y+40));
            objects.add(new PlayerShotBasic(x+60, y+50));
          } else
          {
            objects.add(new PlayerShotBasic(x+17, y+40));
            objects.add(new PlayerShotBasic(x+45, y+40));
          }
          fireRate=time;
        }
      }
      if ((getKey('m')||getKey('M'))&& missleRate==0&& homingLock==false&&invulnerable==false)
      {
        objects.add(new playerMissle(x+17, y+40, nearestEnemy((int)x, (int) y)));  //the lasers
        objects.add(new playerMissle(x+45, y+40, nearestEnemy((int)x, (int) y)));
        if (gameMode=="SideScroller")
        {
          objects.add(new playerMissle(x+17, y+40, nearestEnemy((int)x, (int) y)));  //the lasers
          objects.add(new playerMissle(x+45, y+40, nearestEnemy((int)x, (int) y)));
          fireRate=time;
        } 
        missleRate=time2;
      }
    }
    if (multiplayer==false)
    {
      if (companionLock==false)
      {
        if (companionTimer!=0)//so it stays on the screen for x amount of time
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
        if (companionTimer==0)
        {
          if (multiplayer==false)
          {
            if ((getKey('j')||getKey('J'))&&numCredits>=100)
            {
              companionTimer=960;
              numCredits-=100;
              //x=random(width);
              //y=height-50;
              if (gameMode=="SideScroller")
              {  
                CompPower.add(new CompanionPower(60, random(10, height-10)));
              } else 
              {
                CompPower.add(new CompanionPower(random(10, width-10), height-60));
              }
            }
          } else
          {
            if ((getKey('g')||getKey('G'))&&numCredits>=100)
            {
              companionTimer=960;
              numCredits-=100;
              //x=random(width);
              //y=height-50;
              if (gameMode=="SideScroller")
              {  
                CompPower.add(new CompanionPower(60, random(10, height-10)));
              } else 
              {
                CompPower.add(new CompanionPower(random(10, width-10), height-60));
              }
            }
          }
        }
      }
    }
    if (missleRate>0)
    {
      missleRate--;
    }
    if (fireRate>0)
    {
      fireRate--;
    }

    //println(isAlive);
  }
  public void reactions()
  {
    for (int x = 0; x < collisions.size (); x++)
    {
      GameObject o = collisions.get(x);
      if (o instanceof EnemyProjectile&&invulnerable==false)
      {
        if (shieldLock==false)
        {
          cShieldRegenTimer=180;
          if (curShield>0)
          {
            tint(255, 0, 0);
            image(image, this.x, y, w, h);
            tint(255);
            curShield-=5;
          }
          if (curShield<=0)
          {
            curShield=0;
          }
          if (playerCurHealth>0&&curShield<=0)
          {
            tint(255, 0, 0);
            image(image, this.x, y, w, h);
            tint(255);
            playerCurHealth-=5;
          }
          if (playerCurHealth<=0&&curShield<=0)
          {
            takeDamage(o.getDamage());
          }
        } else
        {
          if (playerCurHealth>0)
          {
            tint(255, 0, 0);
            image(image, this.x, y, w, h);
            tint(255);
            playerCurHealth-=5;
          }
          if (playerCurHealth<=0)
          {
            takeDamage(o.getDamage());
          }
        }
      }
      if (o instanceof Enemy&&invulnerable==false)
      {

        if (shieldLock==false)
        {
          cShieldRegenTimer=180;
          if (curShield>0)
          {
            tint(255, 0, 0);
            image(image, this.x, y, w, h);
            tint(255);
            curShield-=10;
          }
          if (curShield<=0)
          {
            curShield=0;
          }
          if (playerCurHealth>0&&curShield<=0)
          {
            tint(255, 0, 0);
            image(image, this.x, y, w, h);
            tint(255);
            playerCurHealth-=10;
          }
          if (playerCurHealth<=0&&curShield<=0)
          {
            takeDamage(o.getDamage());
          }
        } else
        {
          if (playerCurHealth>0)
          {
            tint(255, 0, 0);
            image(image, this.x, y, w, h);
            tint(255);
            playerCurHealth-=10;
          }
          if (playerCurHealth<=0)
          {
            takeDamage(o.getDamage());
          }
        }
      }
    }
  }
}
