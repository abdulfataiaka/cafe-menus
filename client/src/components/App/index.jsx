import React from 'react';
import { Switch, Route, Redirect, Link } from 'react-router-dom';
import ListMenuItems from '../ListMenuItems';
import ManageMenuItem from '../ManageMenuItem';
import './index.css';

function App() {
  return (
    <>
      <div className="app-header">
        <Link to="/">CREATE REACT</Link>
      </div>
      <div className="app-main">
        <Switch>
          <Route exact path="/" render={props => <ListMenuItems {...props} />} />
          <Route exact path="/manage/:id?" render={props => <ManageMenuItem {...props} />} />
          <Route render={() => <Redirect to="/" />} />
        </Switch>
      </div>
    </>
  );
}

export default App;
