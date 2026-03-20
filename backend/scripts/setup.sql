-- Novu Foods App - Database Schema
-- Run this in Railway's PostgreSQL console after deploying

-- Restaurants table
CREATE TABLE IF NOT EXISTS restaurants (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  cuisine_type TEXT DEFAULT 'General',
  rating NUMERIC(3,1) DEFAULT 0,
  image_url TEXT,
  owner_name TEXT,
  owner_email TEXT,
  owner_phone TEXT,
  address TEXT,
  description TEXT,
  store_type TEXT DEFAULT 'restaurant',
  delivery_fee NUMERIC(10,2) DEFAULT 3.00,
  delivery_time TEXT DEFAULT '30-40 min',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Menu items table
CREATE TABLE IF NOT EXISTS menu_items (
  id SERIAL PRIMARY KEY,
  restaurant_id INTEGER REFERENCES restaurants(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT,
  price NUMERIC(10,2) NOT NULL,
  category TEXT DEFAULT 'General',
  image_url TEXT,
  available BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  customer_name TEXT NOT NULL,
  customer_email TEXT,
  customer_phone TEXT,
  delivery_address TEXT NOT NULL,
  total_amount NUMERIC(10,2) NOT NULL,
  status TEXT DEFAULT 'preparing',
  estimated_delivery TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Order items table
CREATE TABLE IF NOT EXISTS order_items (
  id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES orders(id) ON DELETE CASCADE,
  menu_item_id INTEGER,
  restaurant_id INTEGER,
  item_name TEXT NOT NULL,
  quantity INTEGER NOT NULL DEFAULT 1,
  price NUMERIC(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample seed data (optional - remove if not needed)
INSERT INTO restaurants (name, cuisine_type, rating, image_url, address, description, delivery_fee, delivery_time)
VALUES
  ('Burger Palace', 'American', 4.5, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800', '123 Main St', 'Best burgers in town', 2.99, '20-30 min'),
  ('Pizza Hub', 'Italian', 4.3, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800', '456 Oak Ave', 'Authentic Italian pizzas', 1.99, '25-35 min'),
  ('Sushi World', 'Japanese', 4.7, 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=800', '789 Cherry Lane', 'Fresh sushi daily', 3.99, '30-45 min')
ON CONFLICT DO NOTHING;
