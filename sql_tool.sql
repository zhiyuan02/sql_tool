--a random seed tool
  create view Getrand as
 select rand() as value


-- generate random integer from a to b
create function GetRandInt
 (
 @a int,
 @b int
 )
 returns int
 begin
	declare @res int
	declare @ran decimal(10,5)
	select @ran=value from Getrand
	set @res=floor((@b-@a+1)*@ran+@a)
	return @res
end
--generate random Date from a to b
 create function GetRandDate
 (
 @a date,
 @b date
 )
 returns date
 begin
	declare @u int,@t int 
	select @t=datediff(day,@a,@b)
	set @u=dbo.GetRandInt(0,@t)
	return dateadd(day,@u,@a)
 end
 print(dbo.GetRandDate('2001-10-10','2005-10-4'))

-- generate random string 
CREATE FUNCTION random_string()
RETURNS VARCHAR(10)
AS
BEGIN
  declare @ran decimal(10,4)
  select @ran=value from Getrand 
  DECLARE @random_index INT;
  DECLARE @random_string VARCHAR(10);
  SET @random_index = FLOOR(@ran * 3);
  IF @random_index = 0
    SET @random_string = 'java';
  ELSE IF @random_index = 1
    SET @random_string = 'c++';
  ELSE
    SET @random_string = 'c#';
  RETURN @random_string;
END;
 
 
 --DateTool to help write SQL query statement in data case
  create  table   DateTool
  (
		sdate  date  primary key
  )

   
   --generete date fron 2006 to 2020
     declare  @i date
	 set @i='2006-01-01'
	 
	 while(@i< '2020-01-01'  )
	 begin
	 
		insert into DateTool values(@i,null,null)
		set @i=dateadd( day,1, @i )
	 
	 end

 
  alter  table DateTool
 add   
 year_month nvarchar(200),
 xun  nvarchar(200)
 
 --update DateTool ,add year_month and xun colomn

 ;with  T
 as 
 (
		 select     sdate ,
		 
		 cast  (year(sdate)    as   nvarchar(200)  )+'-'+
		 
		
		   substring(   CONVERT(nvarchar(100), sdate,23)   ,6,2)
		 
		 
		 
		 as  年月,
		 
			 case
					when  day(sdate)>=1 and day(sdate)<=10   then   
					 
					cast  (year(sdate)    as   nvarchar(200)  )+'-'
							+cast (month(sdate)   as   nvarchar(200)  )
					 + ' 上旬'
					when  day(sdate)>=11 and day(sdate)<=20  then    
					cast  (year(sdate)    as   nvarchar(200)  )+'-'
							+cast (month(sdate)   as   nvarchar(200)  )
					+  ' 中旬'
					else  
					cast  (year(sdate)    as   nvarchar(200)  )+'-'
							+cast (month(sdate)   as   nvarchar(200)  )
					+   ' 下旬'
			 end
			 as  旬   from  DateTool
) 

 update   DateTool     set 
 year_month=T.年月   , xun=T.旬  
 from DateTool  
 inner join T
 on   DateTool.sdate=T.sdate
 
   declare  @sid int,@cid int
   select  top 1    @sid=supplierid    
   from    Production.Suppliers 	 
	order by  newid()