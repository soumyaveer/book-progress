import React, { Component } from 'react';
import UserSessionNavItem from './UserSessionNavItem';

class NavBar extends Component {
  render() {
    return (
      <div className="row">
        <div className="col-xs-12">
          <UserSessionNavItem />
        </div>
      </div>
    );
  }
}

export default NavBar;