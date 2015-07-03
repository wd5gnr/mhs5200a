BEGIN {
#    print ":"
    FS=",";
    ct=0
    chunk=0
    header=0
}

/^[ \t]*$/ {
    next;
}


/^[ \t]*#/ {
    next;
}

function dohead() {
    printf(":\n:a%1x%1x",chan,chunk);
    header=1;    
}


header==0 {
    dohead();
}

    {
	gsub("\"","");
	gsub("[ \t\r\n]","");
	for (i=1;i<=NF;i++)  {
	    if (ct==64) {
		print ""
		ct=0;
		chunk++;
		if (chunk==16) exit(0)
		dohead();
	    }
	    else if (ct!=0) printf(",");
	    ct++;
	    printf("%d",$i);
	}
    }
    
	
	    
       
