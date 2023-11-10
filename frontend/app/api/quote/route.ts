export type PostResponse = {
  data: Record<string, any> | null
  error: string | null
}

export async function POST(request: Request): Promise<PostResponse> {
  const url = 'http://localhost:9292/quote_pricing'

  try {
    const res = await fetch(url, {
      cache: 'no-store',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'POST,GET,HEAD',
      },
      body: JSON.stringify(request),
    })
    const data = await res.json()

    return { data, error: null }
  } catch (err: any) {
    return {
      data: null,
      error: 'There was a problem with getting a quote. ' + err.message,
    }
  }
}
