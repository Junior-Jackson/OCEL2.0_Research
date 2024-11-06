//Import Objects. 
// Part 1 Import  Material 
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/object_material.csv'
as row 
create (o:objects{Object_Id:row.ocel_id,Object_Type:row.ocel_type,Time:datetime(row.ocel_time),Price:toInteger(row.NetPriceEKPONETPR),Quantity:toInteger(row.QuantityEKPOMENGE),Delivery_Date:coalesce(row.DeliveryDateEKPOBEDAT,"unknown"),Plant_Powers:toInteger(row.PlantEKPOWERKS),Material_Name:row.MaterialEKPOMATNR,Storage_Location:row.StorageLocationEKPOLGORT,Changefield:coalesce(row.ocel_changed_field,"unknown")})

//part 2  Import  Invoice
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/object_invoicereceipt.csv'
as row  create (o:objects{Object_Id:row.ocel_id,Time:datetime(row.ocel_time),CreditAmount:coalesce(toInteger(row.CreditAmountBSEGWRBTR),"unknown"),DebitAmount:coalesce(toInteger(row.DebitAmountBSEGDMBTR),"unknown"),PaymentBlock:coalesce(toInteger(row.PaymentBlockRSEGZLSPR),"unknown"),new_value:coalesce(row.new_value,"unknown"),ocel_changed_field:coalesce(row.ocel_changed_field,"unknown"),ocel_changed_field:coalesce(row.ocel_changed_field,"unknown")})

//part 3  Import  Goods Receipt.
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/object_goodsreceipt.csv'
as row 
Create (o:objects{Object_Id:row.ocel_id,Time:datetime(row.ocel_time),InvoiceReceipt:coalesce(row.InvoiceReceiptMSEGWEAHR,"unknown"),MovementType:coalesce(row.MovementTypeMSEGBWART,"unknown"),new_value:coalesce(row.new_value,"unknown"),PostingDateMKPFBLDAT:coalesce(row.PostingDateMKPFBLDAT,"unknown")})

//part 4  Import  Payment
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/object_payment.csv'
as row 
Create (o:objects{
    Object_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    PaymentMethod:coalesce(row.PaymentMethodZLSCH,"unknown"),
    Amount:coalesce(toInteger(row.AmountDMBTR),"unknown"),
    new_value:coalesce(row.new_value,"unknown"),
    ocel_changed_field:coalesce(row.ocel_changed_field,"unknown")
})
//part 5  Import  purchase_order
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/object_purchase_order.csv'
as row 
create(o:objects{
    Object_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    PurchasingGroup:coalesce(row.PurchasingGroupEKKOEKGRP,"unknown"),
    PurchasingOrganization:coalesce(row.PurchasingOrganizationEKKOEKORG,"unknown"),
    DocumentType:coalesce(row.DocumentTypeEKKOBSART,"unknown"),
    ReleaseStatus:coalesce(row.ReleaseStatusEKKOFRGZU,"unknown"),
    Vendor:coalesce(row.VendorEKKOLIFNR,"unknown"),
    new_value:coalesce(row.new_value,"unknown"),
    ocel_changed_field:coalesce(row.ocel_changed_field,"unknown")
})
// part 6  Import  phurcase_requisition
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/object_purchase_requisition.csv'
as row 
create (o:objects{
    Object_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    PurchasingGroup:coalesce(row.PurchasingGroupEBANEKGRP,"unknown"),
    ReleaseIndicator:coalesce(row.ReleaseIndicatorEBANFRGZU,"unknown"),
    new_value:coalesce(row.new_value,"unknown"),
    ocel_changed_field:coalesce(row.ocel_changed_field,"unknown")
})
//part 7  Import Quotation
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/object_quotation.csv'
as row 
create (o:objects{
    Object_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    PurchasingGroup:coalesce(row.PurchasingGroupEBANEKGRP,"unknown"),
    RFQType:coalesce(row.RFQTypeEBANBSART,"unknown"),
    PurchasingOrganization:coalesce(row.PurchasingOrganizationEBANEKORG,"unknown"),
    Vendor:coalesce(row.VendorEBANLIFNR,"unknown"),
    new_value:coalesce(row.new_value,"unknown"),
    ocel_changed_field:coalesce(row.ocel_changed_field,"unknown")
})
//part 8 Give the attributes "Type" to each objects
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/object.csv'
as row 
match (o:objects{Object_Id:row.ocel_id})
set o.Type=row.ocel_type


// part 9 Import Object to Objects Relationships. 
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/object_object.csv'
as row 
match (o:objects{Object_Id:row.ocel_source_id})
match (n:objects{Object_Id:row.ocel_target_id})
merge (o)-[:qualifies{qualifier:row.ocel_qualifier}]->(n)

// Import Events
// part 10 Import ApprovePurchaseOrder 
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/event_ApprovePurchaseOrder.csv'
as row 
create (e:events{
    Event_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    Lifecycle:row.lifecycle,
    Resource:row.resource
})
// part 11 Import ApprovePurchaseRequisition
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/event_ApprovePurchaseRequisition.csv'
as row 
create (e:events{
    Event_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    Lifecycle:row.lifecycle,
    Resource:row.resource
})
//part 12 Import CreateGoodsReceipt 
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/event_CreateGoodsReceipt.csv'
as row 
create (e:events{
    Event_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    Lifecycle:row.lifecycle,
    Resource:row.resource
})
//Import 13 CreateInvocieReceipt
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/event_CreateInvoiceReceipt.csv'
as row 
create (e:events{
    Event_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    Lifecycle:row.lifecycle,
    Resource:row.resource
})
//part 14 Import  Create Phurcase Order 
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/event_CreatePurchaseOrder.csv'
as row 
create (e:events{
    Event_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    Lifecycle:row.lifecycle,
    Resource:row.resource
})
// Part 15 Import Create Phurcase Requisition
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/event_CreatePurchaseRequisition.csv'
as row 
create (e:events{
    Event_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    Lifecycle:row.lifecycle,
    Resource:row.resource
})
// Part 16 ImportCreate Request for Quotation
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/event_CreateRequestforQuotation.csv'
as row 
create (e:events{
    Event_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    Lifecycle:row.lifecycle,
    Resource:row.resource
})
// Part 17 Import Delegate Purchase Requisition Approval
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/event_DelegatePurchaseRequisitionApproval.csv'
as row 
create (e:events{
    Event_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    Lifecycle:row.lifecycle,
    Resource:row.resource
})
// Part 18 Import Execute Payment
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/event_ExecutePayment.csv'
as row 
create (e:events{
    Event_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    Lifecycle:row.lifecycle,
    Resource:row.resource
})
// Part 19 Import Perform Two Way Match.
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/event_PerformTwoWayMatch.csv'
as row 
create (e:events{
    Event_Id:row.ocel_id,
    Time:datetime(row.ocel_time),
    Lifecycle:row.lifecycle,
    Resource:row.resource
})
// Part 20 Import Load Event Type
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/event.csv'
as row 
match (e:events{Event_Id:row.ocel_id})
set e.Type=row.ocel_type
// Part 21 Import Event to Object Relationship 
Load Csv with headers from 'https://raw.githubusercontent.com/Junior-Jackson/OCEL2.0_Research/refs/heads/CSV-Import-Large-Event-Logs-Neo4j/event_object.csv'
as row 
match (e:events{Event_Id:row.ocel_event_id})
match (n:objects{Object_Id:row.ocel_object_id})
merge (e)-[:qualifies{qualifier:row.ocel_qualifier}]->(n)

//Process mining questions
//process discovery.

// PD1 What is the most frequent action that occurs throughout this process? 

match (events:events)
return events.Type as Event_Type, count(events.Type) as Number_of_actions
Order by Number_of_actions DESC Limit 1

// PD2 What is the most frequent actions that occur sequentially
match(event:events)
match(Event1:events)
match(object:objects)
match p=(event)<-[]-(object)-[]->(Event1)
where event.Type <> Event1.Type 
and event.time < Event1.time
with p, collect(event.Type + Event1.Type) as Mark
return count(Mark)as Number_of_Sequence_Action, Mark as Sequence_of_actions
order by Number_of_Sequence_Action DESC Limit 1 

// PD3 How many purchase orders were created
//from the events Perspective
match (e:events{Type:"Create Purchase Order"})
return count(e) as Amount_of_Purchase_Order
// Or from the objects perspective 
match (o:objects{Type:"purchase_order"})
return count(o) as Amount_of_Purchase_Order
// note that objects should provide the inccorrect answer, given how CSV works. 
// PD4 Given that the purchase order is over $5000, how many requisitions were approved after creating and how many were denied?
    match (purchase_order:objects{Type:"purchase_order"})
    match (payment:objects{Type:"payment"})
    match p1 = (purchase_order)-[]->(payment)
    where payment.Amount < 5000
    match (Event1:events{Type:"Approve Purchase Order"})
    match (Event2:events{Type:"Create Purchase Order"})
    match p2 = (Event1)-[]->(purchase_order)<-[]-(Event2)
    match p3 = (Event1)-[]->(purchase_order)
    with count(p2) as Amount_of_Approvals, count (p3) as Total_amount
    return Amount_of_Approvals as Amount_of_Approvals, Total_amount-Amount_of_Approvals as Amount_Denied
// PD5 Which is the most likely action to proceed after approving the Purchase Order? 
// Given my knowledge i wasnt able to answer this.
// PD 6

// PD 7 
match (n:events{Type:"Execute Payment"})
match (o:objects{Type:"payment"})
match  p=(n)-[]->(o)
with o.Object_Id as id , Count(o) as Count
where Count > 1 
return id, Count 
// Process Conformance  
// PC1 Is the payment cost equal to the invoice’s cost? If there isn't, list the invoice and payment ID and the cost of both.
// Through Object-to-Object relationship
match {invoice_receipt:objects{Type:"invoice receipt"}}
match {payment:objects{Type:"payment"}}
match p=(payment)-[]->(goods_receipt)
where payment.Amount <> goods_receipt.CreditAmount
return payment.Object_Id , goods_receipt.Object_Id
// Through Object-to-Event relationships
match {invoice_receipt:objects{Type:"invoice receipt"}}
match {payment:objects{Type:"payment"}}
match {Events:events{Type:"Execute Payment"}}
match p1=(payment)<-[]-(Events)-[]->(invoice_receipt)
where payment.Amount <> goods_receipt.CreditAmount
return payment.Object_Id , goods_receipt.Object_Id
//  PC2 Were any requisitions not created by the manufacturing department and not approved by the Procurement Requisition Manager? If not specify the object.
match {Create_requisition:events{Type:"Create Purchase Requisition"}}
match {Approval_Requisition:events{Type:"Approve Purchase Requisition"}}
match {object:objects{Type:"Purchase_Order"}}
match p= (Create_requisition)-[]->(object)<-[]-(Approval_Requisition)
where Create_requisition.resource <> "Manufacturing Department" and Approval_Requisition.resource <> "Procurement Requisition Manager"
return object.Object_Id as Not_approved_Correctly
// PC3 Are there any duplicated payments that occurred? If so, what are the associated Invoices that are being duplicated.

// Cannot be done. 

// Process Performance
// PP1
//cannot be done. 

//Join Query Testing.  
//Chain of relationship. 
//1st Chain 
match (e:events{Type:"Approve Purchase Order"})
match (o:objects{Type:"purchase_order"})
match p = (e)-[]->(o)
return  e.Event_Id, e.Type, o.Object_Id,o.Type
//2nd Chain 
match (e:events{Type:"Approve Purchase Order"})
match (o:objects{Type:"purchase_order"})
match (f:events)
where f.Type <> "Approve Purchase Order"
match p = (e)-[]->(o)<-[]-(f)
return  e.Event_Id, e.Type, o.Object_Id,o.Type,f.Event_Id,f.Object_Id


//3rd Chain 
match (e:events{Type:"Approve Purchase Order"})
match (o:objects{Type:"purchase_order"})
match (f:events)
match (o1:objects{Type:"quotation"})
where f.Type <> "Approve Purchase Order"
match p = (e)-[]->(o)<-[]-(f)-[]->(o1)
return  e.Event_Id, e.Type, o.Object_Id,o.Type,f.Event_Id,f.Object_Id,o1.Object_Id,o1.Type


//4th Chain 
match (e:events{Type:"Approve Purchase Order"})
match (o:objects{Type:"purchase_order"})
match (f:events)
match (o1:objects{Type:"quotation"})
match (g:events)
where f.Type <> "Approve Purchase Order" and g.Type <> "Approve Purchase Order"
match p = (e)-[]->(o)<-[]-(f)-[]->(o1)<-[]-(g)
return  e.Event_Id, e.Type, o.Object_Id,o.Type,f.Event_Id,f.Object_Id,o1.Object_Id,o1.Type,g.Type,g.Event_Id

//5th Chain 

match (e:events{Type:"Approve Purchase Order"})
match (o:objects{Type:"purchase_order"})
match (f:events)
match (o1:objects{Type:"quotation"})
match (g:events)
match (o2:objects{Type:"purchase_requisition"})
where f.Type <> "Approve Purchase Order" and g.Type <> "Approve Purchase Order"
match p = (e)-[]->(o)<-[]-(f)-[]->(o1)<-[]-(g)-[]->(o2)
return  e.Event_Id, e.Type, o.Object_Id,o.Type,f.Event_Id,f.Object_Id,o1.Object_Id,o1.Type,g.Type,g.Event_Id,o2.Object_Id,o2.Type



//Split-merge Queries. 
// Split-merge as Two Query. 
match (e:events{Type:"Approve Purchase Order"})
match (o1:objects{Type:"purchase_order"})
match (o2:objects{Type:"quotation"})
match (e1:events)
match (e2:events)
where e1.Type <> "Approve Purchase Order" and e2.Type <> "Approve Purchase Order"
match p1 = (e)-[]->(o1)<-[]-(e1)
match p2 = (e)-[]->(o2)<-[]-(e2)
return e.Event_Id,o1.Object_Id,e1.Event_Id,o2.Object_Id,e2.Event_Id
// Split-Merg as One Query. 
match (e:events{Type:"Approve Purchase Order"})
match (o1:objects{Type:"purchase_order"})
match (o2:objects{Type:"quotation"})
match (e1:events)
match (e2:events)
where e1.Type <> "Approve Purchase Order" and e2.Type <> "Approve Purchase Order"
match p1 = (e2)-[]->(o2)<-[]-(e)-[]->(o1)<-[]-(e1)
return e.Event_Id,o1.Object_Id,e1.Event_Id,o2.Object_Id,e2.Event_Id