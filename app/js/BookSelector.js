import React, { Component } from "react";
import SearchBar from "./SearchBar";
import SearchResultList from "./SearchResultList";

class BookSelector extends Component {
  state = {
    searchData: {
      results: [],
      query: ''
    }
  };

  handleSearchSuccess = (searchData) => {
    this.setState({
      searchData
    })
  };

  render() {
    const { searchData } = this.state;
    const noResultsFoundForQuery = searchData.results.length === 0 && searchData.query.length > 0;

    return (
      <div>
        <div>
          <SearchBar onSearchSuccess={ this.handleSearchSuccess }/>
        </div>
        {
          noResultsFoundForQuery ?
            <div>No matches found</div>
            :
            <div><SearchResultList searchResults={ searchData.results }/></div>
        }
      </div>
    )
  }
}

export default BookSelector;
