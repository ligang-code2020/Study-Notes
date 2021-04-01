# Flex
采用 Flex 布局的元素，称为 Flex 容器（flex container），简称"容器"。它的所有子元素自动成为容器成员，称为 Flex 项目（flex item），简称"项目"。  

注意，设为 Flex 布局以后，子元素的float、clear和vertical-align属性将失效。   

容器默认存在两根轴：水平的主轴（main axis）和垂直的交叉轴（cross axis）。主轴的开始位置（与边框的交叉点）叫做main start，结束位置叫做main end；交叉轴的开始位置叫做cross start，结束位置叫做cross end。

项目默认沿主轴排列。单个项目占据的主轴空间叫做main size，占据的交叉轴空间叫做cross size。   
</br>

![avatar](https://www.runoob.com/wp-content/uploads/2015/07/3791e575c48b3698be6a94ae1dbff79d.png)

## flex-direction
flex-direction属性决定主轴的方向（即项目的排列方向）。

在flex布局中，是分为主轴和侧轴两个方向，也可以理解为x轴和y轴
> * 默认主轴的方向就是x轴的方向，水平向右   
> * 默认侧轴的方向就是y轴的方向，水平向下

### flex-direction 的属性
> row : 主轴为x轴，水平向右

![avatar](../../flex-direction.png) 



