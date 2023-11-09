import React from 'react'

type FormFieldGroupProps = {
  children: React.ReactNode
  /** Label text for formfield */
  legendText: string
}

const FormFieldGroup = ({ legendText, children }: FormFieldGroupProps) => {
  return (
    <fieldset className="formfield-group" role="group">
      <legend>{legendText}</legend>
      {children}
    </fieldset>
  )
}

export default FormFieldGroup
