
const memberControllers = require('../controllers/member')
const employeeControllers = require('../controllers/employee')
const productControllers = require('../controllers/product')
//const indexControllers = require('../controllers/index.controller')

const { Router } = require('express');
const router = Router();


router.get('/members', memberControllers.getMember)
router.get('/members/:id', memberControllers.getMemberbyId)
router.get('/guest_member', memberControllers.getGuestMember)
router.get('/employees', employeeControllers.getEmployees)
router.get('/trainers', employeeControllers.getTrainers)
router.get('/trainers/:id', employeeControllers.getTrainersbyId)
router.get('/trainers_members/:id', employeeControllers.getTrainersMembers)
router.get('/products', productControllers.getProducts)
router.get('/products/:id', productControllers.getProductsById)
router.get('/product_series', productControllers.getProductSeries)
router.get('/seller', productControllers.getSellers)
router.get('/totals_salary', employeeControllers.getSalary)
router.get('/totals_member', memberControllers.getTotalMember)
router.get('/totals_guestmember', memberControllers.getTotalGuestMember)

router.post('/members', memberControllers.createMember)
router.post('/guest_member', memberControllers.createGuestMember)
router.post('/employees', employeeControllers.createEmployees)
router.post('/trainers', employeeControllers.createTrainers)
router.post('/trainers_members', employeeControllers.createTrainersMembers)
router.post('/products', productControllers.createProducts)
router.post('/product_series', productControllers.createProductSeries)
router.post('/seller', productControllers.createSellers)



router.put('/members/:id', memberControllers.updateMember)
router.put('/employees/:id', employeeControllers.updateEmployees)
router.put('/trainers/:id', employeeControllers.updateTrainers)
router.put('/products', productControllers.updateProducts)
router.put('/product_series', productControllers.updateProductSeries)
router.put('/seller', productControllers.updateSellers)


router.delete('/members/:id', memberControllers.deleteMember)
router.delete('/guest_member/', memberControllers.deleteGuestMember)
router.delete('/employees/:id', employeeControllers.deleteEmployees)
router.delete('/products', productControllers.deleteProducts)
router.delete('/product_series', productControllers.deleteProductSeries)
router.delete('/seller', productControllers.deleteSellers)
module.exports = router;