# API Document (context)
## context.frequency
The bar update frequency, set by user at init stage
* `1m` - 00:00 is the start of 1 minute, 01:00 is next minute
* `5m` - same as above
* `15m` - same as above
* `30m` - same as above
* `60m` - same as above
* `4h` - same as above
* `1d` - same as above
* `1w` - same as above
* `1M` - same as above
## conetex.benchmark
Market return (fluctuation) reference, used to compute alpha value, set by user at init stage. <span style="color:blue">Will replace to bittrex supported values</span>.
* `huobi_cny_btc` - huobi rmb btc price
* `huobi_cny_ltc` - huobi rmb ltc price
* `huobi_cny_eth` - huobi rmb eth price 
## context.security
Strategy defined trading type, set by user at init stage.  <span style="color:blue">Will replace to bittrex supported values</span>.
* `huobi_cny_btc` - huobi rmb btc price
* `huobi_cny_ltc` - huobi rmb ltc price
* `huobi_cny_eth` - huobi rmb eth price
## context.data
This is the API used to retrieve the historical data. <span style="color:red">This would require us to record data in the same format and also provide the same function APIs to be able to query the data; for example, by date</span>.
```python
context.data.get_price(security, count=None, start_time=None, end_time=None, frequency=None)
```
