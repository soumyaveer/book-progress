import React, { Component } from 'react';
import StringUtils from './StringUtils';
import PropTypes from 'prop-types';

class EditBookProgressionForm extends Component {
  state = {
    progressionSelected: {
      book: {
        coverUrl: this.props.bookProgression.book.cover_url,
        id: this.props.bookProgression.book.id,
        totalPages: this.props.bookProgression.book.pages,
        title: this.props.bookProgression.book.title
      },
      bookId: this.props.bookProgression.book_id,
      currentPage: this.props.bookProgression.current_pages,
      id: this.props.bookProgression.id,
      percentRead: this.props.bookProgression.percent_read,
      userId: this.props.bookProgression.user_id
    },
    isRequestInProgress: false,
    isSaveButtonDisabled: true,
    showUpdateError: false
  };

  static propTypes = {
    bookProgression: PropTypes.object,
    onUpdateFormSaveButtonClick: PropTypes.func,
    onCancelButtonClick: PropTypes.func
  };

  handleUpdateFormSubmit = () => {
    event.preventDefault();

    const { progressionSelected } = this.state;
    this.props.onUpdateFormSaveButtonClick(progressionSelected);
  };

  handleCancelButtonClick = (event) => {
    event.preventDefault();
    this.props.onCancelButtonClick();
  };

  handleCurrentPageChange = (event) => {
    const currentPage = event.target.value;

    this.setState(prevState => ({
      progressionSelected: {
        ...prevState.progressionSelected,
        currentPage
      },
      isSaveButtonDisabled: this.updateSaveButtonState()
    }));
  };

  handleTotalPageChange = (event) => {
    const totalPages = event.target.value;

    this.setState({
      progressionSelected: {
        book:{
          totalPages
        }
      },
      isSaveButtonDisabled: this.updateSaveButtonState()
    });
  };

  updateSaveButtonState() {
    const { totalPages } = this.state.progressionSelected.book;
    const { currentPage } = this.state.progressionSelected;
    const requiredAttributesMissing = StringUtils.isBlank(totalPages) || StringUtils.isBlank(currentPage);
    return requiredAttributesMissing;
  }

  render() {
    const { showUpdateError, isSaveButtonDisabled , progressionSelected} = this.state;

    return (
      <div className="edit-form">
        {
          showUpdateError &&
          <div className="alert alert-danger">Errors!</div>
        }

        <form onSubmit={ this.handleUpdateFormSubmit }>
          <div className="form-group">
            <label htmlFor="title">{ progressionSelected.book.title }</label>
          </div>

          <div className="form-group">
            <label htmlFor="currentPage">Current Page</label>
            <input id="currentPage"
                   type="number"
                   name="currentPage"
                   value={ progressionSelected.currentPage }
                   required
                   className="form-control"
                   onChange={ this.handleCurrentPageChange } />
          </div>

          <div className="form-group">
            <label htmlFor="total pages">Total Pages</label>
            <input id="totalPages"
                   type="number"
                   name="totalPages"
                   value={ progressionSelected.book.totalPages }
                   required
                   className="form-control"
                   onChange={ this.handleTotalPageChange } />
          </div>

          <button disabled={ isSaveButtonDisabled } type="submit" className="btn btn-primary">Save</button>
          <button className="btn btn-default" onClick={ this.handleCancelButtonClick }>Cancel</button>
        </form>
      </div>
    )
  }
}

export default EditBookProgressionForm;
