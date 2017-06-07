From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 linux-next 3/3] spi: imx: Add support for SPI Slave
 mode
Date: Wed, 7 Jun 2017 10:33:34 +0200
Message-ID: <20170607083334.uk6pmgzdpgzfkn2i@pengutronix.de>
References: <1496222398-3192-1-git-send-email-jiada_wang@mentor.com>
 <1496222398-3192-4-git-send-email-jiada_wang@mentor.com>
 <20170531121037.pgs5yysveiu54nwo@pengutronix.de>
 <59316463.9030209@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <59316463.9030209-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 02, 2017 at 06:13:07AM -0700, Jiada Wang wrote:
> Hi Sascha
> 
> On 05/31/2017 05:10 AM, Sascha Hauer wrote:
> >> +
> >> +static void mx53_ecspi_tx_slave(struct spi_imx_data *spi_imx)
> >> +{
> >> +	u32 val = 0;
> >> +	int shift = spi_imx->count % sizeof(val);
> >> +
> >> +	if (spi_imx->tx_buf) {
> >> +		if (shift) {
> >> +			memcpy(((u8 *)&val) + sizeof(val) - shift,
> >> +			       spi_imx->tx_buf, shift);
> >> +		} else {
> >> +			val = *((u32 *)spi_imx->tx_buf);
> >> +			shift = sizeof(val);
> >> +		}
> >> +		val = cpu_to_be32(val);
> >> +		spi_imx->tx_buf += shift;
> >> +	}
> >> +
> >> +	if (!shift)
> >> +		shift = sizeof(val);
> > A better name for 'shift' is n_bytes. Its value should be calculated
> > before the if (spi_imx->tx_buf) block. Then you can use memcpy for the
> > four byte case aswell.
> >
> >
> > But anyway, have you tested this function for anything with
> > spi_imx->count % sizeof(val) != 0? In this case you have to put the fill
> > the FIFO only partly somewhere. I would assume you have to do this at
> > the end of the transfer, but you do this at the beginning. Can this
> > work?
> Yes, I have tested the case when "spi_imx->count % sizeof(val) != 0", it
> works.

For the record: Yes, this seems to be right. I misread the datasheet.
When the controller is programmed to transfer 5 bytes, then it seemed
fairly logical to me that it first expects four bytes in its 32bit FIFO
and then the remaining single byte. In fact it's the other way round,
how the example of the BURST_LENGTH register description says:

0x021 A SPI burst contains the 2 LSB in first word and all 32 bits in
second word.

So the part that doesn't fill a whole FIFO width goes out first, not
last.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
