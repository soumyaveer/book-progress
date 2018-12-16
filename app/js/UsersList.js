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
      <div className='row'>
        <div className="col-12 page__header">
          <h1>Readers</h1>
        </div>
        { users.map((user) => {
          return (
            <div className='col-lg-2 col-md-3 col-sm-4 col-xs-6' key={ user.id }>
              <div className="user-avatar">
                <Link to={ `/users/${user.id}/book-shelf` } className='user-avatar__link'>
                  <img className="user-avatar__picture" src={ `https://api.adorable.io/avatars/285/${user.email}.png` }
                       alt={ user.email }/>
                  <div className="user-avatar__username">{ user.username }</div>
                </Link>
              </div>
            </div>
          )
        }) }
      </div>
    )
  }
}

export default UsersList;
