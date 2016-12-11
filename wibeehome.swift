//
//  ViewController.swift
//  Wibee Home
//
//  Created by Hana Minh on 5/7/16.
//  Copyright © 2016 Hana Minh. All rights reserved.
//

import UIKit

extension String {
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}

extension Double {
    var percent: String {
        let formatter: NSNumberFormatter = NSNumberFormatter()
        var result: String?
        /* kieu phan tram voi hai so thap phan VD: 53.67%
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.alwaysShowsDecimalSeparator = true
        */
        formatter.numberStyle = NSNumberFormatterStyle.PercentStyle
        result = formatter.stringFromNumber(self)
        if result == nil {
            return "FORMAT FAILURE"
        }
        return result!
    }
    var currencyType: String {
        let formatter: NSNumberFormatter = NSNumberFormatter()
        var result: String?
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "vi_VN")
        result = formatter.stringFromNumber(self)
        if result == nil {
            return "FORMAT FAILURE"
        }
        return result!
    }
}

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var collateralValue: UITextField!
    @IBOutlet weak var incomeYear: UITextField!
    @IBOutlet weak var termsYear: UITextField!
    @IBOutlet weak var lsThaNoi: UITextField!
    @IBOutlet weak var ltvRatio: UILabel!
    @IBOutlet weak var dtiRatio: UILabel!
    
    @IBOutlet weak var lbTextAmount: UILabel!
    @IBOutlet weak var lbTextCollateralValue: UILabel!
    @IBOutlet weak var lbTextIncome: UILabel!
    @IBOutlet weak var lbTextYear: UILabel!
    
    
    
    @IBOutlet weak var lbSoTienVay: UILabel!
    @IBOutlet weak var lbGiaTriTaiSan: UILabel!
    @IBOutlet weak var lbThuNhap12T: UILabel!
    @IBOutlet weak var lbThoiGianVay: UILabel!
    
    @IBOutlet weak var lbLaiSuatThaNoiThangNay: UILabel!
    @IBOutlet weak var lbLaiSuatCoDinh: UILabel!
    @IBOutlet weak var lbLaiSuatVay: UILabel!
    @IBOutlet weak var tienGocTraThang: UILabel!
    @IBOutlet weak var laiThangDau: UILabel!
    @IBOutlet weak var phaiTraThangDau: UILabel!

    @IBOutlet weak var noteTextView: UITextView!
    
    
    @IBOutlet weak var lbTienGoc: UILabel!
    @IBOutlet weak var lbTienLai: UILabel!
    @IBOutlet weak var lbGocLai: UILabel!
    
    @IBOutlet weak var swTongGocPhaiTraLb: UISwitch!
    @IBOutlet weak var swTongLaiPhaiTraLb: UISwitch!
    @IBOutlet weak var swTongGocLaiLb: UISwitch!
    
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var sliderTerms: UISlider!
    
    @IBOutlet weak var textAnHan: UIButton!
    @IBOutlet weak var tfThoiGianAnHan: UITextField!
    @IBOutlet weak var outletCalculatorRatios: UIButton!
    
    
    
    var tongLaiPhaiTra: Double = 0
    var lbLaiTraThangDau: Double = 0
    var lbTienGocMoiThang: Double = 0
    var lbGocLaiThangDau: Double = 0
    var lsChoVayToanKy: Double = 0
    var sliderCurrentValue: Float = 0
    
    var thoiGianAnHan: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Ngon ngu
    var lbvn1: String = "Số tiền vay:"
    var lbvn2: String = "Giá trị tài sản:"
    var lbvn3: String = "Thu nhập 12T:"
    var lbvn4: String = "Thời gian vay:"
    var lbvn5: String = "TÍNH LÃI SUẤT CHO VAY"
    var lbvn6a: String = "Ko Ân hạn:"
    var lbvn6b: String = "Ân hạn:"
    var lbvn7: String = "Ghi chú:"
    var lbvn8: String = "Lãi suất thả nổi tháng này:"
    var lbvn9: String = "Lãi suât cố định (3.5% - 4% - 4.5%):"
    var lbvn10: String = "Lãi suât vay:"
    var lbvn11: String = "Tiền gốc mỗi tháng:"
    var lbvn12: String = "Tiền lãi tháng đầu:"
    var lbvn13: String = "Gốc & Lãi tháng đầu:"
    
    
    var lben1: String = "Amount:"
    var lben2: String = "Home Value:"
    var lben3: String = "Income 12M:"
    var lben4: String = "Loan Terms:"
    var lben5: String = "CALCULATION"
    var lben6a: String = "No Delay:"
    var lben6b: String = "Delay:"
    var lben7: String = "Note:"
    var lben8: String = "Floating Interest:"
    var lben9: String = "Fix Interest (3.5% - 4% - 4.5%):"
    var lben10: String = "Loan Interest:"
    var lben11: String = "Monthly Principal:"
    var lben12: String = "1st Interest Paid:"
    var lben13: String = "1st Principal & Int:"
    
    
    @IBAction func doiNgonNgu(sender: UIButton) {
        if lbSoTienVay.text == lbvn1 {
            lbSoTienVay.text = lben1
            lbGiaTriTaiSan.text = lben2
            lbThuNhap12T.text = lben3
            lbThoiGianVay.text = lben4
            outletCalculatorRatios.setTitle(lben5, forState: .Normal)
            if textAnHan.titleLabel?.text! == lbvn6a {
                textAnHan.setTitle(lben6a, forState: .Normal)
            } else {
                textAnHan.setTitle(lben6b, forState: .Normal)
            }
            noteTextView.text = lben7
            lbLaiSuatThaNoiThangNay.text = lben8
            lbLaiSuatCoDinh.text = lben9
            lbLaiSuatVay.text = lben10
            lbTienGoc.text = lben11
            lbTienLai.text = lben12
            lbGocLai.text = lben13
            
        } else {
            lbSoTienVay.text = lbvn1
            lbGiaTriTaiSan.text = lbvn2
            lbThuNhap12T.text = lbvn3
            lbThoiGianVay.text = lbvn4
            outletCalculatorRatios.setTitle(lbvn5, forState: .Normal)
            if textAnHan.titleLabel?.text! == lben6a {
                textAnHan.setTitle(lbvn6a, forState: .Normal)
            } else {
                textAnHan.setTitle(lbvn6b, forState: .Normal)
            }
            noteTextView.text = lbvn7
            lbLaiSuatThaNoiThangNay.text = lbvn8
            lbLaiSuatCoDinh.text = lbvn9
            lbLaiSuatVay.text = lbvn10
            lbTienGoc.text = lbvn11
            lbTienLai.text = lbvn12
            lbGocLai.text = lbvn13
        }
        
        calculatorRatios(outletCalculatorRatios)
    }
    
    @IBAction func numberChangeText(sender: AnyObject) {
        if amount.hidden == false {
            amount.hidden = true
            collateralValue.hidden = true
            incomeYear.hidden = true
            termsYear.hidden = true
        
            lbTextAmount.hidden = false
            lbTextCollateralValue.hidden = false
            lbTextIncome.hidden = false
            lbTextYear.hidden = false
        } else {
            amount.hidden = false
            collateralValue.hidden = false
            incomeYear.hidden = false
            termsYear.hidden = false
            
            lbTextAmount.hidden = true
            lbTextCollateralValue.hidden = true
            lbTextIncome.hidden = true
            lbTextYear.hidden = true
        }
        
        lbTextAmount.text! = amount.text!.doubleValue.currencyType
        lbTextCollateralValue.text! = collateralValue.text!.doubleValue.currencyType
        lbTextIncome.text! = incomeYear.text!.doubleValue.currencyType
        if lbSoTienVay.text! == lbvn1 {
            lbTextYear.text! = termsYear.text! + " năm"
        } else {
            lbTextYear.text! = termsYear.text! + " year"
        }
    }
    
    
    
    //Tinh ngay thang nam
    func currentMonthYear() -> (month: Double, year: Double) {
    let date = NSDate()
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components([.Day, .Month, .Year], fromDate: date)
    
    let month = components.month
    let year = components.year
        
    return (Double(month), Double(year))
    }
    
    func dayCount(month: Double, year: Double) -> Double {
        switch month {
        case 2:
            return year % 4 == 0 && year % 100 != 0 ? 29 : 28
        case 1,3,5,7,8,10,12:
            return 31
        case 4,6,9,11:
            return 30
        default:
            return 0 // Invalid month number
        }
    }
    
    @IBAction func koAnHan(sender: UIButton) {
        if tfThoiGianAnHan.hidden == true {
            tfThoiGianAnHan.hidden = false
            if lbSoTienVay.text == lbvn1 {
                textAnHan.setTitle("Ân hạn:", forState: .Normal)
            } else {
                textAnHan.setTitle(lben6b, forState: .Normal)
            }
            
        } else {
            tfThoiGianAnHan.hidden = true
            if lbSoTienVay.text == lbvn1 {
                textAnHan.setTitle("Ko ân hạn:", forState: .Normal)
            } else {
                textAnHan.setTitle(lben6a, forState: .Normal)
            }
            tfThoiGianAnHan.text! = String(0)
            calculatorRatios(outletCalculatorRatios)
        }
    }
    
    @IBAction func calculatorRatios(sender: UIButton) {
        
        thoiGianAnHan = tfThoiGianAnHan.text!.doubleValue
        
        if thoiGianAnHan > termsYear.text!.doubleValue/3 {
            let titlevn: String = "Ân hạn tối đa bằng 1/3 thời gian vay"
            let titleen: String = "Maximum delay 1/3 loan terms"
            let title: String
            if lbSoTienVay.text == lbvn1 {
                title = titlevn
            } else {
                title = titleen
            }
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
            thoiGianAnHan = 0
            tfThoiGianAnHan.text = String(0)
            calculatorRatios(outletCalculatorRatios)
            return
        }
        
        if lsThaNoi.text! .isEmpty {
            let titlevn: String = "Hãy nhập vào trường lãi suất thả nổi"
            let titleen: String = "Please input floating interest"
            let title: String
            if lbSoTienVay.text == lbvn1 {
                title = titlevn
            } else {
                title = titleen
            }
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        if amount.text! .isEmpty {
            return
        }
        if collateralValue.text! .isEmpty {
            return
        }
        if incomeYear.text! .isEmpty {
            return
        }
        if termsYear.text! .isEmpty {
            return
        }
        
        let lsChoVay: Double
        
        var ltv: Double
        ltv = ltvCalculator(amount.text!.doubleValue, collateralValue: collateralValue.text!.doubleValue)
        self.ltvRatio.text = ltv.percent
        
        var dtiPre: Double
        dtiPre = dtiCalculator(incomeYear.text!.doubleValue, lsCoDinh: 3.5)
        
        var dti: Double
        
        var laiTraThangDau: Double
        
        var tienGocHangThang: Double
        
        tienGocHangThang = amount.text!.doubleValue/((termsYear.text!.doubleValue - thoiGianAnHan)*12)
        tienGocTraThang.text! = round(tienGocHangThang).currencyType
        
        if lbSoTienVay.text == lbvn1 {
            lbLaiSuatThaNoiThangNay.text! = lbvn8
            lbLaiSuatCoDinh.text! = lbvn9
            lbLaiSuatVay.text! = lbvn10
            lbTienGoc.text! = lbvn11
            lbTienLai.text! = lbvn12
            lbGocLai.text! = lbvn13
        } else {
            lbLaiSuatThaNoiThangNay.text! = lben8
            lbLaiSuatCoDinh.text! = lben9
            lbLaiSuatVay.text! = lben10
            lbTienGoc.text! = lben11
            lbTienLai.text! = lben12
            lbGocLai.text! = lben13
        }
        // Update labels
        lbLaiSuatThaNoiThangNay.text! = lbLaiSuatThaNoiThangNay.text! + " " + lsThaNoi.text! + "%"
        
        if (dtiPre < 0.4) && (ltv < 0.5) {
            lbLaiSuatCoDinh.text! = lbLaiSuatCoDinh.text! + " 3.5%"
            lsChoVay = lsThaNoi.text!.doubleValue + 3.5
            lbLaiSuatVay.text! = lbLaiSuatVay.text! + " " + String(lsChoVay) + "%"
            self.dtiRatio.text = dtiPre.percent
            laiTraThangDau = amount.text!.doubleValue*(lsChoVay/100)/360*dayCount(currentMonthYear().month, year: currentMonthYear().year)
            laiThangDau.text! = round(laiTraThangDau).currencyType
            if thoiGianAnHan == 0 {
                phaiTraThangDau.text! = round(tienGocHangThang + laiTraThangDau).currencyType
            } else {
                phaiTraThangDau.text = round(laiTraThangDau).currencyType
                if lbSoTienVay.text! == lbvn1 {
                    lbTienGoc.text = "Tiền gốc từ kỳ \(Int(thoiGianAnHan*12) + 1) :"
                } else {
                    lbTienGoc.text = "Monthly Prin No.\(Int(thoiGianAnHan*12) + 1) :"
                }
            }
        } else if (dtiPre < 0.4) || (ltv < 0.5) {
            lbLaiSuatCoDinh.text! = lbLaiSuatCoDinh.text! + " 4%"
            lsChoVay = lsThaNoi.text!.doubleValue + 4
            lbLaiSuatVay.text! = lbLaiSuatVay.text! + " " + String(lsChoVay) + "%"
            dti = dtiCalculator(incomeYear.text!.doubleValue, lsCoDinh: 4)
            self.dtiRatio.text = dti.percent
            laiTraThangDau = amount.text!.doubleValue*(lsChoVay/100)/360*dayCount(currentMonthYear().month, year:  currentMonthYear().year)
            laiThangDau.text! = round(laiTraThangDau).currencyType
            if thoiGianAnHan == 0 {
                phaiTraThangDau.text! = round(tienGocHangThang + laiTraThangDau).currencyType
            } else {
                phaiTraThangDau.text = round(laiTraThangDau).currencyType
                if lbSoTienVay.text! == lbvn1 {
                    lbTienGoc.text = "Tiền gốc từ kỳ \(Int(thoiGianAnHan*12) + 1) :"
                } else {
                    lbTienGoc.text = "Monthly Prin No.\(Int(thoiGianAnHan*12) + 1) :"
                }
            }
        } else {
            lbLaiSuatCoDinh.text! = lbLaiSuatCoDinh.text! + " 4.5"
            lsChoVay = lsThaNoi.text!.doubleValue + 4.5
            lbLaiSuatVay.text! = lbLaiSuatVay.text! + " " + String(lsChoVay) + "%"
            dti = dtiCalculator(incomeYear.text!.doubleValue, lsCoDinh: 4.5)
            self.dtiRatio.text = dti.percent
            laiTraThangDau = amount.text!.doubleValue*(lsChoVay/100)/360*dayCount(currentMonthYear().month, year: currentMonthYear().year)
            laiThangDau.text! = round(laiTraThangDau).currencyType
            if thoiGianAnHan == 0 {
                phaiTraThangDau.text! = round(tienGocHangThang + laiTraThangDau).currencyType
            } else {
                phaiTraThangDau.text = round(laiTraThangDau).currencyType
                if lbSoTienVay.text! == lbvn1 {
                    lbTienGoc.text = "Tiền gốc từ kỳ \(Int(thoiGianAnHan*12) + 1) :"
                } else {
                    lbTienGoc.text = "Monthly Prin No.\(Int(thoiGianAnHan*12) + 1) :"
                }
            }
        }
        
        tongLaiPhaiTra = tongLai(amount.text!.doubleValue, lsChoVay: lsChoVay, terms: termsYear.text!.doubleValue)
        lbLaiTraThangDau = laiTraThangDau
        lbTienGocMoiThang = tienGocHangThang
        lsChoVayToanKy = lsChoVay/100
        
        swTongGocPhaiTraLb.on = false
        swTongLaiPhaiTraLb.on = false
        swTongGocLaiLb.on = false
    }

    @IBAction func swTongGocPhaiTra(sender: UISwitch) {
        if swTongGocPhaiTraLb.on {
            if lbSoTienVay.text == lbvn1 {
                lbTienGoc.text! = "Tổng tiền gốc:"
            } else {
                lbTienGoc.text! = "Total Principal:"
            }
            tienGocTraThang.text = amount.text!.doubleValue.currencyType
        } else {
            if thoiGianAnHan == 0 {
                if lbSoTienVay.text == lbvn1 {
                    lbTienGoc.text! = lbvn11
                } else {
                    lbTienGoc.text = lben11
                }
                tienGocTraThang.text! = lbTienGocMoiThang.currencyType
            } else {
                if lbSoTienVay.text == lbvn1 {
                    lbTienGoc.text = "Tiền gốc từ kỳ \(Int(thoiGianAnHan*12) + 1) :"
                } else {
                    lbTienGoc.text = "Monthly Prin No.\(Int(thoiGianAnHan*12) + 1) :"
                }
                tienGocTraThang.text = lbTienGocMoiThang.currencyType
            }
        }
    }
    
    
    @IBAction func swTongLaiPhaiTra(sender: UISwitch) {
        if swTongLaiPhaiTraLb.on {
            if lbSoTienVay.text == lbvn1 {
                lbTienLai.text! = "Tổng tiền lãi:"
            } else {
                lbTienLai.text = "Total Interest:"
            }
            laiThangDau.text! = String(tongLaiPhaiTra.currencyType)
        } else {
            if lbSoTienVay.text == lbvn1 {
                lbTienLai.text! = lbvn12
            } else {
                lbTienLai.text = lben12
            }
            laiThangDau.text! = String(lbLaiTraThangDau.currencyType)
        }
    }
    
    @IBAction func swTongGocLai(sender: UISwitch) {
        if swTongGocLaiLb.on {
            if lbSoTienVay.text == lbvn1 {
                lbGocLai.text = "Tổng Gốc & Lãi:"
            } else {
                lbGocLai.text = "Total Principal & Int:"
            }
            phaiTraThangDau.text! = (tongLaiPhaiTra + amount.text!.doubleValue).currencyType
        } else {
            if lbSoTienVay.text == lbvn1 {
                lbGocLai.text! = lbvn13
            } else {
                lbGocLai.text = lben13
            }
            if thoiGianAnHan == 0 {
            phaiTraThangDau.text! = (lbLaiTraThangDau + lbTienGocMoiThang).currencyType
            } else {
                phaiTraThangDau.text = lbLaiTraThangDau.currencyType
            }
        }
    }
    
    
    @IBAction func onSliderTermChange(sender: UISlider) {
        
        swTongGocPhaiTraLb.on = false
        swTongLaiPhaiTraLb.on = false
        swTongGocLaiLb.on = false
        
        sliderTerms.minimumValue = 1
        sliderTerms.maximumValue = Float(termsYear.text!.doubleValue*12)
        sliderLabel.text! = "\(lroundf(sender.value))"
        
        if lbSoTienVay.text == lbvn1 {
            lbTienGoc.text! = "Tiền gốc kỳ \(lroundf(sender.value)) :"
            lbTienLai.text! = "Tiền lãi kỳ \(lroundf(sender.value)) :"
            lbGocLai.text! = "Gốc & Lãi kỳ \(lroundf(sender.value)) :"
        } else {
            lbTienGoc.text! = "Principal No.\(lroundf(sender.value)) :"
            lbTienLai.text! = "Interest No.\(lroundf(sender.value)) :"
            lbGocLai.text! = "Prin & Int No.\(lroundf(sender.value)) :"
        }
        
        let date = NSDate()
        let calender = NSCalendar.currentCalendar()
        let components = calender.components([.Day, .Month, .Year], fromDate: date)
        let currentYear = components.year
        var calculateYear:Double = Double(currentYear)
        let currentMonth = components.month
        var calculateMonth: Double = Double(currentMonth - 1)
        
        var tienGocDaTraToiKyTinh: Double = 0
        for _ in 0..<Int(lroundf(sender.value)) {
            if calculateMonth == 12 {
                calculateMonth = 0
                calculateYear += 1
            }
            calculateMonth += 1
        }
        
        if thoiGianAnHan == 0 {
            tienGocTraThang.text = lbTienGocMoiThang.currencyType
            for i in 0..<Int(lround(Double(sender.value))) {
                tienGocDaTraToiKyTinh = amount.text!.doubleValue - lbTienGocMoiThang*Double(i)
                let laiCuaKy: Double = tienGocDaTraToiKyTinh*lsChoVayToanKy/360*dayCount(calculateMonth, year: calculateYear)
                laiThangDau.text! = laiCuaKy.currencyType
                
                phaiTraThangDau.text! = (lbTienGocMoiThang + laiCuaKy).currencyType
            }
        } else {
            for i in 0..<Int(lround(Double(sender.value))) {
                if i <= Int(thoiGianAnHan*12 - 1) {
                    tienGocTraThang.text = Double(0).currencyType
                    tienGocDaTraToiKyTinh = amount.text!.doubleValue
                    let laiCuaKy: Double = tienGocDaTraToiKyTinh*lsChoVayToanKy/360*dayCount(calculateMonth, year: calculateYear)
                    laiThangDau.text! = laiCuaKy.currencyType
                    
                    phaiTraThangDau.text! = (0 + laiCuaKy).currencyType
                } else {
                    tienGocTraThang.text! = lbTienGocMoiThang.currencyType
                    tienGocDaTraToiKyTinh = amount.text!.doubleValue - lbTienGocMoiThang*Double(i - Int(thoiGianAnHan*12))
                    let laiCuaKy: Double = tienGocDaTraToiKyTinh*lsChoVayToanKy/360*dayCount(calculateMonth, year: calculateYear)
                    laiThangDau.text! = laiCuaKy.currencyType
                    
                    phaiTraThangDau.text! = (lbTienGocMoiThang + laiCuaKy).currencyType
                }
            }
        }
    }
    
    @IBAction func onSliderPlus(sender: UIButton, forEvent event: UIEvent) {
        sliderCurrentValue = sliderTerms.value
        self.sliderTerms.setValue(sliderCurrentValue + 1, animated: true)
        self.onSliderTermChange(sliderTerms)
    }
    
    @IBAction func onSliderMinus(sender: UIButton) {
        sliderCurrentValue = sliderTerms.value
        self.sliderTerms.setValue(sliderCurrentValue - 2, animated: true)
        self.onSliderTermChange(sliderTerms)
    }
    
    
    
    func ltvCalculator(amount: Double, collateralValue: Double) -> Double {
        let ltv = amount/collateralValue
        return ltv
    }
    
    func dtiCalculator(incomeYear: Double, lsCoDinh: Double) -> Double {
        let goclaiphaitra = gocLai12Thang(amount.text!.doubleValue, lsThaNoi: lsThaNoi.text!.doubleValue, lsCoDinh: lsCoDinh, terms: termsYear.text!.doubleValue)
        return goclaiphaitra/incomeYear
    }
    
    func tongLai(soTien: Double, lsChoVay: Double, terms: Double) -> Double {
        let date = NSDate()
        let calender = NSCalendar.currentCalendar()
        let components = calender.components([.Day, .Month, .Year], fromDate: date)
        let currentYear = components.year
        var calculateYear:Double = Double(currentYear)
        var calculateYeartt: Double = calculateYear
        let currentMonth = components.month
        var calculateMonth: Double = Double(currentMonth - 1)
        var calculateMonthtt: Double = calculateMonth
        var laiPhaiTra:Double = 0
        var laiPhaiTratt: Double = 0
        var duNoDauKy: Double
        
        let soTienGocPhaiTra = soTien/((terms - thoiGianAnHan)*12)
        
        for j in 0..<Int(thoiGianAnHan*12) {
            if calculateMonth == 12 {
                calculateMonth = 0
                calculateYear += 1
            }
            calculateMonth += 1
            duNoDauKy = soTien
            laiPhaiTra += duNoDauKy*(lsChoVay/100)/360*dayCount(calculateMonth, year: calculateYear)
            laiPhaiTratt = laiPhaiTra
            calculateMonthtt = calculateMonth
            calculateYeartt = calculateYear
            _ = j
        }
        
        for i in Int(thoiGianAnHan*12)..<Int(terms*12) {
            if calculateMonthtt == 12 {
                calculateMonthtt = 0
                calculateYeartt += 1
            }
            calculateMonthtt += 1
            duNoDauKy = soTien - soTienGocPhaiTra*Double(i - Int(thoiGianAnHan*12))
            laiPhaiTratt += duNoDauKy*(lsChoVay/100)/360*dayCount(calculateMonthtt, year: calculateYeartt)
        }
        return laiPhaiTratt
    }
    
    
    func gocLai12Thang(soTien: Double, lsThaNoi: Double, lsCoDinh: Double, terms: Double) -> Double {
        let soTienGocPhaiTra: Double
        var laiPhaiTra: Double
        var duNoDauKy: Double
        let ngayTrongThang = [31,28,31,30,31,30,31,31,30,31,30,31]
        var gocLai: Double = 0
        
        soTienGocPhaiTra = soTien/(terms*12)
        let lsChoVay = lsThaNoi + lsCoDinh
        
        for i in 0..<12 {
            duNoDauKy = soTien - soTienGocPhaiTra*Double(i)
            laiPhaiTra = duNoDauKy*(lsChoVay/100)/360*Double(ngayTrongThang[i])
            gocLai += soTienGocPhaiTra + laiPhaiTra
        }
        return gocLai
    }
    
    @IBAction func onTapGestureRecognized(sender: AnyObject) {
        amount.resignFirstResponder()
        collateralValue.resignFirstResponder()
        incomeYear.resignFirstResponder()
        termsYear.resignFirstResponder()
        lsThaNoi.resignFirstResponder()
        noteTextView.resignFirstResponder()
        tfThoiGianAnHan.resignFirstResponder()
    }
}

