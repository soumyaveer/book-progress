import React, { Component } from 'react';
import UserListItem from './UserListItem';

const USERS_URL = '/api/users';

  class UsersList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      users: []
    }
  }

  componentDidMount() {
    fetch(USERS_URL)
      .then(request => request.json())
      .then(json =>
        this.setState({
          users: json.users
        })
      )
  }

  render() {
    const { users } = this.state;

    return (
      <ul>
        { users.map((user) => {
          return (
            <UserListItem
              user={user}
              key={user.id}
            />
            )
          })
        }
      </ul>
    )
  }
}

export default UsersList;