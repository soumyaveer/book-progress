import React, { Component } from "react";
import { Redirect, Route } from 'react-router';
import BookProgressAPIClient from "./BookProgressAPIClient";

class SearchResultListItem extends Component {
  state ={
    errors: [],
    isAddButtonDisabled: false,
    isRequestInProgress: false,
    showErrors: false
  };

  handleAddBookButtonClick = (event) => {
    event.preventDefault();

    this.setState({ isRequestInProgress: true });

    let { book } = this.props;

    BookProgressAPIClient.createBook(book).then((response) => {
      if(response.status === 200){
        return response.json().then((json) => this.handleAddBookButtonClickSuccess(json))
      } else if(response.status === 412){
        return response.json().then((json) => this.handleAddBookButtonClickFailure(json))
      } else {
        this.handleGenericFailureError(response)
      }
    }).catch((error) => this.handleGenericFailureError(error));
  };

  handleAddBookButtonClickSuccess = (book_json) => {
    this.setState({ isRequestInProgress: true });

    let bookProgressionRequestBody = {
      user_id: window.current_user.id,
      book_id: book_json.id
    };

    BookProgressAPIClient.createBookProgress(bookProgressionRequestBody).then(bookProgressionResponse => {
      if(bookProgressionResponse.status === 200){
        return bookProgressionResponse.json().then(
          bookProgressionJson => this.handleAddBookToBookShelfSuccess(bookProgressionJson)
        )
      } else if(bookProgressionResponse.status === 412){
        return bookProgressionResponse.json().then(
          bookProgressionJson => this.handleAddBookButtonClickFailure(bookProgressionJson)
        )
      } else {
        this.handleGenericFailureError(bookProgressionResponse)
      }
    }).catch((error) => this.handleGenericFailureError(error));
  };

  handleAddBookToBookShelfSuccess = (json) => {
    this.setState({
      isAddButtonDisabled: true,
      isRequestInProgress: false,
      showErrors: false
    })
  };

  handleGenericFailureError = () => {
    this.setState({
      errors: ['An unknown error occurred. Could not add book to the BookShelf.'],
      isRequestInProgress: false,
      showErrors: true
    })
  };

  handleAddBookButtonClickFailure = (json) => {
    this.setState({
      errors: json['errors'],
      isRequestInProgress: false,
      showErrors: true
    })
  };

  render() {
    const { book } = this.props;
    const { isAddButtonDisabled, showErrors} = this.state;
    const AddButtonMessage = !isAddButtonDisabled ? "Add Button" : "Book added to your shelf";

    return (
      <li className="book-search__list">
          {
            showErrors &&
            <div className="alert alert-danger">
              <ul className='list-unstyled'>
                { errors.map((error, index) =>
                  <li key={index}>{error}</li>
                )}
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
                onClick={this.handleAddBookButtonClick}
                type="submit">
          {AddButtonMessage}
        </button>
      </li>
    )
  }
}

export default SearchResultListItem;
