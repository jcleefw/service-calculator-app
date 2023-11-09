import ServiceCard from './components/ServiceCard'
import { ServiceProps } from './types/service'

const getServices = async () => {
  const res = await fetch('http://localhost:3000/api/services', {
    cache: 'no-store',
  })
  const data = await res.json()
  return data.data
}

export default async function Home() {
  const services: Record<string, ServiceProps> = await getServices()

  const servicesArray = Object.entries(services)
  const formName = 'quoteForm'

  return (
    <main>
      <h1>Ask us for a quote</h1>
    </main>
  )
}
