request = function()
        path = "/api/reservationTime?from=2024-04-07&to=2024-04-13"
        return wrk.format("GET", path)
end