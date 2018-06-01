function entry()
  while (ii <= 100) do
    visit();
    t = 1;
    while (t<6) do
      cast();
      draw();
      a = finish();
      t = t + a;
    end
  end
  if (tonumber(s.lock) == 0) then
    lockDevice();
    lua_exit();
  end
end

function cast()
  local x1, y1;
  x1, y1 = findMultiColorInRegionFuzzy(cast_c, cast_s, degree, cast_x1, cast_y1, cast_x2, cast_y2);
  while (x1 == -1) do
		mSleep(unidelay)
    x1, y1 = findMultiColorInRegionFuzzy(cast_c, cast_s, degree, cast_x1, cast_y1, cast_x2, cast_y2);
  end
  mSleep(castdelay);
  click(x1, y1);
  local x, y = findMultiColorInRegionFuzzy(hit_c, hit_s, degree, hit_x1, hit_y1, hit_x2, hit_y2);
  while (x == -1 and y == -1) do
		mSleep(unidelay)
    x, y = findMultiColorInRegionFuzzy(hit_c, hit_s, degree, hit_x1, hit_y1, hit_x2, hit_y2);
  end
  mSleep(3000);
  local x2, y2 = findMultiColorInRegionFuzzy(bait_c, bait_s, baitdegree, bait_x1, bait_y1, bait_x2, bait_y2);
  while (x2 ~= -1 and y2 ~= -1) do--浮标存在
		mSleep(300)
    x2, y2 = findMultiColorInRegionFuzzy(bait_c, bait_s, baitdegree, bait_x1, bait_y1, bait_x2, bait_y2);
  end
end

function draw()--包含擦擦
  local x, y = findMultiColorInRegionFuzzy(hit_c, hit_s, degree, hit_x1, hit_y1, hit_x2, hit_y2);
  while (x == -1 and y == -1) do
    mSleep(unidelay);
    x, y = findMultiColorInRegionFuzzy(hit_c, hit_s, degree, hit_x1, hit_y1, hit_x2, hit_y2);
  end
  mSleep(20);
  touchDown(0, x+5, y+5);
  mSleep(100);
  touchUp(0, x+5, y+5);
  mSleep(10);
  local x1 = -1
	
	if (s.caca == "0") then
		while (x1 ~= 0x000000) do
			for ti = 1, 30 do
				two();
			end
			x1,y1 = getColor(25, 25);
		end
	else
		while (x1 ~= 0x000000) do
			for ti = 1, 30 do
				three();
			end
			x1,y1 = getColor(25, 25);
		end
	end
end

function two()
	mSleep(drawdelay);
  touchDown(0,pt1_x + math.random(-5,5), pt1_y + math.random(-5,5));
  touchMove(0,pt2_x + math.random(-5,5), pt2_y + math.random(-5,5));
  mSleep(28)
  touchMove(0,pt3_x + math.random(-5,5), pt3_y + math.random(-5,5));
  mSleep(28)
  touchUp(0,pt3_x + math.random(-5,5), pt3_y + math.random(-5,5));
end

function three()
  mSleep(drawdelay);
  touchDown(0,point1_x + math.random(-5,5), point1_y + math.random(-5,5));
  touchMove(0,point2_x + math.random(-5,5), point2_y + math.random(-5,5));
  mSleep(28);
  touchMove(0,point3_x + math.random(-5,5), point3_y + math.random(-5,5));
  mSleep(28);
  touchUp(0,point3_x + math.random(-5,5), point3_y + math.random(-5,5));
end

function finish()--完成处理
	mSleep(500)
  local x1, y1, x2, y2;
  x1, y1 = findMultiColorInRegionFuzzy(cast_c, cast_s, degree, cast_x1, cast_y1, cast_x2, cast_y2);--找cast按钮
  x2, y2 = findMultiColorInRegionFuzzy(exhausted_c, exhausted_s, degree, exhausted_x1, exhausted_y1, exhausted_x2, exhausted_y2);--体力用尽
  while (x1 == -1 and x2 == -1) do
		mSleep(unidelay)
    keepScreen(true);
    x3, y3 = findMultiColorInRegionFuzzy(getbox_c, getbox_s, degree, getbox_x1, getbox_y1, getbox_x2, getbox_y2);--箱子
    x4, y4 = findMultiColorInRegionFuzzy(getegg_c, getegg_s, degree, getegg_x1, getegg_y1, getegg_x2, getegg_y2);--蛋
    x5, y5 = findMultiColorInRegionFuzzy(con_c, con_s, degree, con_x1, con_y1, con_x2, con_y2);--继续钓鱼
    keepScreen(false);
    if (x3 ~= -1) then
      x, y = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter_x1, enter_y1, enter_x2, enter_y2);
      click(x, y);
    elseif (x4 ~= -1) then
      getegg();
    elseif (x5 ~= -1) then
      click(x5, y5);
    end
		keepScreen(true);
    x1, y1 = findMultiColorInRegionFuzzy(cast_c, cast_s, degree, cast_x1, cast_y1, cast_x2, cast_y2);--找cast按钮
    x2, y2 = findMultiColorInRegionFuzzy(exhausted_c, exhausted_s, degree, exhausted_x1, exhausted_y1, exhausted_x2, exhausted_y2);--体力用尽
		keepScreen(false);
	end
  
  if (x1 ~= -1) then
    return 1;
  else
    exhausted();
    return 5;
  end
end

function getegg()
  --出卵
	mSleep(1000)
  x, y = findMultiColorInRegionFuzzy(putegg_c, putegg_s, degree, putegg_x1, putegg_y1, putegg_x2, putegg_y2);
  while (x == -1 and y == -1) do
    mSleep(unidelay);
    x, y = findMultiColorInRegionFuzzy(putegg_c, putegg_s, degree, putegg_x1, putegg_y1, putegg_x2, putegg_y2);
  end
  click(x, y);
  mSleep(1500);
  x1, y1 = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter2_x1, enter2_y1, enter2_x2, enter2_y2);
  x2, y2 = findMultiColorInRegionFuzzy(clearup_c, clearup_s, degree, clearup_x1, clearup_y1, clearup_x2, clearup_y2);
  while (x1 == -1 and x2 == -1) do
		mSleep(unidelay)
    x1, y1 = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter2_x1, enter2_y1, enter2_x2, enter2_y2);
    x2, y2 = findMultiColorInRegionFuzzy(clearup_c, clearup_s, degree, clearup_x1, clearup_y1, clearup_x2, clearup_y2);
  end
  
  if (x1 ~= -1) then 
    click(x1, y1);
  else
    click(x2, y2);
    feedandsell();
    mSleep(1500);
    x, y = findMultiColorInRegionFuzzy(getegg_c, getegg_s, degree, getegg_x1, getegg_y1, getegg_x2, getegg_y2);
    while (x == -1 and y == -1) do
      mSleep(unidelay);
      x, y = findMultiColorInRegionFuzzy(getegg_c, getegg_s, degree, getegg_x1, getegg_y1, getegg_x2, getegg_y2);
    end
    getegg();
  end
end

function exhausted()
  --用尽体力
  x, y = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter_x1, enter_y1, enter_x2, enter_y2);
  while (x == -1 and y == -1) do
    mSleep(1000+unidelay);
    x, y = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter_x1, enter_y1, enter_x2, enter_y2);
  end
  mSleep(100);
  click(x+5, y+5);
  mSleep(400);
  
  --返回好友
  x, y = findMultiColorInRegionFuzzy(goback_c, goback_s, degree, goback_x1, goback_y1, goback_x2, goback_y2);
  while (x == -1 and y == -1) do
    mSleep(unidelay);
    x, y = findMultiColorInRegionFuzzy(goback_c, goback_s, degree, goback_x1, goback_y1, goback_x2, goback_y2);
  end
  mSleep(200);
  click(x+5, y+5);
  mSleep(600);
  x, y = findMultiColorInRegionFuzzy(yes_c, yes_s, degree, yes_x1, yes_y1, yes_x2, yes_y2);
  if (x ~= -1 and y ~= -1) then
    mSleep(200);
    click(x+5, y+5);
  end
  backtolist();
end

function feedandsell()
  mSleep(1000);
  feed();
  while (true) do
    gonext();
    mSleep(200);
    r,g,b = getColorRGB(btn_feedx, btn_feedy);
    if b>100 then  -- 如果找到了
      feed();
    else
      r3,g3,b3 = getColorRGB(epicx, epicy);
      if (b3 > 100) then
        break;
      end
    end
    r,g,b = getColorRGB(scrollx, scrolly);--滚动条颜色
    if (r<20 and g<20 and b<20) then
      gotop();
      feed();
    end
  end
  --卖鱼
  mSleep(200);
  sellfish();
  --返回
  x, y = findMultiColorInRegionFuzzy(goback_c, goback_s, degree, goback_x1, goback_y1, goback_x2, goback_y2);
  while (x == -1 and y == -1) do
    mSleep(unidelay);
    x, y = findMultiColorInRegionFuzzy(goback_c, goback_s, degree, goback_x1, goback_y1, goback_x2, goback_y2);
  end
  mSleep(100);
  click(x+5, y+5);
end

function feed()
  click(btn_feedx, btn_feedy+5);   -- 点击喂食
  mSleep(500);
  r,g,b = getColorRGB(btn_foodx, btn_foody);
  if r ~= g then  -- 如果找到了
    click(btn_foodx, btn_foody);   -- 点击普通食物
    mSleep(100);
  else
    click(btn_xx, btn_xy);   -- 点击X
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

function sellfish()
  mSleep(300);
  x, y = findMultiColorInRegionFuzzy(sell_c, sell_s, degree, sell_x1, sell_y1, sell_x2, sell_y2);
  while (x == -1 and y == -1) do
    mSleep(unidelay);
    x, y = findMultiColorInRegionFuzzy(sell_c, sell_s, degree, sell_x1, sell_y1, sell_x2, sell_y2);
  end
  mSleep(100);
  click(x+5, y+5);
  mSleep(300);
  
  x, y = findMultiColorInRegionFuzzy(sell_c, sell_s, degree, sell2_x1, sell2_y1, sell2_x2, sell2_y2);
  while (x == -1 and y == -1) do
    mSleep(unidelay);
    x, y = findMultiColorInRegionFuzzy(sell_c, sell_s, degree, sell2_x1, sell2_y1, sell2_x2, sell2_y2);
  end
  mSleep(100);
  click(x, y);
  mSleep(800);
end

function visit()
	ii = ii + 1;
	sysLog(ii)
  if ii > 120 then
		lockDevice(); 
    lua_exit();
  end
	mSleep(2000+unidelay);
  local x, y = findMultiColorInRegionFuzzy(zero_c, zero_s, degree, zero_x1, zero_y1, zero_x2, zero_y2);
  if (x ~= -1 and y ~= -1) then
    pass();
    visit();
    return;
  else
    x1, y1 = findColorInRegionFuzzy(energy_c, degree, energy_x1, energy_y1, energy_x2, energy_y2); 
    if (x1 ~= -1 and y1 ~= -1) then
      x, y = findColorInRegionFuzzy(0xffffff, degree, visit_x1, visit_y1, visit_x2, visit_y2);
      if (x ~= -1 and y ~= -1) then
        click(x, y);
        mSleep(400);
      end
    else
      pass();
      visit();
      return;
    end
    mSleep(2000)
    x, y = findMultiColorInRegionFuzzy(practice_c, practice_s, degree, practice_x1, practice_y1, practice_x2, practice_y2);
    while (x == -1 and y == -1) do
			mSleep(unidelay)
      x, y = findMultiColorInRegionFuzzy(practice_c, practice_s, degree, practice_x1, practice_y1, practice_x2, practice_y2);
    end
    mSleep(800);
    click(x, y);
    keepScreen(true);
    x, y = findMultiColorInRegionFuzzy(cast_c, cast_s, degree, cast_x1, cast_y1, cast_x2, cast_y2);
    x1, y1 = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter_x1, enter_y1, enter_x2, enter_y2);
    keepScreen(false);
    while (x == -1 and x1 == -1) do
			mSleep(unidelay)
      keepScreen(true);
      x, y = findMultiColorInRegionFuzzy(cast_c, cast_s, degree, cast_x1, cast_y1, cast_x2, cast_y2);
      x1, y1 = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter_x1, enter_y1, enter_x2, enter_y2);
      keepScreen(false);
    end
    if (x1 ~= -1) then
      backtolist();
			pass();
      visit();
      return;
    end
  end
end

function pass()
  touchDown(0, 540, 440);
  mSleep(50);
  touchMove(0, 540, 360);
  mSleep(50);
  touchUp(0, 540, 360);
end

function backtolist()
  xt, yt = findColorInRegionFuzzy(0xffffff, degree, visit_x1, visit_y1, visit_x2, visit_y2);
  while (xt == -1) do
		mSleep(unidelay)
    x1, y1 = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter_x1, enter_y1, enter_x2, enter_y2);
    x2, y2 = findMultiColorInRegionFuzzy(list_c, list_s, degree, list_x1, list_y1, list_x2, list_y2)
    if (x1 ~= -1) then
      --确定
      click(x1, y1);
    else
      --返回好友列表
      click(x2, y2);
      mSleep(1500);
    end
    xt, yt = findColorInRegionFuzzy(0xffffff, degree, visit_x1, visit_y1, visit_x2, visit_y2);
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
  degree = tonumber(s.degree);--精度
	baitdegree = tonumber(s.baitdegree)
	unidelay = tonumber(s.unidelay)
	castdelay = tonumber(s.castdelay)
	drawdelay = tonumber(s.delay)
	
  --体力0
  zero_c = 0x282828;
  zero_s = "-3|3|0x2a2b2b,-3|10|0x333332,4|4|0x292929,4|6|0x222323";
  zero_x1, zero_y1, zero_x2, zero_y2 = 825, 340, 840, 355;--第二个好友
  
  --体力图标
  energy_c = 0x61de68;
  energy_x1, energy_y1, energy_x2, energy_y2 = 775,340,800,360;
  
  --访问按钮
  visit_x1, visit_y1, visit_x2, visit_y2 = 885,315,915,345;
  
  --钓鱼练习按钮
  practice_c = 0xf3f4f3;
  practice_s = "15|-14|0xe1e1e2,39|3|0xbacdd1,62|-11|0xfefeff,91|-13|0x1285cb";
  practice_x1, practice_y1, practice_x2, practice_y2 = 310,560,410,590;
  
  --CAST按钮
  cast_c = 0xffffff;
  cast_s = "10|-6|0x4997e4,28|-11|0xd3dee8,50|6|0xfdfdfd,68|-15|0xffffff";
  cast_x1, cast_y1, cast_x2, cast_y2 = 800, 580, 890, 610;
  
  --确定按钮
  enter_c = 0xeaebeb;
  enter_s = "14|-7|0xffffff,35|-5|0x0ca3f0,49|-7|0xf3f3f4,59|-4|0xfafaf9";
  enter_x1, enter_y1, enter_x2, enter_y2 = 475, 535, 545, 550;
  enter2_x1, enter2_y1, enter2_x2, enter2_y2 = 605, 525, 695, 555;
  
  --返回好友列表
  list_c = 0xf6f6f6;
  list_s = "13|-13|0xf0f3f3,31|3|0xf9f8f9,63|2|0x02c8fd,91|-11|0xffffff";
  list_x1, list_y1, list_x2, list_y2 = 295, 615, 425, 650;
  
  --Hit
  hit_c = 0xfeffff;
  hit_s = "15|-8|0xfbfbfc,29|-5|0x1f64a8,37|-16|0xeff3f7";
  hit_x1, hit_y1, hit_x2, hit_y2 = 810,570,875,610;
  
  --Bait
  if (s.baitcolor == "0") then
    bait_c = 0xf02f38;
    bait_s = "0|2|0xe9212b,0|4|0xd51c25,-2|2|0xeb2a33,1|2|0xec2029";
  else
    bait_c = 0xefcb50;
    bait_s = "0|-1|0xf9d665,0|1|0xe5bf45,-1|0|0xf1cc53,1|0|0xe5c349"; 
  end
  bait_x1, bait_y1, bait_x2, bait_y2 = 450,350,500,610;
  
	--三点擦点位
  point1_x, point1_y = 1000,662;
  point2_x, point2_y = 760,635;
  point3_x, point3_y = 1000,605;
	
	--一字擦点位
	pt1_x, pt1_y = 762,612;
	pt2_x, pt2_y = 1020,610;
  pt3_x, pt3_y = 942,638;
	
  --体力用尽
  exhausted_c = 0xa58235;
  exhausted_s = "6|-10|0xca9f3c,16|-3|0x997830,30|3|0xbc9338,34|-1|0x161210";
  exhausted_x1, exhausted_y1, exhausted_x2, exhausted_y2 = 395, 205, 435, 225;
  
  --box
  getbox_c = 0xffffff;
  getbox_s = "30|0|0xffffff,60|0|0xffffff";
  getbox_x1, getbox_y1, getbox_x2, getbox_y2 = 350,295,420,300;
  
  --egg
  getegg_c = 0xffffff;
  getegg_s = "30|0|0xffffff,60|0|0xffffff";
  getegg_x1, getegg_y1, getegg_x2, getegg_y2 = 355,325,415,330;
  
  --Continue
  con_c = 0xeaebec;
  con_s = "14|-14|0xf4f5f5,37|-10|0xcbcccf,66|-4|0x00a1fd,93|-13|0xfaf9fa";
  con_x1, con_y1, con_x2, con_y2 = 865,615,980,650;
  
  --putegg
  putegg_c = 0xe4edef;
  putegg_s = "50|0|0xf7f9fa,73|-1|0x02c5f5,101|0|0x01a7cf,121|-7|0x06a7ef";
  putegg_x1, putegg_y1, putegg_x2, putegg_y2 = 300,525,450,555;
  
  --goback
  goback_c = 0xc8efee;
  goback_s = "-15|27|0x54bbb9,18|28|0x50b2b1";
  goback_x1, goback_y1, goback_x2, goback_y2 = 965,15,1005,55;
  
  --yes
  yes_c = 0xf7f6f7;
  yes_s = "10|-17|0xd1d3d4,21|-5|0x06b0f7"
  yes_x1, yes_y1, yes_x2, yes_y2 = 360, 530, 385, 555;
  
  --clearup
  clearup_c = 0x02bdf5;
  clearup_s = "46|-3|0xfcfdfc,80|1|0xbfd9df,102|3|0x00a5cb,121|-6|0x0899e0";
  clearup_x1, clearup_y1, clearup_x2, clearup_y2 = 575,525,720,555;
  
  --Sell
  sell_c = 0x049edf;
  sell_s = "6|-5|0xf4f5f5,10|-10|0x1170ae,28|-2|0x08acfb,54|-8|0xf6f7f7";
  sell_x1, sell_y1, sell_x2, sell_y2 = 815, 515, 875, 530;
  sell2_x1, sell2_y1, sell2_x2, sell2_y2 = 470, 525, 550, 555;
  
  --feed
  scrollx, scrolly, scrolltop = 966, 633, 175;
  btn_feedx, btn_feedy = 850, 580;
  btn_foodx, btn_foody = 665, 353;
  btn_xx, btn_xy = 825, 185;
  goldx, goldy = 882, 198;
  epicx, epicy = 53,245;
  
end

function setParamiPhone()
  degree = tonumber(s.degree);--精度
	baitdegree = tonumber(s.baitdegree)
	unidelay = tonumber(s.unidelay)
	castdelay = tonumber(s.castdelay)
	drawdelay = tonumber(s.delay)
	
  --体力0
  zero_c = 0x252525;
  zero_s = "-3|3|0x1e1e1e,-3|11|0x1a1a1a,0|14|0x282727,4|7|0x141414,4|3|0x252525";
  zero_x1, zero_y1, zero_x2, zero_y2 = 915, 270, 930, 295;--第二个好友
  
  --体力图标
  energy_c = 0x4ee260;
  energy_x1, energy_y1, energy_x2, energy_y2 = 860, 270, 885, 300;
  
  --访问按钮
  visit_x1, visit_y1, visit_x2, visit_y2 = 990, 250, 1010, 270;
  
  --钓鱼练习按钮
  practice_c = 0xfefefe;
  practice_s = "-8|4|0xfdfdfd,0|5|0xfdfdfd,8|4|0xfafafa";
  practice_x1, practice_y1, practice_x2, practice_y2 = 370, 500, 405, 525;
  
  --CAST按钮
  cast_c = 0xffffff
  cast_s = "17|-8|0xfdfefe,29|8|0xaabed1,58|-9|0xe5ebf1,76|12|0xffffff";
  cast_x1, cast_y1, cast_x2, cast_y2 = 890, 445, 975, 465;
  
  --确定按钮
  enter_c = 0xf8f8f8;
  enter_s = "15|1|0xffffff,-1|17|0xfafafa,15|17|0x02b0e3";
  enter_x1, enter_y1, enter_x2, enter_y2 = 530,470,555,495;
  enter2_x1, enter2_y1, enter2_x2, enter2_y2 = 675, 465, 720, 500;
  
  --返回好友列表
  list_c = 0xffffff;
  list_s = "13|-10|0xfefefe,40|2|0xffffff,61|-10|0xf7f7f7,80|3|0xfcfcfc,99|-12|0xffffff";
  list_x1, list_y1, list_x2, list_y2 = 340, 570, 450, 590;
  
  --Hit
  hit_c = 0xffffff;
  hit_s = "16|12|0xffffff,25|22|0xffffff,39|0|0xffffff,39|22|0xffffff";
  hit_x1, hit_y1, hit_x2, hit_y2 = 910, 440, 960, 470;
  
  --Bait
  if (s.baitcolor == "0") then
    bait_c = 0xf02f38;
    bait_s = "0|2|0xe9212b,0|4|0xd51c25,-2|2|0xeb2a33,1|2|0xec2029";
  else
    bait_c = 0xefcb50;
    bait_s = "0|-1|0xf9d665,0|1|0xe5bf45,-1|0|0xf1cc53,1|0|0xe5c349"; 
  end
  bait_x1, bait_y1, bait_x2, bait_y2 = 500, 250, 550, 560;

  --三点擦点位
  point1_x, point1_y = 1100,555;
  point2_x, point2_y = 850,500;
  point3_x, point3_y = 1100,450;
  
	--一字擦点位
  pt1_x, pt1_y = 860,463;
  pt2_x, pt2_y = 1111,468;
  pt3_x, pt3_y = 1030,528;
	
  --体力用尽
  exhausted_c = 0xf4be43;
  exhausted_s = "13|8|0xf2bd43,18|15|0xc59b3a,35|9|0xbb9236";
  exhausted_x1, exhausted_y1, exhausted_x2, exhausted_y2 = 430, 120, 480, 155;
  
  --box
  getbox_c = 0xffffff;
  getbox_s = "60|0|0xffffff,30|0|0xffffff";
  getbox_x1, getbox_y1, getbox_x2, getbox_y2 = 390, 225, 460, 235;
  
  --egg
  getegg_c = 0xffffff;
  getegg_s = "60|0|0xffffff,30|0|0xffffff";
  getegg_x1, getegg_y1, getegg_x2, getegg_y2 = 390, 255, 460, 265;
  
  --Continue
  con_c = 0xf3f3f4;
  con_s = "17|-8|0xedeeef,45|6|0xf6f6f7,76|-1|0xeff0f0,102|-1|0xfbfbfb";
  con_x1, con_y1, con_x2, con_y2 = 960, 560, 1085, 595;
  
  --putegg
  putegg_c = 0xd6dcde;
  putegg_s = "18|-14|0xfefefe,47|-1|0xfcfcfc,79|-2|0xe2e8ea,105|-15|0xb1b4b6,144|-3|0xfdfefe";
  putegg_x1, putegg_y1, putegg_x2, putegg_y2 = 335, 465, 495, 500;
  
  --goback
  goback_c = 0xc4f1f0;
  goback_s = "-15|27|0x58c5c3,16|28|0x58c4c2";
  goback_x1, goback_y1, goback_x2, goback_y2 = 1070, 15, 1110, 55;
  
  --yes
  yes_c = 0x07b4ff
  yes_s = "20|-16|0xd8d9d9,21|1|0x9ba1a3,28|-5|0xdfe2e4,46|6|0x01cdff"
  yes_x1, yes_y1, yes_x2, yes_y2 = 390, 470, 440, 495;
  
  --clearup
  clearup_c = 0x07b4ff;
  clearup_s = "24|-7|0xd0d2d3,51|-3|0x066696,81|-4|0xfcfcfc,115|-7|0x838a8e,151|3|0xf2f3f3";
  clearup_x1, clearup_y1, clearup_x2, clearup_y2 = 630, 475, 790, 495;
  
  --Sell
  sell_c = 0x02c6ff
  sell_s = "19|-9|0xf2f2f3,31|1|0xdfe1e2,44|-8|0x0ba2ef,73|-13|0xfafafa,72|0|0x0183a8";
  sell_x1, sell_y1, sell_x2, sell_y2 = 890, 455, 970, 480;
  sell2_x1, sell2_y1, sell2_x2, sell2_y2 = 510, 460, 600, 495;
  
  --feed
  scrollx, scrolly, scrolltop = 1070, 575, 125;
  btn_feedx, btn_feedy = 940, 530;
  btn_foodx, btn_foody = 745,290;
  btn_xx, btn_xy = 915,110;
  goldx, goldy = 980, 125;
  epicx, epicy = 56, 180;
end

function click(x, y)
  if (x == nil or x <= 0) then
    return;
  else
    touchDown(0, x + math.random(10,15), y + math.random(10,15)); 
    mSleep(50 + math.random(20,50));
    touchUp(0, x + math.random(10,15), y + math.random(10,15));
    mSleep(150 + math.random(20,50));
  end
end

init("com.gamevil.fishingsuperstarsfree",1);
r,s=showUI("ui.json");
if (r == 0) then
  lua_exit();
else
  setScreen();
end
ii = 0;
entry();