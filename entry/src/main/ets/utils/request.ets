import axios, {
  AxiosError,
  AxiosInterceptorOptions, AxiosRequestConfig,
  AxiosResponse,
  InternalAxiosRequestConfig } from "@ohos/axios";

export const httpRequest = axios.create({
  baseURL:"http://youker.net:8360",//配置环境变量
  timeout:3000
});

//请求拦截
httpRequest.interceptors.request.use((config:InternalAxiosRequestConfig)=>{
  return config;
},(err:AxiosError)=>{
  return Promise.reject();
})

//响应拦截
httpRequest.interceptors.response.use((resonse:AxiosResponse)=>{
  return resonse.data
},(err:AxiosError)=> Promise.reject())