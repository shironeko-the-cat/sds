package com.example.demo.dto.response;

import java.util.List;

public class ModelListResponseDto {
    private Integer pageIndex;
    private Integer pageSize;
    private List<ModelResponseDto> datas;

    public Integer getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(Integer pageIndex) {
        this.pageIndex = pageIndex;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public List<ModelResponseDto> getDatas() {
        return datas;
    }

    public void setDatas(List<ModelResponseDto> datas) {
        this.datas = datas;
    }
}
