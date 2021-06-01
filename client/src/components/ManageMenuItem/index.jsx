import React, { useEffect, useState } from 'react';
import { useHistory, useParams } from 'react-router';
import Api from '../../api';
import Button from '../Button';
import './index.css';

const DEFAULT_DATA = {
  type: null,
  name: null,
  price: null,
  photo: null,
}

export const ManageMenuItem = () => {
  const history = useHistory();
  const { id } = useParams();
  const [menuItem, setMenuItem] = useState({});
  const [errors, setErrors] = useState([]);

  const fetchMenuItem = async (id) => {
    const { payload, errors: reqErrors } = await Api.fetch(id);
    setErrors(reqErrors);
    setMenuItem(payload);
  }

  const getSubmitData = (form) => {
    const result = {};
  
    Object.keys(DEFAULT_DATA).forEach(field => {
      let value = form[field].value;

      if (field === 'photo') {
        const files = form[field].files;
        if (files.length === 0) value = null;
        else value = files[0];
      }

      result[field] = value;
    });

    return result;
  }

  const submitHandler = async (event) => {
    event.preventDefault();
    const data = getSubmitData(event.target);

    const { errors: reqErrors } = await (id ? Api.update(id, data) : Api.create(data));
    setErrors(reqErrors);
    if (reqErrors.length === 0) history.push('/');
  }

  useEffect(() => { if(id) fetchMenuItem(id); }, [id]);

  return (
    <div className="manage-menu-item">
      <div className="title">{ id ? 'Edit' : 'Add' } Menu Item</div>

      <form onSubmit={submitHandler}>
        <div>
          <label>Type</label>&nbsp;&nbsp;
          <select name="type" key={menuItem.type} defaultValue={menuItem.type}>
            <option value="">-- Select --</option>
            <option value="side">Side</option>
            <option value="main_course">Main Course</option>
          </select>
        </div><br />

        <div>
          <label>Name</label>
          <input name="name" defaultValue={menuItem.name || ""} />
        </div><br />

        <div>
          <label>Price</label>
          <input name="price" placeholder="Ex. $56" defaultValue={menuItem.price || ""} />
        </div><br />

        <div>
          <label>Photo</label>
          <input type="file" name="photo" />
        </div><br />

        <Button name="Save Item" />
        <br /><br />

        { errors.map(error => <div key={error}>{error}</div>) }
    </form>
    </div>
  )
};

export default ManageMenuItem;
