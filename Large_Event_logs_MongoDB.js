// Process Discovery 
// PD1 What is the most frequent actions that occurs throughout this process?
db.getCollection('Events').aggregate([
  {$group: {
    _id:"$type",
    count: {
       $sum:1
    }
   }},
   {$sort:{
   count:-1
   }},
   {$limit:1}
])
// PD2 What is the most frequent actions that occurs sequentially

// PD3 How many purchase orders were created?
// Events Perspective 
db.getCollection("Events").aggregate([
  {$match:{
    "type":"Create Purchase Order"
  }},
  {$group: {
    _id:{e:"$type"},
    count: {
       $sum:1
    }
   }},
   {$sort:{
   count:-1
   }},
   {$limit:1}
])
// or Objects Perspective 
db.getCollection("Objects").aggregate([
  {$match:{
    "type":"purchase_order"
  }},
  {$group:{
    _id:"$type",
    count:{$sum:1}
  }}
])
// PD4 Given that the purchase order is over $5000, how many requisitions were approved after creating and how many were denied?

// PD5 Which is the most likely action to precede after approving the Purchase Order.

// PD6 What are the actions that occur from creating a requisition to creating an invoice? List out the actions for each requisition.

//  PD7 List out each duplicated payments, as well as how many duplicated payments occurred for each 
db.getCollection("Objects").aggregate([
  {$match:{"type": "Execute Payment"}},
  {$unwind:"$relationships"},
  {$match:{
   "relationships.objectId":{$regex:/payment/}
  }},
  {$group:{
  _id:"$relationships.objectId",
  count:{$sum:1}
  }},
  {$match:{count:{$gt:1}}},
  {$sort:{count:-1}}
])
// Process Conformance
// PC1 Is the payment  cost equal to the invoice’s cost? If there isn't, list the invoice and payment ID and the cost of both.

// PC2 Were any requisitions not created by the manufacturing department and not approved by the Procurement Requisition Manager? If not specify the object.

// PC3  Are there any duplicated payments that occurred? If so, what are the associated Invoices that are being duplicated

// Process Performance. 
// PP1 What is the longest process to occur within the organisation? 

// Join Query Testing
// Chain of Relationship 
// 1st Chain
db.getCollection("Events").aggregate([
    {$match: {
        "type":"Approve Purchase Order"
      }},
       {$lookup: {
         from: "Objects",
         localField: "relationships.objectId",
         foreignField: "id",
         as: "purchase_order"
       }},
       {$unwind:"$purchase_order"},
       {$match:{"purchase_order.type":"purchase_order"}}
])
//2nd Chain
db.getCollection("Events").aggregate([
  {$match: {
      "type":"Approve Purchase Order"
    }},
     {$lookup: {
       from: "Objects",
       localField: "relationships.objectId",
       foreignField: "id",
       as: "purchase_order"
     }},
     {$unwind:"$purchase_order"},
     {$match:{"purchase_order.type":"purchase_order"}},
     {$lookup: {
      from: "Events",
      localField: "purchase_order.attributes.time",
      foreignField: "time",
      as: "Events_1"
    }},
    {$unwind:"$Events_1"},
    {$match:{$and:[
      {"Event_1.type":{$not:{$regex:/Approve Purchase Order/}}}
    ]}}
])
// 3rd Chain
db.getCollection("Events").aggregate([
  {$match: {
      "type":"Approve Purchase Order"
    }},
     {$lookup: {
       from: "Objects",
       localField: "relationships.objectId",
       foreignField: "id",
       as: "purchase_order"
     }},
     {$unwind:"$purchase_order"},

     {$match:{"purchase_order.type":"purchase_order"}},

     {$lookup: {
      from: "Events",
      localField: "purchase_order.attributes.time",
      foreignField: "time",
      as: "Events_1"
    }},
    {$unwind:"$Events_1"},
    {$match:{$and:[
      {"Events_1.type":{$not:{$regex:/Approve Purchase Order/}}}
    ]}},
    {$lookup: {
      from: "Objects",
      localField: "Events_1.relationships.objectId",
      foreignField: "id",
      as: "quotation"
    }},
    {$unwind:"$quotation"},
    {$match:{
      "quotation.type":"quotation"
    }}
])
//4th Chain
db.getCollection("Events").aggregate([
  {$match: {
      "type":"Approve Purchase Order"
    }},
     {$lookup: {
       from: "Objects",
       localField: "relationships.objectId",
       foreignField: "id",
       as: "purchase_order"
     }},
     {$unwind:"$purchase_order"},

     {$match:{"purchase_order.type":"purchase_order"}},

     {$lookup: {
      from: "Events",
      localField: "purchase_order.attributes.time",
      foreignField: "time",
      as: "Events_1"
    }},
    {$unwind:"$Events_1"},
    {$match:{$and:[
      {"Events_1.type":{$not:{$regex:/Approve Purchase Order/}}}
    ]}},
    {$lookup: {
      from: "Objects",
      localField: "Events_1.relationships.objectId",
      foreignField: "id",
      as: "quotation"
    }},
    {$unwind:"$quotation"},
    {$match:{
      "quotation.type":"quotation"
    }},
    {$lookup: {
      from: "Events",
      localField: "quotation.attributes.time",
      foreignField: "time",
      as: "Event_2"
    }},
    {$match:{$and:[
      {"Events_2.type":{$not:{$regex:/Approve Purchase Order/}}},
    ]}}

])
// 5th Chain 
db.getCollection("Events").aggregate([
  {$match: {
      "type":"Approve Purchase Order"
    }},
     {$lookup: {
       from: "Objects",
       localField: "relationships.objectId",
       foreignField: "id",
       as: "purchase_order"
     }},
     {$unwind:"$purchase_order"},

     {$match:{"purchase_order.type":"purchase_order"}},

     {$lookup: {
      from: "Events",
      localField: "purchase_order.attributes.time",
      foreignField: "time",
      as: "Events_1"
    }},
    {$unwind:"$Events_1"},
    {$match:{$and:[
      {"Events_1.type":{$not:{$regex:/Approve Purchase Order/}}}
    ]}},
    {$lookup: {
      from: "Objects",
      localField: "Events_1.relationships.objectId",
      foreignField: "id",
      as: "quotation"
    }},
    {$unwind:"$quotation"},
    {$match:{
      "quotation.type":"quotation"
    }},
    {$lookup: {
      from: "Events",
      localField: "quotation.attributes.time",
      foreignField: "time",
      as: "Events_2"
    }},
    {$match:{$and:[
      {"Events_2.type":{$not:{$regex:/Approve Purchase Order/}}},
    ]}},
    {$lookup:{
      from: "Objects",
      localField: "Events_2.relationships.objectId",
      foreignField: "id",
      as: "purchase_requisition"
    }},
    {$unwind:"$purchase_requisition"},
    {$match:{"purchase_requisition.type":"purchase_requisition"}}
  
])
// Split-Merge Relationship 
db.getCollection("Events").aggregate([
  {$match: {
    "type":"Approve Purchase Order"
  }},
   {$lookup: {
     from: "Objects",
     localField: "relationships.objectId",
     foreignField: "id",
     as: "Objects_1"
   }},

   {$unwind:"$Objects_1"},
   {$match:{$or:[{"Objects_1.type":"purchase_order"},
  {"Objects_1.type":"quotation"}]}},
  {$lookup: {
    from: "Events",
    localField: "Objects_1.attributes.time",
    foreignField: "time",
    as: "Events_1"
  }},
  {$unwind:"$Events_1"},
  {$match:{$and:[
    {"Events_1.type":{$not:{$regex:/Approve Purchase Order/}}},
    {"Events_1.relationships.qualifier":"purchase_order"}
  ]}},
  {$lookup:{
    from: "Objects",
    localField: "Events_1.relationships.objectId",
    foreignField: "id",
    as: "Objects_2"
  }},
  {$unwind:"$Objects_2"},
  {$match:{"Objects_2.type":"purchase_order"}},

    {$lookup:{
    from: "Events",
    localField: "Objects_1.attributes.time",
    foreignField: "time",
    as: "Events_2"
  }},
  {$unwind:"$Events_2"},
  {$match:{$and:[
    {"Events_2.type":{$not:{$regex:/Approve Purchase Order/}}},
    {"Events_2.relationships.qualifier":"quotation"}
  ]}},
  {$lookup:{
    from: "Objects",
    localField: "Events_2.relationships.objectId",
    foreignField: "id",
    as: "Objects_3"
  }},
  {$unwind:"$Objects_3"},
  {$match:{"Objects_3.type":"quotation"}}
])
