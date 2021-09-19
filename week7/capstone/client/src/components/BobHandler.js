import { useState } from 'react';

export default function BobHandler({ btnText, submit, episode, details, title, id }){
    const initialInputs = { episode: episode || '', details: details || '', title: title || '' }
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
                <input details="text"  name="episode"  value={inputs.episode}  className='switchUp'  onChange={handleChange}  placeholder="Season & Episode Number"/>
                <input details="text"  name="title"  value={inputs.title}  className='switchUp'  onChange={handleChange}  placeholder="Name of Episode"/>
                <input details="text"  name="details"  value={inputs.details}  className='switchUp'  onChange={handleChange}  placeholder="Episode Details"/>
            
                <button id="postSub">{btnText}</button>
            </span>
        </form>
    )
}