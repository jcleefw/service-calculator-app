## Start BE Sinatra application
```bash
  rackup
```

## run test in sinatra
We can only run test individually at the moment. 
```bash
rspec
```

## Assumptions/Tradeoffs
- Invalid service will not be taken into account. But this will not crash the app. We will show an error message to inform user that the invalid service is "NOT AVAILABLE".
- Invalid service option will not be taken into account. In this current implementation, this invalid option will be ignored WITHOUT any notification to the user. 
- All currency will be hardcoded to `AUD`
- When there is duplication in the service requested, it will be treated as a separate object instead of combining them into 1 object
- Only some unit test are written. Mostly for methods that does more computation.


---

## Start FE Next application
```bash
  cd frontend

  npm run dev
```