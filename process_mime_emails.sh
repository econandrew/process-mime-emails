#/bin/sh

INDIR="[the folder containing *.eml files]"
OUTDIR="[where you want to output the files]"

count=1
mkdir $OUTDIR/all
for app in $INDIR/*.eml
do
  printf -v padcount "%03d" $count
  echo "$count: $app"
  mkdir $OUTDIR/$padcount
  cd $OUTDIR/$padcount
  tocname="${padcount}-0-toc.txt"
  echo "Email ${padcount}" > $tocname

  # Unpack mime attachments + email text
  munpack -t "../../$app" > temp.txt

  # Rename email text as appropriate
  partcount=1
  cat temp.txt | while read line; do
    fields=($line)
    fn=${fields[0]}
    mimetype=`echo ${fields[1]} | sed 's/(\([^\)]*\))/\1/'`
    if echo $fn |  grep "^part[0-9][0-9]*$" > /dev/null; then
      case $mimetype in 
        text/html) mv $fn $padcount-$partcount-$fn.html ;;
        text/plain) mv $fn $padcount-$partcount-$fn.txt ;;
      esac
    else
      mv $fn $padcount-$partcount-$fn
    fi
    let partcount=partcount+1
  done
  
  # Remove text email if an HTML version exists
  # You may not want to trust this...ymmv
  if [ -e $padcount-2-part2.html ]
    then rm $padcount-1-part1.txt
  fi
  
  # Build friendly table of contents
  cat temp.txt >> $tocname
  rm temp.txt
  
  # Also keep copies in one big folder for easy printing
  cp * ../all
  
  cd ../..
  let count=count+1
done

