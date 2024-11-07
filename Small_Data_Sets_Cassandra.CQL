//Create Table 
Create Table Events (Event_Type text, 
  Event_Id text,
  Start_TimeStamp Timestamp,
  Complete_TimeStamp Timestamp,
  Staff_Id text,
  Material_Id list<text> ,
  Invoice_Id text,
  Phurcase_order_Id text,
  Requisition_Id text,
  Requisition_Cost Int,
  Primary Key ((Event_Type),Requisition_Cost)
);
// Insert data into Table 
Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Material_Id,Requisition_Id,Requisition_Cost) 
VALUES ('Submission_of_Requisition','Event_1', '2024-01-12 15:00:00','2024-01-12 17:00:00','Staff:1',['Material:1','Material:2','Material:3','Material:4'],'Requisition:1',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Material_Id,Requisition_Id,Requisition_Cost) 
VALUES ('Submission_of_Requisition','Event_2', '2024-01-14 11:00:00','2024-01-14 11:00:00','Staff:1',['Material:5','Material:6','Material:7','Material:8','Material:9'],'Requisition:2',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Material_Id,Requisition_Id,Requisition_Cost) 
VALUES ('Submission_of_Requisition','Event_3', '2024-01-15 10:00:00','2024-01-15 10:00:00','Staff:1',['Material:5','Material:6','Material:7','Material:8','Material:9'],'Requisition:3',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Requisition_Id,Requisition_Cost) 
Values ('Approval_Supervisor','Event_4','2024-01-15 11:30:00','2024-01-15 11:30:00','Staff:2','Requisition:1',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Requisition_Id,Requisition_Cost) 
Values ('Approval_Supervisor','Event_5','2024-01-14 15:00:00','2024-01-14 15:00:00','Staff:2','Requisition:2',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Requisition_Id,Requisition_Cost) 
Values ('Approval_Supervisor','Event_6','2024-01-15 12:00:00','2024-01-15 12:00:00','Staff:2','Requisition:3',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Requisition_Id,Requisition_Cost) 
Values ('Approval_Budget_Manager','Event_7','2024-01-13 10:00:00','2024-01-13 10:00:00','Staff:3','Requisition:1',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Requisition_Id,Requisition_Cost) 
Values ('Approval_Budget_Manager','Event_8','2024-01-14 11:30:00','2024-01-15 10:00:00','Staff:3','Requisition:2',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Requisition_Id,Requisition_Cost) 
Values ('Approval_Budget_Manager','Event_9','2024-01-16 16:00:00','2024-01-16 16:00:00','Staff:3','Requisition:3',-1);
 
Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Requisition_Id,Requisition_Cost) 
Values ('Approval_Department_Head','Event_10','2024-01-12 17:30:00','2024-01-16 09:00:00','Staff:4','Requisition:1',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Phurcase_order_Id,Requisition_Id,Requisition_Cost) 
Values ('Convert_To_Phurcase_Order','Event_11','2024-01-15 12:00:00','2024-01-15 12:00:00','Staff:2','Phurcase_Order:1','Requisition:1',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Phurcase_order_Id,Requisition_Id,Requisition_Cost) 
Values ('Convert_To_Phurcase_Order','Event_12','2024-01-15 17:00:00','2024-01-15 17:00:00','Staff:2','Phurcase_Order:2','Requisition:2',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Phurcase_order_Id,Requisition_Id,Requisition_Cost) 
Values ('Convert_To_Phurcase_Order','Event_13','2024-01-16 16:00:00','2024-01-16 16:00:00','Staff:2','Phurcase_Order:3','Requisition:3',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Phurcase_order_Id,Requisition_Cost) 
Values ('Phurcase_Order_Sent','Event_14','2024-01-16 12:00:00','2024-01-16 12:00:00','Staff:2','Phurcase_Order:1',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Phurcase_order_Id,Requisition_Cost) 
Values ('Phurcase_Order_Sent','Event_15','2024-01-19 12:00:00','2024-01-19 12:00:00','Staff:2','Phurcase_Order:2',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Phurcase_order_Id,Requisition_Cost) 
Values ('Phurcase_Order_Sent','Event_16','2024-01-17 12:00:00','2024-01-17 12:00:00','Staff:2','Phurcase_Order:3',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Invoice_Id,Phurcase_order_Id,Requisition_Cost) 
Values ('Invoice_Recieved','Event_17','2024-01-19 13:00:00','2024-01-19 13:00:00','Staff:2','Invoice:1','Phurcase_Order:1',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Invoice_Id,Phurcase_order_Id,Requisition_Cost) 
Values ('Invoice_Recieved','Event_18','2024-01-18 09:00:00','2024-01-18 09:00:00','Staff:2','Invoice:2','Phurcase_Order:2',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Invoice_Id,Requisition_Cost) 
Values ('Pays_Invoice','Event_19','2024-01-20 10:00:00','2024-01-20 10:00:00','Staff:2','Invoice:1',290);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Invoice_Id,Requisition_Cost) 
Values ('Pays_Invoice','Event_20','2024-01-18 12:00:00','2024-01-18 12:00:00','Staff:2','Invoice:2',295);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Material_Id,Requisition_Cost) 
Values ('Receive_Goods','Event_21','2024-01-25 13:00:00','2024-01-25 13:00:00','Staff:1',['Material:1','Material:2','Material:3','Material:4'],290);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Material_Id,Requisition_Cost) 
Values ('Receive_Goods','Event_22','2024-01-25 13:30:00','2024-01-25 13:30:00','Staff:1',['Material:5','Material:6','Material:7','Material:8','Material:9'],295);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Material_Id,Requisition_Cost) 
Values ('Store_Goods_Into_Warehouse','Event_23','2024-01-25 15:00:00','2024-01-25 15:00:00','Staff:1',['Material:1','Material:2','Material:3','Material:4'],290);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Material_Id,Requisition_Cost) 
Values ('Store_Goods_Into_Warehouse','Event_24','2024-01-25 15:30:00','2024-01-25 15:30:00','Staff:1',['Material:5','Material:6','Material:7','Material:8','Material:9'],295);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Requisition_Id,Requisition_Cost) 
Values ('Process_Order_Completed','Event_25','2024-01-25 15:00:00','2024-01-25 15:00:00','Staff:1','Requisition:1',290);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Requisition_Id,Requisition_Cost) 
Values ('Process_Order_Completed','Event_26','2024-01-25 15:00:00','2024-01-25 15:00:00','Staff:1','Requisition:3',295);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Requisition_Id,Requisition_Cost) 
Values ('Invoice_Declines','Event_27','2024-01-25 15:00:00','2024-01-25 10:00:00','Staff:2','Requisition:2',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Material_Id,Requisition_Id,Requisition_Cost) 
VALUES ('Submission_of_Requisition','Event_28', '2024-01-20 08:00:00','2024-01-20 10:00:00','Staff:1',['Material:10','Material:11'],'Requisition:4',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Requisition_Id,Requisition_Cost) 
Values ('Approval_Supervisor','Event_29','2024-01-20 10:30:00','2024-01-21 09:00:00','Staff:2','Requisition:1',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Requisition_Id,Requisition_Cost) 
Values ('Decline_Budget_Manager','Event_30','2024-01-20 10:30:00','2024-01-13 10:00:00','Staff:3','Requisition:4',-1);

Insert Into Events (Event_Type,Event_Id,Start_TimeStamp,Complete_TimeStamp,Staff_Id,Requisition_Id,Requisition_Cost) 
Values ('Decline_Approval','Event_31','2024-01-21 09:00:00','2024-01-21 09:00:00','Staff:2','Requisition:4',-1);

//Process Mining Question
//Process Discovery
// D3 How many requisitions were successfully delivered?
Select Count(*) FROM Events Where Event_Type = 'Process_Order_Completed';
// D4 How many requisitions require approval from the department heads, and compare this to the requisition amount valued above $10,000?
// Cannot be answer as one query
//Part 1 
SELECT Requisition_Id, Event_Type
FROM Events
WHERE event_type IN ('Approval_Supervisor', 'Approval_Budget_Manager', 'Approval_Department_Head');
// Part 2
SELECT Requisition_Id, Event_Type
FROM Events
WHERE Event_Type = 'Pays_Invoice' AND Requisition_Cost = 10000 
// D5 Given the requisition value above $10,000, how many of these given requisitions were denied (with the exclusion of the ones that were approved by the staff?
SELECT Count(*)
From Events
Where Event_Type IN ('Invoice_Declines') AND Requisition_Cost < 10000

