#!/bin/bash

# TODO - change this url to deployment domain after deployment is complete
export BACKEND_URL="http://127.0.0.1:8000" 

# Uncomment below section to use the local server
# export BACKEND_URL="http://127.0.0.1:8000"

export AUTH_ROUTE="/auth/signin"

export CREATE_DIFF="/diff/create_diff"
export UPDATE_DIFF="/diff/update_diff"
export DELETE_DIFF="/diff/delete_diff"
export GET_DIFF_DETAILS="/diff/delete_diff"
export ATTACH_JIRA_TICKET="/diff/attach_jira_ticket"
export LIST_JIRA_TICKETS="/diff/list_jira_tickets"
export GET_CERTIFICATE=""


