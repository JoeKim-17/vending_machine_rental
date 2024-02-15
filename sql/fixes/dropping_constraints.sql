alter table Inventory
	drop constraint machiens_leasedPrice_check

;
go

alter table Inventory
	add	constraint machines_leasedPrice_check check(MonthlyLeasedPrice > 0)
;
go