import React, { Component } from "react";
import PropTypes from 'prop-types';
import SearchResultListItem from "./SearchResultListItem"

class SearchResultList extends Component {
  static propTypes = {
    searchResults: PropTypes.array
  };

  render() {
    const { searchResults } = this.props;
    return (
      <ul>
        { searchResults.map((book, index) =>
          <SearchResultListItem key={ index } book={ book }/>
        ) }
      </ul>
    )
  }
}

export default SearchResultList;
