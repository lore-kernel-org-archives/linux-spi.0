From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v6 2/4] spi: bcm2835: add bcm2835 auxiliary spi device driver
Date: Mon, 04 Jan 2016 14:51:12 +0100
Message-ID: <1866751.zFWfh0Kuks@chaos-desktop>
References: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org> <1441970527-2403-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441970527-2403-3-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Martin,

I have tested the auxiliary spi device driver. It works in general for me, but 
I have two issues regarding the clock an chip select timing.

Am Freitag, 11. September 2015, 11:22:04 schrieb kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org:
> +static int bcm2835aux_spi_transfer_one(struct spi_master *master,
> +				       struct spi_device *spi,
> +				       struct spi_transfer *tfr)
> +{
> +	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
> +	unsigned long spi_hz, clk_hz, speed;
> +	unsigned long spi_used_hz, xfer_time_us;
> +
> +	/* calculate the registers to handle
> +	 *
> +	 * note that we use the variable data mode, which
> +	 * is not optimal for longer transfers as we waste registers
> +	 * resulting (potentially) in more interrupts when transferring
> +	 * more than 12 bytes
> +	 */
> +	bs->cntl[0] = BCM2835_AUX_SPI_CNTL0_ENABLE |
> +		      BCM2835_AUX_SPI_CNTL0_VAR_WIDTH |
> +		      BCM2835_AUX_SPI_CNTL0_MSBF_OUT;
> +	bs->cntl[1] = BCM2835_AUX_SPI_CNTL1_MSBF_IN;
> +
> +	/* set clock */
> +	spi_hz = tfr->speed_hz;
> +	clk_hz = clk_get_rate(bs->clk);
> +
> +	if (spi_hz >= clk_hz / 2) {
> +		speed = 0;
> +	} else if (spi_hz) {
> +		speed = DIV_ROUND_UP(clk_hz, 2 * spi_hz) - 1;
> +		if (speed >  BCM2835_AUX_SPI_CNTL0_SPEED_MAX)
> +			speed = BCM2835_AUX_SPI_CNTL0_SPEED_MAX;
> +	} else { /* the slowest we can go */
> +		speed = BCM2835_AUX_SPI_CNTL0_SPEED_MAX;
> +	}
> +	bs->cntl[0] |= speed << BCM2835_AUX_SPI_CNTL0_SPEED_SHIFT;
> +
> +	spi_used_hz = clk_hz / (2 * (speed + 1));
> +
> +	/* handle all the modes */
> +	if (spi->mode & SPI_CPOL)
> +		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPOL;
> +	if (spi->mode & SPI_CPHA)
> +		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT |
> +			       BCM2835_AUX_SPI_CNTL0_CPHA_IN;

According to the spi documentation [1]: "CPHA indicates the clock phase used 
to sample data; CPHA=0 says sample on the leading edge, CPHA=1 means the 
trailing edge."
Which is from my understanding different from what the BMC2835 ARM Peripherals 
[2] says for BCM2835_AUX_SPI_CNTL0_CPHA_IN:
"If 1 data is clocked in on the rising edge of the SPI clock
If 0 data is clocked in on the falling edge of the SPI clock"

I would expect the bits to be set dependant on the clock polarity (CPOL).

The other issue I have, is that the chip select is set before the clock 
polarity and the polarity is reset and set again between each transfers of a 
message. If CPOL is set to 1 this leads to additional rising and falling edges 
of the clock while chip select is active, where no data is sampled.

Stephan

[1] http://lxr.free-electrons.com/source/Documentation/spi/spi-summary
[2] https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
