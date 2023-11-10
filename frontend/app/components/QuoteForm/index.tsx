'use client'
import { POST, PostResponse } from '@/app/api/quote/route'
import { ServiceProps } from '@/app/types/service'
import { buildFormData } from '@/app/utils/buildFormData'
import React, { useState } from 'react'
import FormContent from './FormContent'

type QuoteFormProps = {
  formName: string
  services: [string, ServiceProps][]
}

const postFormData = async (formData: any) => {
  const res = await POST(formData)
  console.log(res)

  return res
}

const QuoteForm = ({ formName, services }: QuoteFormProps) => {
  const [quotation, setQuotation] = useState<Record<string, any> | null>(null)
  const [errors, setErrors] = useState<string | null>(null)

  const handleClick = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()

    const formData = new FormData(e.currentTarget)
    const transformedFormData = buildFormData(formData)

    const response: PostResponse = await postFormData(transformedFormData)

    if (response.data) {
      setQuotation(response.data)
    } else if (response.error) {
      setErrors(response.error)
    }
  }

  return (
    <form name={formName} onSubmit={handleClick}>
      <FormContent formName={formName} services={services} />
      <button type="submit">Get quote</button>
    </form>
  )
}

export default QuoteForm
