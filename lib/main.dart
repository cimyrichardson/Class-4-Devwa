import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color kPrimaryBlue = Color(0xFF4C66E7);
const Color kDarkBlue = Color(0xFF0B3A85);
const String kCartStorageKey = 'cart_product_ids';
const String kConnectedStorageKey = 'connected_user';

void main() {
  runApp(const MyApp());
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
  });

  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final String description;
}

const List<Product> kProducts = [
  Product(
    id: 'p1',
    name: 'Écouteurs Bluetooth',
    imageUrl: 'https://images.unsplash.com/photo-1514742923401-b8ae3074e468?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8JUMzJTg5Y291dGV1cnMlMjBCbHVldG9vdGh8ZW58MHx8MHx8fDA%3D',
    price: '3500 HTG',
    description: 'Écouteurs sans fil avec réduction de bruit et autonomie de 20h.',
  ),
  Product(
    id: 'p2',
    name: 'Chargeur Rapide 20W',
    imageUrl: 'https://media.istockphoto.com/id/1412121004/photo/mobile-phone-and-charger.webp?a=1&b=1&s=612x612&w=0&k=20&c=EOgaGwguLPkdmv5D3u_tVSrdV078aT3riMFEbTwAWhU=',
    price: '1200 HTG',
    description: 'Chargeur USB-C compatible avec tous les smartphones récents.',
  ),
  Product(
    id: 'p3',
    name: 'Câble USB-C 2m',
    imageUrl: 'https://images.unsplash.com/photo-1603899122911-27c0cb85824a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8QyVDMyVBMmJsZSUyMFVTQi1DJTIwMm18ZW58MHx8MHx8fDA%3D',
    price: '450 HTG',
    description: 'Câble robuste et rapide pour charge et transfert de données.',
  ),
  Product(
    id: 'p4',
    name: 'Support Téléphone Voiture',
    imageUrl: 'data:image/jpeg;base64,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',
    price: '800 HTG',
    description: 'Support magnétique universel pour tableau de bord.',
  ),
  Product(
    id: 'p5',
    name: 'Enceinte Portable',
    imageUrl: 'data:image/jpeg;base64,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',
    price: '4500 HTG',
    description: 'Enceinte Bluetooth résistante à l\'eau, son puissant 10W.',
  ),
  Product(
    id: 'p6',
    name: 'Adaptateur Secteur',
    imageUrl: 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxISEhUSEhIWFhUVFxUVFRUVFRUWFhUVFRUXFxUVFRUYHSggGBolHhYXIjEiJikrLi4uFyAzODMtNygtLisBCgoKDg0OFxAQFy0dHh0tLS0rLS0rLS0tLSsrLSstLS0rLS0tLS0tLS0tKy0tLS0tLS0rLS0tLS0tLS0tLSstLf/AABEIAOAA4QMBIgACEQEDEQH/xAAcAAABBAMBAAAAAAAAAAAAAAAAAgMEBgEFBwj/xABKEAABAwIDBAgBBwkGBAcAAAABAAIDBBESITEFBkFRBxMiMmFxgZGhFCNCUnKCsTNTYpKissHR8CRDY3Ph8RWzw9IXJURkdIOU/8QAFwEBAQEBAAAAAAAAAAAAAAAAAAECA//EACIRAQEBAAEDAwUAAAAAAAAAAAABEQISITFBYcEDQlFxgf/aAAwDAQACEQMRAD8A7ihCEAhCEAhCEAhCgba2zBSR9bPIGNvYZElxPBrRmT5IJ6FXqLffZ8vdqmN8JMUX/MAW8p6lkgux7XDm1wcPcIHUIQgEIQgEIQgEIQgEIQgEIQgEIQgEIQgEIQgEIQgEIQgEIQgEIUPa20oqaF88zsLGC5PHwAHEk2AHMoI+8e3oaKEzTHwYwd6R/BjRz/AXK4PvBt6atlM0x5hjB3Y2/VaPa51PsAb0bxS105mkyaLiKO9xGy+ni45Enj5AW1bV04zGLdLulwOwnE27TzabH3CS0JTWrTLeUe9NbF3KqW36TusHtJdb2i6Sa1vf6qQfpMLXe7SB8FSQClEqZF2un0vSo3+9pXD/AC3td8HBtvdWPZG+9FUENEvVvdYBkowEk6AHuk+AJXDY+ft5f6/yU/ZdPicXnQXDfPi70091LxizlXoZCi7Mquthjk+uxrj4EjMe6lLm2EIQgEIQgEIQgEIQgEIQgEIQgEIQgEIQgEIQgFyLpqrXmeCDH82I+twD65c5oc70BA+8un7b2rHSwPnlNmMF/Fx0a1vNxNgPNedds7Vkqp5KiXvPN7cGtGTWN8AMvjqVrjGeVRQFlrkhpSnLoweYU61RmuTzSilrDjw9/wCSw4/1z5BAFuPmUQztGtEUZe705k8Ak7v7wTO1Yws0AzBtwz/0Vb2tU/KJsDT2GZDxOhKtOzaQMaAp5Xw65ux0gUbIY4ZesiLWhpJbiYTxILLkC/MBXXZ+04JxeGVkg44HB1vMDT1XngoY/CcV8JGhBsR4g8FLwXqekkKk9GFdPJC4TSukAwkF5xObiLrMxanIC4N7Eq7LnW4EIQgEIQgEIQgEIQgEIQgEIQgEIQgFh7gASSAALknIADUkrK470o77ibFRUzvmgbTSNP5QjWNp+oOJ4nLS97JqWtL0i73mumwRn+zRE9X/AIjtDKfDg3wN+NhU2lYWbLc7MnGlZLkxZOMCoW1PhNALIN8vj+P9fyQPNzN/bx5n+H+61e8u0OqjwtPaeLeTeJU+SUNbcmwAz8ABy9PwVO3hZKJ3CZhY6wIabXDSLt08CpyuQk7ttu5s+3bcPI/jYq0grm9HO9mbHOacu6SNOdtVt6beGZvewv8AMWPu23xBSUsW6QhYipXzkxxkB2FxxHRo0v7kD1Wlp94I32Dw5h/Wb7jP4K67q092gt1mINxwYL4fhd33ldTEHYO7O3KRglghbI3NwdDKGSuuTmdMX3geC3+zukvaMM0cFVTyNL3NZaaAgjE4DKSMtvr9TgukbOqcNgNAAAOQGQC2/WteLOAI8QD+Kw019LvHC8gB7DfTthrj9yTCQttBMHtDmnIrW1ewKaUHFGM8ssvhop9DSMhjbFGLMYA1ouTkPE6rHdo+hCFQIQhAIQhAIQhAIQhAIQsXQcm6V9/ix7qCmcQQLVErTmMQv1LDwNiMR8bDO9uUtkHBWXf/AHedHXVOpxyumB4kTHrPYFxHoqlNSPbwXWTsxanMcs4lrWzubqnRWAomprU8wJiEg6J4BFOHjn/Xklsj/wBf5X/r4pEAvnyPuT+Nvx8lJeDYNa3E95DGNH0nuNmjy4k8ADyQPbGpmyTBz/yUNnO8ZNWN5kNycfNg4qp7/NImhvr8niB824mn91dSbslsEbIgcdh23c5Ll8j78Lkj2aOC51v/AEpc6ncBclskYtxwzOwW8T1g91b34X9z5Z++f34VKGNx0F/a/sl4SNQR5qwRbuSMAu3z81Np9mHRwuOR0WY3qsULXSPaxg7TnBozzu42HlqrnsWj2lSjEyicbXvJAXYnWyzw42kaZYeC2Ox92IhIyVrSHtNxY5Zi2Yt4rqmzI8DWtHABQc7oOlN8bsEzO0Mi2SN0b78sUdx7sC65QVZkaHCxyBcI3iTCbZg2zuDlokTUUE7QJ4Y5ALWxsa6xHEE5j0SZt2Kd5xMxMdwLTe3iOIPqs32J7t1RTAjLhkeYPIjgpzStXsHZZgY5rpnylzi7FIbkCwAbfUgZ681tAEVlCFr5tuUrHYHVMLXfVdLGHexN1FbBCqm2ukPZ9M7qzKZJL2wQjGQ7TCXZNB8L3Ve2t0vwxj5mne93HG9rGt8MTcWI+WXirlTY6Yhcr2F01U0kgjqIuqubB7H9Y0faGEH2ufBdQgma9oexwc1wDmuabgg5ggjUJZhpxCEKKEIQgSsFZSZDkqyoXShsrGxtUwdqPsSW/Nk9k+jj+0VzGQA6hd3rmhwLXAFrgQ4HQgixBXGd5tjSUr3CxdHfsP17J0DuRGnja61Kiv1FEw+C1k2zANCtkZwkOK0NMYXM0R/xBzRmtqWc1XNr7QbcsaAbHM+Rvl7JaYsNDtOIixNv9zmfXirZuXEHSvqC3EIxgi5Yn3Bd59kt8iSuQmbFlbPwXY9wXhjQwadXC4fdIaT52kd7eCgtdTSfNEuN36Eg3AJLQ6w5XzPitFFsRs9XiIuymFs/z8gBcPHC0MPm/wAFutoSmGMuAxPIbFGw6Pmc4kD7NyCT9UE8FutibKEETY74jm57ja75HHE95txLiT6pvZMat2xmngFGfsBv1QrmynWTShTVVej2QG6BbiGmNls2UoUiKEBKrXMYQpdK7NS+qHJDIBdQOwFFVVMiY6SRwaxgLnOJsGtAuSfRYaLLmnTZt0xQMp2nv4pX+LIrYR6yOj9kwV7ejfOt2nM6mogWRDIg3th+vNzJ4Rm45g6qr19O6iLo2SvkmcQ04QGNa4nCGQxMyDjkL6jhbEum7C2Y3Zuzy8gdbgxvcfpSuAsD4YiAPABcnhrT1nXXu8NxMJ166oJbG4+LYg53mwKxDU1M2mxOe4PkaMJLc2sJHaZHzsbtxcSDna4LFcYpI2RmKV0zziOFxLyLdxkQuA0cziJ1uO6EVTS6VrbdiNuMeJvgHtn6tKu/RPtAXqmgAODo3YwBic1zSLF2pALSQOF1aRz+p2dTYsB6+nfYWE8dgTzNsx+C7h0K7Skax1FK7Fhb1ked7WcGyAeBxMdb9J3Cy5700S9dNBbvMiIkPGzpAIx55u+KldCO1HNq4Qcw/rIc+HYxtI9Rb18Ap6K9EoQhYaCEIQYsmpk8UzIFYzWuqAq/tKlEl8Qv5qzzMWungVHPNp7oRPuWjCeYVW2huxPHct7Q+K7BJTqJLTK6jhO0nPjY7sOxaaaE8b6c1oKiiMTPnGWxXwkG/uNR5q7b+VL31pZE0OZCA0txYQ5+rzpa4OWf1VWRFJVzgMDhoC0nIBosSDoOeWvmqNHRRm911HcOozhF9cUR+8CG/i1VGt3enicThxDwyPqD/Mrc7rwyuPVMacbnNw6ix4uJ4AWBuk8JXVNlQ/KKnrCLR04LGDnO8fOu+4DgHImQK3QxLX7E2e2GJkTdGi1+JPFx8Sbk+a3TGqKwGpQYnA1KDVVJDUoNSrJqsq44mGSV7Y2N7z3uDWjzcclMDlkKh7f6UqWFpMI6waCSS8UR54LjHLb9FtvFUOo3p2ztXKkjlERP5Qf2eHWxs693DwL3eSg7XX7Vgh/LTxR/5kjGfvFcW6VNoxVFXE+GVksTYwC6N7XtH9oiLgS0kDIE+hSKXomnk7VVWsYTq2KMyftuLbH0KrG/W6A2cWPZUPkDjh7TMJBA4lrtD4Ko6f0q1pZRFgNjI9rPLIkH9YMXH6aW9Q4fRjBcfGzLMv5XI+8VJj3kqKwQwTOL2RuxBz+08hoa52J9hitgFr59ogk5KLsOMSGUuOUsscIccspHgX8ABZINptiLqn4TYFtNT4vtuEkj/wBouTW5e3BRNqHlhfJKIuqYAbHv5uPAC7RYZk5BI3j2i2WWaa/Zlk7GWK8bfm47A63axxtp2lFaSw2Dbym5DSfyY4ue7gRz4aa3w0Z2nPLK84zilebvPAOt2WjgGsBLvA56FdF6Gdg4qlsoHzdMHdq1sUz24bDyBJ8LNVT3X3fkqJOrYb/nZiMmi9zYczwbroTawA71uzQR00bYYhZrR6k8XOPElKLIFlJaUpc2whCEAkOS0lysSmHhRpI1McEy4KogSRKNLFxWzc1RattgoPOG8dBUQVE8bJBIWPiY/s5vdMCQ6+t7kX8Tx1Ny3F3ZMMRklaRI/UEEFrQchY5i+vsonSRs4xVhlJwxVbWNEnCOoit1bieGgP3jyV03X2q2qjzGGZlhNFxa76wHFjtQfTUFa1D8GzATmFttn7KjjOIMAJ4gKbS0ymNiU1WYGKY0JqJqKusjhYZJZGxsbq97g1o83HJWCSAmaysjhYZJXtYwaueQ0D1PHwXPd5OleGIEUzQRmOvmDmR3/wAOLvyn9UcQSqVDSbU2s8SuJji1bUVA0B408AyHmAAeJRFx3o6V44mkUzbDQTTtc1p59XB+Ud94N1vYhVGPZW09qvEsl42atnqwMQB16imHZGXEix1uFcd3tyqSkIkDTNP+fm7TgR9RujPTPxVobGXKaqp7G3AooHdZI11VN+dqDjz/AEY+6PC9yOatDi4/1lZTI6VO9SAg1vUkqg9K+zS6lebXMZbJ7a/BdQIXPOliukbC2GK2Ood1YuRfCO9a/ncnQAHmEHKXFsMcj25BjOrjyzxTHrDrrhYWNPHNQvk/zUNPoXfPS24NPdB8bC9vHxUJtZciN7g5oLiblxbiucxa5JOWduK3MtVGC45tmeAS2QWtZowYXDK2Q8RYclYGKiW8gbGLvb3fqsyAxuPJosAf4rc7v7DfK7q2E63kkOpIt7WysNG5ausBG2FspziI25ueQXuH0nHOwPIZm/AZ62C6/sDYzYWBrQPE21/0/rUkq6iXu7spkDAxjbAe5PMq00bc1ApYVt6ZiyqdGnAm404pVgQhCihYIQhAghIeE6Qm3qso7lGqxkpZCblZkqKztnZMVTE+CZmJjtRxB4OaeBHNcp2ru3tCgIfC19TFHfq5YnFtTC3LskNuXDTg5ptmLZDtc0ahtBBQcz2H0uSNGCUxPIytM19PJca45Iw9hP3G6LeS9LbQMoaYn/54t7CG/wAFaK/ZtPP+Xp4pfGSNjz7kXWvG6mzhmKGn9YmH4EIKVX9LVVKcEDomk5BtNDJUTX/RdKGsP6pUKPd3ate8SzAxDUS1ji+UA2/JQaR+VgPFdUpadkYwxRsjHKNjWD2aApLICU0VLYO4tJTOEjwaicf3s/awn9CPutHLUjmra2Iu1UqGkUtkQCCLDSqWyEBOtalBqBstTbmqQ5azbW1IqWJ00zsLG6nUknINaPpOJyA4qyiJvFtiKkhdNKchkGtze957sbG/ScToP4Lz/vft+aonIOdRJ2C1pxNp4ycqdh4u+ueJy8Bsd997ZZpQ4j545QQg3FKx30jwdO4angNMta9s6jwOMYd86QTPLr1LB32tPF/AngTbW+GDNLTxwsxGxbGcz+cmby5sZfyJPKxUOGn+UEyyGwJIGfAXLnOPIZn0KjbYreteGRi0bbNjb4DIefH1JUzabxHFgadewPstzefU2/XKovXRBTPc6RxYcDQQx7hzcMgeBNsx4LrlPCqV0TAGnlbylv6PijI/iuiQxqVC4I1sImpqJikxhXVOsCUsNWVhYEIQihYWVhAJBCWsWVQ3gSXsT6S4IiFJDdRpKNbIhYIVMag0hWW0S2hCTZBCZSAJ9sQT2FAagQGpYalAJRCBNlglZJTT3IGa2qZGx0kjg1jAXOc42DWgXJJ5ALge/O9z6qQSi4bn8jhI7rTcGqlb9d30RwHqrT0qbxiSQ0YPzMIbLVZ99xzhp78ssbvADxXL5HyBxfrUygvBOQhiDSTI4Humwy5Ac9aNfUS/JyWtN6h1+skJuY75kA/X5nh591+sBgphG0duQCSXm1lwI2nl3gSOb/BQNh0fWTNDu6Lvf9hoxG/nkPVbqtYZIsZ1qahjB4RtLrW8C659lFaimivOP8NjD4YgxoH7RTe1nYnEDSMNHuc/ibein7GhLgXDWR9mg+dgPd37KzX0AZVVMI0DnAX5EEtv7hM7I6P0J7Su98R/vImOHi6EljvWzgfRdkiavMnRztX5PUMkJsIpGucP8OT5uX2BB9F6gjCoejanwE2wJ1qgUFlYWVloIQhALCysIBAQhVAgoKECbLBCWkuQNlJSisFVKShZWEGQVguWCsEoMOK1W3dpNp4ZJn92NjpD5NaTb1stk4qi9KchNDKwfTdFGfBrpWhx9roOOuqC/FLObgH5VPr25pjiij8gLZcAPFTavZb4aQukyqa18cbicyxsjsQjHIWGY8hwCVu1RfKJqeNw7L3SVso5tY7DE3yvhHkStz0iOs+n/wAyR/qyK7fiVRR6N/ZqZWDUMii8pHFzWj0a0KfvceoNNCzVgcQPEAMYfcEqJsUDDE361ZA0+llL2lMJqyac/k6ezGngXNv79rEfIJgZoWYJ6aIaNliDvR4/jn6qTvNFg2jMfrMjePuhgP7pWtEuGogJ16yEu8C6QPt6MYz3Vi34psW042g9+Igjj3pLe/8ABPUaGOjMc0ch/JzPmpz52af+qz9Ur0buJtAz0MD3G7g3q3/biOB3vhv6rjW3qP8A8iimb3oqjrCfEvdF/wBnsui9ElVeOpi4CVsrRyEzAfxafdB0JhToTLU61QOIWAVm6ihCLoQF1i6CsBE0pCwi6Gs3Qk3WHPsilkpDitPtvaGEYbkXsOybGx5Hgq22qlB7NVK3wJY4fFt/iufH6m2z8NdK8udbNQ4dpwP7k0TvsyMP4Fcn6TN4KlsDad04LZicVmYXFjLXBcDmCSMrLl2E8CR/Xku0mxzvZ6yvxSS5eWqPa9TCbxTvYf0XuH4Fbmn6Q9ps/wDUONvrCN/7zSVek16KL02564xsvpfqW4vlFOyTIYMF4nXF74ibtItpYBWjZ/SpQSkNf1kRw4nOe27A4C5YHNNyeAyzUw1ey9U/fiAy0lQBqGFw82dr+C21JvLRzMa+OpiIffDd4YThNndl1jkctEzUkG41BB8iCoORdHm04WTxdY4N66mbDGTk3HG/NhPAnK3MgDiFtek+EtiimtlFMC/7Dxhd/Aeqo28uzHUM7oXAGIvMkDi3E0XyLSDkcsiPAFNjbc8zDAMZY7LB10jmWH2j2W+tlfKo9MHuDYoj851zXsI07IcC+/ADslSS9gHUxu+Zhu6SQfTflieOYvYN5nD9ZQ3VgYOogN3PIa+UZAj83EODPHj7WjvqOrwxhoDWkOdjJ+ceOLsOeEXNmjmeJKWmGq6Z3WAkWNw+w4EkWDfAANA+yt1VbQc+uZUzvAe9xc9g0iZazG38B+C0lTWlz8eK7z9INsGDkwa5c/8AdbLeLZ0UMFIY7l0sb3vcdScYba3ADCVFXyaVr93J3Xy6zL/9EZH4qzdDr/nZx/7elJ8wD/NUZs1t3YYB3qqqLG+TX3J8rsb7roPRJF85WSDQGKEf/W0k/vBVHS2lONKZalgqB0OSsSbBWQgViWUlZQKushJKzdEZJWC5IcUm6inLpqUrJKQSqNLtikLsxqq/LBINQCrjO26hTQArHTF6nF+lCme50D2ss0B7TbMYiWkfAH2VCc1w4fAj8F6Lr9nNcCC0EHgQCPYqpV+6cLjfq7fZLmj2Bt8F043JiWOOGRyy2rLV06TcyI64x5Fp/EKJLuE092YjzjB/BwWuqM45kKx2Aji9+IkZfFS27T7ZuLtDchbV3mr1/wCGoLQ35RnixE9XkBlk0YvNOO6MATIRO3PuAsPP6fI25LOtKF8rYYyXAB9joOPBWfZnSXUQU8cLWQuEbAwOcJCSGiwuA4cFtndFUgwYJonWaMePG3tZ3AwtNxpqrdS7h7PaxjXUzHua0AvOK7iBmSL800xx3bu9tRV9mQgtvcMYwNbfgc7uv6qTsjdmqnHbBhiOtxZz/u6n1yXZqfYFNCbw08TDzaxoP62qTVUfFTRzOu3CLYnSQlxkZZzWgACzcyAMyXcdVA2RJSyuxTtbhdYPJAJhfzcLdwnjwXZaSIWVM3s3Ac95qaFwZNmXxnJr7624AnkcirKNFvvuyBSNlhAd1brnDmCxwsSLeOFUbaTpC2IPvZjMAHIXxfG6sX/EZqUmOojqaa9w5sRBjfflFJdvq0qJFU08jrRw1NRJfJpw2Pm1gP4IJNHXnqYJHttHSscyBhzMk8zi577eZ9mDiu6dHuyjS0kbHi0jrySfbfmQfIWHoqPuTuTK+VlXXta3q84KYd1h4PfrnodSb2ucrLqtOFBPaU4CmgnGoFgpQKQEoIF3Qk3QgcQ4pAKSSiF3WEi6zdAOSSVguSSUA4JiRifKQ5BClhUKWlW0cE05qK0z6Mcky6iC3ZYmnRoNQKQLPydbLqkkxIIrI8ktrU+Y0nAgaLEzNBcKVhSurQQYobJ0MUgRLJjQQnxXyIuORF0Q0wb3WgeQA/BSyxONjQEDVOhUdjVIjCCU0pYKjtKcaUD4KzdNtWboHLrCRdCD/9k=',
    price: '650 HTG',
    description: 'Adaptateur mural 2 ports USB, charge rapide 2.4A.',
  ),
];

Future<Set<String>> _readCartIds() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String> ids = prefs.getStringList(kCartStorageKey) ?? <String>[];
  return ids.toSet();
}

Future<void> _writeCartIds(Set<String> ids) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(kCartStorageKey, ids.toList());
}

Future<List<Product>> _readCartProducts() async {
  final Set<String> ids = await _readCartIds();
  return kProducts.where((Product item) => ids.contains(item.id)).toList();
}

Future<void> buyProduct(BuildContext context, Product product) async {
  final Set<String> ids = await _readCartIds();
  final bool isNew = ids.add(product.id);
  await _writeCartIds(ids);

  if (!context.mounted) {
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        isNew
            ? '${product.name} ajoute nan panyen.'
            : '${product.name} deja nan panyen.',
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EBoutikoo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryBlue),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> previewItems = kProducts;

    return Scaffold(
      drawer: const AppSideMenu(currentIndex: 0),
      drawerEdgeDragWidth: 96,
      appBar: AppBar(
        leading: const AppMenuButton(),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
        title: const Text('EBoutikoo'),
        actions: [
          IconButton(
            tooltip: 'Panyen',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const CartPage()),
              );
            },
            icon: const Icon(Icons.shopping_cart_checkout),
          ),
          TextButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fonksyon peye a se demonstrasyon.')),
              );
            },
            icon: const Icon(Icons.payment, color: Colors.white, size: 18),
            label: const Text('PEYE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _CategoryBox(
              label: 'Kategori Pwodwi',
              icon: Icons.category_outlined,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (_) => const ProductListPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            _CategoryBox(
              label: 'Kategori Pwodwi',
              icon: Icons.category_outlined,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(
                    builder: (_) => const ProductListPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: previewItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.63,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final Product product = previewItems[index];
                  return _HomeProductCard(product: product);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _CategoryBox extends StatelessWidget {
  const _CategoryBox({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          height: 74,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kDarkBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              const Spacer(),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeProductCard extends StatelessWidget {
  const _HomeProductCard({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => DetailPage(product: product),
                  ),
                );
              },
              child: SizedBox.expand(
                child: NetworkProductImage(url: product.imageUrl),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 2),
            child: Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Savon kreyol',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 2),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => buyProduct(context, product),
                  icon: const Icon(Icons.shopping_cart),
                  color: Colors.black,
                  iconSize: 20,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  color: kDarkBlue,
                  iconSize: 20,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => DetailPage(product: product),
                      ),
                    );
                  },
                  icon: const Icon(Icons.open_in_new),
                  iconSize: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppSideMenu(currentIndex: -1),
      drawerEdgeDragWidth: 96,
      appBar: AppBar(
        leading: const AppMenuButton(),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
        title: const Text('DETAY'),
        actions: [
          TextButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fonksyon peye a se demonstrasyon.')),
              );
            },
            icon: const Icon(Icons.payment, color: Colors.white, size: 18),
            label: const Text('PEYE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 11,
              child: NetworkProductImage(url: product.imageUrl),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            product.price,
            style: TextStyle(
              fontSize: 16,
              color: Colors.green.shade700,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.description,
            style: const TextStyle(fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 10),
          const Text('Savon kreyol se yon bon chwa pou swen po chak jou.'),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: const Color(0xFFF0BC18),
        foregroundColor: Colors.black,
        onPressed: () => buyProduct(context, product),
        child: const Icon(Icons.add_shopping_cart),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }
}

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
        title: const Text('Lis Pwodw'),
        actions: [
          IconButton(
            tooltip: 'Panyen',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const CartPage()),
              );
            },
            icon: const Icon(Icons.add_shopping_cart),
          ),
          TextButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fonksyon peye a se demonstrasyon.')),
              );
            },
            icon: const Icon(Icons.credit_card, color: Colors.white, size: 18),
            label: const Text('PEYE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: kProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.67,
          ),
          itemBuilder: (BuildContext context, int index) {
            final Product product = kProducts[index];
            return Card(
              elevation: 2,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: NetworkProductImage(url: product.imageUrl),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 6, 8, 2),
                    child: Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Savon kreyol',
                      style: TextStyle(fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 2),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => buyProduct(context, product),
                          icon: const Icon(Icons.shopping_cart),
                          iconSize: 20,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite),
                          color: kDarkBlue,
                          iconSize: 20,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => DetailPage(product: product),
                              ),
                            );
                          },
                          icon: const Icon(Icons.open_in_new),
                          iconSize: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _loading = true;
  List<Product> _items = <Product>[];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final List<Product> products = await _readCartProducts();
    if (!mounted) {
      return;
    }
    setState(() {
      _items = products;
      _loading = false;
    });
  }

  Future<void> _removeItem(String id) async {
    final Set<String> ids = await _readCartIds();
    ids.remove(id);
    await _writeCartIds(ids);
    await _loadItems();
  }

  Future<void> _clearAll() async {
    await _writeCartIds(<String>{});
    await _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppSideMenu(currentIndex: 1),
      drawerEdgeDragWidth: 96,
      appBar: AppBar(
        leading: const AppMenuButton(),
        backgroundColor: kPrimaryBlue,
        foregroundColor: Colors.white,
        title: Text('Panyen (${_items.length})'),
        actions: [
          if (_items.isNotEmpty)
            IconButton(
              tooltip: 'Efase tout',
              onPressed: _clearAll,
              icon: const Icon(Icons.delete_sweep),
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? const Center(
                  child: Text(
                    'Panyen ou vid pou kounye a.',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: _items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (BuildContext context, int index) {
                    final Product product = _items[index];
                    return Card(
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 62,
                            height: 62,
                            child: NetworkProductImage(url: product.imageUrl),
                          ),
                        ),
                        title: Text(product.name),
                        subtitle: Text(product.price),
                        trailing: IconButton(
                          onPressed: () => _removeItem(product.id),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }
}

class NetworkProductImage extends StatelessWidget {
  const NetworkProductImage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? p) {
        if (p == null) {
          return child;
        }
        final int? total = p.expectedTotalBytes;
        final double? value =
            total != null ? p.cumulativeBytesLoaded / total : null;
        return Center(
          child: CircularProgressIndicator(value: value),
        );
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? stack) {
        return const ColoredBox(
          color: Color(0xFFDBE2F9),
          child: Center(
            child: Icon(Icons.broken_image, color: kDarkBlue, size: 34),
          ),
        );
      },
    );
  }
}

class AppMenuButton extends StatelessWidget {
  const AppMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext ctx) {
        return IconButton(
          tooltip: 'Meni',
          onPressed: () => Scaffold.of(ctx).openDrawer(),
          iconSize: 28,
          icon: const Icon(Icons.menu_rounded, color: Colors.white),
        );
      },
    );
  }
}

class AppSideMenu extends StatefulWidget {
  const AppSideMenu({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  State<AppSideMenu> createState() => _AppSideMenuState();
}

class _AppSideMenuState extends State<AppSideMenu> {
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    _loadConnectedState();
  }

  Future<void> _loadConnectedState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool value = prefs.getBool(kConnectedStorageKey) ?? false;
    if (!mounted) {
      return;
    }
    setState(() {
      _connected = value;
    });
  }

  Future<void> _setConnected(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kConnectedStorageKey, value);
    if (!mounted) {
      return;
    }
    setState(() {
      _connected = value;
    });
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value ? 'Ou konekte kounye a.' : 'Ou dekonekte kounye a.'),
      ),
    );
  }

  void _goToProductList() {
    Navigator.of(context).pop();
    if (widget.currentIndex == 2) {
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const ProductListPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 52, 16, 18),
            color: kPrimaryBlue,
            child: const Text(
              'EBoutikoo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              _connected ? Icons.verified_user : Icons.login,
              color: kDarkBlue,
            ),
            title: const Text('Konekte'),
            onTap: () => _setConnected(true),
          ),
          ListTile(
            leading: const Icon(Icons.grid_view_rounded, color: kDarkBlue),
            title: const Text('Lis pwodwi'),
            onTap: _goToProductList,
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: kDarkBlue),
            title: const Text('Dekonekte'),
            onTap: () => _setConnected(false),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _connected ? 'Eta: Konekte' : 'Eta: Dekonekte',
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.currentIndex});

  final int currentIndex;

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) {
      return;
    }

    Widget page;
    if (index == 0) {
      page = const HomePage();
    } else if (index == 1) {
      page = const CartPage();
    } else {
      page = const ProductListPage();
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: kPrimaryBlue,
      onTap: (int index) => _onTap(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Lakay',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_rounded),
          label: 'Panyen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_rounded),
          label: 'Pwodwi',
        ),
      ],
    );
  }
}