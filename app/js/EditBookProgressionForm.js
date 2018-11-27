import React, { Component } from 'react';
import { isBlank } from './Utils';
import PropTypes from 'prop-types';

class EditBookProgressionForm extends Component {
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
    onUpdateFormSaveButtonClick: PropTypes.func,
    onCancelButtonClick: PropTypes.func
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
    const { bookProgression } = this.props;

    return (
      <div className="edit-form">
        {
          showUpdateError &&
          <div className="alert alert-danger">Errors!</div>
        }

        <form onSubmit={ this.handleUpdateFormSubmit }>
          <div className="form-group">
            <label htmlFor="title">{ bookProgression.book.title }</label>
          </div>
          <div className="form-group">
            <label htmlFor="currentPage">Current Page</label>
            <input id="currentPage"
                   type="number"
                   name="currentPage"
                   value={ updatedBookProgressionAttributes.current_page }
                   required
                   className="form-control"
                   onChange={ this.handleCurrentPageChange }/>
          </div>
          <div>{ bookProgression.book.pages }</div>
          <button disabled={ isSaveButtonDisabled } type="submit" className="btn btn-primary">Save</button>
          <button className="btn btn-default" onClick={ this.handleCancelButtonClick }>Cancel</button>
        </form>
      </div>
    )
  }
}

export default EditBookProgressionForm;
