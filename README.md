# twitter-mining-scilit

This is the necessary code and files needed to mine twitter scientific literature posting bots and organize by likes and re-tweets, as I did in [this article](https://medium.com/@tjburns_72591/using-and-mining-pre-prints-to-stay-ahead-of-your-field-with-the-help-of-twitter-50d5bdc528de).

### There are three things you need to do before you can use this code: 
1) Download the [twitteR CRAN package](https://cran.r-project.org/web/packages/twitteR/index.html). 
2) Set up the authentication with OAuth, described in section 3 of [this document](http://geoffjentry.hexdump.org/twitteR.pdf)
3) Set up the remaining user inputs in the script, particularly the data directory and the output direcotry (data_dir and out_dir). You also have the option to include only pre-prints or include all types of papers. 

### Notes on the scilit.handles.csv file:
Notice that it [the file](https://github.com/tjburns08/twitter-mining-scilit/blob/master/scilit.handles.csv) organized into 4 columns. <br /> 
<br />
**source**: The name of the twitter bot. <br />
**category**: whether or not it is a pre-print. Useful for downstream organization. <br />
**handle**: The twitter handle. <br /> 
**notes**: add any additional information about the given twitter handle.  

This csv file is meant to be built out. It might be that you find other automated literature-posting bots of interest, or you want to look at the output of particular users. Modify the csv file accordingly. 

