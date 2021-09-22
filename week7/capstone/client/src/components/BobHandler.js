import { useState } from 'react';

export default function BobHandler({ btnText, submit, EPISODE, details, TITLE, id }){
    const initialInputs = { EPISODE: EPISODE || '', details: details || '', TITLE: TITLE || '' }
    const [inputs, setInputs] = useState(initialInputs);

    const handleChange = (e) => {
        const {name, value} = e.target;
        setInputs(prevInputs => ({...prevInputs, [name]: value}))
    }

    const handleSubmit = (e) => {
        e.preventDefault();
        submit(inputs, id);
        setInputs(initialInputs);
    }

    return (
        <form onSubmit={handleSubmit}>
            <span id='alignIt'>
                <input details="text"  name="EPISODE"  value={inputs.EPISODE}  className='switchUp'  onChange={handleChange}  placeholder="Season & Episode Number"/>
                <input details="text"  name="TITLE"  value={inputs.TITLE}  className='switchUp'  onChange={handleChange}  placeholder="Name of Episode"/>
                <input details="text"  name="details"  value={inputs.details}  className='switchUp'  onChange={handleChange}  placeholder="Episode Details"/>
            
                <button id="postSub">{btnText}</button>
            </span>
        </form>
    )
}