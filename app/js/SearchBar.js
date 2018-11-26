import React, { Component } from "react";
import PropTypes from 'prop-types';
import GoogleBooksSearchAPIClient from './GoogleBooksSearchAPIClient';
import { Link } from "react-router-dom";

class SearchBar extends Component {
  state = {
    isSearchButtonDisabled: true,
    isRequestInProgress: false,
    searchQuery: '',
    searchResults: [],
    showError: false
  };

  static propTypes = {
    onSearchSuccess: PropTypes.func
  };

  handleSearchButtonClick = (event) => {
    event.preventDefault();

    this.setState({ isRequestInProgress: true });

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
      isRequestInProgress: false,
      searchResults: searchResults,
      showError: false
    });

    this.props.onSearchSuccess({
      query: this.state.searchQuery,
      results: this.state.searchResults
    });
  };

  handleSearchResultFailure = () => {
    this.setState({
      isRequestInProgress: false,
      showError: true
    })
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
    const { isSearchButtonDisabled, isRequestInProgress, searchQuery, showError } = this.state;
    const userId = window.current_user.id;
    const disableSearchButton = isSearchButtonDisabled || isRequestInProgress;

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

        <button disabled={ disableSearchButton }
                type="submit"
                className="btn btn-primary"
                onClick={ this.handleSearchButtonClick }>Search
        </button>
        {
          showError && <div>There was an unexpected error trying to search, please try again.</div>
        }

        <Link to={ `/users/${userId}/book-shelf` }>Back</Link>
      </div>
    )
  }
}

export default SearchBar;
