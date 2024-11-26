@isTest

public class OpportunityReviewSchedulerTest {
    @testSetup
    public static void testTasks(){        
        Opportunity opp1 = new Opportunity(Name = 'Test Opportunity1', StageName = 'Prospecting', CloseDate = System.today()+30);
        insert opp1;        
        Opportunity opp2 = new Opportunity(Name = 'Test Opportunity2', StageName = 'Closed Won' , CloseDate = System.today()+30);
        insert opp2;
    }
    @isTest
    public static void test1() {
        Test.startTest();
        String cronExp = '0 0 9 ? * 2';
        String jobId = System.Schedule('OpportunityReviewScheduler Schedule' , cronExp , new OpportunityReviewScheduler());
        Test.stopTest();
        Opportunity opp = [SELECT Id, OwnerId FROM Opportunity WHERE StageName != 'Closed Won'];
        List<Task> tasks = [SELECT Id, WhatId, OwnerId FROM Task];
        System.assertEquals(1, tasks.size(),'only 1 task');
        System.assertEquals(opp.OwnerId,tasks[0].OwnerId,'owner same of both opp aqnd task');
    }
}