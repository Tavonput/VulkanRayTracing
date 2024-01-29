#pragma once

#include "logging.h"
#include "context.h"

#include "Core/swapchain.h"
#include "Core/render_pass.h"

struct ApplicationCreateInfo
{
	uint32_t windowHeight = 800;
	uint32_t windowWidth  = 800;

	uint32_t framesInFlight = 2;
};

class Application
{
public:
	void init(ApplicationCreateInfo& createInfo);

	void run();

private:
	Logger  m_logger;

	Context m_context;

	// Rendering
	Swapchain           m_swapchain;
	RenderPass::Manager m_renderPassManager;

	void createRenderPass();

	void cleanup();
};

