# OCEL2.0_Research

This Branch provides all necessary JSON files to import and test for MongoDB's Large event logs.

I did not make these event logs that came from the CSV files. They are from this website "https://www.ocel-standard.org/event-logs/overview/", which is based on Procure-to-Pay. The scenarios (and presumably the event logs) are made by Gyunam Park and Leah Tacke genannt Unterberg, from the Chair of Process and Data Science, RWTH Aachen University. 

Note when Importing:
Although you can import the data strictly from the original source without any edits, it will only import as one Document. We want to see all individual documents. 
I have removed the first "{"events":[" section and removed the last "]}" and imported it through Visual Studio Code. This will show all objects/events as seperate documents. This cannot be done through MongoDB Compass. 
The files presented here provide the edited version to import to MongoDB.
