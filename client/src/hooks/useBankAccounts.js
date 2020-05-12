import { useState, useEffect } from 'react'

import API from 'api'

function useBankAccounts(friendID) {
  const [bankAccounts, setBankAccounts] = useState([])

  const fetchData = async () => {
    const response = await API.bankAccountsGetList()
    const json = await response.json()
    setBankAccounts(json)
  }

  useEffect(() => {
    fetchData()
  }, []);

  return bankAccounts
}

export default useBankAccounts