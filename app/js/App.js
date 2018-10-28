import React, {Component} from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter, Switch, Route } from 'react-router-dom';
import UsersList from './UsersList';
import UserListItem from './UserListItem';


class App extends Component {
  render() {
    return (
      <BrowserRouter>
        <Switch>
          <Route exact path="/" component={UsersList}/>
          <Route exact path="/users/:id/book-shelf" component={UserListItem}/>
        </Switch>
      </BrowserRouter>
      )
  }
}

ReactDOM.render(
  <App/>,
  document.getElementById('root')
);
