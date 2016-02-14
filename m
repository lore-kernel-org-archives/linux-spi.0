From: Jiang Qiu <qiujiang@huawei.com>
Subject: Re: [RFC PATCH] SPI/ACPI: DesignWare: Add ACPI support for Designware
 SPI driver
Date: Sun, 14 Feb 2016 17:47:47 +0800
Message-ID: <56C04D43.1040604@huawei.com>
References: <1454656280-130658-1-git-send-email-qiujiang@huawei.com>
 <CAHp75VeSkUvHSd_JC-qPzwDjBWM8oxJP8jt3UD91uq1=fvEEqw@mail.gmail.com>
Reply-To: <qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <haifeng.wei@huawei.com>,
	<charles.chenxin@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeSkUvHSd_JC-qPzwDjBWM8oxJP8jt3UD91uq1=fvEEqw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Andy,

Sorry for late relpy because Chinese new year holiday. See my replies b=
elow.


Best Regards
Jiang

=E5=9C=A8 2016/2/5 23:55, Andy Shevchenko =E5=86=99=E9=81=93:
> On Fri, Feb 5, 2016 at 9:11 AM, qiujiang <qiujiang@huawei.com> wrote:
>> This patch added ACPI support for DesignWare SPI mmio driver. It
>> was based the corresponding DT driver and compatible for this two
>> way. This patch has been tested on Hisilicon D02 board. It relies
>> on the GPIO patchset.
> My comments below.
As Mark mentioned, I want to ask you how to use this spi-dw-mmio driver=
 for
ACPI binding? Dose it need any other extra patchset?
>
>> @@ -84,8 +87,6 @@ static int dw_spi_mmio_probe(struct platform_devic=
e *pdev)
>>          dws->num_cs =3D num_cs;
>>
>>          if (pdev->dev.of_node) {
>> -               int i;
>> -
>>                  for (i =3D 0; i < dws->num_cs; i++) {
>>                          int cs_gpio =3D of_get_named_gpio(pdev->dev=
=2Eof_node,
>>                                          "cs-gpios", i);
> It seems the driver was never validated with more than one chip selec=
t.
> Perhaps someone has to switch to use of_spi_register_master() here.
of_spi_register_master() will be executed in the spi_register_master(),=
=20
but it just saved the
cs_gpios to the spi_master and not used it any more.
>> @@ -104,6 +105,18 @@ static int dw_spi_mmio_probe(struct platform_de=
vice *pdev)
>>                  }
>>          }
>>
>> +       if (ACPI_COMPANION(&pdev->dev)) {
>> +               for (i =3D 0; i < dws->num_cs; i++) {
>> +                       snprintf(propname, sizeof(propname), "cs%d",=
 i);
>> +                       gpiod =3D devm_gpiod_get(&pdev->dev,
>> +                               propname, GPIOD_ASIS);
>> +                       if (IS_ERR(gpiod)) {
>> +                               dev_err(&pdev->dev, "Get gpio desc f=
ailed!\n");
>> +                               return PTR_ERR(gpiod);
>> +                       }
>> +               }
>> +       }
> Like Mark noticed there is also same issue. Do you indeed check the
> configuration with different chip select signals?
As a spi master driver, it seems that multi-chip select must be=20
supported, so this check is
necessary, I think.
>
