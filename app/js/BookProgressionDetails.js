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

  handleDeleteButtonClick = () => {
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
        <button className="btn btn-default btn-cancel" onClick={ this.handleCancelButtonClick }>×</button>
        <div className="book-progression-details">
          {
            showUpdateError &&
            <div className="alert alert-danger">Errors!</div>
          }

          <div className="text-center">
            <h2>{ bookProgression.book.title }</h2>
            <div>by <i>{ bookProgression.book.authors }</i></div>
            <div><a className="link-primary" href={ bookProgression.book.preview_url } target="_blank">Preview</a></div>
            <div>
              <img src={ bookProgression.book.cover_url } className="book-progression-details__cover" alt={ bookProgression.book.title }/>
            </div>
          </div>
          <div className="text-center">
            <p>{ updatedBookProgressionAttributes.current_page } of { bookProgression.book.pages } pages read</p>
          </div>
          <form onSubmit={ this.handleUpdateFormSubmit } className="book-progression-details__form">
            {
              isBookShelfOwner &&
              <div>
                <div className="form-group">
                  <label htmlFor="currentPage">Update Progress</label>
                  <input id="currentPage"
                         type="number"
                         name="currentPage"
                         value={ updatedBookProgressionAttributes.current_page }
                         required
                         className="form-control"
                         placeholder="Pages read"
                         onChange={ this.handleCurrentPageChange }/>

              </div>
                <div>
                  <button disabled={ isSaveButtonDisabled } type="submit" className="btn btn-primary form__btn">Save</button>
                  <button className="btn btn-danger form__btn" onClick={ this.handleDeleteButtonClick }>Remove</button>
                </div>
              </div>
            }
          </form>
        </div>
      </div>

    )
  }
}

export default BookProgressionDetails;
