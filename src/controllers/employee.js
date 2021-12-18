let {pool} = require('./index.controller')

const getEmployees = async (req, res) => {
    const response = await pool.query('select * from employees');
    res.status(200).json(response.rows);
  };
  const getSalary = async (req, res) => {
    const response = await pool.query('select * from totals_salary');
    res.status(200).json(response.rows);
  };
  const getServants = async (req, res) => {
    const response = await pool.query('select * from servants');
    res.status(200).json(response.rows);
  };
  const getTrainers = async (req, res) => {
    const response = await pool.query('select * from trainers');
    res.status(200).json(response.rows);
  };
  const getTrainersbyId = async (req, res) => {
    const id = req.params.id;
    const response = await pool.query('select * from trainers WHERE emp_id  = $1', [id])
    res.json(response.rows);
  };
  const getTrainersMembers = async (req, res) => {
    const id = req.params.id;
    let response = await pool.query('select * from trainers_members WHERE member_id  = $1', [id])
    let trainers = [];
    for (let index = 0; index < response.rows.length; index++) {
      ;
      let e= await pool.query('select * from trainers WHERE emp_id = $1', [response.rows[index].emp_id])
      trainers.push(e.rows[0])
    };
    res.json(trainers);
  
  };
  const createEmployees = async (req, res) => {
    const { name, surname, salary } = req.body;
    const response = await pool.query('INSERT INTO employees (name, surname, salary) VALUES ( $1, $2, $3  )', [name, surname, salary]);
    console.log(response);
    res.json({
      message: "Employee added succuesfully",
      body: {
        employees: { name, surname, salary }
      }
    })
  };
  const createServants = async (req, res) => {
    const { name, surname, salary } = req.body;
    const response = await pool.query('INSERT INTO servants (name, surname, salary) VALUES ( $1, $2, $3  )', [name, surname, salary]);
    console.log(response);
    res.json({
      message: "Servant added succuesfully",
      body: {
        servant: { name, surname, salary }
      }
    })
  };
  const createTrainers = async (req, res) => {
    const { name, surname, salary } = req.body;
    const response = await pool.query('INSERT INTO employees (name, surname, salary) VALUES ( $1, $2, $3  )', [name, surname, salary]);
    console.log(response);
    res.json({
      message: "Trainer added succuesfully",
      body: {
        employees: { name, surname, salary }
      }
    })
  };
  const createTrainersMembers = async (req, res) => {
    const { member_id, emp_id } = req.body;
    const response = await pool.query('INSERT INTO trainers_members ( member_id, emp_id ) VALUES ( $1, $2 )', [member_id, emp_id]);
    console.log(response);
    res.json({
      message: "Trainer added for member succuesfully",
      body: {
        trainers_members: { member_id, emp_id }
      }
    })
  };
  const updateEmployees = async (req, res) => {
    const id = req.params.id;
    const { name, surname, salary } = req.body;
    const response = await pool.query('UPDATE employees SET name = $1, surname = $2, salary = $3   WHERE emp_id = $4', [
      name,
      surname,
      salary,
      id
    ])
    console.log(response);
    res.json('Employee updated succesfully');
  
  };
  const updateTrainers = async (req, res) => {
    const id = req.params.id;
    const { name, surname, salary } = req.body;
    const response = await pool.query('UPDATE employees SET name = $1, surname = $2, salary = $3   WHERE emp_id = $4', [
      name,
      surname,
      salary,
      id
    ])
    console.log(response);
    res.json('Trainer updated succesfully');
  
  };
  const updateTrainersMembers= async (req, res) => {
    const id = req.params.id;
    const { emp_id } = req.body;
    const response = await pool.query('UPDATE trainers_members SET emp_id = $1,    WHERE member_id = $2', [
      emp_id,
      id
    ])
    console.log(response);
    res.json('Membership updated succesfully');
  
  };
  const updateServants = async (req, res) => {
    const id = req.params.id;
    const { name, surname, salary } = req.body;
    const response = await pool.query('UPDATE employees SET name = $1, surname = $2, salary = $3   WHERE emp_id = $4', [
      name,
      surname,
      salary,
      id
    ])
    console.log(response);
    res.json('Servant updated succesfully');
  
  };
const deleteEmployees = async (req, res) => {
    const id = req.params.id;
    const response = await pool.query('delete from employees where emp_id = $1', [id]);
    console.log(response);
    res.json(`Employee ${id} deleted successfuly`);
  
  };
  const deleteTrainers = async (req, res) => {
    const id = req.params.id;
    const response = await pool.query('delete from trainers where emp_id = $1', [id]);
    console.log(response);
    res.json(`Employee ${id} deleted successfuly`);
  
  };
  const deleteServants = async (req, res) => {
    const id = req.params.id;
    const response = await pool.query('delete from servants where emp_id = $1', [id]);
    console.log(response);
    res.json(`Employee ${id} deleted successfuly`);
  
  };

  module.exports ={
      getEmployees,
      getSalary,
      getServants,
      getTrainers,
      getTrainersbyId,
      getTrainersMembers,
      createEmployees,
      createServants,
      createTrainers,
      createTrainersMembers,
      updateEmployees,
      updateServants,
      updateTrainers,
      updateTrainersMembers,
      deleteEmployees,
      deleteServants,
      deleteTrainers
  }