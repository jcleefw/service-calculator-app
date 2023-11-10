export type ServiceProps = {
  base_price: number
  options: Record<string, number>
}

// typing for per service item for outgoing POST
export type ServiceRequestItem = {
  service: string
  quantity: string
  extras: string[]
}
