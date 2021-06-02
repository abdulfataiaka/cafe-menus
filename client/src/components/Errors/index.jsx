import React from 'react';
import './index.css';

const Errors = ({ errors }) => {
  return (
    <div className="errors">
      { errors.map(error => <span key={error}>{error}</span>) }
    </div>
  );
};

export default Errors;
