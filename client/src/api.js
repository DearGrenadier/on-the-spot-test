const HOST = 'http://0.0.0.0:3000'

const url = (path) => `${HOST}${path}`
const get = (path) => () => fetch(url(path))
const post = (path, formData) => fetch(url(path), {
  method: 'POST',
  body: formData
})

const API = {
  bankAccountsGetList: get('/bank_accounts'),
  bankAccountsCreate: (formData) => post('/bank_accounts', formData),
  moneyTransferesCreate: (formData) => post('/money_transfers', formData)
}

export default API