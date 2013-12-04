From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 5/5] spi: add bcm63xx HSSPI driver
Date: Wed, 4 Dec 2013 15:04:48 +0100
Message-ID: <CAOiHx==utbmYUS4BLoSaaGi91Kw5voQ2vFiA97GLmwn8yU19Dw@mail.gmail.com>
References: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
 <1385811726-6746-6-git-send-email-jogo@openwrt.org> <20131204133823.GS29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131204133823.GS29268-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Dec 4, 2013 at 2:38 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sat, Nov 30, 2013 at 12:42:06PM +0100, Jonas Gorski wrote:
>> Add a driver for the High Speed SPI controller found on newer BCM63XX SoCs.
>>
>> It does feature some new modes like 3-wire or dual spi, but neither of it
>> is currently implemented.
>
> This is basically good so I've applied it but there are a few minor
> things that could use improving, please send incremental patches for
> these.

Cool, thanks, will do. Expect a few days delay since I'm in the middle
of a cold. I Don't want to introduce thinkos ;-)

>
>> +     clk = clk_get(dev, "hsspi");
>
> Use devm_clk_get().

Oh, it indeed seems to work now. The last time I tried it broke
compilation because bcm63xx does not implement CLKDEV (or something
like that).

>
>> +     clk_prepare_enable(clk);
>
> You should check the return value here.

True, even if it can't fail in the current supported platforms.

>
>> +     /* register and we are done */
>> +     ret = spi_register_master(master);
>> +     if (ret)
>> +             goto out_put_master;
>
> devm_spi_register_master().

Sure thing.

>
>> +#ifdef CONFIG_PM
>
> This should be CONFIG_PM_SLEEP.

Ah, dammit, I knew I forgot something. I remember the same issue was
fixed for spi-bcm63xx.c, but somehow forgot to check for it in this
driver.


>> +static int bcm63xx_hsspi_suspend(struct device *dev)
>> +{
>> +     struct spi_master *master = dev_get_drvdata(dev);
>> +     struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
>> +
>> +     spi_master_suspend(master);
>> +     clk_disable(bs->clk);
>
> This ought to be disable_unprepare().  It would also be better to move
> this to runtime PM (you can set auto_runtime_pm to have the core manage
> the enable and disable for you) since that will save a bit of power.

I already set auto_runtime_pm to true. I basically copied what's
currently in spi-bcm63xx.c *coughs*. Is there anything else needed
besides what you mentioned?
>
>> +static int bcm63xx_hsspi_resume(struct device *dev)
>> +{
>> +     struct spi_master *master = dev_get_drvdata(dev);
>> +     struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
>> +
>> +     clk_enable(bs->clk);
>> +     spi_master_resume(master);
>
> Similar comments here, plus you should be checking errors.

Will fix that, too.


Regards
Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
