function ChangeSpeed(amount) {
  local vel = activator.GetVelocity();
  
  local sdx = 0;
  local sdy = 0;
  
  local v = sqrt(vel.x*vel.x+vel.y*vel.y);
  local new_v = v+amount;
  
  if(new_v<0){
  sdx = 0;
  sdy = 0;
  }
  else{
  sdx = new_v*vel.x/v;
  sdy = new_v*vel.y/v;
  }
  
  // if(vel.x<0){
  // sdx=vel.x+amount;
  // if(sdx>0)sdx=0;
  // }
  // if( vel.x>0 || vel.x==0 ){
  // sdx=vel.x-amount;
  // if(sdx<0)sdx=0;
  // }
  
  // if(vel.y<0){
  // sdy=vel.y+amount;
  // if(sdy>0)sdy=0;
  // }
  // if( vel.y>0 || vel.y==0 ){
  // sdy=vel.y-amount;
  // if(sdy<0)sdy=0;
  // }
  
  local new_vel = Vector( sdx , sdy , vel.z);
  
  activator.SetVelocity(new_vel);
  
  //activator.__KeyValueFromVector("basevelocity", new_vel);
}

function ShowSpeed(){
  local vel = activator.GetVelocity();
  printl("speedx:"+vel.x);
  printl("speedy:"+vel.y);
  printl("speedz:"+vel.z);
  
  EntFireByHandle(self,"RunScriptCode"," ShowSpeed() ",1.00,activator,null);

}
