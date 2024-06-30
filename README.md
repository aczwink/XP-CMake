# XP-CMake
"Cross platform cmake" is a set of cmake modules that allows to write compiler/OS/... independent scripts

Though cmake is a cross platform tool, the scripts written for it are mostly dependent on the build platform and quite likely fail on different platforms. These modules take over what actually should have been cmake's job in my opinion

## Installing
Since there are CMake modules, the very first step is to install CMake on your system.
In order to use XP-CMake, the modules need to be "made known" to CMake. The recommended way to do so is to use CMake itself to install the modules.
For Linux/Unix do something like:
```
mkdir build
cd build
cmake ..
sudo make install
```

On Windows platforms there is for convenience the "install.bat" file which does the installation. Simply double click to execute.
