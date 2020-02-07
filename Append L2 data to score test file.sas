DATA SCR_JAN_INDID (KEEP=IND_ID);
SET scr_sample;
IF IND_ID NE .;
RUN;
/*There were 5621226 observations read from the data set WORK.SCR_SAMPLE.
The data set WORK.SCRTEST_INDID has 2927469 observations and 1 variables.
*/

PROC SORT DATA=SCR_JAN_INDID NODUPKEY;
BY IND_ID;RUN;
/*There were 2927469 observations read from the data set WORK.SCRTEST_INDID.
4608 observations with duplicate key values were deleted.
The data set WORK.SCRTEST_INDID has 2922861 observations and 1 variables.*/


DATA _NULL_;
SET SCR_JAN_INDID;
FILE "\\stcsanisln01-idms\idms\Neptune\Apogee\SAS\SJH_JUL_INDID.TXT" LRECL=12 termstr=crlf /*RECFM=F*/;
PUT
@1 IND_ID Z12.
; 
RUN;
/*2922861 records were written to the file "W:\Saint Jude\Lapsed_Buyer_Model_Dec2019_BH\DATA\BH_SJH_201912_INDID.TXT".
The minimum record length was 12.
The maximum record length was 12.
There were 2922861 observations read from the data set WORK.SCR_JAN_INDID.*/

/* Client abbreviation */
%let libref = sjh;

/* Path to client data folder */
%let datapath = W:\Saint Jude\Lapsed_Buyer_Model_Dec2019_BH\DATA;

/* Path to client output folder */
%let outputpath = W:\Saint Jude\Lapsed_Buyer_Model_Dec2019_BH\OUTPUT;

/* Establish library names */
libname &libref "&datapath";
libname bmulera 'W:\Saint Jude\Lapsed_Buyer_Model_Dec2019_BH\DATA'; /*'W:\BMULERA\DATA';*/
libname jhoward 'W:\Saint Jude\Lapsed_Buyer_Model_Dec2019_BH\DATA'; /*'W:\JHOWARD\DATA';*/
libname in 'W:\IN';


/* L2 TABLE ####################################################################*/
/*See documentation for background on individual and household levels*/
/*1,085,518 records returned in dataset l2results 57.08%*/

proc sql feedback errorstop ipassthru threads outobs=max ; 
connect to 
oledb(init_string="Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=True;Initial Catalog=Apogee;Data Source=STCDMSSQLP03;schema=dbo");
create table &libref..L2Results_SCRTEST as select * 
from connection to oledb 
(
	SELECT
	a.INDIVIDUAL_ID as ind_id,/* for verification*/                      
	Company_ID	as	L2_Company_ID	,
	L2_LALVOTERID	as	L2_LALVOTERID	,
	L2_AnyElection_2009	as	L2_AnyElection_2009	,
	L2_AnyElection_2011	as	L2_AnyElection_2011	,
	L2_AnyElection_2013	as	L2_AnyElection_2013	,
	L2_AnyElection_2015	as	L2_AnyElection_2015	,
	L2_AnyElection_2017	as	L2_AnyElection_2017	,
	L2_General_2010	as	L2_General_2010	,
	L2_General_2012	as	L2_General_2012	,
	L2_General_2014	as	L2_General_2014	,
	L2_General_2016	as	L2_General_2016	,
	L2_OtherElection_2010	as	L2_OtherElection_2010	,
	L2_OtherElection_2012	as	L2_OtherElection_2012	,
	L2_OtherElection_2014	as	L2_OtherElection_2014	,
	L2_OtherElection_2016	as	L2_OtherElection_2016	,
	L2_OtherElection_2018	as	L2_OtherElection_2018	,
	L2_PRI_BLT_2010	as	L2_PRI_BLT_2010	,
	L2_PRI_BLT_2011	as	L2_PRI_BLT_2011	,
	L2_PRI_BLT_2012	as	L2_PRI_BLT_2012	,
	L2_PRI_BLT_2013	as	L2_PRI_BLT_2013	,
	L2_PRI_BLT_2014	as	L2_PRI_BLT_2014	,
	L2_PRI_BLT_2015	as	L2_PRI_BLT_2015	,
	L2_PRI_BLT_2016	as	L2_PRI_BLT_2016	,
	L2_PRI_BLT_2017	as	L2_PRI_BLT_2017	,
	L2_PRI_BLT_2018	as	L2_PRI_BLT_2018	,
	L2_PRI_BLT_2019	as	L2_PRI_BLT_2019	,
	L2_PRI_BLT_2020	as	L2_PRI_BLT_2020	,
	L2_Primary_2010	as	L2_Primary_2010	,
	L2_Primary_2012	as	L2_Primary_2012	,
	L2_Primary_2014	as	L2_Primary_2014	,
	L2_Primary_2016	as	L2_Primary_2016	,
	L2_Primary_2018	as	L2_Primary_2018	,
	L2_Comm_Veteran	as	L2_Comm_Veteran	
	from L2 b
	inner join SJH_JUL_INDID a on b.individual_id=a.individual_id 
	) ; 
quit;


/*Table SJH.L2RESULTS_SCRTEST created, with 1798825 rows and 34 columns.*/
