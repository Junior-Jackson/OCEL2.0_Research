// D1 What is the most frequent action that occurs throughout this process? 
db.getCollection('Events').aggregate([
  {$group: {
    _id:"$Attributes.Event_Type",
    count: {
       $sum:1
    }
   }},
   {$sort:{
   count:-1
   }},
   {$limit:1}
])
// D2 What is the most frequent action that occurs sequentially?

//Cannot be done 

// D3 How many requisition were successfully delivered?
db.getCollection('Events').aggregate([ {
  $match:{"Attributes.Event_Type":"Process_Order_Completed"}
},
{$count:"Process_Order_Completed"}])
// D4 How many requisition require approval from the department heads, and compare this to the requisition amount valued above 10,000 Dollars?
// First Half 
db.getCollection('Events').aggregate([
  {$match:{"Attributes.Event_Type":"Approval_Department_Head"}},
  {$group:{
      _id:"$Attributes.Event_Type",
      Count:{$sum:1}
  }}
])
// Second Half
db.getCollection("Events").aggregate([
  {
      $match:{
          "Attributes.Event_Type":"Convert_To_Phurcase_Order"
      }
  },
{    $lookup:{
      from:"Objects",
      localField:"Object_Relationships.ObjectId",
      foreignField:"_id",
      as:"Object_Details"
  }},
  {
      $match:{
              "Object_Details.Attributes.Type":"Requisition"
  }},
  {$lookup:{
    from:"Objects",
    localField:"Object_Relationships.ObjectId",
    foreignField:"_id",
    as:"Phurcase_Order"
}},
{$match:{"Phurcase_Order.Attributes.Type":"Phurcase_Order"}},
{$match:{"Phurcase_Order.Attributes.Total_Cost":{$gt:10000}}},
  {$group:{
      _id:"$_id",
      Count:{$sum:1}
  }}
])
// D5 Given the requisition value above 10,000 dollars, how many of these given requisition were denied (with the exclusion of the ones that were approved by the staff?

// i wasn't able to answer this 

//Process Conformance 
//C1 Are there any orders marked completed before receiving the goods? If so, how many and list out the orders

// i wasn't able to answer this 

//C2 Are any requisition not approved by the supervisor and/or the budget manger that continued afterwards? If so name the requisition and name of the staffs.
// i wasn't able to answer this 

//C3 Are there any materials supplied that are not the same as the ones stated in the purchase order? If so, state the material name with the associated amount with the location of where the material are stored.

// i wasn't able to answer this 

//C4 Were all of the invoices paid by the supervisor? If there are any that are not, state which invoice and the material associated with the invoice.

// i wasn't able to answer this 

//Process Performance

//P1 Out of which staff took the longest to approve the requisition and what was the associated time? 

//Timestmap isnt supported 

//P2 For requisitions that were created during January, what was the average time spent approving requisitions from the supervisor? 

//Timestamp isnt support. 

//Add new questions.
//MD5 When converting from Requisition to phurcase order, were there any other object that were created other than the Phurcase Order? 
db.getCollection("Events").aggregate([
  {$match:{"Attributes.Event_Type":"Convert_To_Purchase_Order"}},
  {
    $unwind: "$Object_Relationships"
  },
  {$match:{
    $and:[
      {"Object_Relationships.ObjectId":{
        $not:{$regex:/Requisition/}
      }},
      {"Object_Relationships.ObjectId":{
        $not:{$regex:/Purchase\_Order/}
      }},
      {"Object_Relationships.ObjectId":{
        $not:{$regex:/Staff/} 
      }}
    ]}
  },
  {
    $group: {
      _id: "$Object_Relationships.ObjectId",
      count: { $sum: 1 },
    }
  },
])
//MD6 When the purchase order was sent, were there any of the same Purchase orders that was sent multiple times? 
db.getCollection("Events").aggregate([
  {$match: {
    "Attributes.Event_Type":"Purchase_Order_Sent"
  }},
  {$unwind:"$Object_Relationships"
  },
  {
    $match: { "Object_Relationships.ObjectId": { $regex: /^PhurcaseOrder:\d+$/ } }
  },
    {
    $group: {
      _id: "$Object_Relationships.ObjectId",
      count: { $sum: 1 }
    }
  },
  { $match: { count:{$gt:1} } }
  
])
//MD7 Were all invoices paid by the supervisors, if there are any that are not, state which invoice?
db.getCollection("Events").aggregate([
  {$match:{"Attributes.Event_Type":"Pays_Invoice"}},
  {$lookup: {
    from:"Objects",
    localField: "Object_Relationships.ObjectID",
    foreignField: "_id",
    as:"results"
  }},
  {
    $unwind:"$results"
  },
  {$match:{
    $and:[
      {"results.Attributes.Type":"Staff"},
      {"results.Attributes.Staff_Type": "Supervisor" } //Remove the ne part, to test if it works with current data.
    ]
  }},
  {
    $project: {
      _id:0,
      EventType:"$Attributes.Event_Type",
      Invoice:"$Object_Relationships.ObjectId",
      EmployeeName:"$results.Attributes.Employee_Name"
    }
  }
])





