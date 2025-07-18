import ballerina/http;

// Global map with country codes and tax rates (between 5-10)
final map<decimal> countryTaxRates = {
    "US": 7.25,
    "CA": 8.50,
    "GB": 6.75,
    "DE": 9.20,
    "FR": 8.80,
    "IT": 7.90,
    "ES": 6.40,
    "NL": 9.50,
    "BE": 8.10,
    "AT": 7.60,
    "CH": 5.30,
    "SE": 9.80,
    "NO": 8.90,
    "DK": 9.10,
    "FI": 7.70,
    "AU": 6.20,
    "JP": 5.80,
    "KR": 8.30,
    "SG": 6.90,
    "IN": 9.40,
    "BR": 7.15,
    "MX": 8.75,
    "PT": 6.50,
    "LK": 5.00
};

// HTTP service on /tax context
service /tax on new http:Listener(8080) {
    
    // GET resource function for /rate/{countryCode}
    resource function get rate/[string countryCode]() returns TaxRateResponse|http:NotFound {
        
        // Check if country code exists in the map
        if countryTaxRates.hasKey(k = countryCode) {
            decimal taxRate = countryTaxRates.get(k = countryCode);
            
            TaxRateResponse response = {
                taxRate: taxRate,
                countryCode: countryCode
            };
            
            return response;
        } else {
            // Return 404 if country code not found
            return http:NOT_FOUND;
        }
    }
}