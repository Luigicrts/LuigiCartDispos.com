// Luigi Carts Clone – React + Tailwind

import { useState } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { BrowserRouter as Router, Route, Routes, Link, useNavigate } from "react-router-dom";

const products = [
  // product list remains unchanged
  {
    name: "Luigi 2G Disposable",
    price: "$30.00",
    image: "/images/luigi-2g-1.png",
  },
  {
    name: "Luigi 2G Disposable",
    price: "$25.00",
    image: "/images/luigi-2g-2.png",
  },
  {
    name: "Luigi 2G Disposable – 25 pack box",
    price: "$250.00",
    image: "/images/luigi-2g-3.png",
  },
  {
    name: "Luigi 2G Disposable – Pack of 100",
    price: "$900.00",
    image: "/images/luigi-2g-4.png",
  },
  {
    name: "Luigi 2G Disposable – Pack of 250",
    price: "$2,100.00",
    image: "/images/luigi-2g-5.png",
  },
  {
    name: "Luigi 2G Disposable – Pack of 50",
    price: "$500.00",
    image: "/images/luigi-2g-6.png",
  },
  {
    name: "Luigi 2G Disposable – Pack of 500",
    price: "$4,000.00",
    image: "/images/luigi-2g-7.png",
  },
  {
    name: "Luigi Banana Gelato Disposable",
    price: "$30.00",
    image: "/images/banana-gelato-1.png",
  },
  {
    name: "Luigi Banana Gelato Disposable",
    price: "$25.00",
    image: "/images/banana-gelato-2.png",
  },
  {
    name: "Luigi Banana Gelato Disposable",
    price: "$25.00",
    image: "/images/banana-gelato-3.png",
  },
  {
    name: "Luigi Banana Gelato Fatone Pre Roll",
    price: "$10.00",
    image: "/images/banana-fatone.png",
  },
  {
    name: "Luigi Blackberry Dream Disposable",
    price: "$25.00",
    image: "/images/blackberry-dream.png",
  },
];

function Shop({ addToCart }) {
  return (
    <main className="bg-black min-h-screen p-6 grid grid-cols-1 md:grid-cols-3 gap-6">
      {products.map((product, idx) => (
        <Card key={idx} className="bg-white text-black shadow-lg">
          <img src={product.image} alt={product.name} className="w-full rounded-t-xl" />
          <CardContent className="p-4">
            <h2 className="text-xl font-semibold mb-2">{product.name}</h2>
            <p className="mb-2">{product.price}</p>
            <Button onClick={() => addToCart(product)} className="bg-black text-white hover:bg-gray-800">Add to Cart</Button>
          </CardContent>
        </Card>
      ))}
    </main>
  );
}

function Cart({ cart }) {
  return (
    <div className="bg-black text-white p-6 min-h-screen">
      <h2 className="text-2xl font-bold mb-4">Your Cart</h2>
      {cart.length === 0 ? (
        <p>Your cart is empty.</p>
      ) : (
        <ul className="space-y-4">
          {cart.map((item, idx) => (
            <li key={idx} className="bg-gray-800 p-4 rounded-lg flex items-center gap-4">
              <img src={item.image} alt={item.name} className="w-16 h-16 rounded object-cover" />
              <div>
                <p className="font-semibold">{item.name}</p>
                <p>{item.price}</p>
              </div>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

function OrderPage({ cart }) {
  const navigate = useNavigate();

  const handlePlaceOrder = () => {
    alert("Thank you for your order! Please follow the payment instructions.");
    navigate("/");
  };

  return (
    <div className="bg-black text-white p-6 min-h-screen grid grid-cols-1 md:grid-cols-2 gap-6">
      <div>
        <h2 className="text-2xl font-bold mb-4">Billing Details</h2>
        <form className="space-y-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <input type="text" placeholder="First name" className="p-3 rounded w-full bg-gray-800 text-white" required />
            <input type="text" placeholder="Last name" className="p-3 rounded w-full bg-gray-800 text-white" required />
          </div>
          <input type="text" placeholder="Company name (optional)" className="p-3 rounded w-full bg-gray-800 text-white" />
          <input type="text" placeholder="Street address" className="p-3 rounded w-full bg-gray-800 text-white" required />
          <input type="text" placeholder="Apartment, suite, unit, etc. (optional)" className="p-3 rounded w-full bg-gray-800 text-white" />
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <input type="text" placeholder="City" className="p-3 rounded w-full bg-gray-800 text-white" required />
            <input type="text" placeholder="State" className="p-3 rounded w-full bg-gray-800 text-white" required />
            <input type="text" placeholder="ZIP Code" className="p-3 rounded w-full bg-gray-800 text-white" required />
          </div>
          <input type="text" placeholder="Phone" className="p-3 rounded w-full bg-gray-800 text-white" required />
          <input type="email" placeholder="Email address" className="p-3 rounded w-full bg-gray-800 text-white" required />
        </form>
      </div>

      <div className="bg-gray-900 text-white p-6 rounded-lg border border-gray-700">
        <h3 className="text-xl font-semibold mb-4">Your Order</h3>
        <ul className="mb-4">
          {cart.map((item, idx) => (
            <li key={idx} className="flex justify-between border-b border-gray-600 py-2">
              <span>{item.name}</span>
              <span>{item.price}</span>
            </li>
          ))}
        </ul>
        <p className="mb-2">Total: <strong>{`$${cart.reduce((sum, item) => sum + parseFloat(item.price.replace('$', '')), 0).toFixed(2)}`}</strong></p>
        <div className="mb-4">
          <h4 className="font-bold mb-2">Payment Methods</h4>
          <ul className="space-y-2">
            <li>
              <strong>Bitcoin:</strong> bc1qqzv4v465rpra420mkrz9v8z6mh3mx3tc4f92fg
              <p className="text-sm text-gray-400">Send the total to this wallet address.</p>
            </li>
            <li><strong>Cash App:</strong> <span className="text-green-400 text-2xl">💵</span></li>
          </ul>
        </div>
        <Button onClick={handlePlaceOrder} className="w-full bg-green-600 hover:bg-green-700 text-white font-bold py-2">PLACE ORDER</Button>
      </div>
    </div>
  );
}

function ContactPage() {
  return (
    <div className="bg-black text-white p-6 min-h-screen">
      <h2 className="text-2xl font-bold mb-4">Contact Us</h2>
      <p>Email: contact@luigicarts.com</p>
      <p>Instagram: @luigicarts</p>
    </div>
  );
}

function Home() {
  return (
    <div className="bg-black text-white text-center p-12 min-h-screen">
      <h1 className="text-4xl font-bold mb-4">Welcome to Luigi Carts</h1>
      <p className="text-lg mb-4">Premium disposables delivered discreetly and securely.</p>
      <div className="mt-6 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
        {products.map((product, idx) => (
          <div key={idx} className="bg-white text-black p-4 rounded-lg">
            <img src={product.image} alt={product.name} className="w-full rounded mb-2" />
            <h2 className="font-semibold">{product.name}</h2>
            <p>{product.price}</p>
          </div>
        ))}
      </div>
    </div>
  );
}

export default function App() {
  const [cart, setCart] = useState([]);
  const [showAgeModal, setShowAgeModal] = useState(true);

  const addToCart = (product) => {
    setCart([...cart, product]);
  };

  return (
    <Router>
      {showAgeModal && (
        <div className="fixed inset-0 bg-black bg-opacity-90 flex items-center justify-center z-50">
          <div className="bg-white text-black p-6 rounded-xl text-center">
            <p className="text-lg mb-4">Are you 21 or older?</p>
            <Button onClick={() => setShowAgeModal(false)}>Yes</Button>
          </div>
        </div>
      )}

      <header className="p-4 text-center text-2xl font-bold bg-black text-white">
        <nav className="flex justify-center gap-4">
          <Link to="/">Home</Link>
          <Link to="/shop">Shop</Link>
          <Link to="/cart">Cart</Link>
          <Link to="/order">Order</Link>
          <Link to="/contact">Contact Us</Link>
        </nav>
      </header>

      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/shop" element={<Shop addToCart={addToCart} />} />
        <Route path="/cart" element={<Cart cart={cart} />} />
        <Route path="/order" element={<OrderPage cart={cart} />} />
        <Route path="/contact" element={<ContactPage />} />
      </Routes>

      <footer className="text-center py-6 text-gray-400 text-sm bg-black">
        © {new Date().getFullYear()} Luigi Carts – This site is a replica demo.
      </footer>
    </Router>
  );
}
