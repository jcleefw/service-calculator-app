import { ServiceProps } from '@/app/types/service'
import React from 'react'
import ServiceCard from '../ServiceCard'

type FormContentProps = {
  formName: string
  services: [string, ServiceProps][]
}

const FormContent = ({ formName, services }: FormContentProps) => {
  return services.length > 0 ? (
    services.map(([serviceName, value], idx) => {
      const serviceOptions = Object.entries(value.options).map(
        ([optionKey, optionValue]) => {
          return { label: optionKey, value: optionValue }
        }
      )

      return (
        <div key={`service-${serviceName}`}>
          <ServiceCard
            serviceName={serviceName}
            options={serviceOptions}
            formName={formName}
            idx={idx}
          />
        </div>
      )
    })
  ) : (
    <div>
      <h3>Sorry, we are not providing any services at the moment.</h3>
    </div>
  )
}

export default FormContent
