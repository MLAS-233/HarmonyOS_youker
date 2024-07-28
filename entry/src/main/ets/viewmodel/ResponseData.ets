export interface Banner{
  id: number;
  ad_position_id: number;
  media_type: number;
  name: string;
  link: string;
  image_url: string;
  content: string;
  end_time: number;
  enabled: number;
}
export interface Channel{
  id: number;
  name: string;
  url: string;
  icon_url: string;
  sort_order: number;
}
export interface NewGoodsList{
  id: number;
  name: string;
  list_pic_url: string;
  retail_price: number;
}
export interface HotGoodsList{
  id: number;
  name: string;
  list_pic_url: string;
  retail_price: number;
  goods_brief: string;
}
export interface BrandList{
  id: number;
  name: string;
  list_pic_url: string;
  simple_desc: string;
  pic_url: string;
  sort_order: number;
  is_show: number;
  floor_price: number;
  app_list_pic_url: string;
  is_new: number;
  new_pic_url: string;
  new_sort_order: number;
}
export interface TopicList{
  id: number;
  title: string;
  content: string;
  avatar: string;
  item_pic_url: string;
  subtitle: string;
  topic_category_id: number;
  price_info: number;
  read_count: string;
  scene_pic_url: string;
  topic_template_id: number;
  topic_tag_id: number;
  sort_order: number;
  is_show: number;
}
export interface GoodsList{
  id: number;
  name: string;
  list_pic_url: string;
  retail_price: number;
}
export interface SubCategoryList{
  id: number;
  name: string;
  keywords: string;
  front_desc: string;
  parent_id: number;
  sort_order: number;
  show_index: number;
  is_show: number;
  banner_url: string;
  icon_url: string;
  img_url: string;
  wap_banner_url: string;
  level: string;
  type: number;
  front_name: string;
}
export interface CategoryList{
  id: number;
  name: string;
  keywords?: string;
  front_desc?: string;
  parent_id?: number;
  sort_order?: number;
  show_index?: number;
  is_show?: number;
  banner_url?: string;
  icon_url?: string;
  img_url?: string;
  wap_banner_url?: string;
  level?: string;
  type?: number;
  front_name?: string;
  goodsList?: Array<GoodsList>;
  subCategoryList?: Array<SubCategoryList>
}
export interface IndexData{
  banner : Array<Banner>;
  channel : Array<Channel>;
  newGoodsList : Array<NewGoodsList>;
  hotGoodsList : Array<HotGoodsList>;
  brandList : Array<BrandList>;
  topicList : Array<TopicList>;
  categoryList : Array<CategoryList>;
}
export interface CurrentCategory{
  id: number;
  name: string;
  keywords: string;
  front_desc: string;
  parent_id: number;
  sort_order: number;
  show_index: number;
  is_show: number;
  banner_url: string;
  icon_url: string;
  img_url: string;
  wap_banner_url: string;
  level: string;
  type: number;
  front_name: string;
  subCategoryList: Array<SubCategoryList>
}
export interface CatalogData{
  categoryList: Array<CategoryList>
  currentCategory: CurrentCategory
}
export interface CurrentCatalogData{
  currentCategory: CurrentCategory
}
export interface TopicData{
  id: number;
  title: string;
  price_info: number;
  scene_pic_url: string;
  subtitle: string;
}
export interface SpecialData{
  count: number;
  totalPages: number;
  pageSize: number;
  currentPage: number;
  data:Array<TopicData>;
}
export interface CartList{
  id: number;
  user_id: number;
  session_id: string;
  goods_id: number;
  goods_sn: string;
  product_id: number;
  goods_name: string;
  market_price: number;
  retail_price: number;
  number: number;
  goods_specifition_name_value: string;
  goods_specifition_ids: string;
  checked: number;
  list_pic_url: string;
}
export interface CartTotal{
  goodsCount: number;
  goodsAmount: number;
  checkedGoodsCount: number;
  checkedGoodsAmount: number;
}
export interface CartData{
  cartList: Array<CartList>;
  cartTotal:CartTotal;
}
export interface ResData<T>{
  errno : number;
  errmsg : string;
  data : T;
}