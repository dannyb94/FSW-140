import { useState } from 'react';

export default function InventoryHandler({ btnText, submit, product, info, price, id }){
    const initialInputs = { product: product || '', info: info || '', price: price || '' }
    const [inputs, setInputs] = useState(initialInputs);

    // const handleChange = (e) => {
    //     const {name, value} = e.target;
    //     setInputs(prevInputs => ({...prevInputs, [name]: value}))
    // }

    const handleSubmit = (e) => {
        e.preventDefault();
        submit(inputs, id);
        setInputs(initialInputs);
    }

    return (
        <form onSubmit={handleSubmit}>
            {/* <span id='alignIt'>
                <input info="text"  name="product"  value={inputs.product}  className='switchUp'  onChange={handleChange}  placeholder="product Name"/>
                <input info="text"  name="info"  value={inputs.info}  className='switchUp'  onChange={handleChange}  placeholder="Item info"/>
                <input info="number"  name="price"  value={inputs.price}  className='switchUp'  onChange={handleChange}  placeholder="Price"/>
            
                <button id="postSub">{btnText}</button>
            </span> */}
        </form>
    )
}