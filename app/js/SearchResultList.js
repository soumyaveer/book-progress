import React, { Component } from "react";
import SearchResultListItem from "./SearchResultListItem"

class SearchResultList extends Component {

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
