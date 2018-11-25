import React, { Component } from 'react';
import PropTypes from 'prop-types';
import BookProgressAPIClient from './BookProgressAPIClient';
import { Link } from "react-router-dom";
import UserBookShelfItem from "./UserBookShelfItem";

class UserBookShelf extends Component {
  constructor(props) {
    super(props);

    this.state = {
      book_progressions: [],
      user: {}
    }
  }

  componentDidMount() {
    BookProgressAPIClient
      .getBookProgressions(this.props.match.params.user_id)
      .then((json) =>
        this.setState({
          book_progressions: json.book_progressions,
          user: json.user
        })
      );
  }

  render() {
    const { user, book_progressions } = this.state;
    const isLoggedIn = !!window.current_user;
    const isBookShelfOwner = isLoggedIn && window.current_user.id === user.id;

    return (
      <div className="row">
        <div className="col-xs-12">
          <h1>{ user.username }</h1>
        </div>
        { book_progressions.map((book_progression) => {
          return (
            <UserBookShelfItem key={ book_progression.id } book_progression={ book_progression }/>
          )
        }) }

        { isBookShelfOwner &&
              <Link to={ `/books/new` }>
                Add Book
              </Link>
        }
      </div>
    )
  }
}

UserBookShelf.propTypes = {
  match: PropTypes.shape({
    params: PropTypes.shape({
      user_id: PropTypes.node,
    }).isRequired,
  }).isRequired
};

export default UserBookShelf;
