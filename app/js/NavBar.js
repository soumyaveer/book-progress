import React, { Component } from 'react';
import UserSessionNavItem from './UserSessionNavItem';
import UserSignUpNavItem from './UserSignUpNavItem';

class NavBar extends Component {
  render() {
    const isLoggedIn = !!window.current_user;

    return (
      <div className="row">
        <div className="col-12">
          <UserSessionNavItem isLoggedIn={isLoggedIn}/>
          {
            isLoggedIn ? null : <UserSignUpNavItem/>
          }
        </div>
      </div>
    );
  }
}

export default NavBar;
