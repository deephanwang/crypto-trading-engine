# Cryptocurrency Trading Engine Introduction

## Basic concept of a quant trading system
pseudocode
```
start {
    init_func(strategy, info, trade)
    loop：when(info.has_update)execute {
        strategy.read_info
        strategy.compute_trade_signal
        if(strategy.has_trade_order)execute {
            trade.execute
        }
        info.update
    }
}
```
## Quant backtesing
pseudocode
```
start {
    read_settings(running_time, type, error_coefficient)
    init_func(strategy, backtesting, simulate_accounting)
    loop: backtesting.first_to_last.execute {
      strategy.read_historical_data
      strategy.compute_trade_signal
      if(strategy.has_trade_signal)execute {
        simulate_accounting.execute_trade
      }
    }
    print_analysis_results
}
```

## Bitcoin automatic investment plan (AIP)
## Quant parameters
### bar
* bar record: open price, close price, highest price, lowest price and trading volume
* bar is the key of the loop
* bar has frequency: minute, hour, day, week. You will decide this based on your strategy
### frequency
frequency is tide up with bar, for example if you set frequency = 1minute, it means the bar contains 1 minute's information, and the strategy execute every minute.
### function
In strategy template, you need to define two functions to be able to activate your strategy. Please check the APIs document for details.
### variables
Please check the APIs document for details.

## A basic Strategy - Bitcoin AIP
```python
PARAMS = {
    "start_time": "2016-09-20 00:00:00",  # backtesting start time
    "end_time": "2016-10-21 00:00:00",  # backtesting end time
    "slippage": 0.02,  # set slip page
    "account_initial": {"huobi_cny_cash": 10000,
                        "huobi_cny_btc": 3},  # set account init state
}

def initialize(context):
    context.frequency = "1d"
    context.benchmark = "huobi_cny_btc"
    context.security = "huobi_cny_btc"

def handle_data(context):
    if context.account.huobi_cny_cash > 100:
        context.order.buy(context.security, cash_amount="100")
```
Strategy combine with three parts: PARAMS, initialize and handle_data.
* PARAMS: define backtesting start/end time, init fund and amount of bitcoins you want to trade, slip page is the margin of error (i.e. tolerance)
* initialize: set `context` variable, including `frequency`, base price, operate type, user custom data
* handle_data: the logic of the strategy, it is execute when read bar info, and trigger the order
### Example of `handle_data`
```python
def handle_data(context):
    # if account balance greater than threshold (set to 100)
    # then trigger order：
    if context.account.huobi_cny_cash > 100:
        # buy 100 rmb equivalent amount of bitcoin
        context.order.buy(context.security, cash_amount="100")
```
