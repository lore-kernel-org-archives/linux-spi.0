From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/2] spi: qup: Request CS GPIO's during probe
Date: Mon, 09 Mar 2015 11:53:42 -0700
Message-ID: <54FDEC36.5080403@codeaurora.org>
References: <1425655578-22400-1-git-send-email-iivanov@mm-sol.com>	 <1425655578-22400-2-git-send-email-iivanov@mm-sol.com>	 <54F9F31A.3050501@codeaurora.org> <1425889207.2440.9.camel@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@kernel.org>, linus.walleij@linaro.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1425889207.2440.9.camel@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 03/09/15 01:20, Ivan T. Ivanov wrote:
> Hi Stephen,
>
>> On Mar 6, 2015, at 8:34 PM, Stephen Boyd <sboyd@codeaurora.org> wrot=
e:
>> On 03/06/15 07:26, Ivan T. Ivanov wrote:
>>> Ensure that driver is owner of the GPIO's used for CS signals.
>> Why? What happens if we don=E2=80=99t?
> We can have wrong DT configuration, which could reconfigure
> GPIO=E2=80=99s without any warning or error.

Ouch. That sounds bad. Can you please add this information to the commi=
t
text?

>
>>> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
>>> ---
>>> drivers/spi/spi-qup.c | 17 ++++++++++++++++-
>>> 1 file changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
>>> index 2b2c359..a07ba46 100644
>>> --- a/drivers/spi/spi-qup.c
>>> +++ b/drivers/spi/spi-qup.c
>>> @@ -14,11 +14,13 @@
>>> #include <linux/clk.h>
>>> #include <linux/delay.h>
>>> #include <linux/err.h>
>>> +#include <linux/gpio.h>
>>> #include <linux/interrupt.h>
>>> #include <linux/io.h>
>>> #include <linux/list.h>
>>> #include <linux/module.h>
>>> #include <linux/of.h>
>>> +#include <linux/of_gpio.h>
>>> #include <linux/platform_device.h>
>>> #include <linux/pm_runtime.h>
>>> #include <linux/spi/spi.h>
>>> @@ -499,7 +501,7 @@ static int spi_qup_probe(struct platform_device=
 *pdev)
>>>         struct device *dev;
>>>         void __iomem *base;
>>>         u32 max_freq, iomode, num_cs;
>>> -       int ret, irq, size;
>>> +       int ret, irq, size, cs, cs_gpio;
>>>
>>>         dev =3D &pdev->dev;
>>>         res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> @@ -556,6 +558,19 @@ static int spi_qup_probe(struct platform_devic=
e *pdev)
>>>         else
>>>                 master->num_chipselect =3D num_cs;
>>>
>>> +       for (cs =3D 0; cs < master->num_chipselect; cs++) {
>>> +               cs_gpio =3D of_get_named_gpio(dev->of_node, "cs-gpi=
os", cs);
>>> +
>>> +               if (!gpio_is_valid(cs_gpio))
>>> +                       continue;
>>> +
>>> +               ret =3D devm_gpio_request(&pdev->dev, cs_gpio, "spi=
-qup-cs");
>>> +               if (ret) {
>>> +                       dev_err(&pdev->dev, "can't get cs gpios\n")=
;
>>> +                       goto error;
>>> +               }
>>> +       }
>>> +
>>>         master->bus_num =3D pdev->id;
>> Is this related to [1]? In that case I was just relying on DT/pinctr=
l to
>> properly request the gpios.
> But the DT/pinctrl did not request GPIO=E2=80=99s, it just configure =
them.
> For some reason we are ending without any pinctrl_map of type=20
> PIN_MAP_TYPE_MUX_GROUP, which is used for pin reservation.=20
>

Ah ok. I seem to be misremembering the details.

Can you please use the gpiod interfaces here (devm_gpiod_get_index)?
That's more modern. Also, don't print any error because -EPROBE_DEFER
may come out and because __gpiod_get_index() already prints an error on
failure at the debug level.

--=20
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
