import React, { Component } from "react";
import PropTypes from 'prop-types';
import BookProgressAPIClient from "./BookProgressAPIClient";

class SearchResultListItem extends Component {
  state = {
    errors: [],
    isAddButtonDisabled: false,
    isRequestInProgress: false,
    showErrors: false
  };

  createBook(book) {
    return BookProgressAPIClient.createBook(book).then((response) => {
      if (response.status === 200) {
        return response.json();
      } else if (response.status === 412) {
        return response.json().then((json) => { throw new Error(json.errors) });
      } else {
        throw new Error('Unexpected error when creating a book');
      }
    })
  }

  createBookProgression = (book_json) => {
    this.setState({ isRequestInProgress: true });

    let bookProgressionRequestBody = {
      user_id: window.current_user.id,
      book_id: book_json.id
    };

    return BookProgressAPIClient.createBookProgression(bookProgressionRequestBody).then(bookProgressionResponse => {
      if (bookProgressionResponse.status === 200) {
        return bookProgressionResponse.json().then(
          bookProgressionJson => this.handleAddBookToBookShelfSuccess(bookProgressionJson)
        );
      } else if (bookProgressionResponse.status === 412) {
        return bookProgressionResponse.json().then((bookProgressionResponseJSON) => { throw new Error(bookProgressionResponseJSON.errors) });
      } else {
        throw new Error('Unexpected error when creating a book progression');
      }
    })
  };

  handleAddBookButtonClick = (event) => {
    event.preventDefault();
    this.setState({ isRequestInProgress: true });
    let { book } = this.props;

    this.createBook(book).then((book) => this.createBookProgression(book)).catch((errors) => { this.handleFailures(errors) });
  };

  handleAddBookToBookShelfSuccess = () => {
    this.setState({
      isAddButtonDisabled: true,
      isRequestInProgress: false,
      showErrors: false
    })
  };

  handleFailures = (errors) => {
    this.setState({
      errors: errors,
      isRequestInProgress: false,
      showErrors: true
    })
  };

  static propTypes = {
    book: PropTypes.object
  };

  render() {
    const { book } = this.props;
    const { isAddButtonDisabled, showErrors, errors } = this.state;
    const AddButtonMessage = !isAddButtonDisabled ? "Add Button" : "Book added to your shelf";

    return (
      <li className="book-search__list">
        {
          showErrors &&
          <div className="alert alert-danger">
            <ul className='list-unstyled'>
              { errors.map((error, index) =>
                <li key={ index }>{ error }</li>
              ) }
            </ul>
          </div>
        }

        <img
          src={ book.cover_url }
          className="book-progress__cover"
          alt={ book.title }/>

        <div>
          { book.title } - { book.authors } - { book.page_count } - { book.rating }
        </div>

        <button className="btn btn-primary"
                disabled={ isAddButtonDisabled }
                onClick={ this.handleAddBookButtonClick }
                type="submit">
          { AddButtonMessage }
        </button>
      </li>
    )
  }
}

export default SearchResultListItem;
