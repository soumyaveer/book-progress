import React, { Component } from "react";
import GoogleBooksSearchAPIClient from './GoogleBooksSearchAPIClient';

class SearchBar extends Component {
  state = {
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

    this.props.onSearchSuccess(this.state.searchResults);
  };

  handleSearchResultFailure = (response) => {
    this.setState({ showError: true })
  };

  handleSearchInputChange = (event) => {
    this.setState({
      searchQuery: event.target.value
    });
  };

  render() {
    const { searchQuery, showError } = this.state;

    return (
      <div className="form-group">
        <input autoComplete='off'
               className="form-control"
               id={ searchQuery }
               name="search"
               onChange={ this.handleSearchInputChange }
               required
               type="search">
        </input>

        <button type="submit" className="btn btn-primary" onClick={ this.handleSearchButtonClick }>Search</button>
        {
          showError && <div>Unexpected error has occured.</div>
        }
      </div>
    )
  }
}

export default SearchBar;
