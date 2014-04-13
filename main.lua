display.setStatusBar( display.HiddenStatusBar )

local AdMob = require ("ads")
----------------------------------------------------------------------
local _W = display.contentWidth
local _H = display.contentHeight

local back = display.newRect(_W/2, _H/2, _W, _H)

local rectF = display.newImageRect("f.png", 100, 100)
rectF.x = _W/2 -75; rectF.y = _H/2

local rectT = display.newImageRect("t.png", 100, 100)
rectT.x = _W/2 +75; rectT.y = _H/2

local rectR = display.newImageRect("r.png", 100, 100)
rectR.x = _W/2; rectR.y = _H-100
----------------------------------------------------------------------
AdMob.init( "admob", "ca-app-pub-0418222484570974/4310237006")
AdMob.show( "banner", { x= 0, y= 0 } )
----------------------------------------------------------------------
----------------------------------------------------------------------

local function onCompleteF()
	native.showPopup( "social", optionsF )
end

local function pickPhoto( event )
	media.selectPhoto( {
		mediaSource = media.PhotoLibrary,
		listener = onCompleteF,
		origin = rectF.contentBounds, 
		destination = {baseDir=system.TemporaryDirectory, filename="imageF.jpg", type="image"} 
	} )
	
	optionsF = {
		service = "facebook",
		message = "Corona SDK Book Chapter6 Test #CoronaSDK",
		image = {filename = "imageF.jpg", baseDir = system.TemporaryDirectory},
		url = {"http://www.calm-design.com"},
	}
end

rectF:addEventListener("tap", pickPhoto )
----------------------------------------------------------------------
----------------------------------------------------------------------

local function onCompleteT()
	native.showPopup( "twitter", optionsT )
end

local function pickPhoto( event )
	media.selectPhoto( {
		mediaSource = media.PhotoLibrary,
		listener = onCompleteT, 
		origin = rectT.contentBounds, 
		destination = {baseDir=system.TemporaryDirectory, filename="imageT.jpg", type="image"} 
	} )
	
	optionsT = {
		message = "Corona SDK Book Chapter6 Test #CoronaSDK",
		image = {baseDir = system.TemporaryDirectory, filename = "imageT.jpg"},
		url = {"http://www.calm-design.com",},
	}
	
end

rectT:addEventListener("tap", pickPhoto)
----------------------------------------------------------------------
----------------------------------------------------------------------
local function rateApp()
	local optionsR
	
	if("iPhone OS" == system.getInfo("platformName") )then
		optionsR = {iOSAppId = "476332662",}
	elseif("Android" == system.getInfo("platformName") )then
		optionsR = {supportedAndroidStores = "google",}
	end
	
	native.showPopup( "rateApp", optionsR )
end

rectR:addEventListener("tap", rateApp)
----------------------------------------------------------------------
----------------------------------------------------------------------
