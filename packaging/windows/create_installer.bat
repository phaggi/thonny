@echo off

set BUILDDIR=build
rmdir %BUILDDIR% /S /Q
mkdir %BUILDDIR%

@echo ............... COPYING PYTHON ...................................
xcopy pythonny\* %BUILDDIR% /S /E /K>NUL


@echo ............... INSTALLING THONNY ...................................
%BUILDDIR%\python.exe -m pip install --pre --no-cache-dir thonny

@echo ............... INSTALLING Tkinter ...................................
%BUILDDIR%\python.exe -m pip install --pre --no-cache-dir tkinterhtml


@echo ............... INSTALLING easygui ...................................
%BUILDDIR%\python.exe -m pip install --no-cache-dir easygui


@echo ............... INSTALLING PYGAME ...................................
bitsadmin /transfer myDownloadJob /download /priority normal http://www.lfd.uci.edu/~gohlke/pythonlibs/djcobkfp/pygame-1.9.2a0-cp35-none-win32.whl .\pygame-1.9.2a0-cp35-none-win32.whl
%BUILDDIR%\python.exe -m pip install --no-cache-dir pygame-1.9.2a0-cp35-none-win32.whl


@echo ............... CLEANING PYTHON ............................
move %BUILDDIR%\LICENSE.txt %BUILDDIR%\PYTHON-LICENSE.txt>NUL
del %BUILDDIR%\README.txt>NUL
del %BUILDDIR%\NEWS.txt>NUL

del /S "%BUILDDIR%\*.pyc">NUL
del /S "%BUILDDIR%\*.lib">NUL
del /S "%BUILDDIR%\*.a">NUL
del /S "%BUILDDIR%\*.chm">NUL

rmdir %BUILDDIR%\Doc /S /Q>NUL
rmdir %BUILDDIR%\include /S /Q>NUL
rmdir %BUILDDIR%\libs /S /Q>NUL
rmdir %BUILDDIR%\Tools /S /Q>NUL
rmdir %BUILDDIR%\Scripts /S /Q>NUL

rmdir %BUILDDIR%\lib\test /S /Q>NUL


del %BUILDDIR%\tcl\*.sh /Q>NUL
del %BUILDDIR%\tcl\tcl8.6\clock.tcl>NUL
del %BUILDDIR%\tcl\tcl8.6\safe.tcl>NUL
rmdir %BUILDDIR%\tcl\tix8.4.3\demos /S /Q>NUL

rmdir %BUILDDIR%\tcl\tk8.6\demos /S /Q>NUL
rmdir %BUILDDIR%\tcl\tk8.6\msgs /S /Q>NUL

rmdir %BUILDDIR%\tcl\tcl8.6\opt0.4 /S /Q>NUL
rmdir %BUILDDIR%\tcl\tcl8.6\msgs /S /Q>NUL
rmdir %BUILDDIR%\tcl\tcl8.6\tzdata /S /Q>NUL

@echo ............... CLEANING PYTHON PIP ...................................
rmdir %BUILDDIR%\Lib\ensurepip /S /Q>NUL
rmdir %BUILDDIR%\Lib\site-packages\pip /S /Q>NUL
rmdir %BUILDDIR%\Lib\site-packages\pip-7.1.2.dist-info /S /Q>NUL
rmdir %BUILDDIR%\Lib\site-packages\setuptools /S /Q>NUL
rmdir %BUILDDIR%\Lib\site-packages\setuptools-18.2.dist-info /S /Q>NUL

@echo ............... CLEANING PYGAME ...................................
rmdir %BUILDDIR%\Lib\site-packages\pygame\tests /S /Q>NUL
rmdir %BUILDDIR%\Lib\site-packages\pygame\examples /S /Q>NUL
rmdir %BUILDDIR%\Lib\site-packages\pygame\docs /S /Q>NUL


@echo ............... COPYING VS FILES ..........................
xcopy ucrt_redist\*.dll %BUILDDIR% /S /E /K>NUL
xcopy ucrt_redist\api-ms-win*.dll %BUILDDIR%\DLLs /S /E /K>NUL

@echo ............... ENABLE DPI AWARNESS ..............................
@REM call EnableDPIAwareness %PREFIX%\pythonw.exe

@echo ............... COPYING THONNY LAUNCHER ..........................
copy ThonnyRunner\Release\thonny.exe %BUILDDIR% /Y


@echo ............... ADDING LICENSES ...................................
copy ..\..\*LICENSE.txt %BUILDDIR% /Y>NUL


@echo ............... CREATING INSTALLER ..........................
set /p VERSION=<%BUILDDIR%\Lib\site-packages\thonny\VERSION
"C:\Program Files (x86)\Inno Setup 5\iscc" /dAppVer=%VERSION% /dSourceFolder=build inno_setup.iss > installer_building.log


pause
