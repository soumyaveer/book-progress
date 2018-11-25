import React, { Component } from "react";
import { Redirect, Route } from 'react-router';
import BookProgressAPIClient from "./BookProgressAPIClient";

class SearchResultListItem extends Component {
  state ={
    showErrors: false,
    isAddButtonDisabled: false
  };

  handleAddBookButtonClick = (event) => {
    event.preventDefault();
    console.log("Add button clicked!!");
    console.log(this.props.book);

    let { book } = this.props;
    console.log(book);

    BookProgressAPIClient.createBook(book).then((response) => {
      if(response.status === 200){
        return response.json().then((json) => this.handleAddBookButtonClickSuccess(json))
      } else if(response.status === 412){
        return response.json().then(json => console.log(json))
      }
    })
  };

  handleAddBookButtonClickSuccess = (book_json) => {
    console.log("Book Id", book_json.id);

    let bookProgressionRequestBody = {
      user_id: window.current_user.id,
      book_id: book_json.id
    };

    BookProgressAPIClient.createBookProgress(bookProgressionRequestBody).then(bookProgressionResponse => {
      if(bookProgressionResponse.status === 200){
        return bookProgressionResponse.json().then(bookProgressionJson => this.handleAddBookToBookShelfSuccess(bookProgressionJson))
      }
    })
  };

  handleAddBookToBookShelfSuccess = (json) => {
    this.setState({ isAddButtonDisabled: true})
  };

  render() {
    const { book } = this.props;
    const { isAddButtonDisabled, showErrors} = this.state;
    const AddButtonMessage = !isAddButtonDisabled ? "Add Button" : "Book added to your shelf";

    return (
      <li className="book-search__list">
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
