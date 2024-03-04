-- Solution
workspace "RayTrace"
	architecture "x64"
	startproject "RayTrace"

	configurations 
	{
		"Debug",   -- Full debugging
		"Release", -- No debugging but logging is still on. Optimization turned on
		"Dist"     -- No debugging or logging. Optimization turned on
	}

	-- Enable multi-processing for compilation
	flags "MultiProcessorCompile"

-- This is for the output directory. Should look something like "Debug-x86_64"
outputdir = "%{cfg.buildcfg}-%{cfg.architecture}"

-- Dependencies
group "Dependencies"
	include "Vendor/ImGui"
group ""

-- Project
project "RayTrace"
	location "RayTrace"
	kind "ConsoleApp"
	language "C++"

	-- Executable and intermediate objs
	targetdir ( "Bin/" .. outputdir .. "/%{prj.name}" )
	objdir ( "Bin/" .. outputdir .. "/%{prj.name}/Intermediate" )

	-- Source files
	files
	{
		"%{prj.name}/Src/**.h",
		"%{prj.name}/Src/**.cpp",
		"%{prj.name}/Src/**.vert",
		"%{prj.name}/Src/**.frag",
		"%{prj.name}/Src/**.glsl"
	}

	-- Include directories
	includedirs
	{
		"%{prj.name}/Src",
		"%{prj.name}/Src/Utils",
		"Vendor/VulkanSDK/*/Include",
		"Vendor/GLFW/include",
		"Vendor/GLM",
		"Vendor/spdlog/include",
		"Vendor/tinyobjloader",
		"Vendor/ImGui/Include",
		"Vendor/NRD/Include",
		"Vendor/stbimage"
	}

	-- Libraries
	libdirs
	{
		"Vendor/VulkanSDK/*/Lib",
		"Vendor/GLFW/lib-vc2022",
		"Bin/%{cfg.buildcfg}-%{cfg.architecture}/ImGui"
	}

	links
	{
		"glfw3",
		"vulkan-1",
		"ImGui"
	}

	-- PCH
	pchheader "pch.h"
	pchsource "%{prj.name}/Src/Utils/pch.cpp"

	-- Windows
	filter "system:windows"
		cppdialect "C++20"
		systemversion "latest"

		-- Set the debugging working directory the same as the executable
		debugdir ( "Bin/" .. outputdir .. "/%{prj.name}" )

		-- Warning C4996 is on unsafe or depricated code.
		-- spdlog throws a bunch of these warnings and it clogs up the build output.
		-- For now, this warning will be disabled.
		disablewarnings "4996"

	-- Debug
	filter "configurations:Debug"
		defines "RT_DEBUG"
		symbols "On"

	-- Release
	filter "configurations:Release"
		defines "RT_RELEASE"
		optimize "On"

	-- Dist
	filter "configurations:Dist"
		defines "RT_DIST"
		optimize "On"