import React, { useState, useEffect } from 'react';
// Ensure you have configured .env.development file correctly
// import { API_URL } from '../../constants';

const Countries = () => {
 const API_URL=  'http://localhost:3000/api/v1'
  const [countries, setCountries] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function loadCountries() {
      try {
        const response = await fetch(API_URL);
        if (response.ok) {
          const json = await response.json();
          setCountries(json);
        } else {
          throw response;
        }
      } catch (e) {
        setError("An error occurred. Awkward...");
        console.log("An error occurred:", e);
      } finally {
        setLoading(false);
      }
    }
    loadCountries();
  }, []);
  console.log(API_URL);
  if (loading) {
    return <div>Loading...</div>;
  }

  if (error) {
    return <div>{error}</div>;
  }

  return (
    <div>
      {countries.map((country) => (
        <div key={country.country_id}>
          <h2>{country.country_name}</h2>
        </div>
      ))}
    </div>
  );
}

export default Countries;
