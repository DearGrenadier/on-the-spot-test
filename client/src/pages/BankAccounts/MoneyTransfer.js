import React, { useEffect, useState } from 'react'
import { Container, Row, Col, Button, Form } from 'react-bootstrap'
import { Link, useHistory } from 'react-router-dom'

import useBankAccounts from 'hooks/useBankAccounts'
import API from 'api'

export default () => {
  const [senderId, setSenderId] = useState('')
  const [receiverId, setReceiverId] = useState('')
  const [amount, setAmount] = useState('')
  const history = useHistory()
  const bankAccounts = useBankAccounts()

  const senders = bankAccounts.filter((bankAccount) => bankAccount.id.toString() !== receiverId)
  const receivers = bankAccounts.filter((bankAccount) => bankAccount.id.toString() !== senderId)

  const onAmountChange = (event) => setAmount(event.target.value)
  const onSenderChange = (event) => setSenderId(event.target.value)
  const onReceiverChange = (event) => setReceiverId(event.target.value)

  const sendData = async (data) => {
    const response = await API.moneyTransferesCreate(data)

    if (response.statusText === 'OK') {
      history.push('/')
    } else {
      const json = await response.json()
      alert(json.error)
    }
  }

  const handleSubmit = (event) => {
    event.preventDefault()
    const formData = new FormData()
    formData.set('sender_id', senderId)
    formData.set('amount', amount)
    formData.set('receiver_id', receiverId)
    sendData(formData)
  }

  return (
    <Container>
      <Row><Link to='/'>Back</Link></Row>
      <Row>
        <Col md={{ span: 5, offset: 3 }}>
          <Form onSubmit={handleSubmit}>
            <Form.Group>
              <Form.Label>Sender</Form.Label>
              <Form.Control as="select" value={senderId} onChange={onSenderChange}>
                <option value=""></option>
                {senders.map((sender) =>
                  <option key={sender.id} value={sender.id}>
                    {`${sender.name}(${sender.balance.toFixed(2)})`}
                  </option>)}
              </Form.Control>
            </Form.Group>
            <Form.Group>
              <Form.Label>Balance</Form.Label>
              <Form.Control
                value={amount}
                onChange={onAmountChange}
                placeholder="10.00"
                type="number"
                min="0"
                step="0.01"
              />
            </Form.Group>
            <Form.Group>
              <Form.Label>Receiver</Form.Label>
              <Form.Control as="select" value={receiverId} onChange={onReceiverChange}>
                <option value=""></option>
                {receivers.map((receiver) =>
                  <option key={receiver.id} value={receiver.id}>
                    {`${receiver.name}(${receiver.balance.toFixed(2)})`}
                  </option>)}
              </Form.Control>
            </Form.Group>

            <Button type="submit">Create</Button>
          </Form>
        </Col>
      </Row>
    </Container>
  )
}