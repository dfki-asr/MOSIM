yml files for starting containers of the MOSIM Framework.

CoSimulation.yml
	Starts remote co-simulation.
	Usually not needed when Unity is the target engine. In this case co-simulation is usually part of Unity.


CSharpServices.yml
	Starts up all available CSharp Services.
	For now:
		CoordinateSystemMapper
		PostureBlending
		Retargeting
		SkeletonAccess
	
CSharpAdapter.yml
	Stars up CSharp Adapter.
	Unfortunately, for now the CSharp Adapter does not like to be started in a yml file together with other components/service. It seems to be a wired problem Docker with Thrift or the otherway around.

Launcher.yml
	Starts up the MOSIM Console Launcher.
	The MOSIM Launcher (either the MMI-Launcher or the Console Launcher) needs to be started FIRST(!). All other MOSIM services/components want to connect and find each other via the Launcher.
	The MMI Launcher also starts services/components which it finds in its environment. However, for the Console Launcher in Docker this does not make sense.

Unity.yml
	Starts ALL Unity components.
	For now: Unity Adapter and Unity IK as well as Unity Path Planning Service .
