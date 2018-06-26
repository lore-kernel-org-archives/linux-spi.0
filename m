From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI controller
Date: Tue, 26 Jun 2018 16:18:44 +0300
Message-ID: <CAHp75VfskABz+KrnLzDTYH=1cESimi++3HwQ2a1tiWkPTqf=HQ@mail.gmail.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
 <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <CAHp75Vesytovn1s-L0RQbEi6Tua=8qKc8a8yDkFmadgscW_UAw@mail.gmail.com> <4046ba78-b6c0-c09b-43e2-e3c2e550be9f@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Frieder Schrempf <frieder.schrempf@exceet.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4046ba78-b6c0-c09b-43e2-e3c2e550be9f@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 26, 2018 at 3:26 PM, Frieder Schrempf
<frieder.schrempf@exceet.de> wrote:
> On 08.06.2018 22:27, Andy Shevchenko wrote:
>> On Fri, Jun 8, 2018 at 2:54 PM, Yogesh Narayan Gaur
>> <yogeshnarayan.gaur@nxp.com> wrote:

>>> +static int fsl_qspi_check_buswidth(struct fsl_qspi *q, u8 width) {

>>> +       switch (width) {
>>> +       case 1:
>>> +       case 2:
>>> +       case 4:
>>> +               return 0;
>>> +       }

>> if (!is_power_of_2(width) || width >=3D 8)
>>   return -E...;
>>
>> return 0;
>>
>> ?

> Your proposition is a bit shorter, but I think it's slightly harder to re=
ad.

OK.

>>> +
>>> +       return -ENOTSUPP;
>>> +}


>>> +       for (i =3D 0; i < op->data.nbytes; i +=3D 4) {
>>> +               u32 val =3D 0;
>>> +
>>> +               memcpy(&val, op->data.buf.out + i,

>>> +                      min_t(unsigned int, op->data.nbytes - i, 4));

>> You may easily avoid this conditional on each iteration.

> Do you mean something like this, or are there better ways?
>
> u32 val =3D 0;
>
> for (i =3D 0; i < ALIGN_DOWN(op->data.nbytes, 4); i +=3D 4)
> {
>         memcpy(&val, op->data.buf.out + i, 4);
>         val =3D fsl_qspi_endian_xchg(q, val);
>         qspi_writel(q, val, base + QUADSPI_TBDR);
> }
>
> memcpy(&val, op->data.buf.out + i, op->data.nbytes);
> val =3D fsl_qspi_endian_xchg(q, val);
> qspi_writel(q, val, base + QUADSPI_TBDR);

Something like this, though last part should go under

if (IS_ALIGNED(...))

(My comment was about moving out an invariant conditional)

>>> +               val =3D fsl_qspi_endian_xchg(q, val);
>>> +               qspi_writel(q, val, base + QUADSPI_TBDR);
>>> +       }

>>> +MODULE_AUTHOR("Freescale Semiconductor Inc."); MODULE_AUTHOR("Boris
>>> +Brezillion <boris.brezillon@bootlin.com>"); MODULE_AUTHOR("Frieder
>>> +Schrempf <frieder.schrempf@exceet.de>"); MODULE_LICENSE("GPL v2");

>> Wrong indentation.

> What is wrong? Some newlines are missing here between the MODULE_ macros,
> but in my original patch it seems correct.

It should be like

MODULE_FOO(...);
MODULE_BAR(...);
MODULE_BAZ(...);

One macro =E2=80=94 one line.

--=20
With Best Regards,
Andy Shevchenko
