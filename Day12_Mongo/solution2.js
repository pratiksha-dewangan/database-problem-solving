/************************************\
|*          MongoDB Part-1          *|
\************************************/

const empl = [
  {
    no: 1,
    name: "ST",
    salary: 2000,
    role: "OB"
  },
  {
    no: 2,
    name: "MSD",
    salary: 1500,
    role: "WK"
  },
  {
    no: 3,
    name: "YS",
    salary: 1000,
    role: "ALR"
  },
  {
    no: 4,
    name: "RD",
    salary: 1000,
    role: "MOB"
  },
  {
    no: 5,
    name: "RS",
    salary: 500,
    role: "OB"
  },
  {
    no: 6,
    name: "BK",
    salary: 500,
    role: "MOB"
  },
  {
    no: 7,
    name: "VK",
    salary: 300,
    role: "BW"
  },
  {
    no: 8,
    name: "JB",
    salary: 400,
    role: "BW"
  },
  {
    no: 9,
    name: "HP",
    salary: 400,
    role: "ALR"
  },
  {
    no: 10,
    name: "VS",
    salary: 300,
    role: "OB"
  }
];

// Created Database and switch to DB emp
$ use emp

// Create Collection
$ db.createCollection("empl")

// Insert Records Into empl Collection
$ db.empl.insertMany(empl)

================================================================================
1. Update Salary Of Employee where Name is "ST" by +8000

Sol:

$ db.empl.updateOne({name: "ST"}, {$inc: {salary: 8000}})

================================================================================
2. Update Salary Of All Employee by giving an increment of +4000 each

Sol:

$ db.empl.updateMany({}, {$inc: {salary: 4000}})

================================================================================
3. Update role of "MSD" as "C and WK"

Sol:

$ db.empl.updateOne({name: "MSD"}, {$set: {role: "C and WK"}})

================================================================================
4. Add a New Field remark to document with name "RS" set Remark as WC

Sol:

$ db.empl.updateOne({name: "RS"}, {$set: {remark: "WC"}})

================================================================================
5. Add a New Field As Number 11,name AK,Salary 10000,role coach without using insert statement.
   But for Doing So You should have a Record Added woth number 11.

Sol:

$ db.empl.updateOne(
    {no: 11},
    {
      $set: {
        name: "AK",
        salary: 10000,
        role: "coach"
      }
    },
    {upsert: true}
  )

================================================================================
6. Remove added New Field

Sol:

$ db.empl.deleteOne({no: 11})

================================================================================
7. Update the Field "RD" by multiplying with salary by 2

Sol:

$ db.empl.updateOne({name: "RD"}, {$mul: {salary: 2}})

================================================================================
|                              Regular Expressions                             |
================================================================================
8. To Find Document From the empl collection where name begins with S

Sol:

$ db.empl.find({name: /^S/})

================================================================================
9. To Find Document From the empl collection where name begins with R

Sol:

$ db.empl.find({name: /^R/})

================================================================================
10. To Find Document From the empl collection where name ends with K

Sol:

$ db.empl.find({name: /K$/})

================================================================================
11. To Find Document From the empl collection where name ends with D

Sol:

$ db.empl.find({name: /D$/})

================================================================================
12. To Find Document From the empl collection where name has S in any position

Sol:

$ db.empl.find({name: /^.*S.*$/})

================================================================================
|                             Use of $in and $nin                              |
================================================================================
13. Display Documents where in empl collection Field have OB, MOB

Sol:

$ db.empl.find({
    role: {
      $in: ["OB", "MOB"]
    }
  })

================================================================================
14. Display Documents where in empl collection Field not have OB,MOB

Sol:

$ db.empl.find({
    role: {
      $nin: ["OB", "MOB"]
    }
  })
