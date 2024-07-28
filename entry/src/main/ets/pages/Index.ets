import { AnimatorParams } from '@ohos.file.PhotoPickerComponent';
import { GetCart, GetCatalogCurrent, GetHome, GetTopicList, PostCategory} from "../api/Index"
import { Banner, BrandList,
  CategoryList,
  IndexData, HotGoodsList, NewGoodsList, GoodsList, ResData, TopicList,
  CatalogData,SubCategoryList,
  CurrentCategory,
  CurrentCatalogData,
  SpecialData,
  TopicData,
  CartData,
  CartList} from '../viewmodel/ResponseData';
import { it } from '@ohos/hypium';
import { FilterParams, promptAction, router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  private controller :TabsController = new TabsController();
  @Builder tabicon(index:number,src:Resource,text:string){
    Column(){
      Image(src)
        .height(25)
        .colorBlend(index==this.currentIndex?"#a80000":"#000000")
      Text(text)
        .fontColor(index==this.currentIndex?"#a80000":"#000000")
    }
  }
  @Builder onimagetext(text:string,price:number){
    Column(){
      Text(text)
        .width("100%")
      Text("￥"+price.toFixed(2)+"元")
        .width("100%")
        .fontColor("#8B0000")
    }
    .padding({left:12,top:10})
  }
  @Builder categoryhead(title:string){
    Row(){
      Divider()
        .width(30)
      Text(title)
        .height(60)
        .margin({left:10,right:10})
        .fontSize(18)
      Divider()
        .width(30)
    }
    .width("100%")
    .justifyContent(FlexAlign.Center)
  }
  @Builder
  endAction() {
    Button('删除').type(ButtonType.Normal).width(100)
  }

  @State brandList: Array<BrandList> = []
  @State banner: Array<Banner> = []
  @State newGoodsList: Array<NewGoodsList> = []
  @State hotGoodsList: Array<HotGoodsList> = []
  @State topicList: Array<TopicList> = []
  @State categoryList: Array<CategoryList> = []

  @State count: number=0;
  @State totalPages: number=0;
  @State pageSize: number=0;
  @State currentPage: number=0;
  @State data:Array<TopicData>=[];

  @State categoryList3: Array<CategoryList> = []
  @State currentCategory:CurrentCategory= {} as CurrentCategory
  @State currentIndex: number = 0

  @State cartList:Array<CartList> = []
  async aboutToAppear() {
    let res:ResData<IndexData> = await GetHome();
    let res2 = await GetTopicList();
    let res3:ResData<CatalogData> = await PostCategory();
    let res4:ResData<CartData> = await GetCart();
    this.brandList = res.data.brandList
    this.banner = res.data.banner
    this.newGoodsList = res.data.newGoodsList
    this.hotGoodsList = res.data.hotGoodsList
    this.topicList = res.data.topicList
    this.categoryList = res.data.categoryList

    this.count = res2.data.count
    this.totalPages = res2.data.totalPages
    this.pageSize = res2.data.pageSize
    this.currentPage = res2.data.currentPage
    this.data = res2.data.data

    this.categoryList3 = res3.data.categoryList
    this.currentCategory = res3.data.currentCategory

    this.cartList = res4.data.cartList
  }
  build() {
    Tabs({barPosition:BarPosition.End,controller:this.controller}){
      TabContent(){
        Column(){
          Search()
            .borderRadius(0)
            .margin({left:15,right:15,top:13,bottom:13 })
          List(){
            ListItem(){
              Swiper() {
                ForEach(this.banner,(item:Banner)=>{
                  Image(item.image_url).width("100%")
                })
              }
              .autoPlay(true)
              .width("100%")
            }
            ListItem(){
              Row(){
                Column(){
                  Image("https://yanxuan.nosdn.127.net/c6fd8835a6400b7da7a016ad85506b69.png")
                    .width("50%")
                    .margin({top:10,bottom:5})
                  Text("居家")
                }
                .height("100%")
                .layoutWeight(1)
                Column(){
                  Image("https://yanxuan.nosdn.127.net/fede8b110c502ec5799702d5ec824792.png")
                    .width("50%")
                    .margin({top:10,bottom:5})
                  Text("餐厨")
                }
                .height("100%")
                .layoutWeight(1)
                Column(){
                  Image("https://yanxuan.nosdn.127.net/37520d1204a0c55474021b43dac2a69e.png")
                    .width("50%")
                    .margin({top:10,bottom:5})
                  Text("配件")
                }
                .height("100%")
                .layoutWeight(1)
                Column(){
                  Image("https://yanxuan.nosdn.127.net/896a3beac514ae8f40aafe028e5fec56.png")
                    .width("50%")
                    .margin({top:10,bottom:5})
                  Text("服装")
                }
                .height("100%")
                .layoutWeight(1)
                Column(){
                  Image("https://yanxuan.nosdn.127.net/static-union/16644541382b06e4.png")
                    .width("50%")
                    .margin({top:10,bottom:5})
                  Text("志趣")
                }
                .height("100%")
                .layoutWeight(1)
              }
              .padding({bottom:10})
              .borderWidth({bottom:10})
              .borderColor("#EBEDF0")
              .width("100%")
              .height("12%")
            }
            ListItem(){
              Column(){
                Row(){
                  Text("品牌制造商直供")
                    .fontSize(20)
                }
                .height("25%")

                Flex({wrap: FlexWrap.Wrap}){
                  ForEach(this.brandList,(item:BrandList,index:number)=>{
                    Image(item.list_pic_url)
                      .width("50%")
                      .padding(5)
                      .overlay(this.onimagetext(item.name,item.floor_price))
                      .onClick(()=>{
                        router.pushUrl({
                          url:"pages/BrandPage",
                          params:{
                            name: item.name,
                            imgurl: item.list_pic_url,
                            price: item.floor_price,
                            rank: item.sort_order,
                            detail: item.simple_desc
                          }
                        })
                      })
                  })
                }
                .padding(5)
                .width("100%")
                .height("75%")
              }
              .width("100%")
              .height("39%")
              .padding({bottom:50})
              .borderWidth({bottom:10})
              .borderColor("#EBEDF0")
            }
            ListItem(){
              Column(){
                Text("周一周四·新品首发")
                  .height(60)
                  .fontSize(18)
                Flex({wrap:FlexWrap.Wrap}){
                  ForEach(this.newGoodsList,(item:NewGoodsList)=>{
                    Column(){
                      Image(item.list_pic_url).width("100%")
                      Text(item.name)
                        .fontSize(15)
                      Text("￥"+item.retail_price.toFixed(2)+"元")
                        .fontColor("#8B0000")
                    }
                    .width("50%")
                  })
                }
                .width("100%")
              }
              .width("100%")
            }
            .height(550)
            .padding({bottom:10})
            .borderWidth({bottom:10})
            .borderColor("#EBEDF0")
            ListItem(){
              Column({space:10}){
                Text("人气推荐")
                  .height(60)
                  .fontSize(18)
                  .width("100%")
                  .textAlign(TextAlign.Center)
                ForEach(this.hotGoodsList,(item:HotGoodsList)=>{
                  Row(){
                    Image(item.list_pic_url)
                      .height(100)
                    Column(){
                      Text(item.name)
                        .fontSize(17)
                      Text(item.goods_brief)
                        .fontSize(14)
                        .fontColor("#AAAAAA")
                      Text("￥"+item.retail_price.toFixed(2)+"元")
                        .margin({top:10})
                        .fontSize(13)
                        .fontColor("#8B0000")
                    }
                    .alignItems(HorizontalAlign.Start)
                  }
                  .backgroundColor("#FAFAFA")
                  .width("100%")
                })
              }
              .height(420)
              .padding({left:10,right:10})
            }
            .borderWidth({bottom:10})
            .borderColor("#EBEDF0")
            ListItem(){
              Column(){
                Text("专题精选")
                  .height(60)
                  .fontSize(18)
                  .width("100%")
                  .textAlign(TextAlign.Center)
                List({space:20}){
                  ForEach(this.topicList,(item:TopicList)=>{
                    ListItem(){
                      Column(){
                        Image(item.item_pic_url)
                          .width(210)
                          .height(180)
                        Text(item.title)
                          .fontSize(17)
                          .margin({left:10,top:7 })
                        Text(item.subtitle)
                          .fontSize(14)
                          .fontColor("#AAAAAA")
                          .margin({left:10})
                          .textOverflow({overflow: TextOverflow.Ellipsis})
                          .maxLines(1)
                        Text("￥"+item.price_info.toFixed(2)+"元")
                          .margin({top:10})
                          .fontSize(13)
                          .fontColor("#8B0000")
                          .margin({left:10})
                      }
                      .width(240)
                      .alignItems(HorizontalAlign.Start)
                    }
                  })
                }
                .scrollBar(BarState.Off)
                .listDirection(Axis.Horizontal)
              }
            }
            .borderWidth({bottom:10})
            .borderColor("#EBEDF0")
            .height(330)
            ForEach(this.categoryList,(item:CategoryList,index:number)=>{
              ListItem(){
                Column(){
                  this.categoryhead(item.name)
                  Flex({wrap:FlexWrap.Wrap}){
                    ForEach(item.goodsList,(item:GoodsList)=>{
                      Column(){
                        Image(item.list_pic_url)
                        Text(item.name).width("100%")
                          .textOverflow({ overflow:TextOverflow.Ellipsis })
                          .maxLines(1)
                          .fontSize(15)
                          .width("90%")
                          .textAlign(TextAlign.Center)
                        Text("￥"+item.retail_price.toFixed(2)+"元").width("100%")
                          .fontSize(13)
                          .fontColor("#8B0000")
                          .textAlign(TextAlign.Center)
                      }
                      .width("50%")
                      .onClick(()=>{
                        promptAction.showToast({message:item.id.toString()})
                      })
                    })
                  }
                  .width("100%")
                }
              }
            })
          }
          .width("100%")
          .height("100%")
        }
        .width("100%")
      }.tabBar(this.tabicon(0,$rawfile("Icons/home.svg"),"首页"))
      TabContent(){
        Column(){
          Search()
            .borderRadius(0)
            .margin({left:15,right:15,top:13,bottom:13 })
          List(){
            ForEach(this.data,(item:TopicData)=>{
              ListItem(){
                Column(){
                  Image(item.scene_pic_url).width("100%").height(280)
                  Text(item.title).fontSize(20)
                    .margin({left:10 })
                  Text(item.subtitle)
                    .margin({left:10 })
                    .fontColor("#999")
                  Text('￥'+item.price_info.toFixed(2)+"元")
                    .margin(10)
                    .fontColor("8B0000")
                }
                .alignItems(HorizontalAlign.Start)
              }
              .margin({bottom:10})
              .borderWidth({bottom:10})
              .borderColor("#EBEDF0")
            })
            ListItem(){
              Column(){
                Text("没有更多了")
                  .fontColor("#969799")
                  .margin({top:8})
              }
              .justifyContent(FlexAlign.Start)
              .alignItems(HorizontalAlign.Center)
              .height(100)
              .width("100%")
            }
          }
        }
      }
      .tabBar(this.tabicon(1,$rawfile("Icons/toptic.svg"),"专题"))
      TabContent(){
        Column(){
          Search()
            .borderRadius(0)
            .margin({left:15,right:15,top:13,bottom:13 })
          Row(){
            List(){
              ForEach(this.categoryList3,(item:CategoryList,index:number)=>{
                ListItem(){
                  Row(){
                    Divider()
                      .width(5)
                      .height(20)
                      .backgroundColor(this.currentIndex == index? Color.Red : Color.Transparent)
                      .margin({right:10})
                    Text(item.name)
                  }.width("100%")
                  .justifyContent(FlexAlign.Start)
                  .height(60)
                  .backgroundColor(this.currentIndex == index?Color.White:Color.Transparent)
                }
                .onClick(this.changeItem.bind(this,index))
              })
            }.width("23%")
            .height("100%")
            Column(){
              Stack(){
                Image(this.currentCategory.banner_url)
                  .width("100%")
                  .height(120)
                  .borderRadius(5)
              }
              .width("100%")
              Text(this.currentCategory.name).width("100%")
                .height(60)
                .textAlign(TextAlign.Center)
                .fontSize(25)
              Flex({wrap:FlexWrap.Wrap}){
                ForEach(this.currentCategory.subCategoryList,(item:SubCategoryList)=>{
                  Column(){
                    Image(item.banner_url).width("40%")
                    Text(item.name)
                      .fontSize(14)
                      .margin({bottom:30,top:5})
                  }.width("33%")
                  .borderColor("#FCFCFC")
                  .borderWidth(1)
                })
              }
            }
            .height("100%")
            .justifyContent(FlexAlign.Start)
            .padding(5)
            .width("77%")
          }
          .width("100%")
        }
        .height("100%")
        .alignItems(HorizontalAlign.Start)
      }
      .tabBar(this.tabicon(2,$rawfile("Icons/classification.svg"),"分类"))
      TabContent(){
        Column() {
          Text("购物车").height(60)
            .fontSize(20)
          Row() {
            Flex() {
              List() {
                ForEach(this.cartList, (item: CartList, index: number) => {
                  ListItem() {
                    Row() {
                      Checkbox({ name: "", group: "a" })
                      Image(item.list_pic_url)
                        .height("80%")
                    }
                    .justifyContent(FlexAlign.Center)
                    .height("100%")
                  }.height(150)
                })
              }.width(150)
              .backgroundColor("#FAFAFA")

              List() {
                ForEach(this.cartList, (item: CartList, index: number) => {
                  ListItem() {
                    Row() {
                      Column() {
                        Text(item.goods_name)
                          .width("100%")
                          .textAlign(TextAlign.Start)
                        Blank()
                        Row(){
                          Text("￥"+item.market_price)
                          Blank()
                          Text("x"+item.number)
                        }
                        .width("100%")
                      }
                      .padding(10)
                      .height("60%")
                      .justifyContent(FlexAlign.SpaceBetween)
                    }.padding({
                      left: 10,
                      right: 20
                    })
                    .width("100%")
                    .justifyContent(FlexAlign.SpaceAround)
                    // .border({ width: 1 })
                    .height(150)

                  }.swipeAction({
                    end: this.endAction()
                  })
                })
              }.layoutWeight(1)
              .backgroundColor("#FAFAFA")
            }
            .height('100%')
            .width('100%')
          }

          Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
            Row() {
              CheckboxGroup({ group: "a" })
              Text("全选")
            }

            Row() {
              Text() {
                Span("合计:");
                Span("¥ ").fontColor(Color.Red)
                Span("0").fontColor(Color.Red).fontSize(20).height(60)
                Span(".00").fontColor(Color.Red).fontSize(14)
              }
            }

            Row() {
              Button('提交订单').linearGradient({
                direction: GradientDirection.Right,
                colors: [["#ff6034", 0], ['#ee0a24', 1]]
              })
            }
          }
          .position({
            bottom: 0
          })
          .width("100%").height(60).border({
            width: 0
          })
        }
      }
      .tabBar(this.tabicon(3,$rawfile("Icons/shoppingcart.svg"),"购物车"))
      TabContent(){
        Column(){
          Row(){
            Image('http://youker.net/img/avatar.901489fb.png')
              .height(70)
              .width(70)
              .borderRadius(35)
            Text("youker")
              .fontColor("#FFFFFF")
              .margin({left:20})
              .fontSize(25)
            Text(">")
              .fontColor("#FFFFFF")
              .layoutWeight(1)
              .textAlign(TextAlign.End)
          }
          .padding(20)
          .backgroundColor("#B75D12")
          .height("17%")
          .width("100%")
          Grid(){
            GridItem(){
              Column(){
                Image($rawfile("Icons/goodlist.svg"))
                  .width("35%")
                  .margin({bottom:5})
                Text("我的订单")
                  .margin({top:8})
              }
            }
            .backgroundColor("#FFFFFF")
            GridItem(){
              Column(){
                Image($rawfile("Icons/ticket.svg"))
                  .width("35%")
                  .margin({bottom:5})
                Text("优惠券")
                  .margin({top:8})
              }
            }
            .backgroundColor("#FFFFFF")

            GridItem(){
              Column(){
                Image($rawfile("Icons/gift.svg"))
                  .width("35%")
                  .margin({bottom:5})
                Text("礼品卡")
                  .margin({top:8})
              }
            }
            .backgroundColor("#FFFFFF")
            GridItem(){
              Column(){
                Image($rawfile("Icons/like.svg"))
                  .width("35%")
                  .margin({bottom:5})
                Text("我的收藏")
                  .margin({top:8})
              }
            }
            .backgroundColor("#FFFFFF")
            GridItem(){
              Column(){
                Image($rawfile("Icons/foot.svg"))
                  .width("35%")
                  .margin({bottom:5})
                Text("我的足迹")
                  .margin({top:8})
              }
            }
            .backgroundColor("#FFFFFF")
            GridItem(){
              Column(){
                Image($rawfile("Icons/welfare.svg"))
                  .width("35%")
                  .margin({bottom:5})
                Text("会员福利")
                  .margin({top:8})
              }
            }
            .backgroundColor("#FFFFFF")
            GridItem(){
              Column(){
                Image($rawfile("Icons/address.svg"))
                  .width("35%")
                  .margin({bottom:5})
                Text("地址管理")
                  .margin({top:8})
              }
            }
            .backgroundColor("#FFFFFF")
            GridItem(){
              Column(){
                Image($rawfile("Icons/safe.svg"))
                  .width("35%")
                  .margin({bottom:5})
                Text("账号安全")
                  .margin({top:8})
              }
            }
            .backgroundColor("#FFFFFF")
            GridItem(){
              Column(){
                Image($rawfile("Icons/customerserve.svg"))
                  .width("35%")
                  .margin({bottom:5})
                Text("联系客服")
                  .margin({top:8})
              }
            }
            .backgroundColor("#FFFFFF")
            GridItem(){
              Column(){
                Image($rawfile("Icons/help.svg"))
                  .width("35%")
                  .margin({bottom:5})
                Text("帮助中心")
                  .margin({top:8})
              }
            }
            .backgroundColor("#FFFFFF")
            GridItem(){
              Column(){
                Image($rawfile("Icons/feedback.svg"))
                  .width("35%")
                  .margin({bottom:5})
                Text("意见反馈")
                  .margin({top:8})
              }
            }
            .backgroundColor("#FFFFFF")
          }
          .columnsTemplate('1fr 1fr 1fr')
          .rowsTemplate('1fr 1fr 1fr 1fr')
          .columnsGap(1)
          .rowsGap(1)
          .width("100%")
          .height(550)
        }

        .width("100%")
        .height("100%")
      }
      .tabBar(this.tabicon(4,$rawfile("Icons/user.svg"),"我的"))
    }
    .scrollable(false)
    .animationDuration(0)
    .onChange((index:number)=>{
      this.currentIndex=index
    })
  }

  async changeItem(index:number){
    this.currentIndex=index;
    let res3:ResData<CurrentCatalogData> = await GetCatalogCurrent(this.categoryList[index].id)
    this.currentCategory = res3.data.currentCategory

  }
}