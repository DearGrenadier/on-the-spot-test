import React from 'react'
import { Container, Row, Col, Button, Table } from 'react-bootstrap'
import {
  Link
} from 'react-router-dom'

import useBankAccounts from 'hooks/useBankAccounts'

const TableRow = ({ bankAccount }) => (
  <tr>
    <td>{bankAccount.id}</td>
    <td>{bankAccount.name}</td>
    <td>{bankAccount.balance}</td>
  </tr>
)

export default () => {
  const bankAccounts = useBankAccounts()

  return (
    <Container>
      <Row>
        <Col md={{ span: 4, offset: 8 }}>
          <Link to="/money_transfer">
            <Button variant="primary">Transfer Money</Button>
          </Link>
          <Link to="/bank_accounts/new">
            <Button variant="success">Create Bank Account</Button>
          </Link>
        </Col>
      </Row>
      <Row>
        <Col>
          <Table striped bordered hover size="sm">
            <thead>
              <tr>
                <th>#</th>
                <th>Name</th>
                <th>Balance</th>
              </tr>
            </thead>
            <tbody>
              {bankAccounts.map((bankAccount) => <TableRow key={bankAccount.id} bankAccount={bankAccount} />)}
            </tbody>
          </Table>
        </Col>
      </Row>
    </Container>
  )
}