export type QuotationResponseProps = {
  line_items: ServiceResponseItem[]
  line_item_count: number
  currency: string
  subtotal: number
  discount: number
  total: number
  services_unavailable?: string[]
}

export type ServiceResponseItem = {
  service: string
  quantity: string
  total: number
}
