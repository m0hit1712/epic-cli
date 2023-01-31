space=' '
tee='├'
branch='│'
last='└'
hori='─'

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[1;36m'
MEGENTA='\033[0;35m'
NC='\033[0m' # No Color

declare -a untracked_files_list=($(git ls-files --others --exclude-standard))
declare -a unstaged_changes_list=($(git ls-files -m))

create_prefix_str(){
    file=$1
    interfiles=$2
    prefix=""
    dir=$(echo "$3" | rev | cut -d '/' -f 1 | rev)
    line_len=$(( ${#dir} / 2))
    space_len=$((${#3} - $line_len))

    if [ $line_len -gt -1 ]; then
        for ((i=0; i<$space_len; i++));
        do
            echo -n "$space"
        done

        if [ ${interfiles[0]} == $file ]; then
            echo -e "$CYAN$branch$NC"
            for ((i=0; i<$space_len; i++));
            do
                echo -n "$space"
            done
        fi

        if [ ${interfiles[-1]} == $file ]; then
            prefix=$last
        else
            prefix=$tee
        fi

        for ((i=0; i<$line_len; i++));
        do
            prefix+="$hori"
        done
    fi
    full_file_path="$3/$1"
    if [ -z $3 ]; then
        full_file_path="$1"
    fi

    color=""
    suff=""

    for fil in "${untracked_files_list[@]}"
    do 
        if [[ ${fil} == $full_file_path ]]; then
            color=$RED
            suff="   (U)"
            break
        fi
    done

    for fil in "${unstaged_changes_list[@]}"
    do 
        if [[ ${fil} == $full_file_path ]]; then
            color=$YELLOW
            suff="   (M)"
            break
        fi
    done

    if [ ! -z $(git check-ignore $file) ]; then
        suff=" (Ign)"
        color=$MEGENTA
    fi

    echo -e "$CYAN$prefix${NC} $color$file  $suff$NC"
}


tree(){
    filename=$1
    prevpath=$2
    depth=$3
    
    if [ -d $filename ] || [ -z $prevpath ]; then
        if [ ! $depth -gt 1 ]; then
            prevpath=$filename
        fi
    fi

    declare -a interfiles=($(ls $prevpath -al | grep '^-' | awk '{print $9}') $(ls $prevpath -al | grep '^d' | awk '{print $9}'))
    ignore=""
    if [ ! -z "$prevpath" ]; then
        ignore=$(git check-ignore $prevpath)
    fi

    if [ -z "$ignore" ]; then
        for file in "${interfiles[@]}"
        do
            if [ "${file:0:1}" = "." ]; then
                continue
            fi
            create_prefix_str $file $interfiles $prevpath
            if [ -d "$prevpath/$file" ] && [ ! -z $prevpath ] ; then
                depth=$((depth+1))
                prevpath="$prevpath/$file"
                tree $file $prevpath $depth
                prevpath=$(echo "$prevpath" | rev | cut -d '/' -f '2-' | rev)
                depth=$((depth-1))
            else
                if [ -d "$file" ]; then
                    depth=$((depth+1))
                    prevpath="$prevpath/$file"
                    tree $file $prevpath $depth
                    prevpath=""
                    depth=$((depth-1))
                fi
            fi
        done   
    fi
}




tree "" "" 0


