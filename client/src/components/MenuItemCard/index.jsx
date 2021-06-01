import React from 'react';

const MenuItemCard = ({ menuItem }) => {
  return (
    <div>
      <div>{menuItem.name}</div>
      <div>{menuItem.photo}</div>
      <br /><br />
    </div>
  )
}

export default MenuItemCard;
