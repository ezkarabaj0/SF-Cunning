global with sharing class WarehouseSyncScheduleJob implements Schedulable{
    global void execute(SchedulableContext sc)
        {
            WarehouseCalloutService.warehouseEquipmentSync();
        }
    }