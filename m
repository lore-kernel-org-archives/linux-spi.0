From: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 2/5] spi: armada-3700: Add support for the FIFO mode
Date: Wed, 7 Dec 2016 17:19:57 +0100
Message-ID: <a9b86043-b631-8154-edc8-5abe49e47114@free-electrons.com>
References: <20161201102719.4291-1-romain.perier@free-electrons.com>
 <20161201102719.4291-3-romain.perier@free-electrons.com>
 <20161205133728.sza2pt4tfkywu35k@sirena.org.uk>
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
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161205133728.sza2pt4tfkywu35k-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

Le 05/12/2016 à 14:37, Mark Brown a écrit :
> On Thu, Dec 01, 2016 at 11:27:16AM +0100, Romain Perier wrote:
>
>> Changes in v3:
>>  - Don't enable the fifo mode based on the compatible string, we introduce
>>    a module parameter "pio_mode". By default this option is set to zero, so
>>    the fifo mode is enabled. Pass pio_mode=1 to the driver enables the PIO
>>    mode.
>
> Why?  If the hardware supports a more efficient mode of operation it
> doesn't seem sensible not to use it.

That's just that our customer want to keep both modes, this is why I 
decided to use the more efficient mode by default and disable it via a 
module parameter. Previously the more efficient mode was always enabled, 
based on the "compatible string" of the DT (the PIO mode was simply 
useless in this case and dead code)

>
>> -	int i;
>> +	int i, ret = 0;
>
> Coding style - don't combine initialized and non-initalized variables on
> one line.

Ok

>
>>  static int a3700_spi_transfer_one(struct spi_master *master,
>>  				  struct spi_device *spi,
>>  				  struct spi_transfer *xfer)
>>  {
>>  	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
>> -	int ret = 0;
>> +	int ret;
>>
>>  	a3700_spi_transfer_setup(spi, xfer);
>>
>> @@ -505,6 +737,151 @@ static int a3700_spi_transfer_one(struct spi_master *master,
>>  	return ret;
>>  }
>
> This appears to be a random unrelated change, should probably be part of
> the initial driver commit.

Good catch

>
>> +static int a3700_spi_fifo_transfer_one(struct spi_master *master,
>> +				       struct spi_device *spi,
>> +				       struct spi_transfer *xfer)
>> +{
>> +	struct a3700_spi *a3700_spi = spi_master_get_devdata(master);
>> +	int ret = 0, timeout = A3700_SPI_TIMEOUT;
>> +	unsigned int nbits = 0;
>> +	u32 val;
>> +
>> +	a3700_spi_transfer_setup(spi, xfer);
>> +
>> +	a3700_spi->tx_buf  = xfer->tx_buf;
>> +	a3700_spi->rx_buf  = xfer->rx_buf;
>> +	a3700_spi->buf_len = xfer->len;
>> +
>> +	/* SPI transfer headers */
>> +	a3700_spi_header_set(a3700_spi);
>> +
>> +	if (xfer->tx_buf)
>> +		nbits = xfer->tx_nbits;
>> +	else if (xfer->rx_buf)
>> +		nbits = xfer->rx_nbits;
>> +
>> +	a3700_spi_pin_mode_set(a3700_spi, nbits);
>> +
>> +	if (xfer->rx_buf) {
>> +		/* Set read data length */
>> +		spireg_write(a3700_spi, A3700_SPI_IF_DIN_CNT_REG,
>> +			     a3700_spi->buf_len);
>> +		/* Start READ transfer */
>> +		val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
>> +		val &= ~A3700_SPI_RW_EN;
>> +		val |= A3700_SPI_XFER_START;
>> +		spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
>> +	} else if (xfer->tx_buf) {
>> +		/* Start Write transfer */
>
> So this only supports single duplex transfers but there doesn't seem to
> be anything that enforces this.
>

A flag or a capability, typically? I will investigate

Thanks,
Romain

-- 
Romain Perier, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
