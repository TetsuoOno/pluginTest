display.setStatusBar( display.HiddenStatusBar )

--広告の呼出し
local AdMob = require ("ads")
----------------------------------------------------------------------
local _W = display.contentWidth
local _H = display.contentHeight

local back = display.newRect(_W/2, _H/2, _W, _H)

--facebook投稿ボタン
local rectF = display.newImageRect("f.png", 100, 100)
rectF.x = _W/2 -75; rectF.y = _H/2

--Twitter投稿ボタン
local rectT = display.newImageRect("t.png", 100, 100)
rectT.x = _W/2 +75; rectT.y = _H/2

--アプリのレーティングボタン
local rectR = display.newImageRect("r.png", 100, 100)
rectR.x = _W/2; rectR.y = _H-100
----------------------------------------------------------------------
--広告の準備
AdMob.init( "admob", "ca-app-pub-0418222484570974/1386350607")
--広告の表示
AdMob.show( "banner", { x= 0, y= 0 } )
--[[
--iAdを利用する場合、4行目の呼出し時の変数名はAdMobではない方が良い
--広告の準備
AdMob.init( "iads", "856044763")
--広告の表示
AdMob.show( "banner", { x= 0, y= 0 } )
--]]
----------------------------------------------------------------------
----------------------------------------------------------------------
--facebookへの投稿
local function onCompleteF()
	--ネイティブ機能を利用したSNSへの投稿
	native.showPopup( "social", optionsF )
end

--写真を選択するfunction
local function pickPhoto( event )
	--写真の選択
	media.selectPhoto( {
		--端末のデフォルトのアルバムへのアクセス
		mediaSource = media.PhotoLibrary,
		--選択が終了時にonCompleteFを呼び出す
		listener = onCompleteF,
		--選択した写真を仮保存
		destination = {baseDir=system.TemporaryDirectory, filename="imageF.jpg", type="image"} 
	} )
	
	--onCompleteFに渡す設定
	optionsF = {
		--facebookを指定
		service = "facebook",
		--デフォルトで書き込んでおくテキスト
		message = "Corona SDK Book Chapter6 Test #CoronaSDK",
		--仮保存したファイルを指定
		image = {filename = "imageF.jpg", baseDir = system.TemporaryDirectory},
		--デフォルトで書き込んでおくURL
		url = {"http://www.calm-design.com"},
	}
end

rectF:addEventListener("tap", pickPhoto )
----------------------------------------------------------------------
----------------------------------------------------------------------
--Twitterへの投稿
local function onCompleteT()
	--ネイティブ機能を利用したTwitterへの投稿
	native.showPopup( "twitter", optionsT )
end

--写真を選択するfunction
local function pickPhoto( event )
	--iOSのみ機能する
	if("iPhone OS" == system.getInfo("platformName") )then
		--写真の選択
		media.selectPhoto( {
			--端末のデフォルトのアルバムへのアクセス
			mediaSource = media.PhotoLibrary,
			--選択が終了時にonCompleteTを呼び出す
			listener = onCompleteT, 
			--選択した写真を仮保存
			destination = {baseDir=system.TemporaryDirectory, filename="imageT.jpg", type="image"} 
		} )
		
		--onCompleteTに渡す設定
		optionsT = {
			--デフォルトで書き込んでおくテキスト
			message = "Corona SDK Book Chapter6 Test #CoronaSDK",
			--仮保存したファイルを指定
			image = {baseDir = system.TemporaryDirectory, filename = "imageT.jpg"},
			--デフォルトで書き込んでおくURL
			url = {"http://www.calm-design.com",},
		}
	end
end

rectT:addEventListener("tap", pickPhoto)
----------------------------------------------------------------------
----------------------------------------------------------------------
--アプリのレーティングfunction
local function rateApp()
	local optionsR
	
	--iOSの場合
	if("iPhone OS" == system.getInfo("platformName") )then
		--アプリのIDを変数に代入
		optionsR = {iOSAppId = "476332662",}
	
	--Androidの場合
	elseif("Android" == system.getInfo("platformName") )then
		--ストアを変数に代入
		optionsR = {supportedAndroidStores = "google",}
	end
	
	--ストアを開く
	native.showPopup( "rateApp", optionsR )
end

rectR:addEventListener("tap", rateApp)
----------------------------------------------------------------------
----------------------------------------------------------------------
