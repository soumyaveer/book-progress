import React, { Component } from "react";

class SearchResultListItem extends Component {
  render() {
    const { book } = this.props;

    return (
      <li>
        <img
          src={ book.cover_url }
          className="book-progress__cover"
          alt={ book.title }/>

        <div>
          { book.title } - { book.authors } - { book.page_count } - { book.rating }
        </div>
      </li>
    )
  }
}

export default SearchResultListItem;
