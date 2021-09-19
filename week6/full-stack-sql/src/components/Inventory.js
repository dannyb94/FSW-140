import React from "react";
import { useState } from "react";
import InventoryHandler from "./InventoryHandler";


export default function Inventory({ deleteInventoryItem, editInventoryItem, product, info, price, id }){
    const [editToggle, setEditToggle] = useState(false)

    return (
        <div id="cntnr1">
            { !editToggle ?
                <>
                    <h2>Product: {product}</h2>
                    <p>Price: ${price}</p>
                    <p>Info: {info}</p>
                    {/* <button onClick={() => deleteInventoryItem(id)} id="dltBtn">Delete</button>
                    <button onClick={() => setEditToggle(prevToggle => !prevToggle)} id="editBtn">Edit</button> */}
                </>
                :   
                <>
                    <InventoryHandler  product={product}  info={info}  price={price}  btnText="Submit Edit" id={id}  submit={editInventoryItem} />
                    <button onClick={() => setEditToggle(prevToggle => !prevToggle)} id="closeBtn">Close</button>
                </>
            }
        </div>
    )
}