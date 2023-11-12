import { ServiceRequestItem } from '@/app/types/service'
import * as Yup from 'yup'

const createServiceSchema = () => {
  return Yup.object().shape({
    service: Yup.string().required(),
    quantity: Yup.number().required(),
    extras: Yup.array().of(Yup.string()),
  })
}

const QuoteFormSchema = Yup.array().of(Yup.lazy(createServiceSchema))

export default QuoteFormSchema
