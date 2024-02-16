USE VendingMachineRentalDB
GO
create function getUnleasedMachines(@inventoryID int)
returns table
as
return
(
	select 
		derivedTable.MachineID
	from 
	(
		select 
			v.MachineID, max(r.LeaseStatus) as ['LeaseStatus']
		from
			VendingMachines v
			left join LeasedVendingMachines l on v.MachineID = l.MachineID
			left join Rentals r on r.RentalID = l.RentID
		where 
			v.InventoryID = @inventoryID
		group by
			v.MachineID
		having 
			max(r.LeaseStatus) = 0 or max(r.LeaseStatus) is null
	)
	as derivedTable
);