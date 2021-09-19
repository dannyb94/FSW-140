import React from "react";
import { useState } from "react";
import BobHandler from "./BobHandler";


export default function Inventory(prop){
    const [editToggle, setEditToggle] = useState(false)
    const { deleteInventoryItem, editInventoryItem, EPISODE, item, TITLE, id } = prop
    var details = Object.entries(item)
    console.log(details)
    return (
        <div id="cntnr1">
            { !editToggle ?
                <>
                <div id='div-cntnr'>
                    <h2>EPISODE: {EPISODE}</h2>
                    <p>TITLE: {TITLE}</p>
                    <p style = {{overflowY: "scroll", height: "175px"}} >{details.map(detail => {
                                    if(detail[0] === "TITLE" || detail[0] === "EPISODE" || detail[0] === "id"){
                                        return ("") 
                                    } else {
                                        return (<span> {detail[0]} : {detail[1]} <br></br> </span>)
                                    }
                                }
                            )
                        }
                    </p>
                    <button onClick={() => deleteInventoryItem(id)} id="dltBtn">Delete</button>
                    <button onClick={() => setEditToggle(prevToggle => !prevToggle)} id="editBtn">Edit</button>
                </div>
                </>
                :   
                <>
                    <BobHandler EPISODE={EPISODE}  details={details}  TITLE={TITLE}  btnText="Submit Edit" id={id}  submit={editInventoryItem} />
                    <button onClick={() => setEditToggle(prevToggle => !prevToggle)} id="closeBtn">Close</button>
                </>
            }
        </div>
    )
}