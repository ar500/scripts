LOC_PATH=${PWD}

case $LOC_PATH in
	! -d) echo "not dir" ;;
	! -w) echo "not writeable" ;;
esac
