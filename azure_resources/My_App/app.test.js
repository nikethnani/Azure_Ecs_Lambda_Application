// app.test.js
const request = require('supertest');
const app = require('./app'); // Assuming your app is defined in app.js

describe('GET /', () => {
  it('should return 200 OK', () => {
    return request(app)
      .get('/')
      .expect(200);
  });
});