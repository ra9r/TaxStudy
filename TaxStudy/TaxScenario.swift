//
//  TaxScenario.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 9/27/24.
//

import Foundation

@Observable
class TaxScenario: Identifiable {
    
    var ssdi: String = "32154.82"
    
    var interest: String = "12250"
    var taxExemptInterest: String = "0"
    
    var longTermCapitalGains: String = "0"
    var longTermCapitalLosses: String = "0"
    var capitalLossCarryOver: String = "2000000"

    var shortTermCapitalGains: String = "0"
    var shortTermCapitalLosses: String = "0"
    
    var qualifiedDividends: String = "130950"
    var nonQualifiedDividends: String = "0"
    
    var hsaContribution: String = "0"
    var iraContribtuion: String = "0"
    var iraWithdrawal: String = "0"
    var rothConversion: String = "0"
    
    var marginInterestExpense: String = "0"
    var mortgageInterestExpense: String = "0"
    var medicalAndDentalExpense: String = "0"
    
    var grossIncome: Double {
        let income = ssdi.asDouble +
        interest.asDouble +
        taxExemptInterest.asDouble +
        longTermCapitalGains.asDouble +
        qualifiedDividends.asDouble +
        shortTermCapitalGains.asDouble +
        nonQualifiedDividends.asDouble +
        rothConversion.asDouble +
        iraWithdrawal.asDouble
        return income
    }
    
    var totalDividends: Double {
        return qualifiedDividends.asDouble + nonQualifiedDividends.asDouble
    }
    
    var netSTCG: Double {
        return shortTermCapitalGains.asDouble - shortTermCapitalLosses.asDouble
    }
    
    var netLTCG: Double {
        return longTermCapitalGains.asDouble - longTermCapitalLosses.asDouble - capitalLossCarryOver.asDouble - (netSTCG < 0 ? 0 : abs(netSTCG))
    }
    
    var capitalLossDeduction: Double {
        let capitalLossDecutionLimit: Double = 3000
        return netLTCG > 0 ? 0 : min(capitalLossDecutionLimit, abs(netLTCG))
    }
    
    var futureCarryOverLoss: Double {
        return netLTCG < 0 ? abs(netLTCG) - capitalLossDeduction : 0
    }
    
    var agiBeforeSSDI: Double {
        return grossIncome - ssdi.asDouble - hsaContribution.asDouble - taxExemptInterest.asDouble - capitalLossDeduction
    }
    
    var agi: Double {
        return agiBeforeSSDI + taxableSSDI
    }
    
    var magi: Double {
        // For simplicity, assume MAGI = AGI
        return agi
    }
    
    var taxableSSDI: Double {
        let provisionalIncome = agiBeforeSSDI + taxExemptInterest.asDouble + (ssdi.asDouble * 0.5)
        return ssdi.asDouble * (provisionalIncome > 34000 ? 0.85 : 0.5)
    }
    
    var standardDeduction: Double {
        return 14600 // 2023 standard deduction for single filers
    }
    
    var deductibleMedicalExpenses: Double {
        let medicalExpenses = medicalAndDentalExpense.asDouble
        let threshold = 0.075 * agi
        return max(0, medicalExpenses - threshold)
    }
    
    var itemizedDeductions: Double {
        let mortgageInterest = mortgageInterestExpense.asDouble
        let marginInterest = marginInterestExpense.asDouble
        let medicalExpenses = deductibleMedicalExpenses
        return mortgageInterest + marginInterest + medicalExpenses
    }
    
    var deduction: Double {
        return max(standardDeduction, itemizedDeductions)
    }
    
    var taxableIncome: Double {
        return max(0, agi - deduction)
    }
    
    var ordinaryIncome: Double {
        return taxableIncome - qualifiedDividends.asDouble - max(0, netLTCG)
    }
    
    var ordinaryIncomeTax: Double {
        var ordinaryIncomeTax: Double = 0
        
        let thresholds: [Double] = [0, 11600, 47150, 100525, 191950, 243725, 609350]
        let rates: [Double] = [0.10, 0.12, 0.22, 0.24, 0.32, 0.35, 0.37]
        
        for (i, threshold) in thresholds.enumerated() {
            if ordinaryIncome > threshold {
                let nextThreshold = i + 1 < thresholds.count ? thresholds[i + 1] : ordinaryIncome
                let taxableAtRate = min(ordinaryIncome, nextThreshold) - threshold
                ordinaryIncomeTax += taxableAtRate * rates[i]
            } else {
                break
            }
        }
        
        return ordinaryIncomeTax
    }
    
    var ltcgRate: Double {
        return taxableIncome < 89250 ? 0.0 : taxableIncome < 553850 ? 0.15 : 0.2
    }
    
    var qualifiedDividendTax: Double {
        return qualifiedDividends.asDouble * ltcgRate
    }
    
    var capitalGainsTax: Double {
        return max(0, netLTCG) * ltcgRate
    }
    
    var federalTaxes: Double {
        return ordinaryIncomeTax + qualifiedDividendTax + capitalGainsTax
    }
    
    var ncStateTaxes: Double {
        // NC State Tax rate for 2023 is 4.75%
        let ncDeduction = 13000.0
        let taxableIncome = agi - ncDeduction + taxExemptInterest.asDouble - ssdi.asDouble
        let tax = taxableIncome * 0.046
        return max(0, tax)
    }
    
    var totalTaxes: Double {
        return federalTaxes + ncStateTaxes
    }
    
    var effectiveFedTaxRate: Double {
        if grossIncome == 0 {
            return 0
        }
        return federalTaxes / grossIncome
    }
    
    var effectiveStateTaxRate: Double {
        if grossIncome == 0 {
            return 0
        }
        return ncStateTaxes / grossIncome
    }
    
    var effectiveTaxRate: Double {
        if grossIncome == 0 {
            return 0
        }
        return totalTaxes / grossIncome
    }
    
    var afterTaxIncome: Double {
        return grossIncome - totalTaxes
    }
    
}
