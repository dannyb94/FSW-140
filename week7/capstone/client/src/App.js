import { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';
import Bob from './components/Bob';
import BobHandler from './components/BobHandler';

export default function App() {
  const [inventory, setInventoryItems] = useState([]);

  const getInventory = () => {
    axios.get('http://localhost:4000/rows')
      .then(res => {
        console.log(res)
        setInventoryItems(res.data)
      })
      .catch(err => console.log(err.response.data.errMsg))
  }

  useEffect(() => {
    getInventory();
  }, [])

  const addItem = (newInventory) => {
    console.log(newInventory)
    axios.post('http://localhost:4000/rows', newInventory)
      .then(res => {
        setInventoryItems(prevInventory => [...prevInventory, res.data])
      })
      .catch(err => console.log(err))
  }

  const deleteInventoryItem = (itemId) => {
    axios.delete(`http://localhost:4000/rows/${itemId}`)
      .then(res => {
        setInventoryItems(prevInventory => prevInventory.filter(item => item._id !== itemId))
      })
      .catch(err => console.log(err.response.data.errMsg))
  }

  const editInventoryItem = (updates, itemId) => {
    axios.put(`http://localhost:4000/rows/${itemId}`, updates)
      .then(res => {
        setInventoryItems(prevInventory => prevInventory.map(item => {
          return item._id !== itemId ? item : res.data}))
      })
      .catch(err => console.log(err))
  }

  //-----------------------------------------------
  const inventoryList = inventory.map(item => <Bob {...item} item={item} deleteInventoryItem={deleteInventoryItem}  editInventoryItem={editInventoryItem}  key={item.episode} />)

  return (
    <div id='main'>
      <h1 id='BigBob'>Bob Ross</h1>
      <BobHandler  btnText='Add Item' submit= {addItem} />
      {inventoryList} 
    </div>
  );
}
