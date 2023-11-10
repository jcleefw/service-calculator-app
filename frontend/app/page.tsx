import QuoteForm from './components/QuoteForm'
import ServiceCard from './components/ServiceCard'
import { ServiceProps } from './types/service'

const getServices = async () => {
  try {
    const res = await fetch('http://localhost:3000/api/services', {
      cache: 'no-store',
    })
    const data = await res.json()
    return data.data
  } catch {
    // TODO: handle it properly
    console.log('server is down currently, try again')
  }
}

export default async function Home() {
  const services: Record<string, ServiceProps> = await getServices()

  if (services) {
    const servicesArray = Object.entries(services)
    const formName = 'quoteForm'

    return (
      <main>
        <h1>Ask us for a quote</h1>
        <QuoteForm formName={formName} services={servicesArray} />
      </main>
    )
  } else {
    // TODO create UI to handle when server is down
    return (
      <main>
        <h1>Server is currently down. Try again later</h1>
      </main>
    )
  }
}
