package com.syanpicker;

import java.util.List;

/**
 * Created by tyw on 2019-01-29.
 */

public class WaterMarkConfig {

    /**
     * {
     * "isCompression" : 1200, //1200表示：宽不能超过1200像数，长度会自动根据原来的图片比例计算；0表示默认5000。
     * "isServerPath" : 0，  //1 返回服务器路径  ； 0返回本地路径(返数组) ;不传默认为1
     * "saveToAlbum" : 1,  //保存到相册  0:不保存, 1:保存
     * "selectNums" : 9, //每次选多少张图片
     * <p>
     * "titles":
     * [
     * {
     * "text":"主标题",
     * "point":"{20,20}", //位置, 默认{0,0}
     * "font":18,  //默认14
     * "bold":1, //默认为0, 不加粗
     * "color":"#333333", //默认为白色
     * "align":2, //文字对齐, 0:左对齐, 1:右对齐, 2:居中对齐, 3:两端对齐
     * "alpha":100, //透明度,0-1, 默认1
     * "position":0,//坐标原点, 0:左上角, 1:右上角, 2:右下角, 3左下角
     * "centerX":1, //x坐标, 0:不居中, 1:居中, 优先于position
     * "centerY":0, //y坐标, 0:不居中, 1:居中, 优先于position
     * },
     * <p>
     * {
     * "text":"副标题",
     * "point":"{0,60}", //位置, 默认{0,0}
     * "font":16,  //默认14
     * "alpha":0.8, //透明度,0-1, 默认1
     * "centerX":1, //x坐标, 0:不居中, 1:居中, 优先于position
     * },
     * {
     * "text":"作者:SIE",
     * "point":"{20,10}", //位置, 默认{0,0}
     * "align":1, //文字对齐, 0:左对齐, 1:右对齐, 2:居中对齐, 3:两端对齐
     * "alpha":0.2, //透明度,0-1, 默认1
     * "position":2,//坐标原点, 0:左上角, 1:右上角, 2:右下角, 3左下角
     * },
     * ],
     * <p>
     * <p>
     * "images":
     * [
     * {
     * "rect":"{{20,100},{100,100}}", //位置&尺寸
     * "url":"[图片]http://www.chinasie.com/web/template/themes/default/skins/images/logo.png", //图片地址
     * "alpha":0.1, //透明度,0-1, 默认1
     * "position":0,//坐标原点, 0:左上角, 1:右上角, 2:右下角, 3左下角
     * "centerX":1, //x坐标, 0:不居中, 1:居中, 优先于position
     * "centerY":0, //y坐标, 0:不居中, 1:居中, 优先于position
     * },
     * {
     * "type":"AppIcon", //暂时只支持AppIcon, 可按需求添加, App图标, 不使用url时的本地图片
     * "rect":"{{20,40},{120,120}}", //位置&尺寸
     * "position":2,//坐标原点, 0:左上角, 1:右上角, 2:右下角, 3左下角
     * "alpha":0.1, //透明度,0-1, 默认1
     * },
     * ],
     * }
     */

    public int isCompression;
    public int isServerPath;
    public int saveToAlbum;
    public int selectNums;
    public List<TitlesBean> titles;
    public List<ImagesBean> images;


    public static class TitlesBean {
        /**
         * text : 主标题
         * font : 18
         * bold : 1
         * color : #333333
         * align : 2
         * alpha : 100
         * position : 0
         * centerX : 1
         * centerY : 0
         */

        public String text;
        public int font;
        public int bold;
        public String color;
        public int align;
        public double alpha;
        public int position;
        public int centerX;
        public int centerY;
        public int x;
        public int y;
        public int w;
        public int h;

    }

    public static class ImagesBean {
        /**
         * url : [图片]http://www.chinasie.com/web/template/themes/default/skins/images/logo.png
         * alpha : 0.1
         * position : 0
         * centerX : 1
         * centerY : 0
         * type : AppIcon
         */

        public String url;
        public double alpha;
        public int position;
        public int centerX;
        public int centerY;
        public String type;
        public int x;
        public int y;
        public int w;
        public int h;
    }


}
