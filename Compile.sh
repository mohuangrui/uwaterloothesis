#* *************************************************************************
#*                        bash scripts for compile latex
#* *************************************************************************
#! /bin/bash
#* *************************************************************************
#*                        pre information
#* *************************************************************************
if [ "$#" == "1" ];then
    File_Name=`echo *.tex`
elif [ "$#" == "2" ];then
    File_Name="$2"
else
    echo "*************************************************************************"
    echo "Usage: "$0" Compiler(\"x\" or \"p\") File_Name(if omitted, auto search)"
    echo "Compiler \"x\" for \"xelatex\" and  \"p\" for \"pdflatex\""
    echo "if compile failed, use \"X\" to terminate the terminal..."
    echo "*************************************************************************"
    exit
fi
#* *************************************************************************
#*                      get the file name to compile
#* *************************************************************************
File_Name=${File_Name/.tex}
#* *************************************************************************
#*                        get the compiler
#* *************************************************************************
if [[ $1 == 'p' ]];then
    CompileName="pdflatex"
elif [[ $1 == 'x' ]];then
    CompileName="xelatex"
else
    echo "*************************************************************************"
    echo "wrong compiler parameter, use \"pdflatex\" as current compiler"
    CompileName="pdflatex"
    echo "*************************************************************************"
fi
#* *************************************************************************
#*                        temperary directory
#* *************************************************************************
#* set the temp directory name
Tmp="Tmp"
if [[ ! -d $Tmp ]];then
    mkdir -p $Tmp
fi
#* *************************************************************************
#*                include subdirs to compile path
#* *************************************************************************
export TEXINPUTS=".//:$TEXINPUTS"
export BIBINPUTS=".//:$BIBINPUTS"
export BSTINPUTS=".//:$BSTINPUTS"
#* *************************************************************************
#*                compile target file
#* *************************************************************************
$CompileName -output-directory=$Tmp $File_Name || exit
#* *************************************************************************
#*               if use bibtex, need following commands 
#* *************************************************************************
bibtex ./$Tmp/$File_Name
$CompileName -output-directory=$Tmp $File_Name || exit
$CompileName -output-directory=$Tmp $File_Name || exit
#* *************************************************************************
#*                open the generated pdf file
#* *************************************************************************
gnome-open ./$Tmp/"$File_Name".pdf || exit
echo "*************************************************************************"
echo "use $CompileName Compile "$File_Name".tex finished!"
echo "*************************************************************************"
