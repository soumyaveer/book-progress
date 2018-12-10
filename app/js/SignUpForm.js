import React, { Component } from 'react';
import PropTypes from 'prop-types';

class SignUpForm extends Component {
  state = {
    email: null,
    errors: [],
    isRequestInProgress: false,
    password: null,
    showSignUpError: false,
    username: null
  };

  static propTypes = {
    onCancelButtonClick: PropTypes.func
  };

  handleCancelButtonClick = (event) => {
    event.preventDefault();
    this.props.onCancelButtonClick();
  };

  handleFormSubmit = (event) => {
    event.preventDefault();

    const { username, email, password } = this.state;
    const requestBody = {
      email,
      username,
      password
    };

    this.setState({ isRequestInProgress: true });

    fetch(`/users`,
      {
        body: JSON.stringify(requestBody),

        headers:{
          'Accept': 'application/json',
          'content-type': 'application/json'
        },

        method: 'POST'
      }).then(response => {
        if(response.status === 200) {
          return response.json().then((json) => this.handleFormSubmitSuccess(json));
        } else if(response.status === 422) {
          return response.json().then((json) => this.handleFormSubmitFailure(json));
        } else {
          this.handleFormSubmitGenericFailure(response);
        }
      }).catch((error) => this.handleFormSubmitGenericFailure(error));
  };

  handleFormSubmitSuccess = () => {
    this.setState({
      isRequestInProgress: false,
      showSignUpError: false,
    });

    window.location.reload();
  };

  handleFormSubmitFailure = (json) => {
    this.setState({
      errors: json['errors'],
      showSignUpError: true,
      isRequestInProgress: false
    });
  };

  handleFormSubmitGenericFailure = () => {
    this.setState({
      errors: ['An unknown error occurred. Could not sign up.'],
      isRequestInProgress: false,
      showSignUpError: true
    });
  };

  handleUsernameChange = (event) => {
    this.setState({ username: event.target.value });
  };

  handleEmailChange = (event) => {
    this.setState({ email: event.target.value });
  };

  handlePasswordChange = (event) => {
    this.setState({ password: event.target.value });
  };

  render(){
    const { showSignUpError, email, errors, password, username, isRequestInProgress } = this.state;
    const signUpInputsEntered = !!username && !!password  && !!email
      && username.length > 0 && password.length > 0 && email.length > 0;
    const isSignUpButtonDisabled = !signUpInputsEntered || isRequestInProgress;

    return (
      <div className="signup-form">
        {
          showSignUpError &&
          <div className="alert alert-danger">
            <ul className='list-unstyled'>
              { errors.map((error, i) =>
                  <li key={i}>{error}</li>
              )}
              </ul>
          </div>
        }

        <form onSubmit={ this.handleFormSubmit }>
          <div className="form-group">
            <label htmlFor="username">Username</label>
            <input type="text"
                   id="username"
                   name={ username }
                   required
                   className="form-control"
                   onChange={ this.handleUsernameChange }>

            </input>
          </div>

          <div className="form-group">
            <label htmlFor="email">Email</label>
            <input type="email"
                   id="email"
                   required
                   name={ email }
                   className="form-control"
                   onChange={ this.handleEmailChange }>

            </input>
          </div>

          <div className="form-group">
            <label htmlFor="password">Password</label>
            <input type="password"
                   id="password"
                   required
                   name={ password }
                   className="form-control"
                   onChange={ this.handlePasswordChange }>

            </input>
          </div>

          <button disabled={ isSignUpButtonDisabled } type="submit" className="btn btn-primary">Sign Up</button>
          <button className="btn btn-default" onClick={this.handleCancelButtonClick}>Cancel</button>
        </form>
      </div>
    )
  }
}

export default SignUpForm;
