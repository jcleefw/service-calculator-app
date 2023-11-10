'use client'
import { POST, PostResponse } from '@/app/api/quote/route'
import { ServiceProps } from '@/app/types/service'
import { buildFormData } from '@/app/utils/buildFormData'
import React, { useRef, useState } from 'react'
import FormContent from './FormContent'
import QuotationView from '../QuotationView'
import { QuotationResponseProps } from '@/app/types/quote'

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
  // TODO: move this a level up
  const [errors, setErrors] = useState<string | null>(null)

  const formRef = useRef<HTMLFormElement | null>(null)

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

  const handleReset = () => {
    setErrors(null)
    setQuotation(null)

    if (formRef.current) formRef.current.reset()
  }

  const hasResponse = quotation || errors

  return (
    <>
      {quotation && (
        <QuotationView
          data={quotation as QuotationResponseProps}
          onReset={handleReset}
        />
      )}
      {!hasResponse && (
        <form
          ref={formRef}
          name={formName}
          onSubmit={handleClick}
          onReset={handleReset}
        >
          <FormContent formName={formName} services={services} />
          <div className="flex flex-row gap-2">
            <button type="submit">Get quote</button>
            <button type="reset">Reset Form</button>
          </div>
        </form>
      )}
      {errors && <div className="error">{errors}</div>}
    </>
  )
}

export default QuoteForm
