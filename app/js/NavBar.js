import React, { Component } from 'react';
import UserSessionNavItem from './UserSessionNavItem';
import UserSignUpNavItem from './UserSignUpNavItem';

class NavBar extends Component {
  render() {
    const isLoggedIn = !!window.current_user;

    return (
      <div className="row nav-bar">
        <div className="col-12">
          <div className="float-left">
            <a className="btn btn-link global-navbar__action nav-bar__header" href="/">Book Progress</a>
          </div>
          <UserSessionNavItem isLoggedIn={isLoggedIn}/>
          {
            isLoggedIn ? <a href={ `/users/${window.current_user.id}/book-shelf` } className="btn btn-link global-navbar__action">My Shelf</a> : <UserSignUpNavItem/>
          }
        </div>
      </div>
    );
  }
}

export default NavBar;
