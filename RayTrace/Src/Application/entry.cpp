#include <stdexcept>
#include <cstdlib>

#include "application.h"

int main()
{
	// Application settings
	ApplicationCreateInfo settings{};
	settings.windowWidth    = 800;
	settings.windowHeight   = 800;
	settings.framesInFlight = 2;

	// Initialize application
	Application app;
	app.init(settings);

	// Run application
	try
	{
		app.run();
	}
	catch (const std::exception& e)
	{
		std::cerr << e.what() << std::endl;
		return EXIT_FAILURE;
	}

	return EXIT_SUCCESS;
}