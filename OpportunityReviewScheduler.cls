public class OpportunityReviewScheduler implements Schedulable {
    public static void execute(SchedulableContext sCon) {
        List<Opportunity> openOpp = [SELECT Id, OwnerId FROM Opportunity WHERE StageName!='Closed Won' AND StageName!='Closed Lost'];
        List<Task> task = new List<Task>();
        for(Opportunity opp : openOpp){
            Task newTask = new Task(OwnerId = opp.OwnerId , WhatId = opp.Id , Subject = 'New Task Created');
            task.add(newTask);
        }
        insert task;
    }
}