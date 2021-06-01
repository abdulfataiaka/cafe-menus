import BaseApi from './base_api';

export const API_BASE_URL = "http://localhost:53000";

class Api extends BaseApi {
  static fetch(id) {
    return this.request('GET', id, null);
  }

  static create(data) {
    return this.request('POST', null, data);
  }

  static update(id, data) {
    return this.request('PATCH', id, data);
  }

  static delete(id) {
    return this.request('DELETE', id, null);
  }
}

export default Api;
