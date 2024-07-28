import { router } from '@kit.ArkUI';

interface paramsObj{
  name: string;
  imgurl: string;
  price: number;
  rank: number;
  detail: string;
}
@Entry
@Component
struct BrandPage {
  @State params:paramsObj = router.getParams() as paramsObj

  build() {
    Column(){
      Row(){
        Image($rawfile("Icons/cancel.svg"))
          .height(25)
          .margin({left:12})
          .onClick(()=>{
            router.back()
          })
        Text(this.params.name)
          .width("100%")
          .textAlign(TextAlign.Center)
          .padding({right:55})
      }.width("100%")
      .height(75)
      .width("100%")
      Image(this.params.imgurl)
        .width("100%")
      Row(){
        Text(this.params.name)
          .fontSize(25)
        Blank()
        Text("￥"+this.params.price.toFixed(2)+"元")
          .fontSize(18)
          .fontColor("#FF0000")
      }
      .padding(20)
      .width("100%")
      Text("订单排名:"+this.params.rank)
        .textAlign(TextAlign.Start)
        .width("100%")
        .padding({left:20})
      Text(this.params.detail)
        .margin({top:30})
        .width("100%")
        .padding({left:20})
        .textAlign(TextAlign.Start)
        .fontColor("#999999")
    }
    .height('100%')
    .width('100%')
  }
}