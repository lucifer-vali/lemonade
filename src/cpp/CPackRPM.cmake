# Optional CPack RPM configuration for lemonade-server + lemonade-tray
# Include this file before include(CPack) in CMakeLists.txt
#
# Generates two RPM packages from a single build:
#   lemonade-server-<version>.x86_64.rpm  — headless server, CLI, systemd units
#   lemonade-tray-<version>.x86_64.rpm    — system-tray GUI (requires server)

# Only set these when RPM packaging is requested or when on RPM-friendly host.
# We do not force CPACK_GENERATOR here; the caller can run `cpack -G RPM`.

set(CPACK_RPM_COMPONENT_INSTALL ON)
set(CPACK_COMPONENTS_ALL Runtime Tray)

# Defaults inherited by all components (can be overridden per component)
set(CPACK_RPM_PACKAGE_LICENSE "Apache-2.0")
set(CPACK_RPM_PACKAGE_GROUP "Applications/System")
set(CPACK_RPM_PACKAGE_URL "https://github.com/lemonade-sdk/lemonade")

# Architecture and file name
set(CPACK_RPM_PACKAGE_ARCHITECTURE "x86_64")
set(CPACK_PACKAGE_FILE_NAME "lemonade-server-${CPACK_PACKAGE_VERSION}.${CPACK_RPM_PACKAGE_ARCHITECTURE}")
set(CPACK_PACKAGE_RELOCATABLE OFF)
set(CPACK_RPM_PACKAGE_RELOCATABLE OFF)

# ------------------------------------------------------------------
# Runtime (lemonade-server) — lemond, lemonade CLI, resources, systemd
# ------------------------------------------------------------------

set(CPACK_RPM_RUNTIME_PACKAGE_NAME "lemonade-server")

# RPM runtime requirements (package names on Fedora/RHEL)
# Adjust for target distro if needed.
set(CPACK_RPM_RUNTIME_FILE_NAME
    "lemonade-server-${CPACK_PACKAGE_VERSION}.${CPACK_RPM_PACKAGE_ARCHITECTURE}.rpm")
set(CPACK_RPM_RUNTIME_PACKAGE_REQUIRES "libcurl, openssl, libwebsockets, zstd")

# Provide RPM-native script hooks
set(CPACK_RPM_POST_INSTALL_SCRIPT_FILE "${CMAKE_CURRENT_SOURCE_DIR}/src/cpp/postinst-rpm")
set(CPACK_RPM_PRE_UNINSTALL_SCRIPT_FILE "${CMAKE_CURRENT_SOURCE_DIR}/src/cpp/prerm-rpm")
set(CPACK_RPM_POST_UNINSTALL_SCRIPT_FILE "${CMAKE_CURRENT_SOURCE_DIR}/src/cpp/postrm-rpm")

# ---------------------------------------------------------------
# Tray (lemonade-tray) — system-tray GUI client
# ---------------------------------------------------------------
set(CPACK_RPM_TRAY_PACKAGE_NAME "lemonade-tray")
set(CPACK_RPM_TRAY_FILE_NAME
    "lemonade-tray-${CPACK_PACKAGE_VERSION}.${CPACK_RPM_PACKAGE_ARCHITECTURE}.rpm")
set(CPACK_RPM_TRAY_PACKAGE_REQUIRES
    "lemonade-server >= ${CPACK_PACKAGE_VERSION}, gtk3, libappindicator-gtk3, libnotify")
set(CPACK_RPM_TRAY_PACKAGE_SUMMARY "Lemonade System Tray Application")
set(CPACK_RPM_TRAY_PACKAGE_DESCRIPTION
    "System tray interface for Lemonade Server. Provides quick access to model management, logs, and the web app.")

# End of RPM config.
