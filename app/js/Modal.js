import React, { Component } from 'react';
import { createPortal } from 'react-dom';

const modalRoot = document.getElementById('modal-root');

class Modal extends Component {
  constructor(props) {
    super(props);
    this.element = document.createElement('div');
  };

  componentDidMount() {
    modalRoot.appendChild(this.element);
  };

  componentWillUnmount() {
    modalRoot.removeChild(this.element);
  }

  render() {
    const modal = (
      <div className="modal__overlay">
        <div className="modal__section">
          { this.props.children }
        </div>
      </div>
    );

    return createPortal(modal, this.element);
  }
}

export default Modal;