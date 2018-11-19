import React, { Component } from 'react';
import Modal from './Modal';

class UserSessionsNavItem extends Component {
  state = {
    isLoggedIn: !!window.current_user,
    showLoginModal: false
  };

  handleButtonClick = () => {
    let { isLoggedIn } = this.state;

    if (isLoggedIn) {
      fetch(`/sessions`, {
        method: 'delete'
      }).then(() => window.location = '/');
    } else {
      this.setState({
        showLoginModal: true
      });
    }
  };

  render() {
    let { isLoggedIn, showLoginModal } = this.state;

    return (
      <div>
        <button type="button"
                className="btn btn-link global-navbar__action"
                onClick={ this.handleButtonClick }>
          { isLoggedIn ? 'Logout' : ' Login' }
        </button>
        { showLoginModal ? <Modal>
          I am modal
        </Modal>
          :
          null}
      </div>
    );
  }
}

export default UserSessionsNavItem;