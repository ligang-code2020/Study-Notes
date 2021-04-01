# Flex

采用 Flex 布局的元素，称为 Flex 容器（flex container），简称"容器"。它的所有子元素自动成为容器成员，称为 Flex 项目（flex item），简称"项目"。

注意，设为 Flex 布局以后，子元素的 float、clear 和 vertical-align 属性将失效。

容器默认存在两根轴：水平的主轴（main axis）和垂直的交叉轴（cross axis）。主轴的开始位置（与边框的交叉点）叫做 main start，结束位置叫做 main end；交叉轴的开始位置叫做 cross start，结束位置叫做 cross end。

项目默认沿主轴排列。单个项目占据的主轴空间叫做 main size，占据的交叉轴空间叫做 cross size。  
</br>

![avatar](../../flex.png)

## flex-direction

flex-direction 属性决定主轴的方向（即项目的排列方向）。

在 flex 布局中，是分为主轴和侧轴两个方向，也可以理解为 x 轴和 y 轴

> - 默认主轴的方向就是 x 轴的方向，水平向右
> - 默认侧轴的方向就是 y 轴的方向，水平向下

### flex-direction 的属性

> row : 主轴为 x 轴，水平方向，自左向右  
> row-reverse : 主轴为 x 轴，水平方向，自右向左  
> columu : 主轴为 y 轴，垂直方向，自上向下  
> columu-reverse : 主轴为 y 轴，垂直方向，自下向上

</br>

![avatar](../../flex-direction.png)
