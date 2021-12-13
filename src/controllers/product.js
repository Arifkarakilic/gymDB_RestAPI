let {pool} = require('./index.controller')


const getProducts = async (req, res) => {
    const response = await pool.query('select * from products');
    res.status(200).json(response.rows);
  };
  const getProductsById = async (req, res) => {
    const id = req.params.id;
    const response = await pool.query('select * from products WHERE barcode  = $1', [id])
    res.json(response.rows);
  };
  const getProductSeries = async (req, res) => {
    const response = await pool.query('select * from product_series');
    res.status(200).json(response.rows);
  };
  const getSellers = async (req, res) => {
    const response = await pool.query('select * from seller');
    res.status(200).json(response.rows);
  };
  const getSales = async (req, res) => {
    const id = req.params.id;
    let response = await pool.query('select * from sales WHERE member_id  = $1', [id])
    let sales = [];
    for (let index = 0; index < response.rows.length; index++) {
      ;
      let e= await pool.query('select * from members WHERE member_id = $1', [response.rows[index].member_id])
      sales.push(e.rows[0])
    };
    res.json(sales);

  };





  const createProducts = async (req, res) => {
    const { weight, price, name, last_use_date } = req.body;
    const response = await pool.query('CALL create_product( $1, $2, $3, $4 )', [weight, price, name, last_use_date]);
    console.log(response);
    res.json({
      message: "Products added for member succuesfully",
      body: {
        products: { weight, price, name, last_use_date }
      }
    })
  };
  const createProductSeries = async (req, res) => {
    const { name, quantity, price, last_use_date, barcode,  seller } = req.body;
    const response = await pool.query('INSERT INTO product_series ( name, quantity, price, last_use_date, barcode,  seller ) VALUES ( $1, $2, $3, $4, $5, $6 )', [name, quantity, price, last_use_date, barcode,  seller]);
    console.log(response);
    res.json({
      message: "Products added for member succuesfully",
      body: {
        product_series: { name, quantity, price, last_use_date, barcode,  seller }
      }
    })
  };
  const createSellers = async (req, res) => {
    const { name, adress } = req.body;
    const response = await pool.query('INSERT INTO seller ( name, adress ) VALUES ( $1, $2 )', [name, adress]);
    console.log(response);
    res.json({
      message: "Seller added for member succuesfully",
      body: {
        seller: { name, adress }
      }
    })
  };
  const createSales = async (req, res) => {
    const { member_id, barcode } = req.body;
    const response = await pool.query('INSERT INTO seller ( member_id, barcode ) VALUES ( $1, $2 )', [member_id, barcode]);
    console.log(response);
    res.json({
      message: "Sale added for member succuesfully",
      body: {
        sales: { member_id, barcode }
      }
    })
  };









  const updateProducts = async (req, res) => {
    const id = req.params.id;
    const { weight, price, name, last_use_date } = req.body;
    const response = await pool.query('UPDATE products SET weight = $1 price = $2 name = $3 last_use_date = $4 WHERE barcode = $5', [
      weight,
      price,
      name,
      last_use_date,
      id
    ])
    console.log(response);
    res.json('Products updated succesfully');
  
  };
  const updateProductSeries = async (req, res) => {
    const id = req.params.id;
    const { name, quantity, price, last_use_date, barcode,  seller } = req.body;
    const response = await pool.query('UPDATE product_series SET name = $1 quantity = $2 price = $3 last_use_date = $4 barcode = $5 seller = $6 WHERE series_id = $7', [
      name,
      quantity,
      price,
      last_use_date,
      barcode,
      seller,
      id
    ])
    console.log(response);
    res.json('Products updated succesfully');
  
  };
  const updateSellers = async (req, res) => {
    const id = req.params.id;
    const { name, adress, } = req.body;
    const response = await pool.query('UPDATE seller SET name = $1 adress = $2 WHERE seller_id = $3', [
      name,
      category,
      id
    ])
    console.log(response);
    res.json('Seller updated succesfully');
  
  };





  const deleteProducts = async (req, res) => {
    const id = req.params.id;
    const response = await pool.query('delete from products where emp_id = $1', [id]);
    console.log(response);
    res.json(`Product ${id} deleted successfuly`);
  
  };
  const deleteProductSeries = async (req, res) => {
    const id = req.params.id;
    const response = await pool.query('delete from product_series where series_id = $1', [id]);
    console.log(response);
    res.json(`Series ${id} deleted successfuly`);
  
  };
  const deleteSellers = async (req, res) => {
    const id = req.params.id;
    const response = await pool.query('delete from product_series where series_id = $1', [id]);
    console.log(response);
    res.json(`Series ${id} deleted successfuly`);
  
  };

  module.exports ={
      getProducts,
      getProductsById,
      getProductSeries,
      getSales,
      getSellers,
      createProducts,
      createProductSeries,
      createSales,
      createSellers,
      updateProducts,
      updateProductSeries,
      updateSellers,
      deleteProducts,
      deleteProductSeries,
      deleteSellers

  }