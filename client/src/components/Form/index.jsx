import React, { useCallback } from 'react';

const FormView = ({ submitHandler }) => {
  return (
    <form onSubmit={submitHandler}>
      <label>Type</label>
      <select />

      <label>Name</label>
      <input />

      <label>Price</label>
      <input />

      <label>Photo</label>
      <input type="file" />

      <button>Save Item</button>
    </form>
  )
};

const Form = () => {
  const submitHandler = useCallback((event) => {
    event.preventDefault();

    console.log("Submitting the form");
  }, []);

  return <FormView submitHandler={submitHandler} />;
}

export default Form;
