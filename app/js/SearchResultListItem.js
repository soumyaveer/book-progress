import React, { Component } from "react";

class SearchResultListItem extends Component {

  handleAddBookButtonClick = (event) => {
    event.preventDefault();
    console.log("Add button clicked!!");
    console.log(this.props.book);

    let { book } = this.props;

  };

  render() {
    const { book } = this.props;

    return (
      <li className="book-search__list">
        <img
          src={ book.cover_url }
          className="book-progress__cover"
          alt={ book.title }/>

        <div>
          { book.title } - { book.authors } - { book.page_count } - { book.rating }
        </div>

        <button className="btn btn-primary" onClick={this.handleAddBookButtonClick} type="submit">Add Book</button>
      </li>
    )
  }
}

export default SearchResultListItem;
