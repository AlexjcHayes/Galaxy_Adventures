/****************************************************\
 
 Abstract Projectile Classes
 (Subclasses of GameObject)
 
 \****************************************************/

abstract class Projectile extends GameObject
{
  boolean expired=false;
  Projectile(float x, float y, float w, float h, float xSpeed, float ySpeed)
  {
    super(x, y, w, h);
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
  }
  void act()
  {
    super.act(); 
    if (y>height+20)
    {
      die();
    }
    if (y<-20)
    {
      die();
    }
    if (x>width+20)
    {
      die();
    }
    if (x<-20)
    {
      die();
    }
  }
}

abstract class PlayerProjectile extends Projectile
{
  PlayerProjectile(float x, float y, float w, float h, float xSpeed, float ySpeed)
  {
    super(x, y, w, h, xSpeed, ySpeed);
  }

  void reactions()
  {
    for (int x = 0; x < collisions.size (); x++)
    {
      GameObject o = collisions.get(x);

      // When this projectile hits an enemy, set it to be removed
      if (o instanceof Enemy)
      {
        die();
      }
    }
  }
}

abstract class EnemyProjectile extends Projectile
{
  EnemyProjectile(float x, float y, float w, float h, float xSpeed, float ySpeed)
  {
    super(x, y, w, h, xSpeed, ySpeed);
  }

  void reactions()
  {
    for (int x = 0; x < collisions.size (); x++)
    {
      GameObject o = collisions.get(x);

      // When this projectile hits a player, set it to be removed
      if (o instanceof Player||o instanceof Companion)
      {
        die();
      }
    }
  }
}

/****************************************************\
 
 Concrete Projectile Classes
 
 - You'll design new projectiles here.
 - The most important part is the "super" call
 - It takes six parameters, in this order
 1) starting x position
 2) starting y position
 3) width
 4) height
 5) x speed
 6) y speed
 
 \****************************************************/

class PlayerShotBasic extends PlayerProjectile
{
  PlayerShotBasic(float x, float y)
  {
    super(x, y, blueShot.width, blueShot.height, 0, -PLAYER_SHOT_SPEED);
    image = blueShot;
    damage = PLAYER_SHOT_DAMAGE;
    if (gameMode=="SideScroller")
    {
      ySpeed=0;
      xSpeed=5;
      x = x + xSpeed;
      y = y + ySpeed;
    }
  }
  //public void act()
  //{
  //  x = x + xSpeed;
  //  y = y + ySpeed;
  //  if (y>height+10||y<-10||x<-10||x>width+10)
  //  {
  //    objects.remove(this);
  //  }
  //}
}
class CompanionShotBasic extends PlayerProjectile
{
  CompanionShotBasic(float x, float y)
  {
    super(x, y, blueShot.width, blueShot.height, 0, -PLAYER_SHOT_SPEED);
    image = blueShot;
    damage = PLAYER_SHOT_DAMAGE;
    if (gameMode=="SideScroller")
    {
      ySpeed=0;
      xSpeed=5;
      x = x + xSpeed;
      y = y + ySpeed;
    }
  }
  // public void act()
  //{
  //  x = x + xSpeed;
  //  y = y + ySpeed;
  //  if (y>height+10||y<-10||x<-10||x>width+10)
  //  {
  //    objects.remove(this);
  //  }
  //}
}
class RedShot extends EnemyProjectile
{
  RedShot(float x, float y)
  {
    super(x, y, redShot.width, redShot.height, 0, RED_SHOT_SPEED);
    image = redShot;
    damage = RED_SHOT_DAMAGE;
    if (Level==4&&numWorld==2)
    {
      ySpeed=2;
      xSpeed=-5;
    }
  }
  //public void act()
  //{
  //  x=x+xSpeed;
  //  y=y+ySpeed;
  //  if (y>height+10||y<-10||x<-10||x>width+10)
  //  {
  //    objects.remove(this);
  //  }
  //}
}
class RedShot2 extends EnemyProjectile
{
  int roll;
  RedShot2(float x, float y)
  {
    super(x, y, redShot.width, redShot.height, 0, RED_SHOT_SPEED);
    roll=(int)random(3);
    image = redShot;
    damage = RED_SHOT_DAMAGE;
    if (Level==4&&numWorld==2)
    {
      if (roll==0)
      {
        ySpeed=-2;
      }
      if (roll==1)
      {
        ySpeed=2;
      }
      if (roll==2)
      {
        ySpeed=0;
      }
      xSpeed=-5;
      x=x+xSpeed;
      y=y-ySpeed;
    }
  }
  public void act()
  {
    //ySpeed=-2;
    //xSpeed=-5;
    x=x+xSpeed;
    y=y+ySpeed;
    if (x<-15)
    {
      objects.remove(this);
    }
    if (clean())
    {
      objects.remove(this);
    }
    clean();
    reactions();
  }
  public boolean clean()
  {
    for (GameObject o : objects)  //loops through all objects                                          
    {
      //Enemies.size();
      //objects.size();
      if (o instanceof lvl2boss)  // and if an enemy object is in the array list, it returns false. Otherwise it returns true
      {
        return false;
      }
    }
    return true;
  }
  public void reactions()
  {
    for (int x = 0; x < collisions.size (); x++)// have them disapear when shot by player
    {
      GameObject o = collisions.get(x);
      if (o instanceof Companion||o instanceof Player)
      {
        objects.remove(this);
      }
    }
  }
}

class plasmaShot2 extends EnemyProjectile
{
  plasmaShot2(float x, float y)
  {
    super(x+9, y, 50, 50, 0, RED_SHOT_SPEED);
    image = plasmaShot;
    damage = plasmaShotDamage;
    if (Level==4&&numWorld==2)
    {
      ySpeed=0;
      xSpeed=-5;
      x=x+xSpeed;
      y=y+ySpeed;
    }
  }
  public void act()
  {
    x=x+xSpeed;
    if (x<-15)
    {
      objects.remove(this);
    }
    if (clean())
    {
      objects.remove(this);
    }
    clean();
    reactions();
  }
  public boolean clean()
  {
    for (GameObject o : objects)  //loops through all objects                                          
    {
      //Enemies.size();
      //objects.size();
      if (o instanceof lvl2boss)  // and if an enemy object is in the array list, it returns false. Otherwise it returns true
      {
        return false;
      }
    }
    return true;
  }
  public void reactions()
  {
    for (int x = 0; x < collisions.size (); x++)// have them disapear when shot by player
    {
      GameObject o = collisions.get(x);
      if (o instanceof Companion||o instanceof Player)
      {
        objects.remove(this);
      }
    }
  }
}
class plasmaShot extends EnemyProjectile
{
  plasmaShot(float x, float y)
  {
    super(x+9, y, 50, 50, 0, RED_SHOT_SPEED);
    image = plasmaShot;
    damage = plasmaShotDamage;
    if (Level==4&&numWorld==2)
    {
      ySpeed=0;
      xSpeed=-5;
      x=x+xSpeed;
      y=y+ySpeed;
    }
  }
  // public void act()
  //{
  //  x = x + xSpeed;
  //  y = y + ySpeed;
  //  if (y>height+10||y<-10||x<-10||x>width+10)
  //  {
  //    objects.remove(this);
  //  }
  //}
}
class ultaBomb extends EnemyProjectile
{
  int lifeTimer;
  ultaBomb(float x, float y)
  {
    super(x+9, y, 50, 50, 0, RED_SHOT_SPEED);
    ySpeed=random(1, 3);
    xSpeed=random(-3, 3);
    image = Bomb;
    damage = plasmaShotDamage;
    lifeTimer=300;
  }
  public void act()
  {
    x = x + xSpeed;
    y = y + ySpeed;
    if (lifeTimer<100)
    {
      xSpeed=0;
      ySpeed=0;
    }
    if (lifeTimer>0)
    {
      lifeTimer--;
    }
    if (lifeTimer==0)
    {
      lifeTimer=0;
      for (int i=0; i<5; i++)
      {
        objects.add(new ultaBombProjectile(x, y));
      }
      objects.remove(this);
    }
    reactions();
  }
  public void reactions()
  {
    for (int x = 0; x < collisions.size (); x++)// have them disapear when shot by player
    {
      GameObject o = collisions.get(x);
      if (o instanceof CompanionShotBasic||o instanceof Companion||o instanceof PlayerShotBasic||o instanceof Player)
      {
        objects.remove(this);
      }
    }
  }
}
class bomb extends EnemyProjectile
{
  int lifeTimer;
  bomb(float x, float y)
  {
    super(x+9, y, 50, 50, 0, RED_SHOT_SPEED);
    ySpeed=0;
    xSpeed=0;
    x = x + xSpeed;
    y = y + ySpeed;
    image = Bomb;
    damage = plasmaShotDamage;
    lifeTimer=300;
  }
  public void act()
  {
    if (lifeTimer>0)
    {
      lifeTimer--;
    }
    if (lifeTimer==0)
    {
      lifeTimer=0;
      for (int i=0; i<3; i++)
      {
        objects.add(new bombProjectile(x, y));
        //objects.add(new bombProjectile(x+17, y+40, nearestPlayer((int)x, (int) y))); //tracking form
      }
      objects.remove(this);
    }
  }
}
class bombProjectile extends EnemyProjectile
{
  //int lifeTimer=300;
  bombProjectile(float x, float y)
  {
    super(x+9, y, 50, 50, 0, RED_SHOT_SPEED);
    ySpeed=random (-3, 3);
    xSpeed=random(-3, 3);
    damage = plasmaShotDamage;
  }
  public void act()
  {
    x = x + xSpeed;
    y = y + ySpeed;
    if (y>height+10||y<-10||x<-10||x>width+10)
    {
      objects.remove(this);
    }
  }
  public void render()
  {
    image(BombProjectile, x, y, 15, 15);
  }
  ///////////////////////////////////////////////////
  //Player myPlayer;
  //bombProjectile(float x, float y, Player p)
  //{
  //  super(x, y, blueShot.width, blueShot.height, 0, -PLAYER_SHOT_SPEED);
  //  damage = playerMissleDamage;
  //  myPlayer=p;
  //  //xSpeed=projectileXVelocity;
  //  //ySpeed=4;
  //}
  //public void render()
  //{
  //  imageMode(CENTER);
  //  image(BombProjectile, x, y, 25, 25);
  //  imageMode(CORNER);
  //}
  //public float getTargetAngle(float startX, float startY, float targetX, float targetY) {
  //  double dist = getDistanceBetween(startX, startY, targetX, targetY);
  //  double sinNewAng = (targetY - startY) / dist;
  //  double cosNewAng = (targetX - startX) / dist;
  //  double angle = 0;

  //  if (sinNewAng > 0) {
  //    if (cosNewAng > 0) {
  //      angle = 360 - Math.toDegrees(Math.asin(sinNewAng));
  //    } else {
  //      angle = Math.toDegrees(Math.asin(sinNewAng)) + 180;
  //    }
  //  } else {
  //    angle = Math.toDegrees(Math.acos(cosNewAng));
  //  }
  //  return (float) angle;
  //}
  //public double getDistanceBetween(float startX, float startY, float endX, float endY) {
  //  return Math.sqrt((Math.pow((endX - startX), 2)) + (Math.pow((endY - startY), 2)));
  //}
  //public float projectileXVelocity(float ang, float v) {
  //  if (ang > 90 && ang < 180) {
  //    return (float) Math.cos(Math.PI - Math.toRadians(ang))*-v ;
  //  } else if (ang > 180 && ang < 270) {
  //    return (float) Math.cos(Math.toRadians(ang) - Math.PI)*-v ;
  //  } else if (ang > 270 && ang < 360) {
  //    return (float) Math.cos(2 * Math.PI - Math.toRadians(ang))*v ;
  //  } else {
  //    return (float) Math.cos(Math.toRadians(ang))*v;
  //  }
  //}
  //public float projectileYVelocity(float ang, float v) {
  //  if (ang > 90 && ang < 180) {
  //    return (float) Math.sin(Math.PI - Math.toRadians(ang))*-v ;
  //  } else if (ang > 180 && ang < 270) {
  //    return (float) Math.sin(Math.toRadians(ang) - Math.PI)*v;
  //  } else if (ang > 270 && ang < 360) {
  //    return (float) Math.sin(2 * Math.PI - Math.toRadians(ang))*v;
  //  } else {
  //    return (float) Math.sin(Math.toRadians(ang))*-v ;
  //  }
  //}
  //public void act()
  //{
  //  super.act();
  //  if (lifeTimer>0)
  //  {
  //    lifeTimer--;
  //  }
  //  if (lifeTimer==0)
  //  {
  //    lifeTimer=0;
  //    objects.remove(this);
  //  }
  //  if (playerGameState!="gameOver"&&stageIsClear()==false)
  //  {
  //    xSpeed=projectileXVelocity(getTargetAngle(x-40, y, nearestPlayer((int)x, (int) y).x, nearestPlayer((int)x, (int)y).y ), PLAYER_SHOT_SPEED/2);
  //    ySpeed=projectileYVelocity(getTargetAngle(x-40, y, nearestPlayer((int)x, (int) y).x, nearestPlayer((int)x, (int)y).y ), PLAYER_SHOT_SPEED/2);
  //  } else if (stageIsClear())
  //  {
  //    objects.remove(this);
  //  } else if (playerGameState=="gameOver")
  //  {
  //    objects.remove(this);
  //  }
  //}
  //public void reactions()
  //{
  //  for (int x = 0; x < collisions.size (); x++)// have them disapear when shot by player
  //  {
  //    GameObject o = collisions.get(x);
  //    if (o instanceof PlayerShotBasic||o instanceof Player||o instanceof CompanionShotBasic||o instanceof Companion)
  //    {
  //      objects.remove(this);
  //    }
  //  }
  //}
}
class ultaBombProjectile extends EnemyProjectile
{
  ultaBombProjectile(float x, float y)
  {
    super(x+9, y, 50, 50, 0, RED_SHOT_SPEED);
    ySpeed=random (-3, 3);
    xSpeed=random(-3, 3);
    damage = plasmaShotDamage;
  }
  public void act()
  {
    x = x + xSpeed;
    y = y + ySpeed;
    if (y>height+10||y<-10||x<-10||x>width+10)
    {
      objects.remove(this);
    }
    reactions();
  }
  public void render()
  {
    image(BombProjectile, x, y, 15, 15);
  }
  public void reactions()
  {
    for (int x = 0; x < collisions.size (); x++)// have them disapear when shot by player
    {
      GameObject o = collisions.get(x);
      if (o instanceof CompanionShotBasic||o instanceof Companion||o instanceof PlayerShotBasic||o instanceof Player)
      {
        objects.remove(this);
      }
    }
  }
}
class orangeShot extends EnemyProjectile
{
  orangeShot(float x, float y)
  {
    super(x+9, y, 50, 50, 0, RED_SHOT_SPEED);
    ySpeed=0;
    xSpeed=5;
    x = x + xSpeed;
    y = y + ySpeed;
    image = orangeShot;
    damage = plasmaShotDamage;
  }
  // public void act()
  //{
  //  x = x + xSpeed;
  //  y = y + ySpeed;
  //  if (y>height+10||y<-10||x<-10||x>width+50)
  //  {
  //    objects.remove(this);
  //  }
  //}
}
class RedLaser extends EnemyProjectile
{
  RedLaser(float x, float y)
  {
    super(x+9, y, 50, 50, 0, RED_SHOT_SPEED);
    ySpeed=0;
    xSpeed=5;
    x = x + xSpeed;
    y = y + ySpeed;
    image = redLaser;
    damage = redLaserDamage;
  }
  // public void act()
  //{
  //  x = x + xSpeed;
  //  y = y + ySpeed;
  //  if (y>height+10||y<-10||x<-10||x>width+50)
  //  {
  //    objects.remove(this);
  //  }
  //}
}
//class DragonBreath extends EnemyProjectile
//{
//  DragonBreath(float x, float y)
//  {
//    super(x+9, y, 50, 50, 0, RED_SHOT_SPEED);
//    ySpeed=0;
//    xSpeed=5;
//    x = x + xSpeed;
//    y = y + ySpeed;
//    image = dragonBreath;
//    damage = dragonBreathDamage;
//  }
//}
class DragonBreath extends EnemyProjectile
{
  DragonBreath(float x, float y)
  {
    super(x+9, y, 50, 50, 0, dragonbreathSpeed);
    image = dragonBreath;
    damage = dragonBreathDamage;
  }
  void erase()
  {
    if (y>height+20)
    {
      objects.remove(this);
    }
  }
}
class FlameBreath extends EnemyProjectile
{
  FlameBreath(float x, float y)
  {
    super(x+9, y, 50, 50, 0, dragonbreathSpeed);
    image = flameBall;
    damage = dragonBreathDamage;
  }
  // public void act()
  //{
  //  x = x + xSpeed;
  //  y = y + ySpeed;
  //  if (y>height+20||y<-10||x<-10||x>width+10)
  //  {
  //    objects.remove(this);
  //  }
  //}
}
class Charge extends EnemyProjectile
{
  float size;
  int timer;
  int ySpeed=4;
  Charge(float x, float y)
  {
    super(x+9, y, 50, 50, 0, dragonbreathSpeed);
    damage = dragonBreathDamage;
    timer=0;
    size=0;
  }
  public void render()
  {
    fill(255);
    imageMode(CENTER);
    image(ChargeBall, x, y, size, size);
    imageMode(CORNER);
  }
  public void act()
  {
    x+=xSpeed;
    if (size<40)
    {
      size+=1;
    } else
    {
      y+=ySpeed;
      size+=.25;
    }
    if (y>height+50)
    {
      objects.remove(this);
    }
    if (clean())
    {
      objects.remove(this);
    }
    clean();
  }
  public boolean clean()
  {
    for (GameObject o : objects)  //loops through all objects                                          
    {
      //Enemies.size();
      //objects.size();
      if (o instanceof Lvl3_fireCharger)  // and if an enemy object is in the array list, it returns false. Otherwise it returns true
      {
        return false;
      }
    }
    return true;
  }
}
class blackLaser extends EnemyProjectile
{
  blackLaser(float x, float y)
  {
    super(x, y, redShot.width, redShot.height, 0, RED_SHOT_SPEED);
    image = blackLaser;
    damage = blackLaserDamage;
  }
  // public void act()
  //{
  //  x = x + xSpeed;
  //  y = y + ySpeed;
  //  if (y>height+10||y<-10||x<-10||x>width+10)
  //  {
  //    objects.remove(this);
  //  }
  //}
}
class playerMissle extends PlayerProjectile
{
  Enemy myEnemy;
  playerMissle(float x, float y, Enemy e)
  {
    super(x, y, blueShot.width, blueShot.height, 0, -PLAYER_SHOT_SPEED);
    damage = playerMissleDamage;
    myEnemy=e;
    //xSpeed=projectileXVelocity;
    //ySpeed=4;
  }
  public void render()
  {
    imageMode(CENTER);
    image(playerMissle, x, y, 25, 25);
    imageMode(CORNER);
  }
  public float getTargetAngle(float startX, float startY, float targetX, float targetY) {
    double dist = getDistanceBetween(startX, startY, targetX, targetY);
    double sinNewAng = (targetY - startY) / dist;
    double cosNewAng = (targetX - startX) / dist;
    double angle = 0;

    if (sinNewAng > 0) {
      if (cosNewAng > 0) {
        angle = 360 - Math.toDegrees(Math.asin(sinNewAng));
      } else {
        angle = Math.toDegrees(Math.asin(sinNewAng)) + 180;
      }
    } else {
      angle = Math.toDegrees(Math.acos(cosNewAng));
    }
    return (float) angle;
  }
  public double getDistanceBetween(float startX, float startY, float endX, float endY) {
    return Math.sqrt((Math.pow((endX - startX), 2)) + (Math.pow((endY - startY), 2)));
  }
  public float projectileXVelocity(float ang, float v) {
    if (ang > 90 && ang < 180) {
      return (float) Math.cos(Math.PI - Math.toRadians(ang))*-v ;
    } else if (ang > 180 && ang < 270) {
      return (float) Math.cos(Math.toRadians(ang) - Math.PI)*-v ;
    } else if (ang > 270 && ang < 360) {
      return (float) Math.cos(2 * Math.PI - Math.toRadians(ang))*v ;
    } else {
      return (float) Math.cos(Math.toRadians(ang))*v;
    }
  }
  public float projectileYVelocity(float ang, float v) {
    if (ang > 90 && ang < 180) {
      return (float) Math.sin(Math.PI - Math.toRadians(ang))*-v ;
    } else if (ang > 180 && ang < 270) {
      return (float) Math.sin(Math.toRadians(ang) - Math.PI)*v;
    } else if (ang > 270 && ang < 360) {
      return (float) Math.sin(2 * Math.PI - Math.toRadians(ang))*v;
    } else {
      return (float) Math.sin(Math.toRadians(ang))*-v ;
    }
  }
  public void act()
  {
    super.act();
    for (GameObject o : objects)
    {
      if (o instanceof Enemy&&stageIsClear()==false)
      {
        xSpeed=projectileXVelocity(getTargetAngle(x, y, nearestEnemy((int)x, (int) y).x, nearestEnemy((int)x, (int)y).y ), PLAYER_SHOT_SPEED);
        ySpeed=projectileYVelocity(getTargetAngle(x, y, nearestEnemy((int)x, (int) y).x, nearestEnemy((int)x, (int)y).y ), PLAYER_SHOT_SPEED);
      } else if (stageIsClear())
      {
        objects.remove(this);
      }

      //if(myEnemy==null)
      //{
      //objects.remove(this); 
      //}
    }
  }
}
class enemyMissleP extends EnemyProjectile //Targets Player
{
  Player myPlayer;
  enemyMissleP(float x, float y, Player p)
  {
    super(x, y, blueShot.width, blueShot.height, 0, -PLAYER_SHOT_SPEED);
    damage = playerMissleDamage;
    myPlayer=p;
    //xSpeed=projectileXVelocity;
    //ySpeed=4;
  }
  public void render()
  {
    imageMode(CENTER);
    image(enemyHomingBall, x, y, 25, 25);
    imageMode(CORNER);
  }
  public float getTargetAngle(float startX, float startY, float targetX, float targetY) {
    double dist = getDistanceBetween(startX, startY, targetX, targetY);
    double sinNewAng = (targetY - startY) / dist;
    double cosNewAng = (targetX - startX) / dist;
    double angle = 0;

    if (sinNewAng > 0) {
      if (cosNewAng > 0) {
        angle = 360 - Math.toDegrees(Math.asin(sinNewAng));
      } else {
        angle = Math.toDegrees(Math.asin(sinNewAng)) + 180;
      }
    } else {
      angle = Math.toDegrees(Math.acos(cosNewAng));
    }
    return (float) angle;
  }
  public double getDistanceBetween(float startX, float startY, float endX, float endY) {
    return Math.sqrt((Math.pow((endX - startX), 2)) + (Math.pow((endY - startY), 2)));
  }
  public float projectileXVelocity(float ang, float v) {
    if (ang > 90 && ang < 180) {
      return (float) Math.cos(Math.PI - Math.toRadians(ang))*-v ;
    } else if (ang > 180 && ang < 270) {
      return (float) Math.cos(Math.toRadians(ang) - Math.PI)*-v ;
    } else if (ang > 270 && ang < 360) {
      return (float) Math.cos(2 * Math.PI - Math.toRadians(ang))*v ;
    } else {
      return (float) Math.cos(Math.toRadians(ang))*v;
    }
  }
  public float projectileYVelocity(float ang, float v) {
    if (ang > 90 && ang < 180) {
      return (float) Math.sin(Math.PI - Math.toRadians(ang))*-v ;
    } else if (ang > 180 && ang < 270) {
      return (float) Math.sin(Math.toRadians(ang) - Math.PI)*v;
    } else if (ang > 270 && ang < 360) {
      return (float) Math.sin(2 * Math.PI - Math.toRadians(ang))*v;
    } else {
      return (float) Math.sin(Math.toRadians(ang))*-v ;
    }
  }
  public void act()
  {
    super.act();
    if (playerGameState!="gameOver"&&stageIsClear()==false)
    {
      xSpeed=projectileXVelocity(getTargetAngle(x-40, y, nearestPlayer((int)x, (int) y).x, nearestPlayer((int)x, (int)y).y ), PLAYER_SHOT_SPEED/2);
      ySpeed=projectileYVelocity(getTargetAngle(x-40, y, nearestPlayer((int)x, (int) y).x, nearestPlayer((int)x, (int)y).y ), PLAYER_SHOT_SPEED/2);
    } else if (stageIsClear())
    {
      objects.remove(this);
    } else if (playerGameState=="gameOver")
    {
      objects.remove(this);
    }
  }
  public void reactions()
  {
    for (int x = 0; x < collisions.size (); x++)// have them disapear when shot by player
    {
      GameObject o = collisions.get(x);
      if (o instanceof PlayerShotBasic||o instanceof Player||o instanceof CompanionShotBasic||o instanceof Companion)
      {
        objects.remove(this);
      }
    }
  }
}
class enemyMissleC extends EnemyProjectile //Targets Player
{
  Companion myCompanion;
  enemyMissleC(float x, float y, Companion c)
  {
    super(x, y, blueShot.width, blueShot.height, 0, -PLAYER_SHOT_SPEED);
    damage = playerMissleDamage;
    myCompanion=c;
    //xSpeed=projectileXVelocity;
    //ySpeed=4;
  }
  public void render()
  {
    imageMode(CENTER);
    image(enemyHomingBall, x, y, 25, 25);
    imageMode(CORNER);
  }
  public float getTargetAngle(float startX, float startY, float targetX, float targetY) {
    double dist = getDistanceBetween(startX, startY, targetX, targetY);
    double sinNewAng = (targetY - startY) / dist;
    double cosNewAng = (targetX - startX) / dist;
    double angle = 0;

    if (sinNewAng > 0) {
      if (cosNewAng > 0) {
        angle = 360 - Math.toDegrees(Math.asin(sinNewAng));
      } else {
        angle = Math.toDegrees(Math.asin(sinNewAng)) + 180;
      }
    } else {
      angle = Math.toDegrees(Math.acos(cosNewAng));
    }
    return (float) angle;
  }
  public double getDistanceBetween(float startX, float startY, float endX, float endY) {
    return Math.sqrt((Math.pow((endX - startX), 2)) + (Math.pow((endY - startY), 2)));
  }
  public float projectileXVelocity(float ang, float v) {
    if (ang > 90 && ang < 180) {
      return (float) Math.cos(Math.PI - Math.toRadians(ang))*-v ;
    } else if (ang > 180 && ang < 270) {
      return (float) Math.cos(Math.toRadians(ang) - Math.PI)*-v ;
    } else if (ang > 270 && ang < 360) {
      return (float) Math.cos(2 * Math.PI - Math.toRadians(ang))*v ;
    } else {
      return (float) Math.cos(Math.toRadians(ang))*v;
    }
  }
  public float projectileYVelocity(float ang, float v) {
    if (ang > 90 && ang < 180) {
      return (float) Math.sin(Math.PI - Math.toRadians(ang))*-v ;
    } else if (ang > 180 && ang < 270) {
      return (float) Math.sin(Math.toRadians(ang) - Math.PI)*v;
    } else if (ang > 270 && ang < 360) {
      return (float) Math.sin(2 * Math.PI - Math.toRadians(ang))*v;
    } else {
      return (float) Math.sin(Math.toRadians(ang))*-v ;
    }
  }
  public void act()
  {
    super.act();
    if (companionGameState!="gameOver"&&stageIsClear()==false)
    {
      xSpeed=projectileXVelocity(getTargetAngle(x-40, y, nearestCompanion((int)x, (int) y).x, nearestCompanion((int)x, (int)y).y ), PLAYER_SHOT_SPEED/2);
      ySpeed=projectileYVelocity(getTargetAngle(x-40, y, nearestCompanion((int)x, (int) y).x, nearestCompanion((int)x, (int)y).y ), PLAYER_SHOT_SPEED/2);
    } else if (stageIsClear())
    {
      objects.remove(this);
    } else if (companionGameState=="gameOver")
    {
      objects.remove(this);
    }
  }
  public void reactions()
  {
    for (int x = 0; x < collisions.size (); x++)// have them disapear when shot by player
    {
      GameObject o = collisions.get(x);
      if (o instanceof CompanionShotBasic||o instanceof Companion||o instanceof PlayerShotBasic||o instanceof Player)
      {
        objects.remove(this);
      }
    }
  }
}
class companionMissle extends PlayerProjectile
{
  Enemy myEnemy;
  companionMissle(float x, float y, Enemy e)
  {
    super(x, y, blueShot.width, blueShot.height, 0, -PLAYER_SHOT_SPEED);
    damage = playerMissleDamage;
    myEnemy=e;
    //xSpeed=projectileXVelocity;
    //ySpeed=4;
  }
  public void render()
  {
    imageMode(CENTER);
    image(playerMissle, x, y, 25, 25);
    imageMode(CORNER);
  }
  public float getTargetAngle(float startX, float startY, float targetX, float targetY) {
    double dist = getDistanceBetween(startX, startY, targetX, targetY);
    double sinNewAng = (targetY - startY) / dist;
    double cosNewAng = (targetX - startX) / dist;
    double angle = 0;

    if (sinNewAng > 0) {
      if (cosNewAng > 0) {
        angle = 360 - Math.toDegrees(Math.asin(sinNewAng));
      } else {
        angle = Math.toDegrees(Math.asin(sinNewAng)) + 180;
      }
    } else {
      angle = Math.toDegrees(Math.acos(cosNewAng));
    }
    return (float) angle;
  }
  public double getDistanceBetween(float startX, float startY, float endX, float endY) {
    return Math.sqrt((Math.pow((endX - startX), 2)) + (Math.pow((endY - startY), 2)));
  }
  public float projectileXVelocity(float ang, float v) {
    if (ang > 90 && ang < 180) {
      return (float) Math.cos(Math.PI - Math.toRadians(ang))*-v ;
    } else if (ang > 180 && ang < 270) {
      return (float) Math.cos(Math.toRadians(ang) - Math.PI)*-v ;
    } else if (ang > 270 && ang < 360) {
      return (float) Math.cos(2 * Math.PI - Math.toRadians(ang))*v ;
    } else {
      return (float) Math.cos(Math.toRadians(ang))*v;
    }
  }
  public float projectileYVelocity(float ang, float v) {
    if (ang > 90 && ang < 180) {
      return (float) Math.sin(Math.PI - Math.toRadians(ang))*-v ;
    } else if (ang > 180 && ang < 270) {
      return (float) Math.sin(Math.toRadians(ang) - Math.PI)*v;
    } else if (ang > 270 && ang < 360) {
      return (float) Math.sin(2 * Math.PI - Math.toRadians(ang))*v;
    } else {
      return (float) Math.sin(Math.toRadians(ang))*-v ;
    }
  }
  public void act()
  {
    super.act();
    for (GameObject o : objects)
    {
      if (o instanceof Enemy&&stageIsClear()==false)
      {
        xSpeed=projectileXVelocity(getTargetAngle(x, y, nearestEnemy((int)x, (int) y).x, nearestEnemy((int)x, (int)y).y ), PLAYER_SHOT_SPEED);
        ySpeed=projectileYVelocity(getTargetAngle(x, y, nearestEnemy((int)x, (int) y).x, nearestEnemy((int)x, (int)y).y ), PLAYER_SHOT_SPEED);
      } else if (stageIsClear())
      {
        objects.remove(playerMissle);
      }

      //if(myEnemy==null)
      //{
      //objects.remove(this); 
      //}
    }
  }
}
