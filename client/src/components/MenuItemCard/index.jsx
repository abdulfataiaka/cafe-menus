import React from 'react';
import Button from '../Button';
import { API_BASE_URL } from '../../api';
import './index.css';

const MenuItemCard = ({ menuItem, deleteHandler }) => {
  const { id, name, type, price } = menuItem;

  return (
    <div className="menu-item-card">
      <div className="menu-item-card-main">
        <div className="menu-item-photo">
          { menuItem.photo && <img src={`${API_BASE_URL}/${menuItem.photo}`} /> }
        </div>
        <div className="menu-item-info">
          <div>
            <span>{type}</span>
            <span>{price}</span>
          </div>
          <div>{name}</div>
        </div>
        <div>
          <Button to={`/manage/${id}`} name="Edit"></Button>
          <Button name="Delete" onClick={() => deleteHandler(id)}></Button>
        </div>
      </div>
    </div>
  )
}

export default MenuItemCard;
