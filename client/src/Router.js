import React from 'react'
import {
  Switch,
  Route,
  BrowserRouter
} from 'react-router-dom'


import Pages from 'pages'

const Router = () => (
  <BrowserRouter>
    <Switch>
      <Route exact path="/">
        <Pages.BankAccounts.List />
      </Route>
      <Route exact path="/bank_accounts/new">
        <Pages.BankAccounts.New />
      </Route>
      <Route path="/money_transfer">
        <Pages.BankAccounts.MoneyTransfer />
      </Route>
    </Switch>
  </BrowserRouter>
)

export default Router