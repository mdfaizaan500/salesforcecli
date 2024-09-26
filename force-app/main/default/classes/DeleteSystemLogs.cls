public class DeleteSystemLogs {

    @AuraEnabled
    public static void deleteLogRecords(DateTime startDate,DateTime endDate,String logLevels) {
    List<String> lstLevels = new List<String>();
        if(!string.isBlank(logLevels)){
           lstLevels = logLevels.split(',');
        }
        if(lstLevels !=null && lstLevels.size()>0){
        Database.executeBatch(new SystemLogTruncationBatch(startDate,endDate,lstLevels));
        }
    }

}