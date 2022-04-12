with

aum as (

    select * from {{ref('stg_acorns_eod_account_balance')}}

),

agg_aum_user_accounts as (

	select user_uuid, 
	account_snapshot_date, 
  round(sum(balance),0) as aum,

  case 
  when account_type in ('InvestmentAccount::Basic')
  then sum(balance) 
  end as invest,

  case 
  when account_type in ('InvestmentAccount::RothIRA','InvestmentAccount::SimplifiedEmployeePension','InvestmentAccount::TraditionalIRA')
  then sum(balance) 
  end as later,

  case 
  when account_type in ('InvestmentAccount::UGMA','InvestmentAccount::UTMA')
  then sum(balance) 
  end as early

  from aum

	where 
	account_snapshot_date =  DATE_ADD( to_date(CURRENT_TIMESTAMP) , -1 )
	group by user_uuid, account_snapshot_date, account_type

),

agg_aum_balances as (
	select 
	user_uuid,
	account_snapshot_date,
	sum(invest) as invest_bal, 
	sum(early)as early_bal,
	sum(later) as later_bal
	from agg_aum_user_accounts
	group by user_uuid, account_snapshot_date
)

select * from agg_aum_balances