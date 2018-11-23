import React, { Component } from "react";
import SearchBar from "./SearchBar";
import SearchResultList from "./SearchResultList";

class BookSelector extends Component {
  state = {
    searchResults: []
  };

  handleSearchSuccess = (searchResults) => {
    this.setState({
      searchResults
    })
  };

  render() {
    const { searchResults } = this.state;

    return (
      <div>
        <div>
          <SearchBar onSearchSuccess={ this.handleSearchSuccess }/>
        </div>
        <div>
          <SearchResultList searchResults={ searchResults }/>
        </div>
      </div>
    )
  }
}

export default BookSelector;
