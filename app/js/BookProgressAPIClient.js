export default class BookProgressAPIClient{
  static getBookProgressions(userId) {
    return fetch(`/api/users/${userId}/book-progressions`).then(request => request.json());
  };

  static getUsers() {
    return fetch('/api/users').then(request => request.json());
  }

  static createBook(book){
    return fetch("/api/books", {
      body: JSON.stringify(book),
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json'
      },
      method: 'POST'
    })
  }

  static createBookProgress(bookProgressionRequestBody){
    return fetch("/api/book_progressions", {
      body: JSON.stringify(bookProgressionRequestBody),
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json'
      },
      method: 'POST'
    })
  }
}
