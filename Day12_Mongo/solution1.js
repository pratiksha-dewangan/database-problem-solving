/************************************\
|*          MongoDB Part-1          *|
\************************************/

$ const emps = [
  {
    "eno": 1,
    "ename": "Sachin",
    "sal": 6000,
    "design": "manager",
    "dept": "Purchase"
  },
  {
    "eno": 2,
    "ename": "Dhoni",
    "sal": 5000,
    "design": "manager",
    "dept": "Sales"
  },
  {
    "eno": 3,
    "ename": "Kohli",
    "sal": 3000,
    "design": "clerk",
    "dept": "Admin"
  },
  {
    "eno": 4,
    "ename": "Dravid",
    "sal": 4000,
    "design": "manager",
    "dept": "Purchase"
  },
  {
    "eno": 5,
    "ename": "Bumrah",
    "sal": 3500,
    "design": "manager",
    "dept": "Sales"
  },
  {
    "eno": 6,
    "ename": "Jadeja",
    "sal": 2500,
    "design": "clerk",
    "dept": "Admin"
  },
  {
    "eno": 7,
    "ename": "Rohit",
    "sal": 4000,
    "design": "manager",
    "dept": "Sales"
  }
];

$ db.createCollection("emps")
$ db.emps.insertMany(emps)

$ const foods = [{
    _id: 1,
    fruits: ['banana', 'apple', 'cherry']
  }, {
    _id: 2,
    fruits: ['orange', 'watermelon', 'mango']
  }, {
    _id: 3,
    fruits: ['pinaple', 'strawberry', 'grapes']
  }, {
    _id: 4,
    fruits: ['banana', 'strawberry', 'grapes']
  }, {
    _id: 5,
    fruits: ['orange', 'grapes']
}];

$ db.createCollection("foods")
$ db.foods.insertMany(foods)

================================================================================
1. List all emplyees name with their salary who are in admin department.

Sol:

$ db.emps.find({dept: "Admin"}, {ename: 1, sal: 1})

================================================================================
2. List all emplyees name with their salary and designation who are in Purchase department.

Sol:

$ db.emps.find({dept: "Purchase"}, {ename: 1, sal: 1, design: 1})

================================================================================
3. List all employees no, name, salary who are in the Sales department and Designation is Manager.

Sol:

$ db.emps.find({dept: "Sales", design: "manager"}, {design: 0, dept: 0})

================================================================================
4. Calculate Annual salary of each emplyees.

Sol:

$ db.emps.aggregate([{
    $project: {
      eno: 1,
      sal:1,
      ename: 1,
      _id: 0,
      annualSal: {
        $multiply: [ "$sal", 12 ]
      }
    }
  }])

================================================================================
5. Convert the names of the emplyees in Lower case and display only no and name of each emplyees.
   db.emp.aggregate([{$project:{eno:1,ename:1,_id:0,Employee:{$toLower:['$ename']}}}])

Sol:

$ db.emps.aggregate([{
    $project: {
      _id: 0,
      eno: 1,
      ename: 1,
      employee: { $toLower: [ "$ename" ] }
    }
  }])

================================================================================
6. Display each document of the collection emplyee the total salary of each emplyee should be displayed department wise.

Sol:

$ db.emps.aggregate([{
      $group: { _id: "$dept", employees: { $push: "$$ROOT" } }
    }
  ])

$ db.emps.aggregate([
    {
      $group: { _id: "$dept", totalSalary: { $sum: "$sal" } }
    }
  ])

================================================================================
7. Findout Total Salary manager designation wise.

Sol:

$ db.emps.aggregate([
    {
      $match: { design: "manager" }
    },
    {
      $group: { _id: "$dept", totalSalary: { $sum: "$sal" } }
    }
  ])

================================================================================
8. Find The Average Salary of each department in emp collection.

Sol:

$ db.emps.aggregate({
    $group: { _id: "$dept", averageSal: { $avg: "$sal" } }
  })

================================================================================
9. Find The MAX Salary of each department in emp collection.

Sol:

$ db.emps.aggregate({
    $group: { _id: "$dept", maxSal: { $max: "$sal" } }
  })

================================================================================
10. update The Document with null value in desig field where name is Kohli.

Sol:

$ db.emps.updateOne({ ename: "Kohli" }, { $set: {design: null} })

================================================================================
11. To remove design Field having Null Values in emp Collection.

Sol:

$ db.emps.updateMany({ design: null }, { $unset: {design: 0}})

================================================================================
12. Display those documents from in food collection
    which has fruits array consituted of banana,apple,cherry 

Sol:

$ db.foods.find({ fruits: { $in: ["banana", "apple", "cherry"] }})

================================================================================
13. Display those documents From food Collection which has fruits array
    having a banana as an element.

Sol:

$ db.foods.find({ fruits: { $in: ["banana"] }})
