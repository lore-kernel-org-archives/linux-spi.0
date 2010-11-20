From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 6/6] atmel_spi: fix warning In function
	'atmel_spi_dma_map_xfer'
Date: Sat, 20 Nov 2010 22:48:20 +0100
Message-ID: <20101120214820.GG8942@pengutronix.de>
References: <20101120095906.GD4216@game.jcrosoft.org> <1290247733-17834-6-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-arm-kernel@lists.infradead.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1290247733-17834-6-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

[adding spi-devel-general and lkml to Cc:]

On Sat, Nov 20, 2010 at 11:08:53AM +0100, Jean-Christophe PLAGNIOL-VILL=
ARD wrote:
> passing argument 2 of 'dma_map_single' discards qualifiers from point=
er target type
>=20
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.co=
m>
> ---
>  drivers/spi/atmel_spi.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
> index 154529a..2cf6abd 100644
> --- a/drivers/spi/atmel_spi.c
> +++ b/drivers/spi/atmel_spi.c
> @@ -352,8 +352,10 @@ atmel_spi_dma_map_xfer(struct atmel_spi *as, str=
uct spi_transfer *xfer)
> =20
>  	xfer->tx_dma =3D xfer->rx_dma =3D INVALID_DMA_ADDRESS;
>  	if (xfer->tx_buf) {
> +		void *nonconst_tx =3D (void *)xfer->tx_buf; /* shut up gcc */
> +
>  		xfer->tx_dma =3D dma_map_single(dev,
> -				(void *) xfer->tx_buf, xfer->len,
> +				nonconst_tx, xfer->len,
>  				DMA_TO_DEVICE);
Hmm, I wonder if this is the right approach to do this.  I'd prefer to
have something like:

	dma_map_single_to_device(struct device *, const void *, ...)

don't know if that's sensible though.

And I wonder about gcc that your patch makes a difference.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
