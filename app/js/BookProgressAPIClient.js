export default class BookProgressAPIClient {
  static getBookProgressions(userId) {
    return fetch(`/api/users/${userId}/book-progressions`).then(request => request.json());
  }

  static getUsers() {
    return fetch('/api/users').then(request => request.json());
  }

  static createBook(book) {
    return fetch("/api/books", {
      body: JSON.stringify(book),
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json'
      },
      method: 'POST'
    })
  }

  static createBookProgression(bookProgressionRequestBody) {
    return fetch("/api/book_progressions", {
      body: JSON.stringify(bookProgressionRequestBody),
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json'
      },
      method: 'POST'
    })
  }

  static updateBookProgression(bookProgressionRequestBody) {
    const bookProgressionURL = `/api/book_progressions/${bookProgressionRequestBody.id}`;

    return fetch(bookProgressionURL, {
      body: JSON.stringify(bookProgressionRequestBody),
      headers: {
        'Accept': 'application/json',
        'content-type': 'aaplication/json'
      },
      method: 'PATCH'
    })
  }

  static deleteBookProgression(bookProgressionRequestBody) {
    const deleteBookProgressionURL = `/api/book_progressions/${bookProgressionRequestBody.id}/delete`;

    return fetch(deleteBookProgressionURL, {
      body: JSON.stringify(bookProgressionRequestBody),
      headers: {
        'Accept': 'application/json',
        'content-type': 'aaplication/json'
      },
      method: 'DELETE'
    })
  }
}
