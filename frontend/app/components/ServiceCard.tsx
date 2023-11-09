import React from 'react'
import FormField from './FormField'
import FormFieldGroup from './FormFieldGroup'
import { transformTextToSentence } from '../utils/textTransform'

type ServiceCardProps = {
  serviceName: string
  idx?: number
  formName: string
  options: Array<{ label: string; value: number }>
}

const ServiceCard = ({
  serviceName,
  idx,
  formName,
  options: serviceOptions,
}: ServiceCardProps) => {
  return (
    <div className="card">
      <h2>{transformTextToSentence(serviceName)}</h2>

      <input
        type="hidden"
        name={`${formName}[${idx}].service`}
        id={`${formName}[${idx}].service`}
        value={serviceName}
      />

      <FormField labelText="Quantity" labelFor={`${formName}[${idx}].quantity`}>
        <input
          type="number"
          name={`${formName}[${idx}].quantity`}
          id={`${formName}[${idx}].quantity`}
          required
          defaultValue={0}
        />
      </FormField>

      <FormFieldGroup legendText="Additional Options">
        {serviceOptions.length > 0 &&
          serviceOptions.map((opt) => (
            <FormField
              labelText={transformTextToSentence(opt.label)}
              labelFor={`${formName}[${idx}].options.${opt.value}`}
              key={`${idx}.options.${opt.value}`}
            >
              <input
                type="checkbox"
                name={`${formName}[${idx}].options.${opt.value}`}
                id={`${formName}[${idx}].options.${opt.value}`}
              />
            </FormField>
          ))}
      </FormFieldGroup>
    </div>
  )
}

export default ServiceCard
