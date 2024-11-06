# OCEL2.0_Research

This Branch provides all necessary JSON files to import and test for MongoDB's Large event logs.

These event logs that came from the JSON files are not made by me.
They are from this website, which is based on Procure-to-Pay. A description of the scenario is also provided here. 
They are made by the Chair of Process and Data Science, RWTH Aachen University
https://www.ocel-standard.org/event-logs/overview/

Note when Importing:
Although you can import the data strictly from the original source without any edits, it will only import as one Document. 
I have removed the first "{"events":[" section and removed the last "]}" and imported it through Visual Studio Code. This will show all objects/events as seperate documents. This cannot be done through MongoDB Compass. 
The files presented here provide the edited version to import to MongoDB.
