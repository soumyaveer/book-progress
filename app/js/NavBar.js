import React, { Component } from 'react';

class NavBar extends Component {
  render() {
    return (
      <div className="row">
        <div className="col-xs-12">
          <button type="button"
                  className="btn btn-link global-navbar__action">{ window.current_user ? 'Logout' : 'Login' }
          </button>
        </div>
      </div>
    );
  }
}

export default NavBar;