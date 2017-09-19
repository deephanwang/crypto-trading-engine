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
We use *pandas* as our data structure.
[Python Data Analysis Library](http://pandas.pydata.org/)

This is the API used to retrieve the historical data. <span style="color:red">This would require us to record data in the same format and also provide the same function APIs to be able to query the data; for example, by date</span>.
* context.data.get_price
```python
context.data.get_price(security, count=None, start_time=None, end_time=None, frequency=None)
```
This function is used to retrieve up to current bar's data, data frame (pandas.DataFrame).
### **Args**: 
`security` - trading type
<span style="color:blue">Will replace to bittrex supported values</span>.
* `huobi_cny_btc` - huobi rmb btc price
* `huobi_cny_ltc` - huobi rmb ltc price
* `huobi_cny_eth` - huobi rmb eth price
* throw error when type not exist
* throw error when pass in a list

`count` - return number of bars
* count and start_time can not use at same time
* if pass in None value to count and start_time is not None, use start_time to compute (if start_time is valid)
* if count and start_time all Nones, count = 200
* only accept integer, throw error if not
* range 0 < count <= 1440, throw if not in the range

`start_time`

Use either count or start_time. If you give start_time and end_time, it will return number of bars between (start_stime, end_time]. Throw error if start_time and end_time in the same bar.
* if None, use count
* start_time should small than end_time, throw error otherwise
* only accept GMT+8 time format string (24 hours), `yyyy-MM-dd HH:mm:ss`, you have to convert if you are in different timezone
* if use start_time, the max number of bars can not exceed 14400, throw error otherwise

`end_time`

end time, not include the end time bar
* if None, default to the next bar_time (bar_time + frequency) as end time
* throw error if value greater than strategy default bar_time
* only accept GMT+8 time format string (24 hours), `yyyy-MM-dd HH:mm:ss`, you have to convert if you are in different timezone

`frequency`

data sampling frequency, use GMT+8 format
* `1m` - 00:00 is the start of 1 minute, 01:00 is next minute
* `5m` - same as above
* `15m` - same as above
* `30m` - same as above
* `60m` - same as above
* `4h` - same as above
* `1d` - same as above
* `1w` - same as above
* `1M` - same as above
* use context.frequency if None
* throw error if pass in other number
* if return data has None values, will use smooth function to fill the missing data
### **Returns**:
pandas.DataFrame - bar_time/security/open/high/low/close/volume
* bar_time - based on frequency time mark, dateime.dataime
* security - security trading code, return in different lines if it is a list
* open - opening price of the bar
* high - highest price of the bar
* low - lowest price of the bar
* close - close price of the bar
* volume - the trading volume of the bar (quantity, not price)

|                     |security     |open   |high   |low |close |volume |
| --------------------|:------------|:------|:------|:------ |:-------|:-------|
| 2016-10-26 00:00:00 |huobi_cny_btc|4300.67|4309.99|4297.01 |4304.29 |2000000 |
| 2016-10-26 00:01:00 |huobi_cny_btc|4300.67|4309.99|4297.01 |4304.29 |2000000 |
| 2016-10-26 00:02:00 |huobi_cny_btc|4300.67|4309.99|4297.01 |4304.29 |2000000 |
| 2016-10-26 00:03:00 |huobi_cny_btc|4300.67|4309.99|4297.01 |4304.29 |2000000 |

### **Raises**:
* TypeError
* InvalidSecurityError
* InvalidFilterError
* InvalidFrequencyError

### example: get the latest history data
```python
>>> context.frequency                       # get current frequency
"5m"
>>> context.data.get_price("huobi_cny_btc") # get huobi rmb bitcoin 200 bars with frequency of 5min
```
