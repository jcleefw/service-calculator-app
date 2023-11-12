import React from 'react'

const ErrorView = ({ errors }: { errors: string[] }) => {
  return (
    <div className="error">
      <h3>{`${errors.length} has occurred`}</h3>
      <ul>
        {errors.map((error, idx) => (
          <li key={`error-${idx}`}>{error}</li>
        ))}
      </ul>
    </div>
  )
}

export default ErrorView
