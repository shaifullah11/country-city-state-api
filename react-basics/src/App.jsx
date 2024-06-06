import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
import Countries from './features/countries/Countries'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <p>list of countries</p>
      <Countries />
    </>
  )
}

export default App
