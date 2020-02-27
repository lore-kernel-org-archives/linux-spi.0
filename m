From: Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v2 02/11] spi: set mode bits for "spi-rx-dtr" and
 "spi-tx-dtr"
Date: Thu, 27 Feb 2020 17:23:04 +0100
Message-ID: <20200227172247.0e8ec459@collabora.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-3-p.yadav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200226093703.19765-3-p.yadav-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 26 Feb 2020 15:06:54 +0530
Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org> wrote:

> These two DT properties express DTR receive and transmit capabilities of
> a SPI flash and controller. Introduce two new mode bits: SPI_RX_DTR and
> SPI_TX_DTR which correspond to the new DT properties. Set these bits
> when the two corresponding properties are present in the device tree.
> Also update the detection of unsupported mode bits to include the new
> bits.
> 
> Signed-off-by: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/spi/spi.c       | 10 +++++++++-
>  include/linux/spi/spi.h |  2 ++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 38b4c78df506..25c8ed9343f9 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1927,6 +1927,13 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		}
>  	}
>  
> +	/* Device DTR mode. */
> +	if (of_property_read_bool(nc, "spi-tx-dtr"))
> +		spi->mode |= SPI_TX_DTR;
> +
> +	if (of_property_read_bool(nc, "spi-rx-dtr"))
> +		spi->mode |= SPI_RX_DTR;
> +

If this DTR mode is only used in spi-mem, maybe we shouldn't add those
flags. SPI mem devices are usually smart enough to advertise what they
support, and the subsystem in charge of those devices (in this specific
case, spi-nor) will check what the controller supports
using spi_mem_supports_op(). The only case we might have to deal with
at some point is board level limitations (disabling DTR because the
routing prevents using this mode).

>  	if (spi_controller_is_slave(ctlr)) {
>  		if (!of_node_name_eq(nc, "slave")) {
>  			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
> @@ -3252,7 +3259,8 @@ int spi_setup(struct spi_device *spi)
>  		bad_bits &= ~SPI_CS_HIGH;
>  	ugly_bits = bad_bits &
>  		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
> -		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
> +		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
> +		     SPI_TX_DTR  | SPI_RX_DTR);
>  	if (ugly_bits) {
>  		dev_warn(&spi->dev,
>  			 "setup: ignoring unsupported mode bits %x\n",
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 6d16ba01ff5a..bf1108318389 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -183,6 +183,8 @@ struct spi_device {
>  #define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
>  #define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
>  #define	SPI_3WIRE_HIZ	0x8000			/* high impedance turnaround */
> +#define SPI_RX_DTR	0x10000			/* receive in DTR mode */
> +#define SPI_TX_DTR	0x20000			/* transmit in DTR mode */
>  	int			irq;
>  	void			*controller_state;
>  	void			*controller_data;
