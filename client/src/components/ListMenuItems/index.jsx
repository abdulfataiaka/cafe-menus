import React, { useEffect, useState } from 'react';
import MenuItemCard from '../../components/MenuItemCard';
import Api from '../../api';

const ListMenuItems = () => {
  const [errors, setErrors] = useState([]);
  const [menuItems, setMenuItems] = useState([]);

  useEffect(() => {
    async function fetch() {
      const { payload = null, errors } = await Api.fetch();

      setErrors(errors);
      setMenuItems(payload);
    }

    fetch();
  }, []);

  console.log(errors);

  return (
    <>
      <div>Menu</div>
      { menuItems.map((menuItem) => <MenuItemCard key={menuItem.id} menuItem={menuItem} />)}
    </>
  )
};

export default ListMenuItems;
