import React, { useState } from 'react'
import { Container, Row, Col, Button, Form } from 'react-bootstrap'
import { Link, useHistory } from 'react-router-dom'

import API from 'api'

export default () => {
  const history = useHistory()
  const [name, setName] = useState('')
  const [balance, setBalance] = useState('')

  const onNameChange = (event) => setName(event.target.value)
  const onBalanceChange = (event) => setBalance(event.target.value)

  const sendData = async (data) => {
    const response = await API.bankAccountsCreate(data)

    if (response.statusText === 'Created') {
      history.push('/')
    } else {
      const json = await response.json()
      alert(json.errors)
    }
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    const formData = new FormData()
    formData.set('name', name)
    formData.set('balance', balance)

    sendData(formData)
  }

  return (
    <Container>
      <Row><Link to='/'>Back</Link></Row>
      <Row>
        <Col md={{ span: 5, offset: 3 }}>
          <Form onSubmit={handleSubmit}>
            <Form.Group>
              <Form.Label>Bank Account Name</Form.Label>
              <Form.Control
                value={name}
                onChange={onNameChange}
                placeholder="Account ##"
                type="text"
                required
              />
            </Form.Group>
            <Form.Group>
              <Form.Label>Balance</Form.Label>
              <Form.Control
                value={balance}
                onChange={onBalanceChange}
                placeholder="10.00"
                type="number"
                step="0.01"
                min="0"
              />
            </Form.Group>

            <Button type="submit">Create</Button>
          </Form>
        </Col>
      </Row>
    </Container>
  )
}