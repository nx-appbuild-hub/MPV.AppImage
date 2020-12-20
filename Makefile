# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)
DESTINATION="MPlayer.AppImage"

all: clean

	mkdir --parents $(PWD)/build/Mpv.AppDir
	apprepo --destination=$(PWD)/build appdir mpv

	rm --force $(PWD)/build/Mpv.AppDir/*.desktop 				| true
	rm --force $(PWD)/build/Mpv.AppDir/*.svg 					| true
	rm --force $(PWD)/build/Mpv.AppDir/*.png					| true

	cp --force $(PWD)/AppDir/*.desktop $(PWD)/build/Mpv.AppDir/	| true
	cp --force $(PWD)/AppDir/*.png $(PWD)/build/Mpv.AppDir/ 	| true
	cp --force $(PWD)/AppDir/*.svg $(PWD)/build/Mpv.AppDir/ 	| true

	echo "exec \$${APPDIR}/bin/mpv --player-operation-mode=pseudo-gui \"\$${@}\"" >> $(PWD)/build/Mpv.AppDir/AppRun

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage  $(PWD)/build/Mpv.AppDir $(PWD)/Mpv.AppImage

clean:
	rm -rf $(PWD)/build
