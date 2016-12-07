From: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 1/5] spi: Add basic support for Armada 3700 SPI
 Controller
Date: Wed, 7 Dec 2016 13:42:28 +0100
Message-ID: <13532b8e-4fd8-fd39-772c-f350ab7473b6@free-electrons.com>
References: <20161201102719.4291-1-romain.perier@free-electrons.com>
 <20161201102719.4291-2-romain.perier@free-electrons.com>
 <20161205120540.mvihgafelszitzhq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
        Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
        Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org,
        dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161205120540.mvihgafelszitzhq-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

Le 05/12/2016 à 13:05, Mark Brown a écrit :
> On Thu, Dec 01, 2016 at 11:27:15AM +0100, Romain Perier wrote:
>
>> +config SPI_ARMADA_3700
>> +	tristate "Marvell Armada 3700 SPI Controller"
>> +	depends on ARCH_MVEBU && OF
>
> Why does this not have a COMPILE_TEST dependency?

Because that's a mistake, I will fix it.

>
>> +	/* Reset SPI unit */
>> +	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
>> +	val |= A3700_SPI_SRST;
>> +	spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
>> +
>> +	for (i = 0; i < A3700_SPI_TIMEOUT; i++)
>> +		udelay(1);
>
> Why not just do a single udelay()?

Mhhhh... good point.


>
>> +static irqreturn_t a3700_spi_interrupt(int irq, void *dev_id)
>> +{
>> +	struct spi_master *master = dev_id;
>> +	struct a3700_spi *a3700_spi;
>> +	u32 cause;
>> +
>> +	a3700_spi = spi_master_get_devdata(master);
>> +
>> +	/* Get interrupt causes */
>> +	cause = spireg_read(a3700_spi, A3700_SPI_INT_STAT_REG);
>> +
>> +	/* mask and acknowledge the SPI interrupts */
>> +	spireg_write(a3700_spi, A3700_SPI_INT_MASK_REG, 0);
>> +	spireg_write(a3700_spi, A3700_SPI_INT_STAT_REG, cause);
>> +
>> +	/* Wake up the transfer */
>> +	if (a3700_spi->wait_mask & cause)
>> +		complete(&a3700_spi->done);
>> +
>> +	return IRQ_HANDLED;
>> +}
>
> This reports that we handled an interrupt even if we did not in fact
> handle an interrupt.  It's also a bit dodgy that it doesn't check what
> the interrupt was but that's less serious.

I don't understand, what do you expect ? That I return something != 
IRQ_HANDLED when the cause of the interrupt is not present in wait_mask ?

>
>> +	master->bus_num = (pdev->id != -1) ? pdev->id : 0;
>
> At most this should be just setting the bus number to pdev->id like
> other drivers do.

ack

>
>> +	ret = clk_prepare_enable(spi->clk);
>> +	if (ret) {
>> +		dev_err(dev, "could not prepare clk: %d\n", ret);
>> +		goto error;
>> +	}
>
> I'd expect the hardware prepare/unprepare to be managing the enable and
> disable of the clock in order to save a little power.

Ok, if that's better for power management, why not then.

>
>> +	dev_info(dev, "Marvell Armada 3700 SPI Controller at 0x%08lx, irq %d\n",
>> +		 (unsigned long)res->start, spi->irq);
>
> This is just adding noise to the boot, remove it.  It's not telling us
> anything we read from the hardware or anything.

ack


Thanks,
Romain

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
