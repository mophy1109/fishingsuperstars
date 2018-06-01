function entry()
	finish();
	while (true) do
		fix();
		for i = 1, 5 do
			cast();
			draw();--浮标消失，上钩
			finish();
		end
	end
end

function entryEndless()
	finishEndless();
	while (true) do
		fix();
		for i = 1, 5 do
			cast();
			draw();--浮标消失，上钩
			finishEndless();
		end
	end
end

function entryManual()
	while (true) do
		easydraw();--浮标消失，上钩
	end
end

function fix()
	local x1, y1 = -1,-1;
	x1, y1 = findMultiColorInRegionFuzzy(fix_c, fix_s, 90, fix_x1, fix_y1, fix_x2, fix_y2);
	if (x1 ~= -1) then
		click(x1, y1);
		local x2, y2;
		x2, y2 = findMultiColorInRegionFuzzy(fixall_c, fixall_s, degree, fixall_x1, fixall_y1, fixall_x2, fixall_y2);
		while (x2 == -1) do
			mSleep(unidelay)
			keepScreen(true)
			x2, y2 = findMultiColorInRegionFuzzy(fixall_c, fixall_s, degree, fixall_x1, fixall_y1, fixall_x2, fixall_y2);
			keepScreen(false)
		end
		click(x2, y2);
		local x3, y3;
		x3, y3 = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter_x1, enter_y1, enter_x2, enter_y2);
		while (x3 == -1) do
			mSleep(unidelay)
			keepScreen(true)
			x3, y3 = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter_x1, enter_y1, enter_x2, enter_y2);
			keepScreen(false)
		end
		mSleep(200)
		click(x3, y3);
		mSleep(200);
	end
end

function cast()
	local x1, y1 = -1, -1;
	x1, y1 = findMultiColorInRegionFuzzy(cast_c, cast_s, degree, cast_x1, cast_y1, cast_x2, cast_y2);
	mSleep(castdelay);
	click(x1, y1);
	local x, y = findMultiColorInRegionFuzzy(hit_c, hit_s, degree, hit_x1, hit_y1, hit_x2, hit_y2);
	while (x == -1 and y == -1) do
		mSleep(unidelay)
		keepScreen(true)
		x, y = findMultiColorInRegionFuzzy(hit_c, hit_s, degree, hit_x1, hit_y1, hit_x2, hit_y2);
		keepScreen(false)
	end
	mSleep(finddelay);
	local countbait = 0;
	local x2, y2 = -1, -1;
	while (x2 == -1 and countbait <= baitcount) do
		mSleep(200)
		x2, y2 = findMultiColorInRegionFuzzy(bait_c, bait_s, baitdegree, bait_x1, bait_y1, bait_x2, bait_y2);
		countbait = countbait + 1;
	end
	countbait = 0;
	local xt, yt = x2, y2;
	while (x2 ~= -1 and y2 ~= -1 and countbait <= baitcount) do--浮标存在
		mSleep(200)
		x2, y2 = findMultiColorInRegionFuzzy(bait_c, bait_s, baitdegree, xt-7, yt-7, xt+7, yt+7);
		countbait = countbait + 1;
	end
end

function draw()
	local x, y = findMultiColorInRegionFuzzy(hit_c, hit_s, degree, hit_x1, hit_y1, hit_x2, hit_y2);
	while (x == -1 and y == -1) do
		mSleep(unidelay);
		keepScreen(true)
		x, y = findMultiColorInRegionFuzzy(hit_c, hit_s, degree, hit_x1, hit_y1, hit_x2, hit_y2);
		keepScreen(false)
	end
	mSleep(20);
	touchDown(0, x+5, y+5);
	mSleep(40 + math.random(20,50));
	touchUp(0, x+5, y+5);
	forcedrag();
	local x1 = -1;
	
	if (s.caca == "0") then
		while (x1 ~= 0x000000) do
			for ti = 1, 25 do
				two();
			end
			x1, y1 = getColor(25, 25);
		end
	else
		while (x1 ~= 0x000000) do
			for ti = 1, 25 do
				three();
			end
			x1, y1 = getColor(25, 25);
		end
	end
end

function easydraw()
	local x, y = findMultiColorInRegionFuzzy(hit_c, hit_s, degree, hit_x1, hit_y1, hit_x2, hit_y2);
	--findhit
	while (x == -1 and y == -1) do
		mSleep(unidelay);
		keepScreen(true)
		x, y = findMultiColorInRegionFuzzy(hit_c, hit_s, degree, hit_x1, hit_y1, hit_x2, hit_y2);
		keepScreen(false)
	end
	
	while (x ~= -1 and y ~= -1) do
		mSleep(unidelay);
		keepScreen(true)
		x, y = findMultiColorInRegionFuzzy(hit_c, hit_s, degree, hit_x1, hit_y1, hit_x2, hit_y2);
		keepScreen(false)
	end
	mSleep(20);
	forcedrag();
	local x1 = -1;
	if (s.caca == "0") then
		while (x1 ~= 0x000000) do
			for ti = 1, 50 do
				two();
			end
			x1, y1 = getColor(25, 25);
		end
	else
		while (x1 ~= 0x000000) do
			for ti = 1, 50 do
				three();
			end
			x1, y1 = getColor(25, 25);
		end
	end
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

function two()
	mSleep(drawdelay);
	touchDown(0,pt1_x + math.random(-5,5), pt1_y + math.random(-5,5));
	touchMove(0,pt2_x + math.random(-5,5), pt2_y + math.random(-5,5));
	mSleep(28)
	touchMove(0,pt3_x + math.random(-5,5), pt3_y + math.random(-5,5));
	mSleep(28)
	touchUp(0,pt3_x + math.random(-5,5), pt3_y + math.random(-5,5));
end

function forcedrag()
	touchDown(0,f_x1 + math.random(-5,5),f_y1 + math.random(-5,5));
	mSleep(15);
	touchMove(0,f_x2 + math.random(-5,5),f_y2 + math.random(-5,5));
	mSleep(15);
	touchMove(0,f_x3 + math.random(-5,5),f_y3 + math.random(-5,5));
	mSleep(15);
	touchMove(0,f_x4 + math.random(-5,5),f_y4 + math.random(-5,5));
	mSleep(15);
	touchMove(0,f_x5 + math.random(-5,5),f_y5 + math.random(-5,5));
	mSleep(15);
	touchMove(0,f_x6 + math.random(-5,5),f_y6 + math.random(-5,5));
	mSleep(15);
	touchUp(0,f_x6 + math.random(-5,5),f_y6 + math.random(-5,5));
end

function finish()
	local x, y;
	x, y = findMultiColorInRegionFuzzy(cast_c, cast_s, degree, cast_x1, cast_y1, cast_x2, cast_y2);
	gx = {-1};
	gy = {-1};
	while (x == -1) do
		mSleep(unidelay)
		keepScreen(true);
		gx[1], gy[1] = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, buff_x1, buff_y1, buff_x2, buff_y2);
		gx[2], gy[2] = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter_x1, enter_y1, enter_x2, enter_y2);
		gx[3], gy[3] = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter3_x1, enter3_y1, enter3_x2, enter3_y2);
		gx[4], gy[4] = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter4_x1, enter4_y1, enter4_x2, enter4_y2);
		gx[5], gy[5] = findMultiColorInRegionFuzzy(showoff_c, showoff_s, degree, showoff_x1, showoff_y1, showoff_x2, showoff_y2);
		gx[6], gy[6] = findMultiColorInRegionFuzzy(showoff_c, showoff_s, degree, showoff2_x1, showoff2_y1, showoff2_x2, showoff2_y2);
		gx[7], gy[7] = findMultiColorInRegionFuzzy(showoff_c, showoff_s, degree, showoff3_x1, showoff3_y1, showoff3_x2, showoff3_y2);
		gx[8], gy[8] = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter2_x1, enter2_y1, enter2_x2, enter2_y2);
		gx[9], gy[9] = findMultiColorInRegionFuzzy(book_c, book_s, degree, book_x1, book_y1, book_x2, book_y2);
		gx[10], gy[10] = findMultiColorInRegionFuzzy(book_c, book_s, degree, book2_x1, book2_y1, book2_x2, book2_y2);    
		gx[11], gy[11] = findMultiColorInRegionFuzzy(energy_c, energy_s, degree, energy_x1, energy_y1, energy_x2, energy_y2);
		gx[12], gy[12] = findMultiColorInRegionFuzzy(con_c, con_s, degree, con_x1, con_y1, con_x2, con_y2);--继续钓鱼
		gx[13], gy[13] = findMultiColorInRegionFuzzy(setfree_c, setfree_s, degree, setfree_x1, setfree_y1, setfree_x2, setfree_y2);
		gx[14], gy[14] = findMultiColorInRegionFuzzy(sell_c, sell_s, degree, sell_x1, sell_y1, sell_x2, sell_y2);
		gx[15], gy[15] = findMultiColorInRegionFuzzy(quest_c, quest_s, degree, quest_x1, quest_y1, quest_x2, quest_y2);
		keepScreen(false);
		for case = 1 , #gx do
			if gx[case] ~= -1 then
				--toast(case)
				if case == 13 then
					if gofree == 1 then
						click(gx[case], gy[case]);
						mSleep(200)
						click(420,480)
					end
				end
				if case == 14 then
					xt, yt = findColorInRegionFuzzy(name_red, 95, namecolor_x1, namecolor_y1, namecolor_x2, namecolor_y2);--小王
					xa, ya = findColorInRegionFuzzy(name_purple, 95, namecolor_x1, namecolor_y1, namecolor_x2, namecolor_y2);--大王
					xs, ys = findColorInRegionFuzzy(name_gold, 99, namecolor_x1, namecolor_y1, namecolor_x2, namecolor_y2);--史诗
					if (xt ~= -1 and s.putred == "0") or (xa ~= -1 and s.putpurple == "0") or xs ~= -1 then
						click(putin_x,putin_y);
					else
						click(gx[case], gy[case]);
					end
				elseif case ~= 11 then
					click(gx[case], gy[case]);
				else
					if s.energy == "0" then
						click(gx[case], gy[case]);
					end
				end
				--sysLog(case);
			end
		end
		--重新找cast按钮
		x, y = findMultiColorInRegionFuzzy(cast_c, cast_s, degree, cast_x1, cast_y1, cast_x2, cast_y2);
	end
end


function finishEndless()
	local x, y;
	x, y = findMultiColorInRegionFuzzy(cast_c, cast_s, degree, cast_x1, cast_y1, cast_x2, cast_y2);
	gx = {-1};
	gy = {-1};
	while (x == -1) do
		mSleep(unidelay)
		keepScreen(true);
		gx[1], gy[1] = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, buff_x1, buff_y1, buff_x2, buff_y2);
		gx[2], gy[2] = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter_x1, enter_y1, enter_x2, enter_y2);
		gx[3], gy[3] = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter4_x1, enter4_y1, enter4_x2, enter4_y2);
		gx[4], gy[4] = findMultiColorInRegionFuzzy(enter_c, enter_s, degree, enter2_x1, enter2_y1, enter2_x2, enter2_y2);
		gx[5], gy[5] = findMultiColorInRegionFuzzy(start_c, start_s, degree, start_x1, start_y1, start_x2, start_y2);
		gx[6], gy[6] = findMultiColorInRegionFuzzy(equip_c, equip_s, degree, equip_x1, equip_y1, equip_x2, equip_y2);
		gx[7], gy[7] = findMultiColorInRegionFuzzy(getrwd_c, getrwd_s, degree, getrwd_x1, getrwd_y1, getrwd_x2, getrwd_y2);
		gx[8], gy[8] = findMultiColorInRegionFuzzy(prepare_c, prepare_s, degree, prepare_x1, prepare_y1, prepare_x2, prepare_y2);
		gx[9], gy[9] = findMultiColorInRegionFuzzy(gonext_c, gonext_s, degree, gonext_x1, gonext_y1, gonext_x2, gonext_y2);--继续钓鱼
		gx[10], gy[10] = findMultiColorInRegionFuzzy(goback_c, goback_s,degree, goback_x1, goback_y1, goback_x2, goback_y2);
		gx[11], gy[11] = findMultiColorInRegionFuzzy(energy_c, energy_s, degree, energy_x1, energy_y1, energy_x2, energy_y2);    
		keepScreen(false);
		for case = 1, #gx do
			if gx[case] ~= -1 then
				if case ~= 7 then
					click(gx[case], gy[case]);
				else
					if s.energy == "0" then
						click(gx[case], gy[case]);
					end
				end
				--sysLog(case);
			end
		end
		--重新找cast按钮
		x, y = findMultiColorInRegionFuzzy(cast_c, cast_s, degree, cast_x1, cast_y1, cast_x2, cast_y2);
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
	degree = tonumber(s.degree)
	unidelay = tonumber(s.unidelay)
	castdelay = tonumber(s.castdelay)
	finddelay = tonumber(s.finddelay)
	baitcount = tonumber(s.baitcount)
	baitdegree = tonumber(s.baitdegree)
	drawdelay = tonumber(s.delay)
	gofree = tonumber(s.gofree)
	
	
	--CAST按钮
	cast_c = 0xffffff;
	cast_s = "10|-6|0x4997e4,28|-11|0xd3dee8,50|6|0xfdfdfd,68|-15|0xffffff";
	cast_x1, cast_y1, cast_x2, cast_y2 = 800, 580, 890, 610;
	
	--确定按钮
	enter_c = 0xeaebeb;
	enter_s = "14|-7|0xffffff,35|-5|0x0ca3f0,49|-7|0xf3f3f4,59|-4|0xfafaf9";
	enter_x1, enter_y1, enter_x2, enter_y2 = 475, 535, 545, 550;--middle enter
	enter2_x1, enter2_y1, enter2_x2, enter2_y2 = 605, 525, 695, 555;--right enter
	enter3_x1, enter3_y1, enter3_x2, enter3_y2 = 813,627,841,653;--quest
	enter4_x1, enter4_y1, enter4_x2, enter4_y2 = 475, 568, 503, 593;--levelup
	buff_x1, buff_y1, buff_x2, buff_y2 = 475,605,505,635;--buff
	
	--Hit
	hit_c = 0xfeffff;
	hit_s = "15|-8|0xfbfbfc,29|-5|0x1f64a8,37|-16|0xeff3f7";
	hit_x1, hit_y1, hit_x2, hit_y2 = 810,570,875,610;
	
	--Bait
	if (s.baitcolor == "0") then
		bait_c = 0xe8434b;
		bait_s = "0|-1|0xea5058,-1|0|0xee414a,0|1|0xeb333c,1|0|0xea3e45";
	else
		bait_c = 0xefcb50;
		bait_s = "0|-1|0xf9d665,0|1|0xe5bf45,-1|0|0xf1cc53,1|0|0xe5c349"; 
	end
	bait_x1, bait_y1, bait_x2, bait_y2 = 460, 350, 490, 625;
	if (s.range == "1") then
		bait_y1 = bait_y1 + 100;
		bait_y2 = bait_y2 + 100;
		--toast(bait_y2);
	end
	
	--Continue
	con_c = 0xeaebec;
	con_s = "14|-14|0xf4f5f5,37|-10|0xcbcccf,66|-4|0x00a1fd,93|-13|0xfaf9fa";
	con_x1, con_y1, con_x2, con_y2 = 865, 615, 980, 650;
	
	--force
	f_x1,f_y1,f_x2,f_y2,f_x3,f_y3 = 830,630,860,580,920,585;
	f_x4,f_y4,f_x5,f_y5,f_x6,f_y6 = 945,635,915,680,860,680;
	
	--三点擦点位
	point1_x, point1_y = 1000,662;
	point2_x, point2_y = 760,635;
	point3_x, point3_y = 1000,605;
	
	--一字擦点位
	pt1_x, pt1_y = 762,612;
	pt2_x, pt2_y = 1020,610;
	pt3_x, pt3_y = 942,638;
	
	--Sell
	sell_c = 0x049edf;
	sell_s = "6|-5|0xf4f5f5,10|-10|0x1170ae,28|-2|0x08acfb,54|-8|0xf6f7f7";
	sell_x1, sell_y1, sell_x2, sell_y2 = 685, 615, 960, 645;
	
	--Showoff
	showoff_c = 0xf5f5f5;
	showoff_s = "0|14|0xfdfdfd,4|13|0x048ac1,11|3|0xf4f4f4,9|18|0xe8e9e9";
	showoff_x1, showoff_y1, showoff_x2, showoff_y2 = 475,530,500,555;
	
	showoff2_x1, showoff2_y1, showoff2_x2, showoff2_y2 = 380, 470, 395, 495;
	showoff3_x1, showoff3_y1, showoff3_x2, showoff3_y2 = 511, 466, 574, 502;
	
	--UseEnergy
	energy_c = 0xe9eaeb;
	energy_s = "0|14|0xf0f2f2,4|13|0x0293c6,12|4|0xf9fafa,16|12|0x027eb0";
	energy_x1, energy_y1, energy_x2, energy_y2 = 615, 540, 640, 565;
	
	--Book
	book_c = 0x131313;
	book_s = "20|0|0x131313";
	book_x1, book_y1, book_x2, book_y2 = 915, 173, 940, 175;
	book2_x1, book2_y1, book2_x2, book2_y2 = 815, 135, 835, 140;
	
	--Fix
	fix_c = 0xffffff;
	fix_s = "10|7|0xffffff,-2|17|0xffffff";
	fix_x1, fix_y1, fix_x2, fix_y2 = 40, 190, 60, 215;
	
	--Fixall
	fixall_c = 0xededee;
	fixall_s = "0|4|0x11466c,-8|6|0xfcfdfc,-6|11|0x06689c,0|15|0xf9fafa";
	fixall_x1, fixall_y1, fixall_x2, fixall_y2 = 318, 527, 337, 547;
	
	--quest
	quest_c = 0xfefefe;
	quest_s = "8|0|0xf4f4f4,4|6|0x01121b,0|11|0xfefefe,4|11|0x011f2c";
	quest_x1, quest_y1, quest_x2, quest_y2 = 910, 571, 925, 595;
	
	--namecolor
	name_red = 0xFE2300;
	name_purple = 0xBE60F7;
	name_gold = 0xa49928;
	namecolor_x1, namecolor_y1, namecolor_x2, namecolor_y2 = 665, 190, 915, 230;
	
	--putintank
	putin_x, putin_y = 740, 630;
	
	--startEndless
	start_c = 0xf46306
	start_s = "6|-10|0xfda400,14|0|0xf46808"
	start_x1, start_y1, start_x2, start_y2 = 795,595,842,640
	
	--equip
	equip_c = 0x9fa2a2
	equip_s = "12|13|0xbcbfc1,31|7|0x0e8acf,54|4|0xcccecf"
	equip_x1, equip_y1, equip_x2, equip_y2 = 854, 301, 958, 357
	
	--gonext
	gonext_c = 	0xffffff
	gonext_s = "28|11|0x009aff,54|-3|0xf7f8f7,83|4|0xfbfbfc"
	gonext_x1, gonext_y1, gonext_x2, gonext_y2 = 862, 607, 986, 653
	
	--getreward
	getrwd_c = 0xcfd1d2
	getrwd_s = "36|0|0x3a5f85,69|3|0x055eac,78|6|0x8a9094"
	getrwd_x1, getrwd_y1, getrwd_x2, getrwd_y2 = 	858, 600, 987, 654
	
	--goback
	goback_c = 	0xbfc3c7
	goback_s = "9|7|0x454c50,20|-4|0x0087ff,45|-5|0xececed"
	goback_x1, goback_y1, goback_x2, goback_y2 = 	875, 611, 969, 653
	
	--prepare
	prepare_c = 0xf08800
	prepare_s = "22|-10|0xf8f3f0,51|6|0x856632"
	prepare_x1, prepare_y1, prepare_x2, prepare_y2 = 763, 559, 915, 602
	
	--setfree
	setfree_c = 0
	setfree_s = 0
	setfree_x1, setfree_y1, setfree_x2, setfree_y2 = 0,0,0,0
end

function setParamiPhone()
	degree = tonumber(s.degree)
	unidelay = tonumber(s.unidelay)
	castdelay = tonumber(s.castdelay)
	finddelay = tonumber(s.finddelay)
	baitcount = tonumber(s.baitcount)
	baitdegree =  tonumber(s.baitdegree)
	drawdelay = tonumber(s.delay)
	gofree = tonumber(s.gofree)
	
	--CAST按钮
	cast_c = 0xffffff
	cast_s = "17|-8|0xfdfefe,29|8|0xaabed1,58|-9|0xe5ebf1,76|12|0xffffff";
	cast_x1, cast_y1, cast_x2, cast_y2 = 890, 445, 975, 465;
	
	--确定按钮
	enter_c = 0xf8f8f8;
	enter_s = "15|1|0xffffff,-1|17|0xfafafa,15|17|0x02b0e3";
	enter_x1, enter_y1, enter_x2, enter_y2 = 530, 470, 555, 495;--middle enter
	enter2_x1, enter2_y1, enter2_x2, enter2_y2 = 675, 465, 720, 500;--right enter
	enter3_x1, enter3_y1, enter3_x2, enter3_y2 = 900, 570, 930, 600;--quest
	enter4_x1, enter4_y1, enter4_x2, enter4_y2 = 527,510,557,538;--levelup
	buff_x1, buff_y1, buff_x2, buff_y2 = 526, 552, 557, 581;
	
	--Hit
	hit_c = 0xffffff;
	hit_s = "16|12|0xffffff,25|22|0xffffff,39|0|0xffffff,39|22|0xffffff";
	hit_x1, hit_y1, hit_x2, hit_y2 = 910, 440, 960, 470;
	
	--Bait
	if (s.baitcolor == "0") then
		bait_c = 0xe8434b;
		bait_s = "0|-1|0xea5058,-1|0|0xee414a,0|1|0xeb333c,1|0|0xea3e45";
	else
		bait_c = 0xefcb50;
		bait_s = "0|-1|0xf9d665,0|1|0xe5bf45,-1|0|0xf1cc53,1|0|0xe5c349"; 
	end
	bait_x1, bait_y1, bait_x2, bait_y2 = 500, 250, 550, 560;
	if (s.range == "1") then
		bait_y1 = bait_y1 + 80;
		bait_y2 = bait_y2 + 80;
		--toast(s.range);
	end
	
	--Continue
	con_c = 0xf3f3f4;
	con_s = "17|-8|0xedeeef,45|6|0xf6f6f7,76|-1|0xeff0f0,102|-1|0xfbfbfb";
	con_x1, con_y1, con_x2, con_y2 = 960, 560, 1085, 595;
	
	--force
	f_x1,f_y1,f_x2,f_y2,f_x3,f_y3 = 980,387,1093,443,1079,569;
	f_x4,f_y4,f_x5,f_y5,f_x6,f_y6 = 982,605,889,567,877,449;
	
	--三点擦点位
	point1_x, point1_y = 1100,555;
	point2_x, point2_y = 850,500;
	point3_x, point3_y = 1100,450;
	
	--一字擦点位
	pt1_x, pt1_y = 860,463;
	pt2_x, pt2_y = 1111,468;
	pt3_x, pt3_y = 1030,528;
	
	--Sell
	sell_c = 0xcfd3d5;
	sell_s = "12|0|0xcdd7dc,37|0|0x00a4ff,61|1|0xe8edf0";
	sell_x1, sell_y1, sell_x2, sell_y2 = 990, 585, 1055, 590;
	
	--Showoff
	showoff_c = 0xfeffff;
	showoff_s = "-1|16|0xffffff,11|3|0xffffff,5|15|0x0484b7";
	showoff_x1, showoff_y1, showoff_x2, showoff_y2 = 680, 470, 705, 495
	showoff2_x1, showoff2_y1, showoff2_x2, showoff2_y2 = 380, 470, 395, 495;
	showoff3_x1, showoff3_y1, showoff3_x2, showoff3_y2 = 511, 466, 574, 502;
	
	--UseEnergy
	energy_c = 0xf8f8f8;
	energy_s = "-2|3|0xf4f5f5,-5|8|0xf0f0f1,-2|11|0xf6f6f6,-2|19|0xf6f6f7,11|0|0xe6e7e8,11|11|0xfafbfb,5|21|0xffffff"
	energy_x1, energy_y1, energy_x2, energy_y2 = 680, 480, 705, 510;
	
	--Book
	book_c = 0x131313;
	book_s = "20|0|0x131313";
	book_x1, book_y1, book_x2, book_y2 = 1020, 82, 1040, 83;
	book2_x1, book2_y1, book2_x2, book2_y2 = 905, 81, 930, 83;
	
	--Fix
	fix_c = 0xffffff;
	fix_s = "10|7|0xffffff,-2|17|0xffffff";
	fix_x1, fix_y1, fix_x2, fix_y2 = 40, 190, 60, 215;
	
	--Fixall
	fixall_c = 0xf8f8f9;
	fixall_s = "-1|10|0xe9eaeb,-1|19|0xe9ebeb,13|7|0xffffff,13|20|0xe1e2e3";
	fixall_x1, fixall_y1, fixall_x2, fixall_y2 = 415, 470, 435, 495;
	
	--quest
	quest_c = 0xfefefe;
	quest_s = "8|0|0xf4f4f4,4|6|0x01121b,0|11|0xfefefe,4|11|0x011f2c";
	quest_x1, quest_y1, quest_x2, quest_y2 = 910, 571, 925, 595;
	
	--namecolor
	name_red = 0xFE2300;
	name_purple = 0xBE60F7;
	name_gold = 0xa49928;
	namecolor_x1, namecolor_y1, namecolor_x2, namecolor_y2 = 770, 120, 880, 165;
	
	--putintank
	putin_x, putin_y = 825,580;
	
	--	startEndless
	start_c = 0xb56700
	start_s = "10|5|0xfc991a,12|-3|0x693100"
	start_x1, start_y1, start_x2, start_y2 = 887, 546, 930, 584	
	--	equip
	equip_c = 0xfdfdfd
	equip_s = "1|4|0x9fa2a4,7|1|0x7c888f"
	equip_x1, equip_y1, equip_x2, equip_y2 = 	961, 250, 1003, 280	
	--	gonext
	gonext_c = 0xffffff
	gonext_s = "9|8|0x005da9,29|5|0xaebcc8,61|5|0xf9f9f9,77|14|0x0097e9"
	gonext_x1, gonext_y1, gonext_x2, gonext_y2 = 	954, 551, 1091, 602	
	
	--  getreward
	getrwd_c = 0x989b9f
	getrwd_s = "12|10|0x9ea2a6,43|4|0x73899d,61|10|0xdee1e2,90|3|0xfbfcfc"
	getrwd_x1, getrwd_y1, getrwd_x2, getrwd_y2 = 	958, 555, 1089, 598
	
	--	goback
	goback_c = 0x9ab0c9
	goback_s = "13|9|0xd0d2d4,31|14|0x0099ff,54|9|0x172c3d"
	goback_x1, goback_y1, goback_x2, goback_y2 = 	968, 557, 1077, 604
	
	--	prepare
	prepare_c = 0x692f03
	prepare_s = "26|2|0xdeccbd,55|1|0xfaf7f4,71|2|0xefe6de,110|10|0xd8c8b2"
	prepare_x1, prepare_y1, prepare_x2, prepare_y2 = 	855, 503, 1010, 550
	
	--setfree
	setfree_c = 0xe8f3f9
	setfree_s = "7|-17|0xd5c9d3,17|-8|0x0090ff,44|-15|0xe3f0e9,62|3|0x6f9fb5"
	setfree_x1, setfree_y1, setfree_x2, setfree_y2 = 582, 553, 673, 600
	
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
r,s = showUI("ui.json");
if (r == 0) then
	lua_exit();
else
	setScreen();
end

if (s.mode == "0") then
	entry();
elseif(s.mode == "1") then
	entryEndless()
else
	entryManual()
end