[ { "_class": "Datatype", "name": "Boolean" },
{ "_class": "Class", "abstract": false, "superTypes": [ "/Classifier" ], "features": [ 
  { "_class": "Feature", "name": "abstract", "kind": "attribute", "lowerLimit": 0, "upperLimit": 1, "type": "/Boolean" },
  { "_class": "Feature", "name": "superTypes", "kind": "reference", "lowerLimit": 0, "upperLimit": -1, "type": "/Class" },
  { "_class": "Feature", "name": "features", "kind": "containment", "lowerLimit": 0, "upperLimit": -1, "type": "/Feature" }], "name": "Class" },
{ "_class": "Class", "abstract": true, "features": [ 
  { "_class": "Feature", "name": "name", "kind": "attribute", "lowerLimit": 0, "upperLimit": 1, "type": "/String" }], "name": "Classifier" },
{ "_class": "Class", "abstract": false, "superTypes": [ "/Classifier" ], "name": "Datatype" },
{ "_class": "Class", "abstract": false, "superTypes": [ "/Datatype" ], "features": [ 
  { "_class": "Feature", "name": "literals", "kind": "attribute", "lowerLimit": 0, "upperLimit": -1, "type": "/String" }], "name": "Enum" },
{ "_class": "Class", "abstract": false, "features": [ 
  { "_class": "Feature", "name": "name", "kind": "attribute", "lowerLimit": 0, "upperLimit": 1, "type": "/String" },
  { "_class": "Feature", "name": "kind", "kind": "attribute", "lowerLimit": 0, "upperLimit": 1, "type": "/FeatureKind" },
  { "_class": "Feature", "name": "lowerLimit", "kind": "attribute", "lowerLimit": 0, "upperLimit": 1, "type": "/Integer" },
  { "_class": "Feature", "name": "upperLimit", "kind": "attribute", "lowerLimit": 0, "upperLimit": 1, "type": "/Integer" },
  { "_class": "Feature", "name": "type", "kind": "reference", "lowerLimit": 0, "upperLimit": 1, "type": "/Classifier" }], "name": "Feature" },
{ "_class": "Enum", "literals": [ "attribute", "reference", "containment" ], "name": "FeatureKind" },
{ "_class": "Datatype", "name": "Integer" },
{ "_class": "Datatype", "name": "String" }]
