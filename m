From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] spi/bcm63xx-hsspi: allow for probing through devicetree
Date: Tue, 28 Feb 2017 14:17:46 +0100
Message-ID: <CAOiHx==d3Jhnpa0ppjPHcUHpqg6EnADNgWg4o_ShdnU8z_VG6w@mail.gmail.com>
References: <20170222131940.31085-1-jonas.gorski@gmail.com>
 <20170222131940.31085-3-jonas.gorski@gmail.com> <75499273-96ba-0270-9b06-5b1def1452ca@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <75499273-96ba-0270-9b06-5b1def1452ca-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 27 February 2017 at 23:54, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 02/22/2017 05:19 AM, Jonas Gorski wrote:
>> Add required binding support to probe through device tree.
>>
>> Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/spi/spi-bcm63xx-hsspi.c | 26 +++++++++++++++++++++++---
>>  1 file changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
>> index 79096d17ebde..77c249a22c9b 100644
>> --- a/drivers/spi/spi-bcm63xx-hsspi.c
>> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/mutex.h>
>> +#include <linux/of.h>
>>
>>  #define HSSPI_GLOBAL_CTRL_REG                        0x0
>>  #define GLOBAL_CTRL_CS_POLARITY_SHIFT                0
>> @@ -91,6 +92,7 @@
>>
>>  #define HSSPI_MAX_SYNC_CLOCK                 30000000
>>
>> +#define HSSPI_SPI_MAX_CS                     8
>>  #define HSSPI_BUS_NUM                                1 /* 0 is legacy SPI */
>>
>>  struct bcm63xx_hsspi {
>> @@ -332,7 +334,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
>>       struct device *dev = &pdev->dev;
>>       struct clk *clk;
>>       int irq, ret;
>> -     u32 reg, rate;
>> +     u32 reg, rate, num_cs = HSSPI_SPI_MAX_CS;
>>
>>       irq = platform_get_irq(pdev, 0);
>>       if (irq < 0) {
>> @@ -382,8 +384,20 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
>>       mutex_init(&bs->bus_mutex);
>>       init_completion(&bs->done);
>>
>> -     master->bus_num = HSSPI_BUS_NUM;
>> -     master->num_chipselect = 8;
>> +     if (dev->of_node) {
>> +             master->dev.of_node = dev->of_node;
>
> You could move this out of the if () statement here.

Indeed, of_property_read_u32 is safe to call with a NULL np, so I
don't need to guard it extra.

>> +
>> +             of_property_read_u32(dev->of_node, "num-cs", &num_cs);
>> +             if (num_cs > 8) {
>> +                     dev_warn(dev, "unsupported number of cs (%i), reducing to 8\n",
>> +                              num_cs);
>> +                     num_cs = HSSPI_SPI_MAX_CS;
>> +             }
>> +     } else {
>> +             master->bus_num = HSSPI_BUS_NUM;
>
> And this one too, since the core will take care of assigning it based on
> aliases and such when master->dev.of_node is correctly set.

It will only do if bus_num is < 0, so I will still need to guard it
for !of_node, else the alias-based assignent won't work.


>
> With that changed:
>
> Acked-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Thanks for the review!


Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
