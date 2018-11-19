import React, { Component } from 'react';

class UserSessionsNavItem extends Component {
  constructor(props) {
    super(props);

    this.state = {
      isLoggedIn: !!window.current_user
    }
  }

  handleButtonClick = () => {
    let { isLoggedIn } = this.state;

    if (isLoggedIn) {
      fetch(`/sessions`, {
        method: 'delete'
      }).then(() => window.location = '/');
    } else {
      throw 'Not implemented';
    }
  };

  render() {
    let { isLoggedIn } = this.state;

    return (
      <button type="button"
              className="btn btn-link global-navbar__action"
              onClick={ this.handleButtonClick }>
        { isLoggedIn ? 'Logout' : ' Login' }
      </button>
    );
  }
}

export default UserSessionsNavItem;