//Create Objects
Create (:Object:Staff {Name: "Ray",Type: "Staff", ID: "1", Staff_Type: "Employee"})
Create (:Object:Staff {Name: "Arthur",Type: "Staff", ID: "2", Staff_Type: "Supervisor"})
Create (:Object:Staff {Name: "Simon",Type: "Staff", ID: "3", Staff_Type: "Budget_Manager"})
Create (:Object:Staff {Name: "Luke",Type: "Staff", ID: "4", Staff_Type: "Department_Head"})

Create (:Object:Material { ID: "Material:1", Name: "Wood_Plank",Type: "Material", Storage_Location: "W1", Quantity: 100, Price: 50})
Create (:Object:Material { ID: "Material:2", Name: "Steel_Bar",Type: "Material",  Storage_Location: "W1", Quantity: 150, Price: 60})
Create (:Object:Material { ID: "Material:3", Name: "Glass_Panel",Type: "Material", Storage_Location: "W2", Quantity: 50, Price: 100})
Create (:Object:Material { ID: "Material:4", Name: "Wood_Plank",Type: "Material",  Storage_Location: "W2", Quantity: 50, Price: 100})
Create (:Object:Material { ID: "Material:5", Name: "Iron_Bar",Type: "Material",  Storage_Location: "W2",  Quantity: 50, Price: 65})
Create (:Object:Material { ID: "Material:6", Name: "Steel_Bar",Type: "Material", Storage_Location: "W2",  Quantity: 200, Price: 80})
Create (:Object:Material { ID: "Material:7", Name: "Wood_Plank",Type: "Material", Storage_Location: "W2",  Quantity: 30, Price: 20}) 
Create (:Object:Material { ID: "Material:8", Name: "Aluminium_Foil",Type: "Material", Storage_Location: "W1", Quantity: 40, Price: 70})
Create (:Object:Material { ID: "Material:9", Name: "Plastic_Stick",Type: "Material",  Storage_Location: "W1", Quantity: 50, Price: 60})
Create (:Object:Material { ID: "Material:10", Name: "Plastic_Stick",Type: "Material",  Storage_Location: "W1", Quantity: 100, Price: 500})
Create (:Object:Material { ID: "Material:11", Name: "Aluminium_Foil",Type: "Material", Storage_Location: "W1", Quantity: 800, Price: 5000})

Create (:Object:Invoice { ID: "Invoice:1",Type: "Invoice", Payment: 290, Payment_Method: "Credit"})
Create (:Object:Invoice { ID: "Invoice:2",Type: "Invoice", Payment: 295, Payment_Method: "Credit"})

Create (:Object:Requisition { ID: "Requisition:1",Type: "Requisition", Reason_of_Requisition: "Lack_of_Material"})
Create (:Object:Requisition { ID: "Requisition:2",Type: "Requisition", Reason_of_Requisition: "Lack_of_Material"})
Create (:Object:Requisition { ID: "Requisition:3",Type: "Requisition", Reason_of_Requisition: "Next_Company"})
Create (:Object:Requisition { ID: "Requisition:4",Type: "Requisition", Reason_of_Requisition: "Lack_of_Material"})

Create (:Object:Phurcase_Order { ID: "Phurcase_Order:1",Type: "Phurcase_Order", Supplier_Organisation: "Material_Company", Total_Cost: 290})
Create (:Object:Phurcase_Order { ID: "Phurcase_Order:2",Type: "Phurcase_Order", Supplier_Organisation: "Material_Company", Total_Cost: 240})
Create (:Object:Phurcase_Order { ID: "Phurcase_Order:3",Type: "Phurcase_Order", Supplier_Organisation: "Stellar_Metal_Org", Total_Cost: 295})
//Create Object-to-Object Relationship
Match (phurcase_Order:Object:Phurcase_Order {ID: "Phurcase_Order:1"})
Match (requisition:Object:Requisition {ID: "Requisition:1"})
With phurcase_Order, requisition
Create (requisition)-[:IsBaseOn]->(phurcase_Order)

Match (phurcase_Order:Object:Phurcase_Order {ID: "Phurcase_Order:2"})
Match (requisition:Object:Requisition {ID: "Requisition:2"})
With phurcase_Order, requisition
Create (requisition)-[:IsBaseOn]->(phurcase_Order)

Match (phurcase_Order:Object:Phurcase_Order {ID: "Phurcase_Order:3"})
Match (requisition:Object:Requisition {ID: "Requisition:3"})
With phurcase_Order, requisition
Create (requisition)-[:IsBaseOn]->(phurcase_Order)


Match(invoice:Object:Invoice { ID: "Invoice:1"})
Match (material:Object:Material)
where material.ID in ["Material:1", "Material:2", "Material:3", "Material:4"]
create (material)-[:Listed_in]->(invoice)

Match(:Object:Invoice { ID: "Invoice:2"})
Match (material:Object:Material)
where material.ID in ["Material:5", "Material:6", "Material:7", "Material:8", "Material:9"] 
create (material)-[:Listed_in]->(invoice)
// Create Events, followed by its Event-To-Object Relationship
Create (:Event:Submission_of_Requisition { Event_ID: 1,Type: "Submission_of_Requisition", Start_TimeStamp: datetime("2024-01-12T15:00:00"),Complete_TimeStamp: datetime("2024-01-12T17:00:00"),  Resource: "Ray"})
    Match (submission_of_requisition:Event:Submission_of_Requisition {Event_ID:1})
    match (material:Object:Material)
    Where material.ID in ["Material:1", "Material:2", "Material:3", "Material:4"]
    Create (material)-[:Listed_in]->(submission_of_requisition)
    Match (submission_of_requisition:Event:Submission_of_Requisition {Event_ID:1})
    Match (requisition:Object:Requisition {ID: "Requisition:1"})
    Create (requisition)-[:Created_by]->(submission_of_requisition)
    Match (submission_of_requisition:Event:Submission_of_Requisition {Event_ID:1})
    Match (staff:Object:Staff {ID:"1"})
    Create (staff)-[:Handles]->(submission_of_requisition)


Create (:Event:Submission_of_Requisition { Event_ID:2,Type: "Submission_of_Requisition", Start_TimeStamp: datetime("2024-01-14T09:00:00"), Complete_TimeStamp: datetime("2024-01-14T11:00:00"), Resource: "Ray"})
    Match (submission_of_Requisition:Event:Submission_of_Requisition {Event_ID:2})
    Match (material:Object:Material)
    Where material.ID IN ["Material:5", "Material:6", "Material:7", "Material:8", "Material:9"] 
    Create (material)-[:Listed_in]->(submission_of_Requisition)
    Match (submission_of_Requisition:Event:Submission_of_Requisition {Event_ID:2})
    Match (requisition:Object:Requisition {ID: "Requisition:2"})
    Create (requisition)-[:Created_by]->(submission_of_Requisition)
    Match (submission_of_Requisition:Event:Submission_of_Requisition {Event_ID:2})
    Match (staff:Object:Staff {ID:"1"})
    Create (staff)-[:Handles]->(submission_of_Requisition)

Create (:Event:Submission_of_Requisition { Event_ID: 3,Type: "Submission_of_Requisition", Start_TimeStamp: datetime("2024-01-15T05:00:00"), Complete_TimeStamp: datetime("2024-01-15T10:00:00"), Resource: "Ray"})
    Match (submission_of_Requisition:Event:Submission_of_Requisition {Event_ID: 3})
    Match (material:Object:Material)
    Where material.ID IN ["Material:5", "Material:6", "Material:7", "Material:8", "Material:9"] 
    Create (material)-[:Listed_in]->(submission_of_Requisition)
    Match (submission_of_Requisition:Event:Submission_of_Requisition {Event_ID: 3})
    Match (requisition:Object:Requisition {ID: "Requisition:3"})
    Create (requisition)-[:Created_by]->(submission_of_Requisition)
    Match (submission_of_Requisition:Event:Submission_of_Requisition {Event_ID: 3})
    Match (staff:Object:Staff {ID: "1"})
    Create (staff)-[:Handles]->(submission_of_Requisition)

Create (:Event:Approval_Supervisor { Event_ID: 4,Type: "Approval_Supervisor", Start_TimeStamp: datetime("2024-01-12T17:30:00"), Complete_TimeStamp: datetime("2024-01-15T11:30:00"), Resource: "Arthur"})
    Match (approval_Supervisor:Event:Approval_Supervisor {Event_ID: 4})
    Match (requisition:Object:Requisition {ID: "Requisition:1"})
    Create (requisition)-[:Approved_in]->(approval_Supervisor)
    Match (approval_Supervisor:Event:Approval_Supervisor {Event_ID: 4})
    Match (staff:Object:Staff {ID: "2"})
    Create (staff)-[:Handles]->(approval_Supervisor)
    
Create (:Event:Approval_Supervisor { Event_ID: 5,Type: "Approval_Supervisor", Start_TimeStamp: datetime("2024-01-14T11:30:00"), Complete_TimeStamp: datetime("2024-01-14T15:00:00"),Resource: "Arthur"})
    Match (approval_Supervisor:Event:Approval_Supervisor {Event_ID: 5})
    Match (requisition:Object:Requisition {ID: "Requisition:2"})
    Create (requisition)-[:Approved_in]->(approval_Supervisor)
    Match (approval_Supervisor:Event:Approval_Supervisor {Event_ID: 5})
    Match (staff:Object:Staff {ID: "2"})
    Create (staff)-[:Handles]->(approval_Supervisor)

Create (:Event:Approval_Supervisor { Event_ID: 6,Type: "Approval_Supervisor", Start_TimeStamp: datetime("2024-01-15T10:30:00"), Complete_TimeStamp: datetime("2024-01-15T12:00:00"), Resource: "Arthur"})
    Match (approval_Supervisor:Event:Approval_Supervisor {Event_ID: 6})
    Match (requisition:Object:Requisition {ID: "Requisition:3"})
    Create (requisition)-[:Approved_in]->(approval_Supervisor)
    Match (approval_Supervisor:Event:Approval_Supervisor {Event_ID: 6})
    Match (staff:Object:Staff {ID: "2"})
    Create (staff)-[:Handles]->(approval_Supervisor)


Create (:Event:Approval_Budget_Manager { Event_ID: 7,Type: "Approval_Budget_Manager", Start_TimeStamp: datetime("2024-01-12T17:30:00"), Complete_TimeStamp: datetime("2024-01-13T10:00:00"), Resource: "Simon"})
    Match (approval_Budget_Manager:Event:Approval_Budget_Manager {Event_ID: 7})
    Match (requisition:Object:Requisition {ID: "Requisition:1"})
    Create (requisition)-[:Approved_in]->(approval_Budget_Manager)
    Match (approval_Budget_Manager:Event:Approval_Budget_Manager{Event_ID: 7})
    Match (staff:Object:Staff {ID: "3"})
    Create (staff)-[:Handles]->(approval_Budget_Manager)

Create (:Event:Approval_Budget_Manager { Event_ID: 8,Type: "Approval_Budget_Manager", Start_TimeStamp: datetime("2024-01-14T11:30:00"), Complete_TimeStamp: datetime("2024-01-15T10:00:00"),  Resource: "Simon"}) 
    Match (approval_Budget_Manager:Event:Approval_Budget_Manager {Event_ID:8})
    Match (requisition:Object:Requisition {ID: "Requisition:2"})
    Create (requisition)-[:Approved_in]->(approval_Budget_Manager)
    Match (approval_Budget_Manager:Event:Approval_Budget_Manager {Event_ID: 8})
    Match (staff:Object:Staff {ID: "3"})
    Create (staff)-[:Handles]->(approval_Budget_Manager)

Create (:Event:Approval_Budget_Manager { Event_ID: 9,Type: "Approval_Budget_Manager", Start_TimeStamp: datetime("2024-01-16T09:30:00"), Complete_TimeStamp: datetime("2024-01-16T16:00:00"), Resource: "Simon"})
    Match (approval_Budget_Manager:Event:Approval_Budget_Manager{Event_ID: 9})
    Match (requisition:Object:Requisition {ID: "Requisition:3"})
    Create (requisition)-[:Approved_in]->(approval_Budget_Manager)
    Match (approval_Budget_Manager:Event:Approval_Budget_Manager {Event_ID: 9})
    Match (staff:Object:Staff {ID: "3"})
    Create (staff)-[:Handles]->(approval_Budget_Manager)

Create (:Event:Approval_Department_Head { Event_ID: 10,Type: "Approval_Department_Head", Start_TimeStamp: datetime("2024-01-12T17:30:00"), Complete_TimeStamp: datetime("2024-01-16T09:00:00"),Resource: "Luke"})
    Match (approval_Department_Head:Event:Approval_Department_Head {Event_ID: 10})
    Match (requisition:Object:Requisition {ID: "Requisition:1"})
    Create (requisition)-[:Approved_in]->(approval_Department_Head)
    Match (approval_Department_Head :Event:Approval_Department_Head {Event_ID: 10})
    Match (staff:Object:Staff {ID:"4"})
    Create (staff)-[:Handles]->(approval_Department_Head)

Create (:Event:Convert_To_Phurcase_Order { Event_ID: 11,Type: "Convert_To_Phurcase_Order", Start_TimeStamp: datetime("2024-01-15T09:30:00"), Complete_TimeStamp: datetime("2024-01-15T12:00:00"), Resource: "Arthur"})
    Match (convert_To_Phurcase_Order:Event:Convert_To_Phurcase_Order {Event_ID: 11})
    Match (requisition:Object:Requisition {ID: "Requisition:1"})
    Create (requisition)-[:Converted_to]->(convert_To_Phurcase_Order)
    Match (convert_To_Phurcase_Order:Event:Convert_To_Phurcase_Order {Event_ID: 11})
    Match (phurcase_Order:Object:Phurcase_Order {ID: "Phurcase_Order:1"})
    Create (phurcase_Order)-[:Created_by]->(convert_To_Phurcase_Order)
    Match (convert_To_Phurcase_Order:Event:Convert_To_Phurcase_Order  {Event_ID: 11})
    Match (staff:Object:Staff {ID:"2"})
    Create (staff)-[:Handles]->(convert_To_Phurcase_Order)

Create (:Event:Convert_To_Phurcase_Order { Event_ID: 12,Type: "Convert_To_Phurcase_Order", Start_TimeStamp: datetime("2024-01-15T10:30:00"), Complete_TimeStamp: datetime("2024-01-15T17:00:00"),  Resource: "Arthur"})
    Match (convert_To_Phurcase_Order:Event:Convert_To_Phurcase_Order {Event_ID: 12})
    Match (requisition:Object:Requisition {ID: "Requisition:2"})
    Create (requisition)-[:Converted_to]->(convert_To_Phurcase_Order)
    Match (convert_To_Phurcase_Order:Event:Convert_To_Phurcase_Order {Event_ID: 12})
    Match (phurcase_Order:Object:Phurcase_Order {ID: "Phurcase_Order:2"})
    Create (phurcase_Order)-[:Created_by]->(convert_To_Phurcase_Order)
    Match (convert_To_Phurcase_Order:Event:Convert_To_Phurcase_Order {Event_ID: 12})
    Match (staff:Object:Staff {ID:"2"})
    Create (staff)-[:Handles]->(convert_To_Phurcase_Order)


Create (:Event:Convert_To_Phurcase_Order { Event_ID: 13,Type: "Convert_To_Phurcase_Order", Start_TimeStamp: datetime("2024-01-16T09:30:00"), Complete_TimeStamp: "2024-01-16T16:00:00",Resource: "Arthur"})
    Match (convert_To_Phurcase_Order:Event:Convert_To_Phurcase_Order {Event_ID: 13})
    Match (requisition:Object:Requisition {ID: "Requisition:3"})
    Create (requisition)-[:Converted_to]->(convert_To_Phurcase_Order)
    Match (convert_To_Phurcase_Order:Event:Convert_To_Phurcase_Order {Event_ID: 13})
    Match (phurcase_Order:Object:Phurcase_Order {ID: "Phurcase_Order:3"})
    Create (phurcase_Order)-[:Created_by]->(convert_To_Phurcase_Order)
    Match (convert_To_Phurcase_Order:Event:Convert_To_Phurcase_Order  {Event_ID: 13})
    Match (staff:Object:Staff {ID:"2"})
    Create (staff)-[:Handles]->(convert_To_Phurcase_Order)

Create (:Event:Phurcase_Order_Sent { Event_ID: 14,Type: "Phurcase_Order_Sent", Start_TimeStamp: datetime("2024-01-16T10:00:00"), Complete_TimeStamp: datetime("2024-01-16T12:00:00"),Resource: "Arthur"})
    Match (phurcase_Order_Sent:Event:Phurcase_Order_Sent {Event_ID: 14})
    Match (phurcase_Order:Object:Phurcase_Order {ID: "Phurcase_Order:1"})
    Create (phurcase_Order)-[:Sended_by]->(phurcase_Order_Sent)
    Match (phurcase_Order_Sent:Event:Phurcase_Order_Sent {Event_ID: 14})
    Match (staff:Object:Staff {ID:"2"})
    Create (staff)-[:Handles]->(phurcase_Order_Sent)

Create (:Event:Phurcase_Order_Sent { Event_ID: 15,Type: "Phurcase_Order_Sent", Start_TimeStamp: datetime("2024-01-18T17:00:00"), Complete_TimeStamp: datetime("2024-01-19T12:00:00"),Resource: "Arthur"})
    Match (phurcase_Order_Sent:Event:Phurcase_Order_Sent {Event_ID: 15})
    Match (phurcase_Order:Object:Phurcase_Order {ID: "Phurcase_Order:2"})
    Create (phurcase_Order)-[:Sended_by]->(phurcase_Order_Sent)
    Match (phurcase_Order_Sent:Event:Phurcase_Order_Sent {Event_ID: 15})
    Match (staff:Object:Staff {ID:"2"})
    Create (staff)-[:Handles]->(phurcase_Order_Sent)

Create (:Event:Phurcase_Order_Sent { Event_ID: 16,Type: "Phurcase_Order_Sent", Start_TimeStamp: datetime("2024-01-16T16:30:00"), Complete_TimeStamp: datetime("2024-01-17T12:00:00"),Resource: "Arthur"})
    Match (phurcase_Order_Sent:Event:Phurcase_Order_Sent {Event_ID: 16})
    Match (phurcase_Order:Object:Phurcase_Order {ID: "Phurcase_Order:3"})
    Create (phurcase_Order)-[:Sended_by]->(phurcase_Order_Sent)
    Match (phurcase_Order_Sent:Event:Phurcase_Order_Sent {Event_ID: 16})
    Match (staff:Object:Staff {ID:"2"})
    Create (staff)-[:Handles]->(phurcase_Order_Sent)

Create (:Event:Invoice_Recieved { Event_ID: 17,Type: "Invoice_Recieved", Start_TimeStamp: datetime("2024-01-19T13:00:00"), Complete_TimeStamp: datetime("2024-01-19T13:00:00"),Resource: "Arthur"})
    Match (invoice_Recieved:Event:Invoice_Recieved {Event_ID:17})
    Match (phurcase_Order:Object:Phurcase_Order {ID:"Phurcase_Order:1"})
    Create (phurcase_Order)-[:Converted_to]->(invoice_Recieved)
    Match (invoice_Recieved:Event:Invoice_Recieved {Event_ID:17})
    Match (invoice:Object:Invoice {ID:"Invoice:1"})
    Create (invoice)-[:Created_by]->(invoice_Recieved)
    Match (invoice_Recieved:Event:Invoice_Recieved {Event_ID:17})
    Match (staff:Object:Staff {ID:"2"})
    Create (staff)-[:Handles]->(invoice_Recieved)
 
Create (:Event:Invoice_Recieved { Event_ID: 18,Type: "Invoice_Recieved", Start_TimeStamp: datetime("2024-01-17T12:00:00"), Complete_TimeStamp: datetime("2024-01-18T09:00:00"),Resource: "Arthur"})
    Match (invoice_Recieved:Event:Invoice_Recieved {Event_ID:18})
    Match (phurcase_Order:Object:Phurcase_Order {ID:"Phurcase_Order:2"})
    Create (phurcase_Order)-[:Converted_to]->(invoice_Recieved)
    Match (invoice_Recieved:Event:Invoice_Recieved {Event_ID:18})
    Match (invoice:Object:Invoice {ID:"Invoice:2"})
    Create (invoice)-[:Created_by]->(invoice_Recieved)
    Match (invoice_Recieved:Event:Invoice_Recieved {Event_ID:18})
    Match (staff:Object:Staff {ID:"2"})
    Create (staff)-[:Handles]->(invoice_Recieved)

Create (:Event:Pays_Invoice { Event_ID: 19,Type: "Pays_Invoice", Start_TimeStamp: datetime("2024-01-19T13:00:00"), Complete_TimeStamp: datetime("2024-01-20T10:00:00"), Resource: "Arthur"})
    Match (pays_Invoice:Event:Pays_Invoice {Event_ID: 19})
    Match (invoice:Object:Invoice {ID: "Invoice:1"})
    Create (invoice)-[:Paided_by]->(pays_Invoice)
    Match (pays_Invoice:Event:Pays_Invoice {Event_ID:19})
    Match (staff:Object:Staff {ID:"2"})
    Create (staff)-[:Handles]->(pays_Invoice)

Create (:Event:Pays_Invoice { Event_ID: 20,Type: "Pays_Invoice", Start_TimeStamp: datetime("2024-01-18T09:00:00"), Complete_TimeStamp: datetime("2024-01-18T12:00:00"),  Resource: "Arthur"})
    Match (pays_Invoice:Event:Pays_Invoice {Event_ID: 20})
    Match (invoice:Object:Invoice {ID: "Invoice:2"})
    Create (invoice)-[:Paided_by]->(pays_Invoice)
    Match (pays_Invoice:Event:Pays_Invoice {Event_ID:20})
    Match (staff:Object:Staff {ID:"2"})
    Create (staff)-[:Handles]->(pays_Invoice)

Create (:Event:Receive_Goods { Event_ID: 21,Type: "Receive_Goods", Start_TimeStamp: datetime("2024-01-25T12:00:00"), Complete_TimeStamp: datetime("2024-01-25T13:00:00"), Resource: "Arthur"})
    Match (material:Object:Material)
    Match (recieve_Goods:Event:Receive_Goods {Event_ID: 21})
    Where material.ID IN ["Material:1", "Material:2", "Material:3", "Material:4"]
    Create (material)-[:Created_by]->(recieve_Goods)
    Match (recieve_Goods:Event:Receive_Goods {Event_ID: 21})
    Match (staff:Object:Staff {ID:"1"})
    Create (staff)-[:Handles]->(recieve_Goods)

Create (:Event:Receive_Goods { Event_ID: 22,Type: "Receive_Goods", Start_TimeStamp: datetime("2024-01-25T12:00:00"), Complete_TimeStamp: datetime("2024-01-25T13:30:00"),Resource: "Arthur"})
    Match (material:Object:Material)
    Match (recieve_Goods:Event:Receive_Goods {Event_ID: 22})
    Where material.ID IN ["Material:5", "Material:6", "Material:7", "Material:8", "Material:9"] 
    Create (material)-[:Created_by]->(recieve_Goods)
    Match (recieve_Goods:Event:Receive_Goods {Event_ID: 22})
    Match (staff:Object:Staff {ID:"1"})
    Create (staff)-[:Handles]->(recieve_Goods)


Create (:Event:Store_Goods_Into_Warehouse { Event_ID: 23,Type: "Store_Goods_Into_Warehouse", Start_TimeStamp: datetime("2024-01-25T13:00:00"), Complete_TimeStamp: datetime("2024-01-25T15:00:00"), Resource: "Ray"})
    Match (store_Goods_Into_Warehouse:Event:Store_Goods_Into_Warehouse {Event_ID:23})
    Match (material:Object:Material)
    Where material.ID IN ["Material:1", "Material:2", "Material:3", "Material:4"]
    Create (material)-[:Stored_in]->(store_Goods_Into_Warehouse)
    Match (store_Goods_Into_Warehouse:Event:Store_Goods_Into_Warehouse {Event_ID:23})
    Match (staff:Object:Staff {ID:"1"})
    Create (staff)-[:Handles]->(store_Goods_Into_Warehouse)

Create (:Event:Store_Goods_Into_Warehouse { Event_ID: 24,Type: "Store_Goods_Into_Warehouse", Start_TimeStamp: datetime("2024-01-25T13:00:00"), Complete_TimeStamp: datetime("2024-01-25T15:30:00"), Resource: "Ray"})
    Match (store_Goods_Into_Warehouse:Event:Store_Goods_Into_Warehouse {Event_ID:24})
    Match (material:Object:Material)
    Where material.ID IN ["Material:5", "Material:6", "Material:7", "Material:8","Material:9"]
    Create (material)-[:Stored_in]->(store_Goods_Into_Warehouse)
    Match (store_Goods_Into_Warehouse:Event:Store_Goods_Into_Warehouse {Event_ID:24})
    Match (staff:Object:Staff {ID:"1"})
    Create (staff)-[:Handles]->(store_Goods_Into_Warehouse)

Create (:Event:Process_Order_Completed { Event_ID: 25,Type: "Process_Order_Completed", Start_TimeStamp: datetime("2024-01-25T15:00:00"), Complete_TimeStamp: datetime("2024-01-25T15:00:00"), Resource: "Ray"})
    Match (process_Order_Completed:Event:Process_Order_Completed {Event_ID:25})
    Match (requisition:Object:Requisition {ID: "Requisition:1"})
    Create (requisition)-[:Finalised_by]->(process_Order_Completed)
    Match (process_Order_Completed:Event:Process_Order_Completed {Event_ID:25})
    Match (staff:Object:Staff {ID:"1"})
    Create (staff)-[:Handles]->(process_Order_Completed)


Create (:Event:Process_Order_Completed { Event_ID: 26,Type: "Process_Order_Completed", Start_TimeStamp: datetime("2024-01-25T15:00:00"), Complete_TimeStamp: datetime("2024-01-25T15:00:00"), Resource: "Ray"})
    Match (process_Order_Completed:Event:Process_Order_Completed {Event_ID:26})
    Match (requisition:Object:Requisition {ID: "Requisition:3"})
    Create (requisition)-[:Finalised_by]->(process_Order_Completed)
    Match (process_Order_Completed:Event:Process_Order_Completed {Event_ID:26})
    Match (staff:Object:Staff {ID:"1"})
    Create (staff)-[:Handles]->(process_Order_Completed)

Create (:Event:Invoice_Declines { Event_ID: 27,Type: "Invoice_Declines", Start_TimeStamp: datetime("2024-01-21T10:00:00"), Complete_TimeStamp: datetime("2024-01-25T10:00:00"),Resource: "Arthur"})
    Match (invoice_Declines:Event:Invoice_Declines{Event_ID:27})
    Match (requisition:Object:Requisition {ID: "Requisition:2"})
    Create (requisition)-[:Finalised_by]->(invoice_Declines)
    Match (invoice_Declines:Event:Invoice_Declines{Event_ID:27})
    Match (staff:Object:Staff {ID:"2"})
    Create (staff)-[:Handles]->(invoice_Declines)

Create (:Event:Submission_of_Requisition { Event_ID: 28,Type: "Submission_of_Requisition", Start_TimeStamp: datetime("2024-01-20T08:00:00"), Complete_TimeStamp: datetime("2024-01-20T10:00:00"),  Resource: "Ray"})
    Match (submission_of_requisition:Event:Submission_of_Requisition {Event_ID:28})
    Match(material:Object:Material)
    Where material.ID in ["Material:10", "Material:11"]
    Create (material)-[:Listed_in]->(submission_of_requisition)
    Match (submission_of_requisition:Event:Submission_of_Requisition {Event_ID:28})
    Match (requisition:Object:Requisition {ID: "Requisition:4"})
    Create (requisition)-[:Created_by]->(submission_of_requisition)
    Match (submission_of_requisition:Event:Submission_of_Requisition {Event_ID:28})
    Match (staff:Object:Staff {ID:"1"})
    Create (staff)-[:Handles]->(submission_of_requisition)

Create (:Event:Approval_Supervisor { Event_ID: 29,Type: "Approval_Supervisor", Start_TimeStamp: datetime("2024-01-20T10:30:00"), Complete_TimeStamp: datetime("2024-01-21T09:00:00"), Resource: "Arthur"})
    Match (approval_Supervisor:Event:Approval_Supervisor {Event_ID: 29})
    Match (requisition:Object:Requisition {ID: "Requisition:4"})
    Create (requisition)-[:Approved_in]->(approval_Supervisor)
    Match (approval_Supervisor:Event:Approval_Supervisor {Event_ID: 29})
    Match (staff:Object:Staff {ID: "2"})
    Create (staff)-[:Handles]->(approval_Supervisor)

Create (:Event:Decline_Budget_Manager { Event_ID: 30 ,Type: "Decline_Budget_Manager", Start_TimeStamp: datetime("2024-01-20T10:30:00"), Complete_TimeStamp: datetime("2024-01-20T12:00:00"), Resource: "Simon"})
    Match (approval_Supervisor:Event:Decline_Budget_Manager{Event_ID: 30})
    Match (requisition:Object:Requisition {ID: "Requisition:4"})
    Create (requisition)-[:Approved_in]->(approval_Supervisor)
    Match (approval_Supervisor:Event:Decline_Budget_Manager{Event_ID: 30})
    Match (staff:Object:Staff {ID: "2"})
    Create (staff)-[:Handles]->(approval_Supervisor)

Create (:Event:Decline_Approval { Event_ID: 31,Type: "Decline_Approval", Start_TimeStamp: datetime("2024-01-21T09:00:00"), Complete_TimeStamp: datetime("2024-01-21T09:00:00"),Resource: "Simon"})
    Match (invoice_Declines:Event:Decline_Approval{Event_ID:31})
    Match (requisition:Object:Requisition {ID: "Requisition:4"})
    Create (requisition)-[:Finalised_by]->(invoice_Declines)
    Match (invoice_Declines:Event:Decline_Approval{Event_ID:31})
    Match (staff:Object:Staff {ID:"2"})
    Create (staff)-[:Handles]->(invoice_Declines)

//Answer Process Mining Questions
//Proocess Discovery
// D1 What is the most frequent action that occurs throughout this process? 
Match (event:Event)
Return event.Type as Event_Type, count(event.Type) as Number_of_actions
Order By Number_of_actions DESC Limit 1
// D2 What is the most frequent action that occurs sequentially?
//Note: not answered correctly 
Match (event:Event{Event_ID: 50})
Match (Event1:Event)
Match (object:Object)
Match  p=(event)<-[]-(object)-[]->(Event1)
Where event.Type <> Event1.Type 
and object.Type <> "Staff" 
and event.Complete_TimeStamp < Event1.Complete_TimeStamp
With p,  collect(event.Type + Event1.Type) as Mark
Return count(Mark)as Number_of_Sequence_Action, Mark as Sequence_of_actions
Order By Number_of_Sequence_Action DESC Limit 1

// D3 How many requisitions were successfully delivered?
Match (event:Event:Process_Order_Completed)
Return count(event) as Number_of_completed_requisitions
//or 
Match p=(object)-[:Finalised_by]->(Event)
Where Event.Type = "Process_Order_Completed"
Return Distinct count(Event)
// D4 How many requisitions require approval from the department heads, and compare this to the requisition amount valued above $10,000?
Match (requisition:Object:Requisition)
Match (Phurcase_order:Object:Phurcase_Order)
Match p=(requisition)-[]->(event)<-[]-(Phurcase_order)
return Count(Phurcase_order.Total_Cost >= 10000) as Value, Phurcase_order.Type as Type
Union 
Match (approval_department_head:Event:Approval_Department_Head)
return Count(approval_department_head) as Value, approval_department_head.Type as Type
// D5 Given the requisition value above $10,000 , how many of these given requisitions were denied (with the exclusion of the ones that were approved by the staff?
Match (phurcase_order:Object:Phurcase_Order)
where phurcase_order.Total_Cost >= 10000
Match p=(phurcase_order)-[:Created_by]->(convert_To_Phurcase_Order:Event:Convert_To_Phurcase_Order)<-[]-(requisition:Object:Requisition)
Match (EventFailed:Event)
where EventFailed.Type <> "Process_Order_Completed" and EventFailed.Type <> "Decline_Approval"  
Match path = (requisition)-[:Finalised_by]->(EventFailed:Event) 
return Count(path) as Amount_of_requisition_Denied, EventFailed.Type as EventType, Collect(requisition.ID) as Requisition
//Process Conformance 
//C1 Are there any orders marked completed before receiving the goods? If so, how many and list out the orders
Match (Completed_Orders:Event:Process_Order_Completed)
Match (requisition:Object:Requisition)
Match (staff:Object:Staff)
match (Goods_Recieved:Event:Receive_Goods)
Match p= (requisition)-[:Finalised_by]->(Completed_Orders)<-[]-(staff)-[]->(Goods_Recieved)
where Completed_Orders.Complete_TimeStamp < Goods_Recieved.Complete_TimeStamp
return Collect (distinct requisition.ID) as Requisition, count(distinct requisition.ID) as Amount 
//C2 Are any requisitions not approved by the supervisor and/or the budget manager that continued afterwards? If so name the requisition and name of the staffs.
Match (Decline:Event:Decline_Approval)
Match (staff:Object:Staff)
match p=(staff)-[]->(Decline)<-[]-(Object)-[]->(Events)
Where Decline.Complete_TimeStamp < Events.Complete_TimeStamp and Decline.Event_ID <> Events.Event_ID
Match (requisition:Object:Requisition)
Match (Staff:Object:Staff)
match z=(Staff)-[]->(Events)<-[]-(requisition)
Return Staff.Name As Name_Of_Staff, requisition.ID As Requisition
//C4 Were all of the invoices paid by the supervisor? If there are any that are not, state which invoice and the material associated with the invoice.
Match (pays_Invoice:Event:Pays_Invoice)
Match (staff:Object:Staff)
Match p = (staff)-[:Handles]->(pays_Invoice)
where staff.Staff_Type <> "Supervisor"
Match z = (material)-[:Listed_in]->(invoice)-[:Paided_by]->(pays_Invoice)
return invoice.ID as Invoice, Collect(material) as Materials, Count(pays_Invoice) as Failed_Amount 
