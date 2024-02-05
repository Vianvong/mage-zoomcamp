import re

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

def camel_to_snake(camel_case_str):
    result = re.sub('([a-z0-9])([A-Z])', r'\1_\2', camel_case_str)
    result = re.sub('([A-Z]+)([A-Z][a-z0-9]+)', r'\1_\2', result)
    return result.lower()


@transformer
def transform(data, *args, **kwargs):
    data.columns = [camel_to_snake(column) for column in data.columns]
    data_filtered = data[(data['passenger_count'] > 0) & (data['trip_distance'] > 0)]
    data_filtered['lpep_pickup_date'] = data_filtered['lpep_pickup_datetime'].dt.date

    return data_filtered


@test
def test_output(output, *args) -> None:
    assert output is not None, 'The output is undefined'
    assert 'vendor_id' in output.columns
    assert (output['passenger_count'] > 0).all()
    assert (output['trip_distance'] > 0).all()
