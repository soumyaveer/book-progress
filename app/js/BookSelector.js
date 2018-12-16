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
      <div className="row">
        <div className="col-12 page__header"><h1>Add a book</h1></div>
        <div className="col-12">
          <SearchBar onSearchSuccess={ this.handleSearchSuccess }/>
        </div>
        <div className="col-12">
          {
            noResultsFoundForQuery ?
              <div>No matches found</div>
              :
              <div><SearchResultList searchResults={ searchData.results }/></div>
          }
        </div>
      </div>
    )
  }
}

export default BookSelector;
