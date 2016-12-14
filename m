From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: lantiq-ssc: add support for Lantiq SSC SPI
 controller
Date: Wed, 14 Dec 2016 22:51:48 +0100
Message-ID: <f7b12062-b0f6-e704-9992-b68349c2331a@hauke-m.de>
References: <20161211200350.13590-1-hauke@hauke-m.de>
 <20161211200350.13590-3-hauke@hauke-m.de>
 <20161214153407.du2f63irwl2fi72h@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161214153407.du2f63irwl2fi72h-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12/14/2016 04:34 PM, Mark Brown wrote:
> On Sun, Dec 11, 2016 at 09:03:50PM +0100, Hauke Mehrtens wrote:
> 
>> +config SPI_LANTIQ_SSC
>> +	tristate "Lantiq SSC SPI controller"
>> +	depends on LANTIQ
> 
> No || COMPILE_TEST?

Yes, clk_get_fpi(); is SoC specific. The next task is to clean up the
SoC specific code and use common clock framework and then this will be
changed.

>> +	if (t->speed_hz)
>> +		speed_hz = t->speed_hz;
>> +	else
>> +		speed_hz = spidev->max_speed_hz;
> 
> The core will ensure the transfers are always initialized.

Ok, will change
> 
>> +static int lantiq_ssc_unprepare_message(struct spi_master *master,
>> +					struct spi_message *message)
>> +{
>> +	struct lantiq_ssc_spi *spi = spi_master_get_devdata(master);
>> +
>> +	/* Disable transmitter and receiver while idle */
>> +	lantiq_ssc_maskl(spi, 0, SPI_CON_TXOFF | SPI_CON_RXOFF, SPI_CON);
>> +
>> +	return 0;
>> +}
> 
> Why is this done per message and not when the device actually goes idle?

I assume that this is not needed per message, I will try it out.

>> +		default:
>> +			WARN_ON(1);
>> +			data = 0;
>> +		}
> 
> Missing break.
> 
>> +		case 24:
>> +		case 32:
>> +			rx32 = (u32 *) spi->rx;
>> +			*rx32 = data;
>> +			spi->rx_todo -= 4;
>> +			spi->rx += 4;
>> +			break;
> 
> This looks like the device doesn't actually support 24 bits per word or
> at least is expecting the data to be in memory with pad bytes which
> isn't what Linux expects.  You'd need to repack the data for the
> hardware or just not support it.

The datahseet says that it supports 24 bit transfer, but I have never
tested it. I would just remove support for 24 bit as it is probably not
used often.

> 
>> +static irqreturn_t lantiq_ssc_err_interrupt(int irq, void *data)
>> +{
>> +	struct lantiq_ssc_spi *spi = data;
>> +	u32 stat = lantiq_ssc_readl(spi, SPI_STAT);
>> +
>> +	if (stat & SPI_STAT_RUE)
>> +		dev_err(spi->dev, "receive underflow error\n");
>> +	if (stat & SPI_STAT_TUE)
>> +		dev_err(spi->dev, "transmit underflow error\n");
>> +	if (stat & SPI_STAT_RE)
>> +		dev_err(spi->dev, "receive overflow error\n");
>> +	if (stat & SPI_STAT_TE)
>> +		dev_err(spi->dev, "transmit overflow error\n");
>> +	if (stat & SPI_STAT_ME)
>> +		dev_err(spi->dev, "mode error\n");
>> +
>> +	/* Clear error flags */
>> +	lantiq_ssc_maskl(spi, 0, SPI_WHBSTATE_CLR_ERRORS, SPI_WHBSTATE);
>> +
>> +	/* set bad status so it can be retried */
>> +	spi->status = -EIO;
>> +	spi_finalize_current_transfer(spi->master);
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
> This unconditionally returns IRQ_HANDLED even if nothing was flagged.
> 

Ok I will change that.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
