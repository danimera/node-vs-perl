const express = require('express');
const router = express.Router();

const products = [
  { id: 1, name: 'Producto A', price: 10.0 },
  { id: 2, name: 'Producto B', price: 20.5 },
  { id: 3, name: 'Producto C', price: 15.75 },
];

router.get('/', (req, res) => {
  res.json({ user: req.user, products });
});

module.exports = router;
