-- BLENDCONVERT - November 2018
-- Felix Caffier

--------------------------------------------------------------------------------

function onMainViewUpdateMenuFile ( hView, hMenu )

end

function onRefreshUI ( hView, hMenu )
	
	log.message ( "Refreshing BlendConvert module lists..." )
	refreshTargetList ( )

end

--------------------------------------------------------------------------------

function onWebLicenseBlender ( hView, hMenu )

    log.message ( "Visiting Blender website for license information..." )
    system.openURL( "www.blender.org/about/license/" )

end

function onWebShotIris ( hView, hMenu )

    log.message ( "Visiting ShotIris website..." )
    system.openURL( "portfolio.shotiris.net" )

end

function onWebTris ( hView, hMenu )

    log.message ( "Visiting trisymphony website..." )
    system.openURL( "www.trisymphony.com" )

end
