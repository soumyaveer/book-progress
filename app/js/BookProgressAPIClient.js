export default {
  getBookProgressions(userId) {
    return fetch(`/api/users/${userId}/book-progressions`).then(request => request.json());
  },

  getUsers() {
    return fetch('/api/users').then(request => request.json());
  }
}