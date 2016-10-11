Pod::Spec.new do |s|

  s.name         = "DYTV"
  s.version      = "1.00"
  s.summary      = "A application for DYTV of ios."

  s.homepage     = "https://github.com/coderLL/DYTV"
  s.screenshots  = "http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=%E6%96%97%E9%B1%BCtvlogo&step_word=&hs=0&pn=0&spn=0&di=105228818310&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=2&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=-1&cs=3832303527%2C2485660051&os=2618432825%2C1948976708&simid=0%2C0&adpicid=0&ln=1420&fr=&fmq=1476189294519_R&fm=result&ic=0&s=undefined&se=&sme=&tab=0&width=&height=&face=undefined&ist=&jit=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fhubei.sinaimg.cn%2F2016%2F0128%2FU8155P1190DT20160128105635.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fik_z%26e3Bftgw_z%26e3Bv54_z%26e3BvgAzdH3Fijz75AzdH3Ffiwg2x7gAzdH3Fda8m-a8-dbAzdH3F8ac0d9mm8d_z%26e3Bip4s&gsm=0&rpstart=0&rpnum=0"
  
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.authors            = { "coderLL" => "897323459@qq.com" }

  s.ios.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/coderLL/DYTV.git", :tag => s.version }

  s.source_files  = "DYTV/DYTV/*"
    
  s.requires_arc = true

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }

end