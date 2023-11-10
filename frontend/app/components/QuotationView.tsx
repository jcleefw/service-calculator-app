import React from 'react'
import { QuotationResponseProps } from '../types/quote'
import { transformTextToSentence } from '../utils/textTransform'

type QuotationViewProps = {
  data: QuotationResponseProps
  onReset: () => void
}

const QuotationView = ({ data, onReset }: QuotationViewProps) => {
  const { line_items, services_unavailable, ...summaryCharges } = data
  return (
    <>
      <div className="quotation">
        {/* eslint-disable-next-line react/no-unescaped-entities */}
        <h4>Here's your requested quote</h4>

        <div className="card">
          {Object.entries(summaryCharges).map(([key, value], index) => (
            <div key={`${key}-${index}`} className="quotation-summary">
              <div className="q-label">{transformTextToSentence(key)}</div>
              <div className="q-value">{value}</div>
            </div>
          ))}
        </div>
        <button type="reset" onClick={onReset}>
          Reset Form
        </button>
      </div>
    </>
  )
}

export default QuotationView
