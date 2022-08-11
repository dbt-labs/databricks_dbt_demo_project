   select * from {{ ref('distinct') }}
    
   natural join {{ ref('row_numbered') }} row_numbered
      where row_numbered.rn = 1

-- natural join, where the values match for all columns named the same. Don't have to specify on condition - implicitly inferred. it doesn't have any duplicate columns, will consolidate into one column. 
-- when you introduce nulls, it goes out of wack
