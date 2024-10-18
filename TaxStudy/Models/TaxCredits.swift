//
//  TaxCredits.swift
//  TaxStudy
//
//  Created by Rodney Aiglstorfer on 10/14/24.
//

enum TaxCreditType : String {
    
    /// Child Tax Credit (CTC): The Child Tax Credit is a federal tax benefit aimed at helping families
    /// with dependent children. It directly reduces the amount of taxes owed by providing financial
    /// assistance to families with qualifying children.
    case childTaxCredit
    
    /// Earned Income Tax Credit (EITC) is a refundable tax credit aimed at benefiting low- to
    /// moderate-income individuals and families, particularly those with children. It is designed
    /// to reduce the tax burden on these taxpayers and, in many cases, to increase their refunds,
    /// making it a key tool for poverty alleviation.
    case earnedIncomeTaxCredit
    
    /// American Opportunity Tax Credit (AOTC): Provides up to $2,500 per eligible
    /// student for qualified education expenses for the first four years of higher education.
    case americanOpportunityTaxCredit
    
    /// Lifetime Learning Credit (LLC): Offers up to $2,000 per tax return for post-secondary
    /// education and courses to improve job skills, with no limit on the number of years it
    /// can be claimed.
    case lifetimeLearningCredit
    
    /// Retirement Savings Contribution Credit (Saver’s Credit) Allows low- and moderate-income taxpayers to claim a credit for contributions to a
    /// retirement plan, such as a traditional or Roth IRA, 401(k), or similar retirement accounts.
    /// The credit ranges from 10% to 50% of contributions, depending on income.
    case saversCredit
    
    /// Foreign Tax Credit (FTC) Available to taxpayers who paid or accrued foreign taxes on income that is also subject
    /// to U.S. tax. This credit is designed to mitigate double taxation on income earned abroad.
    case foreignTaxCredit
    
    /// Provides a credit for qualified adoption expenses, up to a certain limit (e.g., $15,950 in 2024).
    /// This non-refundable credit can be carried forward if it exceeds the taxpayer’s liability for the year.
    case adoptionCredit
    
    /// Premium Tax Credit (PTC) Available to individuals and families who purchase health insurance through the Marketplace
    /// under the Affordable Care Act (ACA). The credit helps reduce the cost of premiums based on income.
    case premiumTaxCredit
    
    /// Provides a credit for installing renewable energy systems in a home, such as solar panels,
    /// wind turbines, and geothermal heat pumps. The percentage of the credit depends on the year of installation.
    case residentialRenewableEnergyCredit
    
    /// Provides a credit for improvements such as insulation, energy-efficient windows, and HVAC systems.
    case energyEfficiencyImprovementCredit
    
    /// Provides a credit for the purchase of a qualifying plug-in electric vehicle (EV). The amount varies
    /// depending on the manufacturer and the vehicle, but it can be as high as $7,500.
    case plugInElectricVehicleCredit
    
    /// A non-refundable credit of up to $500 for dependents who do not qualify for the Child Tax Credit,
    /// such as older children or elderly relatives.
    case dependentCareCredit
    
    /// Offers a credit for a portion of expenses paid for the care of children under age 13 or other dependents,
    /// if the care allows the taxpayer (and spouse, if applicable) to work or look for work. The credit ranges from
    /// 20% to 35% of eligible expenses.
    case childAndDependencyCareCredit
    
    /// Health Coverage Tax Credit (HCTC) A credit for certain individuals who lost their jobs due to foreign trade
    /// or who receive benefits from the Pension Benefit Guaranty Corporation (PBGC). It covers a percentage of
    /// qualified health insurance premiums.
    case healthCoverageTaxCredit
    
    /// Work Opportunity Tax Credit (WOTC) A credit for businesses that hire individuals from certain targeted
    /// groups that face significant barriers to employment (e.g., veterans, long-term unemployed individuals,
    /// and certain individuals receiving government assistance).
    case workOpportunityTaxCredit
    
    /// A credit available to taxpayers 65 or older, or under 65 and permanently disabled, with relatively low income levels.
    case elderlyOrDisabledTaxCredit
    
    /// Catch all credit for supporting future changes to the tax code.
    case customCredit
}

extension TaxCreditType: DeductionType {
    var id: String {
        return self.rawValue
    }
    
    var isSupported: Bool {
        return true
    }
    
    var label: String {
        switch self {
        case .childTaxCredit:
            return String(localized: "Child Tax Credit")
        case .earnedIncomeTaxCredit:
            return String(localized: "Earned Income Tax Credit")
        case .americanOpportunityTaxCredit:
            return String(localized: "American Opportunity Tax  Credit")
        case .lifetimeLearningCredit:
            return String(localized: "Lifetime Learning")
        case .saversCredit:
            return String(localized: "Saver’s Credit")
        case .foreignTaxCredit:
            return String(localized: "Foreign Tax Credit")
        case .adoptionCredit:
            return String(localized: "Adoption Credit")
        case .premiumTaxCredit:
            return String(localized: "Premium Tax Credit")
        case .residentialRenewableEnergyCredit:
            return String(localized: "Residential Renewable Energy")
        case .energyEfficiencyImprovementCredit:
            return String(localized: "Energy Efficiency Improvement")
        case .plugInElectricVehicleCredit:
            return String(localized: "Electric Vehicle Credit")
        case .dependentCareCredit:
            return String(localized: "Dependent Care Credit")
        case .childAndDependencyCareCredit:
            return String(localized: "Child and Dependency Care")
        case .healthCoverageTaxCredit:
            return String(localized: "Health Coverage Tax Credit")
        case .workOpportunityTaxCredit:
            return String(localized: "Work Opportunity Tax Credit")
        case .elderlyOrDisabledTaxCredit:
            return String(localized: "Elderly or Disabled Tax Credit")
        case .customCredit:
            return String(localized: "Custom")
        }
    }
    
    var description: String {
        switch self {
        case .childTaxCredit:
            return String(localized: "A federal tax benefit that reduces taxes for families with qualifying children.")
        case .earnedIncomeTaxCredit:
            return String(localized: "A refundable credit for low- to moderate-income individuals and families, designed to reduce tax burden and increase refunds.")
        case .americanOpportunityTaxCredit:
            return String(localized: "Provides up to $2,500 for eligible students' education expenses during the first four years of higher education.")
        case .lifetimeLearningCredit:
            return String(localized: "Offers up to $2,000 per return for post-secondary education or job skills improvement, with no limit on the number of years claimed.")
        case .saversCredit:
            return String(localized: "A credit for contributions to retirement plans, ranging from 10% to 50% of contributions depending on income.")
        case .foreignTaxCredit:
            return String(localized: "A credit for foreign taxes paid on income also subject to U.S. tax, designed to prevent double taxation.")
        case .adoptionCredit:
            return String(localized: "Provides a credit for qualified adoption expenses, with carryover available for unused amounts.")
        case .premiumTaxCredit:
            return String(localized: "Helps reduce the cost of health insurance premiums for individuals and families purchasing coverage through the ACA Marketplace.")
        case .residentialRenewableEnergyCredit:
            return String(localized: "Provides a credit for installing renewable energy systems in a home, like solar panels or wind turbines.")
        case .energyEfficiencyImprovementCredit:
            return String(localized: "A credit for home improvements such as insulation and energy-efficient windows or HVAC systems.")
        case .plugInElectricVehicleCredit:
            return String(localized: "A credit for the purchase of qualifying plug-in electric vehicles, up to $7,500 depending on the vehicle and manufacturer.")
        case .dependentCareCredit:
            return String(localized: "Provides up to $500 for dependents who don't qualify for the Child Tax Credit, like older children or elderly relatives.")
        case .childAndDependencyCareCredit:
            return String(localized: "Offers a credit for a portion of childcare or dependent care expenses, enabling taxpayers to work or look for work.")
        case .healthCoverageTaxCredit:
            return String(localized: "A credit for certain individuals affected by foreign trade or receiving benefits from the PBGC to cover qualified health insurance premiums.")
        case .workOpportunityTaxCredit:
            return String(localized: "A credit for businesses hiring individuals from targeted groups, such as veterans or long-term unemployed workers.")
        case .elderlyOrDisabledTaxCredit:
            return String(localized: "A credit for low-income taxpayers aged 65 or older, or for those under 65 with permanent disabilities.")
        case .customCredit:
            return String(localized: "A placeholder credit to support future changes in the tax code.")
        }
    }
}
