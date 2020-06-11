# TODO: Define the output variable for the lambda function.
output lamda_ouptut {
    value = "${aws_lambda_function.greet_lambda.id}"
}