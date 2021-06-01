import React from 'react';
import { Link } from 'react-router-dom';
import './index.css';

const Button = ({ to, name, ...rest }) => {
  const component = <button className="btn" {...rest}>{ name }</button>;

  return to ? <Link to={to}>{component}</Link> : component;
}

export default Button;
