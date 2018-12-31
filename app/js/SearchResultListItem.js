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
      } else if (response.status === 422) {
        return response.json().then((json) => {
          return Promise.reject(json.errors);
        });
      } else {
        return Promise.reject(['Unexpected error when creating a book']);
      }
    });
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
      } else if (bookProgressionResponse.status === 422) {
        return bookProgressionResponse.json().then((bookProgressionResponseJSON) => Promise.reject(bookProgressionResponseJSON.errors));
      } else {
        return Promise.reject(['Unexpected error when creating a book progression']);
      }
    })
  };

  handleAddBookButtonClick = (event) => {
    event.preventDefault();
    this.setState({ isRequestInProgress: true });
    let { book } = this.props;

    this.createBook(book).then(book => this.createBookProgression(book)).catch(errors => {
      this.handleFailures(errors);
    });
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
    const AddButtonMessage = !isAddButtonDisabled ? "Add Book" : "Book added to your shelf";

    return (
      <li className="search-result-list__item">
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

        <div className="row">
          <div className="col-3 text-center">
            <img src={ book.cover_url } className="book-progress__cover" alt={ book.title }/>
          </div>
          <div className="col-9">
            <h2>{book.title}</h2>
            <div>{book.authors}</div>
            <p>
              {book.rating} rating • {book.page_count} pages • <a href={book.preview_url} target="_blank">Preview book</a>
            </p>
            <button className="btn btn-primary"
                    disabled={ isAddButtonDisabled }
                    onClick={ this.handleAddBookButtonClick }
                    type="submit">
              { AddButtonMessage }
            </button>
          </div>
        </div>
      </li>
    )
  }
}

export default SearchResultListItem;
