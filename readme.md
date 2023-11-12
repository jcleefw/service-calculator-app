## Start BE Sinatra application

Server will be served at PORT 9292 unless defined by user
```bash
  rackup
```

## run test in sinatra
We can only run test individually at the moment. 
```bash
rspec
```

## API Endpoints
There are currently 3 available endpoints

1. GET /services
An endpoint to list out the available services with pricing

2. POST /quote_pricing
An Endpoint to send POST request and will return a calculated pricing 

  Sample of input can be found in the [mocks/input.json](mocks/input.json)

  Sample of output can be found in the [mock/mock_output.json](mocks/mock_output.json)

3. GET /calculate_single_service
An endpoint to calculate an individual service's total price based on quantity and additional options

  example: `GET __URL__/calculate_single_service?quantity=5&extras=add_watermark,background_removal&service=photo_retouching`

---

## Start FE Next application

FE app will be served at PORT 3000 unless defined by user
```bash
  cd frontend

  npm run dev
```

___



## Assumptions/Tradeoffs for BE
- Invalid service will not be taken into account. But this will not crash the app. We will show an error message to inform user that the invalid service is "NOT AVAILABLE".
- Invalid service option will not be taken into account. In this current implementation, this invalid option will be ignored WITHOUT any notification to the user. 
- All currency will be hardcoded to `AUD`
- When there is duplication in the service requested, it will be treated as a separate object instead of combining them into 1 object
- Only some unit test are written. Mostly for methods that does more computation.

## Assumptions/Tradeoffs for FE
There's definitely more work that needs to be done on the FE code. The current state are not as refined as I prefer. Happy to chat it through the next stage and what else more and how I would go about to implement it.

- missing unit test
- more refined state management and UI display
- responsive pages
- tidier styling and consistencies
- add some form validation with yup validation


-- 

## Breakdown of Task
I've used github issues to create tickets for task required.

**To see tickets:**
https://github.com/jcleefw/service-calculator-app/issues