import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Modal from './Modal';
import SignUpForm from "./SignUpForm";

class UserSignUpNavItem extends Component {
  state = {
    showSignUpModal: false
  };

  static propTypes = {
    isLoggedIn: PropTypes.bool
  };

  handleCancelButtonClick = () => {
    this.setState({ showSignUpModal: false })
  };

  handleSignUpButtonClick = () => {
    this.setState({ showSignUpModal: true })
  };

  render() {
    const { showSignUpModal } = this.state;
    return (
      <div>
        <button type="button"
                onClick = {this.handleSignUpButtonClick}
                className="btn btn-link global-navbar__action">
          { !this.props.isLoggedIn ? 'Sign Up' : ' Logout' }
        </button>
        { showSignUpModal
          ? <Modal size="small">
              <SignUpForm onCancelButtonClick={this.handleCancelButtonClick} />
            </Modal>
          :
          null
        }
      </div>
    );
  }
}

export default UserSignUpNavItem;
