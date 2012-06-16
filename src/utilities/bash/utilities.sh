##############################################################################
# @file  utilities.sh
# @brief Default implementation of BASIS Bash Utilities plus core functions.
#
# This module defines the default BASIS utility functions. These default
# implementations are not project-specific, i.e., do not make use of particular
# project attributes such as the name or version of the project. The utility
# functions defined by this module are intended for use in Bash scripts that
# are not build as part of a particular BASIS project. Otherwise, the
# project-specific implementations should be used instead, i.e., those defined
# by the basis.sh module of the project which is automatically added to the
# project during the configuration of the build tree. This basis.sh module and
# the submodules used by it are generated from template modules which are
# customized for the particular project that is being build.
#
# The default values used by the functions defined by this module are defined
# in the config.sh module. See this module for details on how to customize the
# utility functions.
#
# Besides the utility functions which are common to all implementations for
# the different programming languages, does this module further provide
# fundamental functions for the development in Bash.
#
# Copyright (c) 2011, 2012 University of Pennsylvania. All rights reserved.<br />
# See http://www.rad.upenn.edu/sbia/software/license.html or COPYING file.
#
# Contact: SBIA Group <sbia-software at uphs.upenn.edu>
##############################################################################

# return if already loaded
[ "${_SBIA_BASIS_UTILITIES_INCLUDED:-0}" -eq 1 ] && return 0
_SBIA_BASIS_UTILITIES_INCLUDED=1


## @addtogroup BasisBashUtilities
#  @{


# ============================================================================
# constants
# ============================================================================

## @brief Absolute directory path of utilities.sh module.
readonly _BASIS_UTILITIES_DIR=`cd -P -- "\`dirname -- "${BASH_SOURCE}"\`" && pwd -P`

. "${_BASIS_UTILITIES_DIR}/config.sh" || return 1
. "${_BASIS_UTILITIES_DIR}/core.sh"   || return 1

# ============================================================================
# path manipulation
# ============================================================================

# ----------------------------------------------------------------------------
## @brief Clean path, i.e., remove occurences of "./", duplicate slashes,...
#
# This function removes single periods (.) enclosed by slashes or backslashes,
# duplicate slashes (/) or backslashes (\), and further tries to reduce the
# number of parent directory references.
#
# For example, "../bla//.//.\bla\\\\\bla/../.." is convert to "../bla".
#
# @param [in] path Path.
#
# @return Cleaned path.
function clean_path
{
    local _basis_cp_path="$1"
    # GNU bash, version 3.00.15(1)-release (x86_64-redhat-linux-gnu)
    # turns the array into a single string value if local is used
    if [ ${BASH_VERSION_MAJOR} -gt 3 ] || [ ${BASH_VERSION_MAJOR} -eq 3 -a ${BASH_VERSION_MINOR} -gt 0 ]; then
        local _basis_cp_dirs=()
    else
        _basis_cp_dirs=()
    fi
    # split path into parts, discarding redundant slashes
    while [ -n "${_basis_cp_path}" ]; do
        if [ ${#_basis_cp_dirs[@]} -eq 0 ]; then
            _basis_cp_dirs=("`basename -- "${_basis_cp_path}"`")
        else
            _basis_cp_dirs=("`basename -- "${_basis_cp_path}"`" "${_basis_cp_dirs[@]}")
        fi
        _basis_cp_path="`dirname -- "${_basis_cp_path}"`"
        if [ "${_basis_cp_path}" == '/' ]; then
            _basis_cp_path=''
        fi
    done
    # build up path again from the beginning,
    # discarding dots ('.') and stepping one level up for each '..' 
    local _basis_cp_i=0
    while [ ${_basis_cp_i} -lt ${#_basis_cp_dirs[@]} ]; do
        if [ "${_basis_cp_dirs[${_basis_cp_i}]}" != '.' ]; then
            if [ "${_basis_cp_dirs[${_basis_cp_i}]}" == '..' ]; then
                _basis_cp_path=`dirname -- "${_basis_cp_path}"`
            else
                _basis_cp_path="${_basis_cp_path}/${_basis_cp_dirs[${_basis_cp_i}]}"
            fi
        fi
        let _basis_cp_i++
    done
    # return
    echo -n "${_basis_cp_path}"
}

# ----------------------------------------------------------------------------
## @brief Get absolute path given a relative path.
#
# This function converts a relative path to an absolute path. If the given
# path is already absolute, this path is passed through unchanged.
#
# @param [in] path Absolute or relative path.
#
# @return Absolute path.
function to_absolute_path
{
    local _basis_tap_base="$1"
    local _basis_tap_path="$2"
    if [ "${_basis_tap_base:0:1}" != '/' ]; then
        _basis_tap_base="`pwd`/${_basis_tap_base}"
    fi
    if [ "${_basis_tap_path:0:1}" != '/' ]; then
        _basis_tap_path="${_basis_tap_base}/${_basis_tap_path}"
    fi
    clean_path "${_basis_tap_path}"
}

# ----------------------------------------------------------------------------
## @brief Get canonical file path.
#
# This function resolves symbolic links and returns a cleaned path.
#
# @param [in] path Path.
#
# @return Canonical file path without duplicate slashes, ".", "..",
#         and symbolic links.
function get_real_path
{
    # make path absolute and resolve '..' references
    local _basis_grp_path=`to_absolute_path "$1"`
    if ! [ -e "${_basis_grp_path}" ]; then echo -n "${_basis_grp_path}"; return; fi
    # resolve symbolic links within path
    _basis_grp_path=`cd -P -- $(dirname -- "${_basis_grp_path}") && pwd -P`/`basename -- "${_basis_grp_path}"`
    # if path itself is a symbolic link, follow it
    local _basis_grp_i=0
    local _basis_grp_cur="${_basis_grp_path}"
    while [ -h "${_basis_grp_cur}" ] && [ ${_basis_grp_i} -lt 100 ]; do
        _basis_grp_dir=`dirname -- "${_basis_grp_cur}"`
        _basis_grp_cur=`readlink -- "${_basis_grp_cur}"`
        _basis_grp_cur=`cd "${_basis_grp_dir}" && cd $(dirname -- "${_basis_grp_cur}") && pwd`/`basename -- "${_basis_grp_cur}"`
        let _basis_grp_i++
    done
    # If symbolic link could entirely be resolved in less than 100 iterations,
    # return the obtained canonical file path. Otherwise, return the original
    # link which could not be resolved due to some probable cycle.
    if [ ${_basis_grp_i} -lt 100 ]; then _basis_grp_path="${_basis_grp_cur}"; fi
    # return
    echo -n "${_basis_grp_path}"
}

# ============================================================================
# executable information
# ============================================================================

# ----------------------------------------------------------------------------
## @brief Print contact information.
#
# @param [in] contact Name of contact. If not specified or an empty string,
#                     defaults to the global @c CONTACT variable defined by
#                     the config.sh module.
#
# @returns Nothing.
function print_contact
{
    [ -n "$1" ] && echo -e "Contact:\n  $1" || echo -e "Contact:\n  ${CONTACT}"
}

# ----------------------------------------------------------------------------
## @brief Print version information including copyright and license notices.
#
# @param [in] options   Function options as documented below.
# @param [in] name      Name of executable. Should not be set programmatically
#                       to the first argument of the main script, but a string
#                       literal instead.
# @param [in] version   Version of executable, e.g., release of project
#                       this executable belongs to.
# @par Options:
# <table border="0">
#   <tr>
#     @tp @b -p,  @b --project &lt;name&gt; @endtp
#     <td>Name of project this executable belongs to.
#         If not specified, no project information is printed.</td>
#   </tr>
#   <tr>
#     @tp @b -c  @b --copyright &lt;copyright&gt; @endtp
#     <td>The copyright notice. Defaults to the global @c COPYRIGHT initially
#         defined by the config.sh module. If 'none', no copyright notice is
#         printed.</td>
#   </tr>
#   <tr>
#     @tp @b -l  @b --license &lt;license&gt; @endtp
#     <td>Information regarding licensing. Defaults to the global @c LICENSE
#         initially defined by the config.sh module. If 'none', no license
#         information is printed.</td>
#   </tr>
# </table>
#
# @returns Nothing.
function print_version
{
    local _basis_pv_name=''
    local _basis_pv_version=''
    local _basis_pv_project=''
    local _basis_pv_copyright="${COPYRIGHT:-}"
    local _basis_pv_license="${LICENSE:-}"
    while [ $# -gt 0 ]; do
        case "$1" in
            -p|--project)
                if [ $# -gt 1 ]; then
                    _basis_pv_project="$2"
                else
                    echo "print_version(): Option -p, --project is missing an argument!" 1>&2
                fi
                shift
                ;;
            -c|--copyright)
                if [ $# -gt 1 ]; then
                    _basis_pv_copyright="$2"
                else
                    echo "print_version(): Option -c, --copyright is missing an argument!" 1>&2
                fi
                shift
                ;;
            -l|--license)
                if [ $# -gt 1 ]; then
                    _basis_pv_license="$2"
                else
                    echo "print_version(): Option -l, --license is missing an argument!" 1>&2
                fi
                shift
                ;;
            *)
                if   [ -z "${_basis_pv_name}" ]; then
                    _basis_pv_name=$1
                elif [ -z "${_basis_pv_version}" ]; then
                    _basis_pv_version=$1
                else
                    echo "print_version(): Too many arguments or invalid option: $1" 1>&2
                fi
                ;;
        esac
        shift
    done
    [ -n "${_basis_pv_name}"    ] || { echo "print_version(): Missing name argument"    1>&2; return 1; }
    [ -n "${_basis_pv_version}" ] || { echo "print_version(): Missing version argument" 1>&2; return 1; }
    echo -n "${_basis_pv_name}"
    [ -n "${_basis_pv_project}" ] && echo -n " (${_basis_pv_project})"
    echo " ${_basis_pv_version}"
    [ -n "${_basis_pv_copyright}" ] && echo -e "Copyright (c) ${_basis_pv_copyright}"
    [ -n "${_basis_pv_license}"   ] && echo -e "${_basis_pv_license}"
}

# ----------------------------------------------------------------------------
## @brief Get absolute path of executable file.
#
# This function determines the absolute file path of an executable. If no
# arguments are given, the absolute path of this executable is returned.
# Otherwise, the named command is searched in the system @c PATH and its
# absolute path returned if found. If the executable is not found, an empty
# string is returned.
#
# @param [out] path Absolute path of executable or empty string if not found.
#                   If @p name is not given, the path of this executable is returned.
# @param [in]  name Name of command or an empty string.
#
# @returns Whether or not the command was found.
#
# @retval 0 On success.
# @retval 1 On failure.
function get_executable_path
{
    [ -n "$1" ] && [ $# -eq 1 -o $# -eq 2 ] || return 1
    if [ $# -lt 2 ]; then
        local _basis_gep_path="`get_real_path "$0"`"
    else
        local _basis_gep_path=`/usr/bin/which "$2" 2> /dev/null`
    fi
    local "$1" && upvar $1 "${_basis_gep_path}"
    [ $? -eq 0 ] && [ -n "${_basis_gep_path}" ]
}

# ----------------------------------------------------------------------------
## @brief Get name of executable file.
#
# @param [out] file Name of executable file or an empty string if not found.
#                   If @p name is not given, the name of this executable is returned.
# @param [in]  name Name of command or an empty string.
#
# @returns Whether or not the command was found.
#
# @retval 0 On success.
# @retval 1 On failure.
function get_executable_name
{
    [ -n "$1" ] && [ $# -eq 1 -o $# -eq 2 ] || return 1
    local _basis_gen_path && get_executable_path _basis_gen_path
    [ $? -eq 0 ] || return 1
    local _basis_gen_name="`basename "${_basis_gen_path}"`"
    local "$1" && upvar $1 "${_basis_gen_name}"
}

# ----------------------------------------------------------------------------
## @brief Get directory of executable file.
#
# @param [out] dir  Directory of executable file or an empty string if not found.
#                   If @p name is not given, the directory of this executable is returned.
# @param [in]  name Name of command or an empty string.
#
# @returns Whether or not the command was found.
#
# @retval 0 On success.
# @retval 1 On failure.
function get_executable_directory
{
    [ -n "$1" ] && [ $# -eq 1 -o $# -eq 2 ] || return 1
    local _basis_ged_path && get_executable_path _basis_ged_path
    [ $? -eq 0 ] || return 1
    local _basis_ged_dir="`dirname "${_basis_ged_path}"`"
    local "$1" && upvar $1 "${_basis_ged_dir}"
}

# ============================================================================
# command execution
# ============================================================================

# ----------------------------------------------------------------------------
## @brief Build quoted string from array.
#
# Example:
# @code
# basis_array_to_quoted_string str 'this' "isn't" a 'simple example of "a quoted"' 'string'
# echo "${str}"
# @endcode
#
# @param [out] var      Name of result variable for quoted string.
# @param [in]  elements All remaining arguments are considered to be the
#                       elements of the array to convert.
#
# @returns Nothing.
function to_quoted_string
{
    local _basis_tqs_str=''
    local _basis_tqs_element=''
    # GNU bash, version 3.00.15(1)-release (x86_64-redhat-linux-gnu)
    # turns the array into a single string value if local is used
    if [ ${BASH_VERSION_MAJOR} -gt 3 ] || [ ${BASH_VERSION_MAJOR} -eq 3 -a ${BASH_VERSION_MINOR} -gt 0 ]; then
        local _basis_tqs_args=("$@")
    else
        _basis_tqs_args=("$@")
    fi
    local _basis_tqs_i=1
    while [ $_basis_tqs_i -lt ${#_basis_tqs_args[@]} ]; do
        _basis_tqs_element="${_basis_tqs_args[$_basis_tqs_i]}"
        # escape double quotes
        _basis_tqs_element=`echo -n "${_basis_tqs_element}" | sed "s/\"/\\\\\\\\\"/g"`
        # surround element by double quotes if it contains single quotes or whitespaces
        match "${_basis_tqs_element}" "[' ]" && _basis_tqs_element="\"${_basis_tqs_element}\""
        # append element
        [ -n "${_basis_tqs_str}" ] && _basis_tqs_str="${_basis_tqs_str} "
        _basis_tqs_str="${_basis_tqs_str}${_basis_tqs_element}"
        # next argument
        let _basis_tqs_i++
    done
    local "$1" && upvar $1 "${_basis_tqs_str}"
}

# ----------------------------------------------------------------------------
## @brief Split (quoted) string.
#
# This function can be used to split a (quoted) string into its elements.
#
# Example:
# @code
# str="'this' 'isn\'t' a \"simple example of \\\"a quoted\\\"\" 'string'"
# basis_split array "${str}"
# echo ${#array[@]}  # 5
# echo "${array[3]}" # simple example of "a quoted"
# @endcode
#
# @param [out] var Result variable for array.
# @param [in]  str Quoted string.
#
# @returns Nothing.
function split_quoted_string
{
    [ $# -eq 2 ] || return 1
    # GNU bash, version 3.00.15(1)-release (x86_64-redhat-linux-gnu)
    # turns the array into a single string value if local is used
    if [ ${BASH_VERSION_MAJOR} -gt 3 ] || [ ${BASH_VERSION_MAJOR} -eq 3 -a ${BASH_VERSION_MINOR} -gt 0 ]; then
        local _basis_sqs_array=()
    else
        _basis_sqs_array=()
    fi
    local _basis_sqs_str=$2
    # match arguments from left to right
    while match "${_basis_sqs_str}" "[ ]*('([^']|\\\')*[^\\]'|\"([^\"]|\\\")*[^\\]\"|[^ ]+)(.*)"; do
        # matched element including quotes
        _basis_sqs_element="${BASH_REMATCH[1]}"
        # remove quotes
        _basis_sqs_element=`echo "${_basis_sqs_element}" | sed "s/^['\"]//;s/(^|[^\\])['\"]$//"`
        # replace quoted quotes within argument by quotes
        _basis_sqs_element=`echo "${_basis_sqs_element}" | sed "s/[\\]'/'/g;s/[\\]\"/\"/g"`
        # add to resulting array
        _basis_sqs_array[${#_basis_sqs_array[@]}]="${_basis_sqs_element}"
        # continue with residual command-line
        _basis_sqs_str="${BASH_REMATCH[4]}"
    done
    # return
    local "$1" && upvar $1 "${_basis_sqs_array[@]}"
}

# ----------------------------------------------------------------------------
## @brief Execute command as subprocess.
#
# This function is used to execute a subprocess within a Bash script.
#
# Example:
# @code
# # the next command will exit the current shell if it fails
# execute_process ls /not/existing
# # to prevent this, provide the --allow_fail option
# execute_process --allow_fail ls /not/existing
# # to make it explicit where the command-line to execute starts, use --
# execute_process --allow_fail -- ls /not/existing
# @endcode
#
# Note that the output of the command is not redirected by this function.
# In order to execute the command quietly, use this function as follows:
# @code
# execute_process ls / &> /dev/null
# @endcode
# Or to store the command output in a variable including error messages
# use it as follows:
# @code
# output=`execute_process ls / 2>&1`
# @endcode
# Note that in this case, the option --allow_fail has no effect as the
# calling shell will never be terminated. Only the subshell in which the
# command is executed will be terminated. Checking the exit code $? is
# in this case required.
#
# @param [in] options Function options as documented below.
# @param [in] cmd     Executable of command to run or corresponding build
#                     target name. This is assumed to be the first
#                     non-option argument or the argument that follows the
#                     special '--' argument.
# @param [in] args    All remaining arguments are passed as arguments to
#                     the given command.
# @par Options:
# <table border="0">
#   <tr>
#     @tp <b>-f, --allow_fail</b> @endtp
#     <td>Allows the command to fail. By default, if the command
#         returns a non-zero exit code, the exit() function is
#         called to terminate the current shell.</td>
#   </tr>
#   <tr>
#     @tp <b>-v, --verbose</b> [int] @endtp
#     <td>Print command-line to stdout before execution. Optionally, as it is
#         sometimes more convenient to pass in the value of another variable
#         which controls the verbosity of the parent process itself, a verbosity
#         value can be specified following the option flag. If this verbosity
#         less or equal to zero, the command-line of the subprocess is not
#         printed to stdout, otherwise it is.</td>
#   </tr>
#   <tr>
#     @tp <b>-s, --simulate</b> @endtp
#     <td>If this option is given, the command is not actually
#         executed, but the command-line printed to stdout only.</td>
#   </tr>
# </table>
#
# @returns Exit code of subprocess.
function execute_process
{
    # parse arguments
    local _basis_ep_allow_fail='false'
    local _basis_ep_simulate='false'
    local _basis_ep_verbose=0
    local _basis_ep_args=''
    while [ $# -gt 0 ]; do
        case "$1" in
            -f|--allow_fail) _basis_ep_allow_fail='true'; ;;
            -s|--simulate)   _basis_ep_simulate='true';   ;;
            -v|--verbose)
                if [ `match "$2" '^-?[0-9]+$'` ]; then
                    _basis_ep_verbose=$2
                    shift
                else
                    let _basis_ep_verbose++
                fi
                ;;
            --)              shift; break; ;;
            *)               break; ;;
        esac
        shift
    done
    # command to execute and its arguments
    local _basis_ep_command="$1"; shift
    [ -n "${_basis_ep_command}" ] || echo "execute_process(): No command specified to execute" 1>&2; return 1
    # get absolute path of executable
    local _basis_ep_exec && get_executable_path _basis_ep_exec "${_basis_ep_command}"
    [ -n "${_basis_ep_exec}" ] || echo "${_basis_ep_command}: Command not found" 1>&2; exit 1
    # some verbose output
    [ ${verbose} -lt 1 ] || {
        to_quoted_string _basis_ep_args "$@"
        echo "\$ ${_basis_ep_exec} ${_basis_ep_args}"
    }
    # execute command
    [ "${_basis_ep_simulate}" == 'true' ] || "${_basis_ep_exec}" "$@"
    local _basis_ep_status=$?
    # if command failed, exit
    [ ${_basis_ep_status} -eq 0 -o "${_basis_ep_allow_fail}" == 'true' ] || {
        [ -n "${_basis_ep_args}" ] || to_quoted_string _basis_ep_args "$@"
        echo
        echo "Command ${_basis_ep_exec} ${_basis_ep_args} failed" 1>&2
        exit 1
    }
    # return exit code
    return ${_basis_ep_status}
}


## @}
# end of Doxygen group