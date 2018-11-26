export default class GoogleBooksSearchAPIClient {
  static processSearchResultsJSON(json) {
    // console.log('Google Book Search Response: ', json);
    return json.items.map((item) => item.volumeInfo).filter((volumeInfo) => {
      return volumeInfo &&
        volumeInfo.authors &&
        volumeInfo.averageRating &&
        volumeInfo.title &&
        volumeInfo.imageLinks &&
        volumeInfo.industryIdentifiers &&
        volumeInfo.industryIdentifiers.filter((isbn) => isbn.type === 'ISBN_13' ) &&
        volumeInfo.imageLinks.thumbnail &&
        volumeInfo.pageCount;
    }).map(volumeInfo => {
      return {
        authors: volumeInfo.authors.join(', '),
        isbn_13: volumeInfo.industryIdentifiers.filter((isbn) => isbn.type === 'ISBN_13' )[0].identifier,
        rating: volumeInfo.averageRating,
        title: volumeInfo.title,
        cover_url: volumeInfo.imageLinks.thumbnail,
        page_count: volumeInfo.pageCount
      };
    });
  }

  static search(query) {
    const googleSearchURL = `https://www.googleapis.com/books/v1/volumes?q=${query}&maxResults=40&printType=books`;

    return fetch(googleSearchURL, {
      headers: {
        'Accept': 'application/json'
      },
      method: 'GET'
    }).then(response => {
      if (response.status === 200) {
        return response.json().then(this.processSearchResultsJSON);
      } else {
        throw 'Could not search';
      }
    });
  }
}
