# Most Active Authors
# In this challenge, the REST API contains information about a collection of users and articles they created. Given the threshold value, the goal is to use the API to get the list of most active authors. Specifically, the list of usernames of users with submission count strictly greater than the given threshold. The list of usernames must be returned in the order the users appear in the results.

# To access the collection of users perform HTTP GET request to:
# https://jsonmock.hackerrank.com/api/article_users?page=<pageNumber>
# where <pageNumber> is an integer denoting the page of the results to return.

# For example, GET request to:

# https://jsonmock.hackerrank.com/api/article_users/search?page=2

# will return the second page of the collection of users. Pages are numbered from 1, so in order to access the first page, you need to ask for page number 1.

 

# # The response to such request is a JSON with the following 5 fields:
# #
# # page: The current page of the results
# # per_page: The maximum number of users returned per page.
# # total: The total number of users on all pages of the result.
# # total_pages: The total number of pages with results.
# # data: An array of objects containing users returned on the requested page
# #
# # Each user record has the following schema:
# #
# # id: unique ID of the user
# # username: the username of the user
# # about: the about information of the user
# # submitted: total number of articles submitted by the user
# # updated_at: the date and time of the last update to this record
# # submission_count: the number of submitted articles that are approved
# # comment_count: the total number of comments the user made
# # created_at: the date and time when the record was created
 

# Function Description

# Complete the function getUsernames in the editor below. 
# getUsernames has the following parameter(s):
#     threshold: integer denoting the threshold value for the number of submission count

 

# The function must return an array of strings denoting the usernames of the users whose submission count is strictly greater than the given threshold. The usernames in the array must be ordered in the order they appear in the API response.

 

# Input Format For Custom Testing
# In the first line, there is an integer threshold.

# Sample Case 0
# Sample Input For Custom Testing

# 10
# Sample Output

# epaga
# panny
# olalonde
# WisNorCan
# dmmalam
# replicatorblog
# vladikoff
# mpweiher
# coloneltcb
# guelo
# Explanation

 

# The threshold value is 10, so the result must contain usernames of users with the submission count value greater than 10. There are 10 such users and their usernames in the order they first appear in the API response are as listed in Sample Output.



require 'rest-client'
require 'json'


def getUsernames threshold
  users = []
  page_number = 1
  parsed_collection = getApiJsonResponse(page_number)
  parsed_collection["total_pages"].times do
    parsed_collection = getApiJsonResponse(page_number) unless page_number == 1
    parsed_collection['data'].each do |user|
      users << user['username'] if user['submission_count'] > threshold
    end
    page_number += 1
  end
  users
end

def getApiJsonResponse page_number
  url = "https://jsonmock.hackerrank.com/api/article_users/search?page=#{page_number}"
  response = RestClient.get(url)
  JSON.parse(response)  
end

pp getUsernames 10