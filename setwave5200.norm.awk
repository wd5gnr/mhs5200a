# This is useful if you want to convert files with different ranges
# you do NOT need to use this with the supplied spreadsheet!
# This assumes one value per input line
# Although it would be easy to fix up to convert real CSV
# If you aren't sure why this is here, you probably don't need it

BEGIN {
    MIN=-1
    MAX=1
}


   {
       x=$1
       y=(x-MIN)*(255/(MAX-MIN))
       printf("%d\n", y)
   }
   
	   

