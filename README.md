[이거 해석중인데 왜 10 이하면 h30 더하고 10 이상이면 d55를 더하는지 모르겠어 #1](/../../issues/1)

# 소스 코드

```verilog
function [7:0] ascii;
    input [4:0] hex;
    integer i;
    begin
        ascii = 0;
        if(hex <= 9)
            ascii = hex + 8'h30; // 10이하인 경우 + 0X30
        else
            ascii = hex + 8'd55; // 이상인 경우에는 + 0X37
    end
```

---

# 답변

코드를 보면 `hex2ascii` 같다.

## ASCII Code

![Wiki - Ascii code table](https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/USASCII_code_chart.png/220px-USASCII_code_chart.png)

ASCII 코드에서 0~9의 범위는 다음과 같다.

| 숫자 | ASCII Code (binary) |
| ---- | ------------------- |
| 0    | `011 0000`          |
| 1    | `011 0001`          |
| ...  | ...                 |
| 8    | `011 1000`          |
| 9    | `011 1001`          |

## ~~10이하~~<sup>0~9사이</sup>의 숫자에서 `8'h30`을 더하는 이유

```verilog
ascii = hex + 8'h30; // 10이하인 경우 + 0X30
```

hex에서는 0은 `0000 0000`이지만, ascii에서는 `'0'`은 ` 011 0000`이므로,
위 코드에서는 `0011 0000` (`0x30`)을 더해주는 것으로 추정된다.

## 10이상의 숫자에서 `8'd55`를 더하는 이유

hex에서의 `10`이상의 숫자들은 ascii 코드에서 문자 <abbr title="10">`'A'`</abbr>~<abbr title="15">`'F'`</abbr>로 치환되어야 한다.

즉, `10`이상의 숫자에 대해서는 `'A'`와 `10`의 차이를 더해주어야 하는데,

* `55` <sub>(`011 0111`)</sub> = `'A'`<sup>`65`</sup><sub>(`100 0001`)</sub> - `10` <sub>(`0000 1010`)</sub>

그게 `8d'55`인 것이다. (`8'h37`로 표기한 것과 동일하다.)

# 정리

> 16진수 숫자를 아스키코드로 변환하는 코드이다.
