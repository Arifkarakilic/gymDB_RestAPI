let {pool} = require('./index.controller')

const getMember = async (req, res) => {
    const response = await pool.query('select * from members');
    res.status(200).json(response.rows);
  };
  const getTotalMember = async (req, res) => {
    const response = await pool.query('select * from totals_member');
    res.status(200).json(response.rows);
  };
  const getTotalGuestMember = async (req, res) => {
    const response = await pool.query('select * from totals_guestmember');
    res.status(200).json(response.rows);
  };
  const getMemberbyId = async (req, res) => {
    const id = req.params.id;
    const response = await pool.query('select * from members WHERE member_id  = $1', [id])
    res.json(response.rows);
  };
  const getGuestMember = async (req, res) => {
    const response = await pool.query('select * from guest_member');
    res.status(200).json(response.rows);
  };

  const createMember = async (req, res) => {
    const { name, surname, height, weight, sex, tel, adress, membership_id } = req.body;
  
    const response = await pool.query('CALL create_member($1, $2, $3, $4, $5, $6, $7, $8 )', [name, surname, height, weight, sex, tel, adress, membership_id]);
    console.log(response);
    res.json({
      message: "Member added succuesfully",
      body: {
        members: { name, surname, height, weight, sex, tel, adress, membership_id }
      }
    })
  };
  const createGuestMember = async (req, res) => {
    const { name, surname, login, logout } = req.body;
    const response = await pool.query('CALL create_guestMember($1, $2, $3, $4 )', [name, surname, login, logout]);
    console.log(response);
    res.json({
      message: "GuestMember added succuesfully",
      body: {
        guest_member: { name, surname, login, logout }
      }
    })
  };
  const updateMember = async (req, res) => {
    const id = req.params.id;
    const { name, surname, height, weight, sex, tel, adress, membership_id } = req.body;
    const response = await pool.query('UPDATE members SET name = $1, surname = $2, height = $3, weight = $4, sex = $5, tel = $6, adress = $7, membership_id = $8   WHERE member_id = $9', [
      name,
      surname,
      height,
      weight,
      sex,
      tel,
      adress,
      membership_id,
      id
    ])
    console.log(response);
    res.json('Member updated succesfully');
  
  };

  const deleteMember = async (req, res) => {
    const id = req.params.id;
    const response = await pool.query('delete from members where member_id = $1', [id]);
    console.log(response);
    res.json(`Member ${id} deleted successfuly`);
  
  };
  const deleteGuestMember = async (req, res) => {
    const response = await pool.query('delete from guest_member where 1=1');
    console.log(response);
    res.json(`GuestMember deleted successfuly`);
  
  };
  module.exports = {
      getMember,
      getTotalMember,
      getTotalGuestMember,
      getMemberbyId,
      getGuestMember,
      createMember,
      createGuestMember,
      updateMember,
      deleteMember,
      deleteGuestMember
    }
  