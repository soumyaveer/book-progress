import React , { Component } from "react";
import SearchBar from "./SearchBar";
import SearchResultList from "./SearchResultList";

class BookSelector extends Component {

  render(){
    return (
      <div>
        <div>
          <SearchBar />
        </div>
        <div>
          <SearchResultList />
        </div>
      </div>
    )
  }
}

export default BookSelector;
