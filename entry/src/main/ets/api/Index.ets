import {httpRequest} from "../utils/request"
import {ResData,IndexData,CatalogData, SpecialData, CartData} from "../viewmodel/ResponseData"
//  /api/index/index
export const GetHome = ():Promise<ResData<IndexData>> => httpRequest({url:"/api/index/index"});
export const PostCategory = ():Promise<ResData<CatalogData>> => {
  return httpRequest({
    method:"post",
    url:"/api/catalog/index"
  })
}
export const GetCatalogCurrent=(id:number):Promise<ResData<CatalogData>>  =>{
  return httpRequest({
    url:"/api/catalog/current",
    method:"get",
    params:{id}
  })
}
export const GetTopicList=(page:number=1,size:number=10):Promise<ResData<SpecialData>>  =>{
  return httpRequest({
    url:"/api/topic/list",
    method:"get",
    params:{page,size}
  })
}

export const GetCart = ():Promise<ResData<CartData>> => httpRequest({url:"/api/cart/index"});