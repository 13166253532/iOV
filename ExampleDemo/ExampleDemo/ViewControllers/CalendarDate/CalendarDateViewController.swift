//
//  CalendarDateViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/8/27.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit
import CVCalendar
class CalendarDateViewController: BaseViewController {

    var menuView:CVCalendarMenuView!
    var calendarView:CVCalendarView!
    
    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "CalendarDateViewController", bundle: nil)
        let vc:CalendarDateViewController=storyboard.instantiateViewController(withIdentifier: "CalendarDateViewController") as! CalendarDateViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        isNavigationBarObstructed()
        self.menuView = CVCalendarMenuView.init(frame: CGRect(x:0, y: 0, width:SCREEN_WHIDTH() , height:15 ))
        self.calendarView = CVCalendarView.init(frame: CGRect(x:0, y: 20, width:SCREEN_WHIDTH() , height:320 ))
        self.calendarView.calendarAppearanceDelegate = self
        self.calendarView.calendarDelegate = self
        self.calendarView.animatorDelegate = self
        self.menuView.menuViewDelegate = self
        
        self.view.addSubview(menuView)
        self.view.addSubview(calendarView)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.menuView.commitMenuViewUpdate()
        self.calendarView.commitCalendarViewUpdate()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
extension CalendarDateViewController:CVCalendarViewDelegate,CVCalendarMenuViewDelegate{
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }
    func presentedDateUpdated(_ date: CVDate) {
        self.title = date.globalDescription
    }
    //在此设置当该日为星期天时，设置文字的颜色为红色，否则设置文字的颜色为黑色
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return weekday == .sunday ? UIColor.red : UIColor.black
    }
    //添加一个代理方法，用来设置允许突出显示某个日期。
    func shouldShowWeekdaysOut() -> Bool {
        return true
    }
    //接着添加此代理方法，用来设置允许以动态的方式进行尺寸的缩放。
    func shouldAnimateResizing() -> Bool {
        return true
    }
    // 添加一个代理方法，用来设置是否选中某个日期视图，此处使用随机的方式来决定是否选中
    func shouldSelectDayView(_ dayView: DayView) -> Bool {
        return arc4random_uniform(3) == 0 ? true : false
    }
    //添加一个代理方法，用来响应某个日期被选中时的事件。此时在控制台输出选中的日期。
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
        print("\(dayView.date.commonDescription) is selectd!")
    }
    //此代理方法用来设置是否允许在日期上显示一个标识符。
    func topMarker(shouldDisplayOnDayView dayView: DayView) -> Bool {
        return true
    }
    //获得当前位置上的日期的天数。
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        let day = dayView.date.day
        let randomDay = Int(arc4random_uniform(31))
        if day == randomDay {
            return true
        }
        return false
    }
    //添加一个代理方法，用来设置点标识的颜色。
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor] {
        let red = CGFloat(arc4random_uniform(600)/255)
        let green = CGFloat(arc4random_uniform(600)/255)
        let blue = CGFloat(arc4random_uniform(600)/255)
        let color = UIColor.init(red: red, green: green, blue: blue, alpha: 1.0)
        let numberOfDots = Int(arc4random_uniform(3) + 1)
        switch numberOfDots {
        case 2:
            return [color,color]
        case 3:
            return [color,color,color]
        default:
            return [color]
        }
    }
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: DayView) -> Bool {
        return true
    }
    //添加一个代理方法，设置点标识的尺寸。
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 13
    }
    //继续添加一个代理方法，设置星期的显示方式，此处设置为缩写方式。共有正常、缩写和超级缩写三种样式可以选择。
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .short
    }
    //该代理方法，用来设置选区视图的贝塞尔路径。
    func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
        //在此返回日期视图的显示区域作为选区视图的路径。
        return {UIBezierPath.init(rect: CGRect(x: 0, y: 0, width:$0.width, height: $0.height))}
    }
    //添加一个代理方法，不允许显示自定义的单独选区。
    func shouldShowCustomSingleSelection() -> Bool {
        return false
    }
    //添加一个代理方法，用来设置显示在日期上的辅助视图。
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        // 初始化一个辅助视图，设置其显示区域和日期视图相同，并且形状为圆形。
        let circleView = CVAuxiliaryView.init(dayView: dayView, rect: dayView.frame, shape: CVShape.circle)
        //设置辅助视图的填充颜色为浅灰色，然后返回该辅助视图。
        circleView.fillColor = UIColor.yellow
        return circleView
    }
    //添加一个代理方法，用来设置是否允许在日期视图上，显示一个辅助视图。
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        //设置当日期视图中的日期为当日的天数时，显示辅助视图，否则不显示。
        if dayView.isCurrentDay {
            return true
        }
        return false
    }
    //继续添加一个代理方法，用来设置补充视图。该补充视图将被用来在所有属于星期五的天数位置，绘制一个圆环。
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        //初始化一个圆周率常数。
        let π = M_PI
        //接着初始化一个浮点类型的常量，作为圆环的间距。
        let ringSpacing: CGFloat = 3.0
        //初始化另一个浮点类型的常量，作为圆环的宽度。
        let ringInsetWidth: CGFloat = 1.0
        //初始化一个浮点类型的常量，作为圆环在垂直方向上的偏移距离。
        let ringVerticalOffset: CGFloat = 1.0
        //创建一个图形层变量，用来绘制圆环。
        var ringLayer: CAShapeLayer!
        //设置圆环路径的宽度为1。
        let ringLineWidth:CGFloat = 1.0
        //设置圆环的线条颜色为紫色。
        let ringLineColour:UIColor = UIColor.purple
        //在此创建一个和日期视图相比，具有相同显示区域的视图对象。
        let newView = UIView.init(frame: dayView.bounds)
        //通过计算获得圆环的直径数据
        let diameter:CGFloat = (newView.bounds.width) - ringSpacing
        //然后通过直径算出半径的大小。
        let radius:CGFloat = diameter/2.0
        //从而创建一个矩形区域，用来绘制圆环形状。
        let rect = CGRect(x:newView.frame.minX-radius, y: newView.frame.midY-radius-ringVerticalOffset, width:diameter , height:diameter )
        //对图形层进行初始化操作，并将该层添加到新建视图的层中。
        ringLayer = CAShapeLayer()
        newView.layer.addSublayer(ringLayer)
        //设置层的填充颜色为空。
        ringLayer.fillColor = nil
        //接着设置层的线条宽度和描边颜色两个属性。
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.cgColor
        //初始化一个浮点常量作为圆环的线宽嵌入值。
        let ringLineWidthInset:CGFloat = CGFloat(ringLineWidth/2.0) + ringLineWidth
        // 通过调用矩形区域对象的相关方法，获得和该矩形区域具有相同中心点，但是更大的另一个矩形区域。
        let ringRect:CGRect = rect.insetBy(dx: ringLineWidthInset, dy: ringLineWidthInset)
        //接着获得该区域的中心点坐标。
        let centrePoint:CGPoint = CGPoint(x: ringRect.midX, y: ringRect.midY)
        //获得绘制圆环的起点角度。
        let startAngle:CGFloat = CGFloat(-π/2.0)
        //然后生成绘制圆环的结束点角度。
        let endAngle:CGFloat = CGFloat(π * 2.0) + startAngle
        //接着通过中心点、半径、起点角度、结束点角度以及是否顺时针等数据，创建一个环形路径。
        let ringPath:UIBezierPath = UIBezierPath.init(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        //设置层的路径为环形路径，并设置层的显示区域和当前的日期层保持相同。
        ringLayer.path = ringPath.cgPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    //接着添加一个代理方法，用来设置在何种情况下，允许显示辅助视图。
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if dayView.date.weekDay() == Weekday.friday {
            return true
        }
        return false
    }
    //设置星期文本的颜色为黑色。
    func dayOfWeekTextColor() -> UIColor {
        return UIColor.black
    }
    //添加最后一个代理方法，设置星期文本的背景颜色为无色。接着点击左上角的[编译并运行]按钮，启动模拟器预览项目。
    func dayOfWeekBackGroundColor() -> UIColor {
        return UIColor.clear
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
