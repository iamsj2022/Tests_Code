create database Interview

Show databases

use Interview

Set SQL_SAFE_UPDATES = 0;

CREATE TABLE interview.paynearby(
	Amount int,
	PayeeRefId int,
	CreatedDate datetime ,
	TransactionStatusRefId int,
    AgentRefId int,
	DistributorRefId int 
) 



Select * from interview.paynearby 

 --Query 1 :

select AgentRefId, count(TransactionStatusRefId) Transaction_Count from interview.paynearby  where TransactionStatusRefId=2 and Amount > 100
group by AgentRefId 
ORDER by Transaction_Count DESC


 --Query 2 :- 

select vw.month,vw.Amount_Sum,vw.lastMonthAmount,
case
when vw.lastMonthAmount =0 then 0
else ((vw.Amount_Sum-vw.lastMonthAmount)/vw.lastMonthAmount)*100

end PercentageGrowth
from(
select month(CreatedDate) as month, SUM(Amount) Amount_Sum,month(CreatedDate)-1 lastMonth,
ISNULL(lst.amt,0) lastMonthAmount
from interview.paynearby t
outer apply(select SUM(tt.Amount) amt from interview.paynearby tt where month(tt.CreatedDate)= month(t.CreatedDate)-1 and tt.TransactionStatusRefId=2 and YEAR(tt.CreatedDate)=2018)lst
where TransactionStatusRefId=2 and YEAR(CreatedDate)=2018
group by month(CreatedDate),lst.amt
) vw




 


