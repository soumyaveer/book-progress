import React, { Component } from 'react';
import PropTypes from 'prop-types';
import LoginForm from './LoginForm';
import Modal from './Modal';

class UserSessionsNavItem extends Component {
  state = {
    showLoginModal: false
  };

  static propTypes = {
    isLoggedIn: PropTypes.bool
  };

  handleButtonClick = () => {
    if (this.props.isLoggedIn) {
      fetch(`/sessions`, {
        method: 'delete'
      }).then(() => window.location = '/');
    } else {
      this.setState({
        showLoginModal: true
      });
    }
  };

  handleCancelButtonClick = () => {
    this.setState({ showLoginModal: false });
  };

  render() {
    let { showLoginModal } = this.state;

    return (
      <div>
        <button type="button"
                className="btn btn-link global-navbar__action"
                onClick={ this.handleButtonClick }>
          { this.props.isLoggedIn ? 'Logout' : ' Login' }
        </button>
        { showLoginModal
          ? <Modal size="small">
              <LoginForm onCancelButtonClick={this.handleCancelButtonClick}/>
            </Modal>
          :
          null}
      </div>
    );
  }
}

export default UserSessionsNavItem;
