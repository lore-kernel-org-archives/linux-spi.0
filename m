From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] spi: orion: support armada extended baud rates
Date: Thu, 04 Sep 2014 00:11:10 +1000
Message-ID: <5407217E.8060700@uclinux.org>
References: <1409554890-21239-1-git-send-email-gerg@uclinux.org> <CAOiHx=n9Y38LXJN1ju5KQc9QxMhTknFGL8b=e4hHKuKKMbDmBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOiHx=n9Y38LXJN1ju5KQc9QxMhTknFGL8b=e4hHKuKKMbDmBQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Jonas,

On 03/09/14 21:09, Jonas Gorski wrote:
> On Mon, Sep 1, 2014 at 9:01 AM,  <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org> wrote:
>> From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
>>
>> The Armada SoC family implementation of this SPI hardware module has
>> extended the configuration register to allow for a wider range of SPI
>> clock rates. Specifically the Serial Baud Rate Pre-selection bits in the
>> SPI Interface Configuration Register now also use bits 6 and 7 as well.
>>
>> Modify the baud rate calculation to handle these differences for the
>> Armada case. Potentially a baud rate can be setup using a number of
>> different pre-scalar and scalar combinations. This code tries all
>> possible pre-scalar divisors (8 in total) to try and find the most
>> accuate set.
>>
>> Signed-off-by: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
>> ---
>>   drivers/spi/spi-orion.c | 77 +++++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 61 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
>> index c4675fa..816822f 100644
>> --- a/drivers/spi/spi-orion.c
>> +++ b/drivers/spi/spi-orion.c
>> @@ -40,6 +40,7 @@
>>   #define ORION_SPI_MODE_CPHA            (1 << 12)
>>   #define ORION_SPI_IF_8_16_BIT_MODE     (1 << 5)
>>   #define ORION_SPI_CLK_PRESCALE_MASK    0x1F
>> +#define ARMADA_SPI_CLK_PRESCALE_MASK   0xDF
>>   #define ORION_SPI_MODE_MASK            (ORION_SPI_MODE_CPOL | \
>>                                           ORION_SPI_MODE_CPHA)
>>
>> @@ -82,31 +83,74 @@ static int orion_spi_baudrate_set(struct spi_device *spi, unsigned int speed)
>>          u32 rate;
>>          u32 prescale;
>>          u32 reg;
>> +       u32 mask;
>>          struct orion_spi *orion_spi;
>>
>>          orion_spi = spi_master_get_devdata(spi->master);
>>
>>          tclk_hz = clk_get_rate(orion_spi->clk);
>>
>> -       /*
>> -        * the supported rates are: 4,6,8...30
>> -        * round up as we look for equal or less speed
>> -        */
>> -       rate = DIV_ROUND_UP(tclk_hz, speed);
>> -       rate = roundup(rate, 2);
>> +       if (of_machine_is_compatible("marvell,armada370")) {
> This is ugly, can't you use a new compatible name for the driver (e.g.
> "marvell,armada370-spi")? And then just store the result in orion_spi.

Yes, could do that.

> I don't think checking a compatible string for every transfer is good
> for performance.

Probably not :-)

>   Also what about armada370-xp, armada375, armada380
> and any other variants out there?

I don't know. I don't have access to functional specs for anything
other than the 370. I expect they are probably the same though.
(Can anyone confirm?)

I'll rework it and resend.

Regards
Greg


>> +               unsigned int clk, spr, sppr, sppr2, err;
>> +               unsigned int best_spr, best_sppr, best_err;
>>
>> -       /* check if requested speed is too small */
>> -       if (rate > 30)
>> -               return -EINVAL;
>> +               best_err = speed;
>> +               best_spr = 0;
>> +               best_sppr = 0;
>>
>> -       if (rate < 4)
>> -               rate = 4;
>> +               tclk_hz *= 10;
>> +               if (speed > tclk_hz)
>> +                       return -EINVAL;
>>
>> -       /* Convert the rate to SPI clock divisor value. */
>> -       prescale = 0x10 + rate/2;
>> +               /* Iterate over the valid range looking for best fit */
>> +               for (sppr = 0; sppr < 8; sppr++) {
>> +                       sppr2 = 0x1 << sppr;
>> +
>> +                       spr = tclk_hz / sppr2;
>> +                       spr = DIV_ROUND_UP(spr, speed);
>> +                       if ((spr == 0) || (spr > 15))
>> +                               continue;
>> +
>> +                       clk = tclk_hz / (spr * sppr2);
>> +                       err = speed - clk;
>> +
>> +                       if (err < best_err) {
>> +                               best_spr = spr;
>> +                               best_sppr = sppr;
>> +                               best_err = err;
>> +                       }
>> +               }
>> +
>> +               if ((best_sppr == 0) && (best_spr == 0))
>> +                       return -EINVAL;
>> +
>> +               prescale = ((best_sppr & 0x6) << 5) |
>> +                       ((best_sppr & 0x1) << 4) | best_spr;
>> +
>> +               mask = ARMADA_SPI_CLK_PRESCALE_MASK;
>> +       } else {
>> +               mask = ORION_SPI_CLK_PRESCALE_MASK;
>> +
>> +               /*
>> +                * the supported rates are: 4,6,8...30
>> +                * round up as we look for equal or less speed
>> +                */
>> +               rate = DIV_ROUND_UP(tclk_hz, speed);
>> +               rate = roundup(rate, 2);
>> +
>> +               /* check if requested speed is too small */
>> +               if (rate > 30)
>> +                       return -EINVAL;
>> +
>> +               if (rate < 4)
>> +                       rate = 4;
>> +
>> +               /* Convert the rate to SPI clock divisor value. */
>> +               prescale = 0x10 + rate/2;
>> +       }
>>
>>          reg = readl(spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
>> -       reg = ((reg & ~ORION_SPI_CLK_PRESCALE_MASK) | prescale);
>> +       reg = ((reg & ~mask) | prescale);
>>          writel(reg, spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
>>
>>          return 0;
>> @@ -348,7 +392,7 @@ static int orion_spi_probe(struct platform_device *pdev)
>>          struct orion_spi *spi;
>>          struct resource *r;
>>          unsigned long tclk_hz;
>> -       int status = 0;
>> +       int mindiv, status = 0;
>>
>>          master = spi_alloc_master(&pdev->dev, sizeof(*spi));
>>          if (master == NULL) {
>> @@ -390,7 +434,8 @@ static int orion_spi_probe(struct platform_device *pdev)
>>
>>          tclk_hz = clk_get_rate(spi->clk);
>>          master->max_speed_hz = DIV_ROUND_UP(tclk_hz, 4);
>> -       master->min_speed_hz = DIV_ROUND_UP(tclk_hz, 30);
>> +       mindiv = (of_machine_is_compatible("marvell,armada370")) ? 1920 : 30;
> Same as above.
>
>
> Jonas
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
