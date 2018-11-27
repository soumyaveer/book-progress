import React, { Component } from 'react';
import PropTypes from 'prop-types';
import BookProgressAPIClient from './BookProgressAPIClient';
import { Link } from "react-router-dom";
import UserBookShelfItem from "./UserBookShelfItem";
import EditBookProgressionForm from "./EditBookProgressionForm";
import Modal from "./Modal";

class UserBookShelf extends Component {
  state = {
    book_progressions: [],
    currentlySelectedBookProgression: {},
    errors: [],
    showUpdateErrors: false,
    showModal: false,
    user: {},
  };

  static propTypes = {
    match: PropTypes.shape({
      params: PropTypes.shape({
        user_id: PropTypes.node,
      }).isRequired,
    }).isRequired
  };

  componentDidMount() {
    BookProgressAPIClient
      .getBookProgressions(this.props.match.params.user_id)
      .then((json) =>
        this.setState({
          book_progressions: json.book_progressions,
          user: json.user
        })
      );
  }

  handleCancelButtonClick = () => {
    this.setState({ showModal: false })
  };

  handleUserBookShelfItemClick = (selectedBookProgression) => {
    this.setState({
      currentlySelectedBookProgression: selectedBookProgression,
      showModal: true
    });
  };

  handleUpdateFormSaveButtonClick = (bookProgressionAttributes) => {
    BookProgressAPIClient.updateBookProgression(bookProgressionAttributes).then((response) => {
      if (response.status === 200) {
        return response.json().then((json) => this.handleUpdateBookProgressionSuccess(json));
      } else if (response.status === 412) {
        return response.json().then((json) => { throw new Error(json.errors) });
      } else {
        throw new Error('Unexpected error when creating a book');
      }
    }).catch((errors) => this.handleUpdateBookProgressionFailure(errors))
  };

  handleUpdateBookProgressionSuccess = (updatedBookProgression) => {
    const updatedBookProgressions = this.state.book_progressions.map((currentBookProgression) => {
      return currentBookProgression.id === updatedBookProgression.id ? updatedBookProgression : currentBookProgression;
    });

    this.setState({
      book_progressions: updatedBookProgressions,
      showModal: false
    });
  };

  // TODO: Check faliure Scenarios. Ask Akshay how to handle failures.
  handleUpdateBookProgressionFailure = (errors) => {
    this.setState({
      errors: errors,
      showUpdateErrors: true
    })
  };

  render() {
    const { currentlySelectedBookProgression, user, book_progressions, showModal, showUpdateErrors, errors  } = this.state;
    const isLoggedIn = !!window.current_user;
    const isBookShelfOwner = isLoggedIn && window.current_user.id === user.id;

    return (
      <div className="row">
        <div className="col-xs-12">
          <h1>{ user.username }</h1>
        </div>

        {
          showUpdateErrors &&
          <div className="alert alert-danger">
            <ul className='list-unstyled'>
              { errors.map((error, i) =>
                <li key={i}>{error}</li>
              )}
            </ul>
          </div>
        }

        { book_progressions.map((book_progression) => {
          return (
            <UserBookShelfItem key={ book_progression.id }
                               book_progression={ book_progression }
                               onClick={ this.handleUserBookShelfItemClick } />
            )
          })
        }

        { isBookShelfOwner && showModal &&
            <Modal size="small">
              <EditBookProgressionForm onCancelButtonClick={ this.handleCancelButtonClick }
                                       bookProgression={ currentlySelectedBookProgression }
                                       onUpdateFormSaveButtonClick={ this.handleUpdateFormSaveButtonClick } />
            </Modal>
        }

        { isBookShelfOwner &&
              <Link to={ `/books/new` }>
                Add Book
              </Link>
        }
      </div>
    )
  }
}

export default UserBookShelf;
