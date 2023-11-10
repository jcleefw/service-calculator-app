'use client'
import { POST, PostResponse } from '@/app/api/quote/route'
import { ServiceProps, ServiceRequestItem } from '@/app/types/service'
import { buildFormData } from '@/app/utils/buildFormData'
import React, { useRef, useState } from 'react'
import FormContent from './FormContent'
import QuotationView from '../QuotationView'
import { QuotationResponseProps } from '@/app/types/quote'
import yup from 'yup'
import QuoteFormSchema from './formSchema'
import ErrorView from '../ErrorView'

type QuoteFormProps = {
  formName: string
  services: [string, ServiceProps][]
}

const postFormData = async (formData: any) => {
  return await POST(formData)
}

const QuoteForm = ({ formName, services }: QuoteFormProps) => {
  const [quotation, setQuotation] = useState<Record<string, any> | null>(null)
  // TODO: move this a level up
  const [errors, setErrors] = useState<string[]>([])

  const formRef = useRef<HTMLFormElement | null>(null)

  const validateForm = async (formData: ServiceRequestItem[]) => {
    try {
      await QuoteFormSchema.validate(formData, { abortEarly: false })
      setErrors([])
      return true
    } catch (validationError: any) {
      setErrors([...errors, ...validationError.errors])
      return false
    }
  }

  const handleClick = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()

    const formData = new FormData(e.currentTarget)
    const transformedFormData = buildFormData(formData)

    const isValid = await validateForm(transformedFormData)

    if (isValid) {
      const response: PostResponse = await postFormData(transformedFormData)
      if (response.data) {
        setQuotation(response.data)
      } else if (response.error) {
        setErrors([...errors, response.error])
      }
    }
  }

  const handleReset = () => {
    setErrors([])
    setQuotation(null)

    if (formRef.current) formRef.current.reset()
  }

  const hasResponse = quotation || errors.length

  return (
    <>
      {quotation && (
        <QuotationView
          data={quotation as QuotationResponseProps}
          onReset={handleReset}
        />
      )}
      {errors.length > 0 && <ErrorView errors={errors} />}

      {!quotation && (
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
    </>
  )
}

export default QuoteForm
