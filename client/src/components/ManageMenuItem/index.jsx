import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router';
import Form from '../../components/Form';
import Api from '../../api';

export const ManageMenuItem = () => {
  const { id } = useParams();
  const [errors, setErrors] = useState([]);
  const [menuItem, setMenuItem] = useState(null);

  useEffect(() => {
    async function create() {
      const { payload = [], errors } = await Api.create({
        type: 'side',
        name: 'Another #32',
        price: '$34',
        photo: undefined,
      });

      setErrors(errors);
      setMenuItem(payload);
    };

    async function update() {
      const { payload = [], errors } = await Api.update(id, {
        price: '$34',
        photo: undefined,
      });

      setErrors(errors);
      setMenuItem(payload);
    };

    async function destroy() {
      const { payload = [], errors } = await Api.delete(id);

      setErrors(errors);
      setMenuItem(payload);
    };

    // create();
    // if(id) update();
    if(id) destroy();
  }, []);

  console.log(errors);
  console.log(menuItem);

  return (
    <>
      <div>Create and Update Menu Item Page</div>
      <Form />
    </>
  )
};

export default ManageMenuItem;
