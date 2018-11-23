import React, { Component } from "react";
import GoogleBooksSearchAPIClient from './GoogleBooksSearchAPIClient';

class SearchBar extends Component {
  state = {
    isSearchButtonDisabled: true,
    searchQuery: '',
    searchResults: [],
    showError: false
  };

  handleSearchButtonClick = (event) => {
    event.preventDefault();

    GoogleBooksSearchAPIClient.search(
      this.state.searchQuery
    ).then(
      this.handleSearchResultSuccess
    ).catch(
      this.handleSearchResultFailure
    );
  };

  handleSearchResultSuccess = (searchResults) => {
    this.setState({
      searchResults: searchResults,
      showError: false
    });

    this.props.onSearchSuccess({
      query: this.state.searchQuery,
      results: this.state.searchResults
    });
  };

  handleSearchResultFailure = (response) => {
    this.setState({ showError: true })
  };

  handleSearchInputChange = (event) => {
    const searchQuery = event.target.value;
    const isSearchButtonDisabled = !searchQuery;

    this.setState({
      isSearchButtonDisabled,
      searchQuery
    });
  };

  render() {
    const { isSearchButtonDisabled, searchQuery, showError } = this.state;

    return (
      <div className="form-group">
        <input autoComplete='off'
               className="form-control"
               id={ searchQuery }
               name="search"
               onChange={ this.handleSearchInputChange }
               placeholder='Search a book'
               required
               type="search">
        </input>

        <button disabled={isSearchButtonDisabled}
                type="submit"
                className="btn btn-primary"
                onClick={ this.handleSearchButtonClick }>Search</button>
        {
          showError && <div>Unexpected error has occured.</div>
        }
      </div>
    )
  }
}

export default SearchBar;
