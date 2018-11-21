import React, { Component } from 'react';

class LoginForm extends Component {
  state = {
    isRequestInProgress: false,
    password: null,
    showLoginError: false,
    username: null
  };

  handleCancelButtonClick = (event) => {
    event.preventDefault();
    this.props.onCancelButtonClick();
  };

  handleFormSubmit = (event) => {
    event.preventDefault();

    const { username, password } = this.state;
    const requestBody = {
      username,
      password
    };

    this.setState({ isRequestInProgress: true });

    fetch(`/sessions`,
      {
        body: JSON.stringify(requestBody),

        headers:{
          'Accept': 'application/json',
          'content-type': 'application/json'
        },

        method: 'POST'
      })
      .then(response => {
        if (response.status === 200) {
          this.handleFormSubmitSuccess();
        } else {
          this.handleFormSubmitFailure();
        }
      });
  };

  handleFormSubmitSuccess = () => {
    this.setState({
      isRequestInProgress: false,
      showLoginError: false
    });
    window.location.reload();
  };

  handleFormSubmitFailure = () => {
    this.setState({
      isRequestInProgress: false,
      showLoginError: true
    });
  };

  handlePasswordChange = (event) => {
    this.setState({ password: event.target.value });
  };

  handleUsernameChange = (event) => {
    this.setState({ username: event.target.value });
  };


  render() {
    const { isRequestInProgress, password, showLoginError, username } = this.state;
    const loginInputsEntered = !!username && !!password && username.length > 0 && password.length > 0;
    const isLoginButtonDisabled = !loginInputsEntered || isRequestInProgress;

    return (
      <div className="login-form">
        {
          showLoginError &&
          <div className="alert alert-danger">Could not login with username and password</div>
        }
        <form onSubmit={ this.handleFormSubmit }>
          <div className="form-group">
            <label htmlFor="username">Username</label>
            <input id="username"
                   type="text"
                   name={ username }
                   required
                   className="form-control"
                   onChange={ this.handleUsernameChange }/>
          </div>

          <div className="form-group">
            <label htmlFor="password">Password</label>
            <input id="password"
                   type="password"
                   name={ password }
                   required
                   className="form-control"
                   onChange={ this.handlePasswordChange }/>
          </div>

          <button disabled={ isLoginButtonDisabled } type="submit" className="btn btn-primary">Login</button>
          <button className="btn btn-default" onClick={this.handleCancelButtonClick}>Cancel</button>
        </form>
      </div>
    );
  }
}

export default LoginForm;