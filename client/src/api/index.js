import BaseApi from './base_api';

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
