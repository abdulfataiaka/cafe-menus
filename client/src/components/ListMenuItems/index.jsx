import React, { useEffect, useState } from 'react';
import MenuItemCard from '../../components/MenuItemCard';
import Button from '../Button';
import Errors from '../Errors';
import Api from '../../lib/api';
import './index.css';

const ListMenuItems = () => {
  const [errors, setErrors] = useState([]);
  const [menuItems, setMenuItems] = useState([]);

  const fetchRequest = async () => {
    const { data, errors: resErrors } = await Api.fetch();
    setErrors(resErrors);
    setMenuItems(data || []);
  }

  useEffect(() => { fetchRequest(); }, []);

  const deleteHandler = async (id) => {
    const { errors: resErrors } = await Api.delete(id);
    setErrors(resErrors);
    if (resErrors.length !== 0) return;
    setMenuItems(menuItems.filter(menuItem => menuItem.id !== id));
  };

  return (
    <div className="list-menu-items">
      <div className="title">
        <span>Menu</span>
        <Button to="/manage" name="Add menu item" />
      </div>

      <div className="notify">
        { errors.length !== 0 && <Errors errors={errors} /> }
        { errors.length === 0 && menuItems.length === 0 && <Errors errors={['There are no menu items at the moment']} /> }
      </div>

      <div className="catalog">
        { menuItems.map(menuItem => (
          <MenuItemCard
            key={menuItem.id}
            menuItem={menuItem}
            deleteHandler={deleteHandler}
          />
        ))}
      </div>
    </div>
  );
};

export default ListMenuItems;
