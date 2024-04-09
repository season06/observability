import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
    vus: 5,
    duration: '1m',
    rps: 500,
    iterations: 30
};

export default function () {
    const url = 'http://10.4.2.234:8000/api/reservation'
    const payload = JSON.stringify({
        "reservationInfo": {
            "course_name": "test",
            "borrower": "test",
            "professor": "test",
            "email": "test@gmail.com",
            "phone": "123"
        },
        "times": [
            {
                "classroom_id": 1,
                "time_slot_id": 1,
                "date": "2024-04-07",
                "need_duty": false
            }
        ]
    });
    const params = {
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': 'Qy8AbriGDoEHUA59qNSlfpsd0SlUTFCtkR8Cql2x',
            'Cookie': 'XSRF-TOKEN=eyJpdiI6InJQcXNzM2F3YjlodVJFaDR4VFlsUWc9PSIsInZhbHVlIjoiMGpMSERGdkFCaVhyZVJ1R3IrRVJseloyWVhkNXJvQ25Ob2YrL0Q1c3kySWlEVXYxVUIvMUYyQWRWSzh0Q2gzMXoraTVtcmNrTjFwTGdaZ2xPc3dIWVo0WjJ1SHJXNUdyeFAyYjh4M0RBMEpmR09mdU5TMEtOVUpDd1B3L1g1VngiLCJtYWMiOiIwZDFiNDgzNTRhMGU5MmYyZjdmNGIxYmNhOWRmMjY5NDRkNjY4MDA4OTdiNDQ0ZTA4OTUyYTljZGVkYmE0MGIwIiwidGFnIjoiIn0%3D; booking_local_session=eyJpdiI6IkN6eXJlMEtHRWxjRE5Ya3RBYmNRUGc9PSIsInZhbHVlIjoiaEJ2WnBQRGpsN1QweEhSNWdCazloN29SaG91dEE0VW9kQ1JpSkwvQjBmZUs5RXpwTzR1NWRLdkFzK0pUR01oYVdvelZGU1c4RGZEOEpYR0haMi9GT0JUZ1pQSW9tY2owMTJ2RzBEVThRVDVBL0Zma1VhcUZUQmJESm9zUUtYSGEiLCJtYWMiOiJjNzE2NmZjYmMxZThiYmZiYTA1YzA5MjNlNThjZWVhYzU2N2JlOTA0NDdhZmVlZDlmYWRiYzRhZjcwMDZjZGI4IiwidGFnIjoiIn0%3D',
        },
    };

    http.post(url, payload, params);
    sleep(1);
}

