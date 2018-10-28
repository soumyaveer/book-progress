import React, { Component } from 'react';
import { Link } from "react-router-dom";
import BookProgressAPIClient from './BookProgressAPIClient';

class UsersList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      users: []
    }
  }

  componentDidMount() {
    BookProgressAPIClient
      .getUsers()
      .then(json =>
        this.setState({
          users: json.users
        })
      )
  }

  render() {
    const { users } = this.state;

    return (
      <div>
        <h1>Users</h1>
        <ul>
          { users.map((user) => {
            return (
              <li key={ user.id }>
                <Link to={ `/users/${user.id}/book-shelf` }>
                  { user.username } &mdash; { user.email }
                </Link>
              </li>
            )
          }) }
        </ul>
      </div>
    )
  }
}

export default UsersList;