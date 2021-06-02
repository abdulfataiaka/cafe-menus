import React, { useEffect, useState } from 'react';
import { useHistory, useParams } from 'react-router-dom';
import Button from '../Button';
import Errors from '../Errors';
import Api from '../../lib/api';
import './index.css';

export const ManageMenuItemView = ({ id, data, errors, submitHandler }) => {
  const type = data.type || "";
  const name = data.name || "";
  const price = data.price || "";

  return (
    <div className="manage-menu-item">
      <div className="title">
        {id ? 'Edit' : 'Add'} Menu Item
      </div>

      <form onSubmit={submitHandler}>
        <div className="form-field">
          <label>Type</label>
          <select name="type" key={type} defaultValue={type}>
            <option value="">-- Select --</option>
            <option value="side">Side</option>
            <option value="main_course">Main Course</option>
          </select>
        </div>

        <div className="form-field">
          <label>Name</label>
          <input name="name" defaultValue={name} />
        </div>

        <div className="form-field">
          <label>Price</label>
          <input name="price" placeholder="Ex. $56" defaultValue={price} />
        </div>

        <div className="form-field">
          <label>Photo</label>
          <input type="file" name="photo" />
        </div>

        <Button name="Save Item" />
      </form>

      { errors.length !== 0 && <Errors errors={errors} /> }
    </div>
  )
};

export const ManageMenuItem = () => {
  const { id } = useParams();
  const history = useHistory();
  const [errors, setErrors] = useState([]);
  const [menuItem, setMenuItem] = useState({});

  const fetchMenuItem = async (id) => {
    const { data, errors: reqErrors } = await Api.fetch(id);
    setMenuItem(data);
    setErrors(reqErrors);
  }

  useEffect(() => { if(id) fetchMenuItem(id); }, [id]);

  const submitHandler = async (event) => {
    event.preventDefault();

    const payload = {
      type: null,
      name: null,
      price: null,
      photo: null,
    }

    Object.keys(payload).forEach(field => {
      let value = event.target[field].value;

      if (field === 'photo') {
        const files = event.target[field].files;
        value = files.length ? files[0] : null;
      }

      payload[field] = value;
    });

    const { data, errors: reqErrors } = await (menuItem.id ? Api.update(menuItem.id, payload) : Api.create(payload));
    setErrors(reqErrors);
    if (data) setMenuItem(data);
    if (reqErrors.length === 0) history.push('/');
  }

  return (
    <ManageMenuItemView
      id={menuItem.id}
      data={menuItem}
      errors={errors}
      submitHandler={submitHandler}
    />
  );
};

export default ManageMenuItem;
