import React, { Component } from 'react';
import BookProgressAPIClient from './BookProgressAPIClient';

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

    return (
      <div>
        <h1>BookShelf for {user.username}</h1>
        <ul>
          { book_progressions.map((book_progression) => {
            return (
              <li key={ book_progression.id }>
                Book: { book_progression.book.title }.
                Current Page: { book_progression.current_page }
              </li>
            )
          }) }
        </ul>
      </div>
    )
  }
}

export default UserBookShelf;