select month(b.CreatedDate),sum(bi.BenchmarkQuantity*bi.BenchmarkEach)
from Budgets b
left join BudgetItems bi on bi.BudgetID=b.BudgetID
where bi.BenchmarkQuantity>1
group by month(b.CreatedDate)
