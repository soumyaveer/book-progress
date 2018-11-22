import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter, Switch, Route } from 'react-router-dom';
import NavBar from './NavBar';
import UsersList from './UsersList';
import UserBookShelf from './UserBookShelf';
import BookSelector from './BookSelector';


class App extends Component {
  render() {
    return (
      <div>
        <NavBar/>
        <BrowserRouter>
          <Switch>
            <Route exact path="/" component={ UsersList }/>
            <Route exact path="/users/:user_id/book-shelf" component={ UserBookShelf }/>
            <Route exact path="/books/new" component={ BookSelector }/>
          </Switch>
        </BrowserRouter>
      </div>
    )
  }
}

ReactDOM.render(
  <App/>,
  document.getElementById('root')
);
