// How will the base url be set on client?
// How will the base url be set via server?

class BaseApi {
  static async request(method, path, data) {
    let errors = [];
    let payload = null;

    const url  = this.buildUrl(path);
    const body = this.buildBody(data);

    try {
      const response = await fetch(url, { method, body, headers: { cache: 'no-cache' } });
      const jsonres = await response.json();
      errors = jsonres.errors || [];
      payload = errors.length ? undefined : jsonres.data;
    } catch(error) {
      payload = undefined;
      errors.push(error.message);
    }

    return { payload, errors };
  }

  static buildUrl(path) {
    let url = "http://localhost:53000/api/menu_items";

    return !path ? url : `${url}/${path}`; 
  }

  static buildBody(data) {
    if(!data) return undefined;

    const formData = new FormData();

    Object.entries(data).forEach(([field, value]) => {
      if (![null, undefined].includes(value)) {
        formData.append(field, value)
      }
    });

    return formData;
  }
}

export default BaseApi;
