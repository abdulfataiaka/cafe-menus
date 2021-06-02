import React from 'react';
import Button from '../Button';
import { API_BASE_URL } from '../../lib/api';
import './index.css';

const TYPES = {
  side: 'Side',
  main_course: 'Main Course',
}

const MenuItemCard = ({ menuItem, deleteHandler }) => {
  const { id, name, price } = menuItem;
  const type = TYPES[menuItem.type];
  const photo = `${API_BASE_URL}/${menuItem.photo}`;

  return (
    <div className="menu-item-card">
      <div className="main">
        <div className="photo">
          { menuItem.photo && <img alt="" src={photo} /> }
        </div>

        <div className="info">
          <div className="info-top">
            <span className="info-type">{type}</span>
            <span className="info-price">{price}</span>
          </div>

          <div>{name}</div>

          <div className="info-btns">
            <Button to={`/manage/${id}`} name="Edit" />
            <Button name="Delete" onClick={() => deleteHandler(id)} />
        </div>
        </div>
      </div>
    </div>
  )
}

export default MenuItemCard;
