From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: rockchip: add support for "cs-gpios" dts property
Date: Mon, 12 Jun 2017 10:18:06 +0200
Message-ID: <CAMuHMdUDjtSNRiBxcBnAMdUEaCZbioPoRE1h=p9=BqHMGmQaEQ@mail.gmail.com>
References: <1497248057-16550-1-git-send-email-jeffy.chen@rock-chips.com>
 <dfe87919-b2cc-37e8-1598-6b3c730ff356@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
 "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
 Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
 "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <dfe87919-b2cc-37e8-1598-6b3c730ff356-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 12, 2017 at 9:15 AM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> On 2017/6/12 14:14, Jeffy Chen wrote:
>>
>> Support using "cs-gpios" property to specify cs gpios.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

>> index 83da493..02171b2 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
>> @@ -17,6 +17,7 @@ Required Properties:
>>          region.
>>   - interrupts: The interrupt number to the cpu. The interrupt specifier
>> format
>>                 depends on the interrupt controller.
>> +- cs-gpios : Specifies the gpio pins to be used for chipselects.
>
> It's not a required property, otherwise how other boards work as your
> patch 2 only add this for rk3399-gru.

>> --- a/drivers/spi/spi-rockchip.c
>> +++ b/drivers/spi/spi-rockchip.c

>> @@ -297,6 +302,50 @@ static void rockchip_spi_set_cs(struct spi_device
>> *spi, bool enable)
>>         pm_runtime_put_sync(rs->dev);
>>   }
>>   +static int rockchip_spi_setup(struct spi_device *spi)
>> +{
>> +       int ret = 0;
>> +       unsigned long flags = (spi->mode & SPI_CS_HIGH) ?
>> +                             GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
>> +       struct rockchip_spi_data *data = spi_get_ctldata(spi);
>> +
>> +       if (!gpio_is_valid(spi->cs_gpio))
>> +               return 0;

> return -EINVAL?

Isn't this check meant to fall back to hardware CS if no cs-gpios property
is present?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
