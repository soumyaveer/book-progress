import React, { Component } from 'react';
import { isBlank } from './Utils';
import PropTypes from 'prop-types';

class BookProgressionDetails extends Component {
  state = {
    isRequestInProgress: false,
    isSaveButtonDisabled: true,
    showUpdateError: false,
    updatedBookProgressionAttributes: {
      id: this.props.bookProgression.id,
      current_page: this.props.bookProgression.current_page
    }
  };

  static propTypes = {
    bookProgression: PropTypes.object,
    isBookShelfOwner: PropTypes.bool,
    onCancelButtonClick: PropTypes.func,
    onDeleteButtonClick: PropTypes.func,
    onUpdateFormSaveButtonClick: PropTypes.func
  };

  handleDeleteButtonClick = () =>{
    this.props.onDeleteButtonClick(this.state.updatedBookProgressionAttributes);
  };

  handleUpdateFormSubmit = () => {
    event.preventDefault();
    this.props.onUpdateFormSaveButtonClick(this.state.updatedBookProgressionAttributes);
  };

  handleCancelButtonClick = (event) => {
    event.preventDefault();
    this.props.onCancelButtonClick();
  };

  handleCurrentPageChange = (event) => {
    const current_page = event.target.value;
    const isSaveButtonDisabled = isBlank(current_page);

    this.setState(previousState => ({
      ...previousState,
      isSaveButtonDisabled,
      updatedBookProgressionAttributes: {
        ...previousState.updatedBookProgressionAttributes,
        current_page
      }
    }));
  };

  render() {
    const { showUpdateError, isSaveButtonDisabled, updatedBookProgressionAttributes } = this.state;
    const { bookProgression, isBookShelfOwner } = this.props;

    return (
      <div>
        <button className="btn btn-default btn-cancel" onClick={ this.handleCancelButtonClick }>x</button>

        <div className="edit-form">

          {
            showUpdateError &&
            <div className="alert alert-danger">Errors!</div>
          }

          <form onSubmit={ this.handleUpdateFormSubmit }>

            <div className="form-group">
              <label htmlFor="title">Title: { bookProgression.book.title }</label>
            </div>

            <div className="form-group">
              <label htmlFor="title">Authored by: { bookProgression.book.authors }</label>
            </div>

            <div>
              <img
                src={ bookProgression.book.cover_url }
                className="book-progress__cover"
                alt={ bookProgression.book.title }/>
            </div>

            <div className="form-group float-right">
              <label htmlFor="pages">Pages: </label>{ " " + bookProgression.book.pages }
            </div>

            {
              isBookShelfOwner &&
              <div className="form-group">
                <div className="book_progression_details--current_page-margin">
                  <label htmlFor="currentPage">Current Page</label>
                  <input id="currentPage"
                         type="number"
                         name="currentPage"
                         value={ updatedBookProgressionAttributes.current_page }
                         required
                         className="form-control"
                         onChange={ this.handleCurrentPageChange }/>
                </div>

                <button disabled={ isSaveButtonDisabled } type="submit" className="btn btn-primary form__btn">Save</button>
                <button className="btn btn-danger form__btn" onClick={ this.handleDeleteButtonClick }>Delete</button>
              </div>
            }
          </form>
        </div>
      </div>

    )
  }
}

export default BookProgressionDetails;
