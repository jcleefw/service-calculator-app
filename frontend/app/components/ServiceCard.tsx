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
        name={`${formName}.${serviceName}.service`}
        id={`${formName}.${serviceName}.service`}
        value={serviceName}
      />

      <FormField
        labelText="Quantity"
        labelFor={`${formName}.${serviceName}.quantity`}
      >
        <input
          type="number"
          name={`${formName}.${serviceName}.quantity`}
          id={`${formName}.${serviceName}.quantity`}
          required
          defaultValue={0}
        />
      </FormField>

      <FormFieldGroup legendText="Additional Options">
        {serviceOptions.length > 0 &&
          serviceOptions.map((opt) => (
            <FormField
              labelText={transformTextToSentence(opt.label)}
              labelFor={`${formName}.${serviceName}.options.${opt.label}`}
              key={`${serviceName}.options.${opt.label}`}
            >
              <input
                type="checkbox"
                name={`${formName}.${serviceName}.options.${opt.label}`}
                id={`${formName}.${serviceName}.options.${opt.label}`}
              />
            </FormField>
          ))}
      </FormFieldGroup>
    </div>
  )
}

export default ServiceCard
