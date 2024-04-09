import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
    vus: 5,
    duration: '1m',
    rps: 100
};

export default function () {
    http.get('http://10.4.2.234:8000/api/reservationTime?from=2024-04-07&to=2024-04-13');
    sleep(0.5);
}

