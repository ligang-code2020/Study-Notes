# Flex

采用 Flex 布局的元素，称为 Flex 容器（flex container），简称"容器"。它的所有子元素自动成为容器成员，称为 Flex 项目（flex item），简称"项目"。

注意，设为 Flex 布局以后，子元素的 float、clear 和 vertical-align 属性将失效。

容器默认存在两根轴：水平的主轴（main axis）和垂直的交叉轴（cross axis）。主轴的开始位置（与边框的交叉点）叫做 main start，结束位置叫做 main end；交叉轴的开始位置叫做 cross start，结束位置叫做 cross end。

项目默认沿主轴排列。单个项目占据的主轴空间叫做 main size，占据的交叉轴空间叫做 cross size。  
</br>

![avatar](../../flex.png)

## flex 父容器的属性

</br>

### <b>1.flex-direction</b>

</br>

flex-direction 属性决定主轴的方向（即项目的排列方向）

---

在 flex 布局中，是分为主轴和侧轴两个方向，也可以理解为 x 轴和 y 轴

> - 默认主轴的方向就是 x 轴的方向，水平向右
> - 默认侧轴的方向就是 y 轴的方向，水平向下

#### flex-direction 的属性

> row : 主轴为 x 轴，水平方向，自左向右

> row-reverse : 主轴为 x 轴，水平方向，自右向左

> columu : 主轴为 y 轴，垂直方向，自上向下

> columu-reverse : 主轴为 y 轴，垂直方向，自下向上

</br>

![avatar](../../flex-direction.png)  
</br>

### <b>2.justify-content</b>

justify-content 属性定义了项目在主轴上的对齐方式。

---

<font color="red">注意：使用这个属性之前，要先确认主轴是哪一个。</font>
</br>

#### justify-content 的属性

> flex-start(默认值)：从头部开始，如果 x 是主轴，方向从左到右

> flex-end：从尾部开始，方向从右到左

> center：在主轴居中对齐

> space-between：先两边贴边 再平分剩余空间

> space-around：平分剩余空间

</br>

![avatar](../../justify-content.png)

</br>

### <b>3.flex-wrap</b>

</br>
默认情况下，项目都排在一条线（又称"轴线"）上，默认子元素不换行。flex-wrap属性定义，如果一条轴线排不下，如何换行。
</br>

---

<font color="red">侧轴默认为 y 轴</font>

#### flex-wrap 的属性

> nowrap(默认值)：不换行

> wrap：换行，第一行在上方

> wrap-reverse：换行，第一行在下方

</br>

### <b>4.align-items</b>

</br>
属性定义项目在侧轴(y轴)上如何对齐
</br>

---

<font color="red">项目必须为单行才生效</font>

#### align-items 的属性

> flex-start(默认值)：从上到下

> flex-end：从下到上

> center：挤在一起居中(垂直居中)

> stretch：拉伸(项目未设置高度或者设为 auto，将占满整个容器的高度)

> baseline：项目的第一行文字的基线对齐

</br>

![avatar](../../align-items.png)

</br>

### <b>5.align-content</b>

</br>
设置子项在侧轴的排列方式并且只适用于多行，单行没有效果
</br>

---

<font color="red">项目必须为多行才生效</font>

#### align-content 的属性

> flex-start：从侧轴的头部开始排列

> flex-end：从侧轴的尾部开始排列

> center：在侧轴中间显示

> space-around：子项目在侧轴平分剩余空间，所以，轴线之间的间隔比轴线与边框的间隔大一倍。

> space-between：子项目在侧轴先分布在两头，再平分剩余空间。

> stretch(默认值)：设置子项目元素高度平分父元素高度

</br></br>
看看效果图

![flex-start](../../flex-start.png)

![flex-end](../../flex-end.png)

![center](../../center.png)

![space-around](../../space-around.png)

![space-between](../../space-between.png)

![stretch](../../stretch.png)

</br>

### <b>6.flex-flow</b>

</br>
flex-flow 属性是 flex-direction 和 flex-wrap 属性的复合属性
</br>

---

> row nowrap 为默认值

</br>

## 子项的属性

</br>

### <b>1.flex 属性</b>

</br>
flex属性定义子项目分配剩余空间，用flex来表示占多少份数
</br>

---

```css
.item {
  flex: <number>; /*default: 0*/
}
```

</br>

### <b>2.align-self</b>

</br>
align-self 控制子项自己在侧轴上的排列方式。align-self 属性允许单个项目有与其他项目不一样的对齐方式，可覆盖align-items属性。默认值为auto，表示继承父元素的align-items属性，则等同于stretch
<br>

---

```css
span:nth-child(2) {
  /*设置自己在侧轴的排列方式*/
  align-self: flex-end;
}
```

</br>

### <b>3.order</b>

</br>
order 属性定义项目的排列顺序，数值越小，排列越靠前，默认为0，可以设置负数
</br>

---

```css
span:nth-child(3) {
  order: -1;
}
```
