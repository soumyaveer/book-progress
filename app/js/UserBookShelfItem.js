import React, { Component } from 'react';
import PropTypes from 'prop-types';

class UserBookShelfItem extends Component {
  static propTypes = {
    book_progression: PropTypes.object,
    onClick: PropTypes.func
  };

  handleClick = () => {
    this.props.onClick(this.props.book_progression);
  };

  render() {
    const { book_progression } = this.props;
    let progress_bar_style = 'book-progress__progress-starting';

    if (book_progression.percent_read > 50) {
      progress_bar_style = 'book-progress__progress-completing';
    } else if (book_progression.percent_read > 20) {
      progress_bar_style = 'book-progress__progress-middle';
    }

    const progress_bar_width = `${book_progression.percent_read}%`;
    const title = `${book_progression.book.title} ${book_progression.percent_read}% read`;

    return (
      <div className="book-progress col-lg-2 col-md-3 col-sm-4 col-xs-6" title={title}>
        <button onClick={this.handleClick} type="button">
          <img
            src={ book_progression.book.cover_url }
            className="book-progress__cover"
            alt={ book_progression.book.title }/>
        </button>
        <div className="book-progress__progress-bar">
          <div className={progress_bar_style} style={{ width: progress_bar_width}} />
        </div>
      </div>
    )
  }
}

export default UserBookShelfItem;
