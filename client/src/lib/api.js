export const API_BASE_URL = process.env.API_BASE_URL;

const buildUrl = path => {
  let url = `${API_BASE_URL}/api/menu_items`;

  return path ? `${url}/${path}` : url; 
}

const buildBody = payload => {
  if(!payload) return;

  const formData = new FormData();

  Object.entries(payload).forEach(([field, value]) => {
    if (![null, undefined].includes(value)) {
      formData.append(field, value)
    }
  });

  return formData;
}

const request = (method, path, payload) => {
  let errors = [];
  let data = null;

  const options = { method, headers: { cache: 'no-cache' } };
  const body = buildBody(payload);
  if(body) options.body = body;
  const url  = buildUrl(path);

  try {
    const response = await fetch(url, options);
    const jsonres = await response.json();
    data = jsonres.data || null;
    errors = jsonres.errors || [];
  } catch(error) {
    errors.push(error.message);
  }

  return { payload, errors };
}

class Api {
  static fetch(id) {
    return request('GET', id, null);
  }

  static create(payload) {
    return this.request('POST', null, payload);
  }

  static update(id, payload) {
    return this.request('PATCH', id, payload);
  }

  static delete(id) {
    return this.request('DELETE', id, null);
  }
}

export default Api;

