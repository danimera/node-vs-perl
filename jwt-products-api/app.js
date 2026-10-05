const express = require('express');
const dotenv = require('dotenv');
const cors = require('cors');
const path = require('path');

dotenv.config({ path: path.join(__dirname, '.env') });

const auth = require('./middleware/auth');
const productsRouter = require('./routes/products');

const app = express();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3001;

app.post('/login', (req, res) => {
  const { username, password } = req.body || {};
  if (!username || !password) return res.status(400).json({ error: 'username and password required' });

  // Simple hardcoded credentials for demo purposes
  if (username === 'admin' && password === 'password') {
    const jwt = require('jsonwebtoken');
    const token = jwt.sign({ username }, process.env.JWT_SECRET || 'change_this_secret', { expiresIn: '1h' });
    return res.json({ token });
  }

  return res.status(401).json({ error: 'Invalid credentials' });
});

app.get('/status', (req, res) => res.json({ status: 'ok' }));

app.use('/products', auth, productsRouter);

app.listen(PORT, () => console.log(`Server listening on port ${PORT}`));
