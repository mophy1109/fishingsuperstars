function entry()
  mSleep(1000);
  feed();
  while (true) do
    gonext();
    feed();
    mSleep(200);
    r,g,b = getColorRGB(scrollx, scrolly);--滚动条颜色
    if (r<20 and g<20 and b<20) then
      gotop();
      mSleep(0);
      feed();
    end
  end
end

function feed()
  r,g,b = getColorRGB(btn_feedx, btn_feedy);
  if b>100 then  -- 如果找到了
    click(btn_feedx, btn_feedy+5);   -- 点击喂食
    mSleep(500);
    r,g,b = getColorRGB(btn_foodx, btn_foody);
    if r ~= g then  -- 如果找到了
      click(btn_foodx, btn_foody);   -- 点击普通食物
      mSleep(100);
    else
      click(btn_xx, btn_xy);   -- 点击X
    end
  end
  mSleep(300);
  r,g,b = getColorRGB(goldx, goldy);
  if r ~= g then
    click(goldx, goldy);   -- 点击收金币
  end
end

function gonext()
  touchDown(0, 150, 550);
  mSleep(50);
  touchMove(0, 150, 200);
  touchUp(0, 150, 200);
  mSleep(500);
end

function gotop()
  touchDown(0, scrollx, scrolly - 20);
  mSleep(50);
  touchMove(0, scrollx, scrolltop);
  touchUp(0, scrollx, scrolltop);
  mSleep(500);
end

function click(x, y)
  if (x == nil or x <= 0) then
    return;
  else
    touchDown(0, x + math.random(10,15), y + math.random(10,15)); 
    mSleep(50 + math.random(20,50));
    touchUp(0, x + math.random(10,15), y + math.random(10,15));
    mSleep(50 + math.random(20,50));
  end
end

function setScreen()
  w,h = getScreenSize();
  if (math.abs((w*1024)/(h*768)-1) < 0.005) then
    setScreenScale(768,1024);
    setParamiPad();
  elseif (math.abs((w*1136)/(h*640)-1) < 0.005) then
    setScreenScale(640,1136);
    setParamiPhone();
  else
    toast("暂不支持此分辨率!");
    lua_exit();
  end
end

function setParamiPad()
  scrollx, scrolly, scrolltop = 966, 633, 175;
  btn_feedx, btn_feedy = 850, 580;
  btn_foodx, btn_foody = 665, 353;
  btn_xx, btn_xy = 825, 185;
  goldx, goldy = 882, 198;
end

function setParamiPhone()
  scrollx, scrolly, scrolltop = 1070, 575, 125;
  btn_feedx, btn_feedy = 940, 530;
  btn_foodx, btn_foody = 745,290;
  btn_xx, btn_xy = 915,110;
  goldx, goldy = 980, 125;
end

init("com.gamevil.fishingsuperstarsfree",1);
setScreen();
entry();