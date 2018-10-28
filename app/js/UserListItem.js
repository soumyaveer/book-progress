import React, { Component } from 'react';
import { Link } from "react-router-dom";

class UserListItem extends Component {
  constructor(props){
    super(props);
  }

  render(){
    const USERS_BOOKSHELF_URL = `users/${this.props.user.id}`;
    return (
      <li key={ this.props.user.id }>
        <Link to={USERS_BOOKSHELF_URL}>{ this.props.user.username }</Link>
        <div>{ this.props.user.email }</div>
      </li>
    )
  }
}

export default UserListItem;