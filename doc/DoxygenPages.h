/**
 * @file  DoxygenPages.h
 * @brief Documentation of main page, other pages, and modules.
 *
 * This file is used to define the groups used by Doxygen to generate the
 * Modules pages and to specify the content of the main page of the
 * documentation generated by Doxygen including other related pages.
 *
 * Copyright (c) 2011 University of Pennsylvania. All rights reserved.
 * See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.
 *
 * Contact: SBIA Group <sbia-software at uphs.upenn.edu>
 */

// ===========================================================================
// main page
// ===========================================================================

// ***************************************************************************
/**
@mainpage

This is the main page of the automatically generated API documentation of
the Build system And Software Implementation Standard (BASIS) project.
The BASIS project was started early in 2011 in order to improve and
standardize the software packages developed at SBIA. Based on the decision
to use <a href="http://www.cmake.org">CMake</a> and its accompanying tools
for testing and packaging software, the standard for building software
from source code was based on this popular, easy to use, and yet powerful
cross-platform, open-source build system. The previously known
<a href="https://sbia-svn.uphs.upenn.edu/projects/Development_Project_Templates/CMakeProjectTemplate/">CMake Project Template</a>
was entirely reworked and became a major component of BASIS.
In fact, the BASIS project evolved from this initial project template
and greatly improved it. See page @ref ProjectTemplate
"Software Project Template" for a description of the template.

Projects following the standard include the BASIS modules and are hence
dependent on the BASIS package, similarly to a software implemented in
C++ depending on third-party libraries used by this implementation, for
example. Therefore, in order to be able to build a BASIS project,
the BASIS package has to be installed. Note, however, that BASIS is not
required during the runtime, i.e., for executing the software.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>
*/

// ===========================================================================
// other pages
// ===========================================================================

// ***************************************************************************
/**
@page BuildSystemStandard Build System Standard

@todo This page has to be written yet.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>
*/

// ***************************************************************************
/**
@page ProjectTemplate Software Project Template

@todo This page has to be written yet.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>
*/

/**
@page Links Links

- <a href="https://sbia-wiki.uphs.upenn.edu/wiki/index.php/BASIS">Project Wiki</a> - The main Wiki page.
- <a href="https://sbia-portal.uphs.upenn.edu/cdash/index.php?project=BASIS">Dashboard</a> - The CDash testing dashboard.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>
*/

// ===========================================================================
// groups
// ===========================================================================

// ---------------------------------------------------------------------------
// CMake Modules
// ---------------------------------------------------------------------------

// ***************************************************************************
/**
@defgroup CMakeModules CMake Modules
@brief    CMake Modules.

The BASIS package in particular provides CMake implementations which
standardize the build system and support the developer of a project in
setting up a software development project.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>
*/

// ***************************************************************************
/**
@defgroup CMakeAPI Public CMake Interface
@brief    Public interface of CMake modules.

The variables, functions, and macros listed here are intended to be used
by the developer of a software development project based on BASIS in their
project specific CMake implementation and the CMakeLists.txt files.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>

@ingroup CMakeModules
*/

// ***************************************************************************
/**
@defgroup CMakeUtilities CMake Utilities
@brief    Utility implementations used by the CMake modules.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>

@ingroup CMakeModules
*/

// ***************************************************************************
/**
@defgroup CMakeHelpers  Non-CMake Utilities
@brief    Auxiliary non-CMake implementations used by the CMake modules.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>

@ingroup CMakeModules
*/

// ***************************************************************************
/**
@defgroup CMakeTools Auxiliary CMake Modules
@brief    Auxiliary CMake modules included and used by the main modules.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>

@ingroup CMakeModules
*/

// ***************************************************************************
/**
@defgroup CMakeFindModules Find Package Modules
@brief    CMake Find modules used by find_package() command.

The BASIS package provides CMake Find module implementations for third-party
packages which are commonly used at SBIA but do not provide a CMake
package configuration file (\<Package\>Config.cmake or \<package\>-config.cmake)
such that CMake cannot find the package by default in config-mode.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>

@ingroup CMakeModules
*/

// ***************************************************************************
/**
@defgroup CMakeTemplates Template Files
@brief    Template files used as input to configure_file() command.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>

@ingroup CMakeModules
*/

// ---------------------------------------------------------------------------
// Utilities
// ---------------------------------------------------------------------------

// ***************************************************************************
/**
@defgroup Utilities Utilities
@brief    Auxiliary implementations in different programming languages.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>
*/

// ***************************************************************************
/**
@defgroup CppUtilities C++ Utilities
@brief    Auxiliary implementations for use in C++ source code.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>

@ingroup  Utilities
*/

// ***************************************************************************
/**
@defgroup BASHUtilities BASH Utilities
@brief    Auxiliary implementations for use in BASH scripts.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>

@ingroup  Utilities
*/

// ***************************************************************************
/**
@defgroup PythonUtilities Python Utilities
@brief    Auxiliary implementations for use in Python scripts.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>

@ingroup  Utilities
*/

// ***************************************************************************
/**
@defgroup PerlUtilities Perl Utilities
@brief    Auxiliary implementations for use in Perl scripts.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>

@ingroup  Utilities
*/

// ---------------------------------------------------------------------------
// Tools
// ---------------------------------------------------------------------------

// ***************************************************************************
/**
@defgroup Tools Command-line Tools
@brief    Basic command-line tools.

The BASIS package not only provides the implementation of the standardized
build system, auxiliary implementations for different supported programming
languages, and the standardized project directory structure, it also includes
some utility command-line tools. In particular, the project management tool
which is used to create and/or modify BASIS projects, and tools for the
automated testing of the software of a BASIS project. These tools are
summarized in this module.

Copyright (c) 2011 University of Pennsylvania. All rights reserved.
See https://www.rad.upenn.edu/sbia/software/license.html or COPYING file.

Contact: SBIA Group <sbia-software at uphs.upenn.edu>
*/
