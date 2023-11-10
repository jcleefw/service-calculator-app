import { ServiceRequestItem } from '../types/service'

// TODO: this requires some more refactoring to be more accurate with the sanitization, and unit test
export const buildFormData = (formData: FormData): ServiceRequestItem[] => {
  const formValues: Record<string, any> = {}
  // Convert FormData to a plain object
  formData.forEach((fieldValue, key) => {
    const [_, serviceName, propName, option_name] = key.split('.')

    if (!formValues[serviceName]) {
      formValues[serviceName] = {
        extras: [],
        service: '',
        quantity: 0,
      }

      if (propName === 'options') {
        formValues[serviceName]['extras'] = [option_name]
      } else {
        formValues[serviceName][propName] = fieldValue
      }
    } else {
      if (propName === 'options') {
        formValues[serviceName]['extras'].push(option_name)
      } else {
        formValues[serviceName][propName] = fieldValue
      }
    }
  })

  return Object.values(formValues)
}
