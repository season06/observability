wrk.method = "POST"
wrk.headers["Content-Type"] = "application/json"
wrk.headers["X-CSRF-TOKEN"] = "jTwHJqyORXJLzpCxKMQ6348GfRRMLFn6ftV2bTop"
wrk.headers["Cookie"] = "XSRF-TOKEN=eyJpdiI6Im83eVRSUWtteWM5VUVuTUcyenV6RlE9PSIsInZhbHVlIjoiWkc1eHlRWDlyb0tWKzQ5NnNiOW9obHRRUkowQS9qZ1k3MTdZM0VldTFTMElMc0thdnZoYi8vU3RzcFhJWS9xN2NReDBBQ1ZWeXBmam5lbWdhR1hGQVFQRGZ4ME1ISnZPUjZ3am5tbFZzQW9mNEY0Wmx5Ym1wSUtuNHFrUm1ZY1giLCJtYWMiOiI1MmRmMDg1MWJiOGFkNzhmZjhhOWQ1ZjUyODczZWIzMTMwOTRjNjQ0YjNiNDZiNWNiYmUxMDRlNGI0Mzk5MWU3IiwidGFnIjoiIn0%3D; booking_local_session=eyJpdiI6IjZpU1ZsbGhIY3c1UXo1TGlGMk8wZlE9PSIsInZhbHVlIjoiL0xOK3NuamVJZzdSOUZsVThuMzByU2N3TGk5eElETFFGSG5QaUhVQlJqOHRUQ3hVTm93UlE5WW9DTWt2MXV5RmhBQWxXM3hGTFY1d3ZUcm9RZW5XdSt5K2pPUEJ1SlVYZXl2Vys4dUo5VnlFMU1CRnR2K2V5Y21LU21rd3JvY0QiLCJtYWMiOiJkYTE5YzRhZDRmZDBiYjFjY2Q4ODI2ZjhhYmI1NmVkZDk1NzcyNmI0NmY1NjVmNzYwMGZhNWVhOWFlN2I1YTU3IiwidGFnIjoiIn0%3D"
wrk.body = "{  \"reservationInfo\": {    \"course_name\": \"test\",    \"borrower\": \"test\",    \"professor\": \"test\",    \"email\": \"test@gmail.com\",    \"phone\": \"123\"  },  \"times\": [    {      \"classroom_id\": 1,      \"time_slot_id\": 2,      \"date\": \"2024-04-08\",      \"need_duty\": false    }  ]}"