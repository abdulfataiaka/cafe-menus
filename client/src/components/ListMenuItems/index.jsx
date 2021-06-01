import React, { useCallback, useEffect, useState } from 'react';
import MenuItemCard from '../../components/MenuItemCard';
import Api from '../../api';
import './index.css';
import Button from '../Button';

const ListMenuItems = () => {
  const [errors, setErrors] = useState([]);
  const [menuItems, setMenuItems] = useState([]);

  const fetchRequest = async () => {
    const { payload = [], errors } = await Api.fetch();
    setErrors(errors);
    setMenuItems(payload);
  }

  const deleteHandler = useCallback(async (id) => {
    const { errors } = await Api.delete(id);
    setErrors(errors);

    if (errors.length !== 0) return

    const filteredMenuItems = menuItems.filter(menuItem => menuItem.id !== id);
    setMenuItems(filteredMenuItems);
  }, [menuItems]);

  useEffect(() => { fetchRequest(); }, []);

  return (
    <div className="list-menu-items">
      <div className="title">
        <span>Menu</span>
        <Button to="/manage" name="Add menu item" />
      </div>

      <div className="catalog">
        { errors.map(error => <div key={error}>{error}</div>) }
        { errors.length === 0 && menuItems.length === 0 && <div>No Menu Items Found</div> }

        { menuItems.map((menuItem) => (
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
