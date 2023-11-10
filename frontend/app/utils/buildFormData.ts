import { ServiceRequestItem } from '../types/service'

// TODO: this requires some more refactoring to be more accurate with the sanitization, and unit test
export const buildFormData = (formData: FormData): ServiceRequestItem[] => {
  const formValues: Record<string, any> = {}
  // Convert FormData to a plain object
  formData.forEach((fieldValue, key) => {
    const [_, serviceName, propName, option_name] = key.split('.')
    // TODO: Hacky way to ensure that quantity is a integer. There's definitely better to do this
    const sanitizedValue =
      propName === 'quantity' ? Number(fieldValue) : fieldValue

    if (!formValues[serviceName]) {
      formValues[serviceName] = {
        extras: [],
        service: '',
        quantity: 0,
      }

      if (propName === 'options') {
        formValues[serviceName]['extras'] = [option_name]
      } else {
        formValues[serviceName][propName] = sanitizedValue
      }
    } else {
      if (propName === 'options') {
        formValues[serviceName]['extras'].push(option_name)
      } else {
        formValues[serviceName][propName] = sanitizedValue
      }
    }
  })

  return Object.values(formValues)
}
