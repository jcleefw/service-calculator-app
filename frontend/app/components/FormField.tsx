import React from 'react'

type FormFieldProps = {
  children: React.ReactNode
  /** Label text for formfield */
  labelText: string
  /** this should map the id for the related input */
  labelFor: string
}

const FormField = ({ labelText, labelFor, children }: FormFieldProps) => {
  return (
    <div className="formfield">
      <label htmlFor={labelFor}>{labelText}</label>
      {children}
    </div>
  )
}

export default FormField
