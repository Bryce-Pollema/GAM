echo "MacOS Version Info According to Python:"
python -c "import platform; print(platform.mac_ver())"
echo "Xcode versionn:"
xcodebuild -version
export gampath=dist
rm -rf $gampath
export specfile="gam.spec"
$python -OO -m PyInstaller --clean --noupx --strip -F --distpath "${gampath}" "${specfile}"
export gam="${gampath}/gam/gam"
$gam version extended
export GAMVERSION=`$gam version simple`
cp LICENSE "${gampath}"
cp GamCommands.txt "${gampath}"
MACOSVERSION=$(defaults read loginwindow SystemVersionStampAsString)
GAM_ARCHIVE="gam-${GAMVERSION}-${GAMOS}-${PLATFORM}-MacOS${MACOSVERSION}.tar.xz"
rm "${gampath}/lastupdatecheck.txt"
# tar will cd to dist/ and tar up gam/
tar -C dist/ --create --file $GAM_ARCHIVE --xz gam
