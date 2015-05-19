From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: SPI_MASTER_MUST_* with scatter-gather only option
 and avoiding realloc
Date: Tue, 19 May 2015 13:46:32 +0100
Message-ID: <20150519124632.GN2761@sirena.org.uk>
References: <20150512165053.GE3066@sirena.org.uk>
 <1431597524-7907-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="frrXvU3mT8dlRds5"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431597524-7907-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--frrXvU3mT8dlRds5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2015 at 09:58:44AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> Rewrite of spi_map_msg and spi_map_buf so that for SPI_MASTER_MUST_*:

This isn't just rewriting the internals, this is adding a completely new
API with separate code, fixing a bug, optimising the existing API and
adding a user of the new API.  I'd have expected all of that to be
called out in the changelog and for it to be split out into several
patches - especially the bug fix since that should go to Linus' tree and
stable.

Like I say I'm not entirely convinced we need the extra flags over just
using can_dma().

> It also fixes the insufficient cleanup in case __spi_map_msg returns
> an error.

This should be a separate patch.

> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index ac1760e..ac74456 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -463,7 +463,7 @@ void bcm2835_dma_init(struct spi_master *master, stru=
ct device *dev)
>  	master->can_dma =3D bcm2835_spi_can_dma;
>  	master->max_dma_len =3D 65535; /* limitation by BCM2835_SPI_DLEN */
>  	/* need to do TX AND RX DMA, so we need dummy buffers */
> -	master->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
> +	master->flags =3D SPI_MASTER_MUST_RX_SG | SPI_MASTER_MUST_TX_SG;
> =20
>  	return;
> =20

This is updating a specific driver to use the new API you're adding,
this should be in a separate patch.

>  #ifdef CONFIG_HAS_DMA
> +static int spi_map_null(struct spi_master *master, struct device *dev,
> +			struct sg_table *sgt,
> +			struct sg_table *sgt_template,
> +			void *buf,
> +			enum dma_data_direction dir)
> +{

It's not obvious to me what this is supposed to do and it looks awfully
like it's duplicating the existing DMA mapping code (but if that's the
case the existing code should be using this not duplicating it so I
guess not).  I think it's supposed to be for creating a scatterlist that
repeatedly reused the same dummy page but there's this template thing,
it's getting a buffer passed in and...

> +	if (is_vmalloc_addr(buf)) {
> +		vm_page =3D vmalloc_to_page(buf);
> +		if (!vm_page) {
> +			sg_free_table(sgt);
> +			return -ENOMEM;
> +		}
> +		page_offset =3D offset_in_page(buf);
> +	} else {
> +		vm_page =3D NULL;
> +		page_offset =3D 0;
> +	}

=2E..this is really weird for that case. =20

I'd have expected to be allocating a scatterlist that transfers a
specified length to/from a normal page sized kmalloc() buffer in which
case we don't need to worry about vmalloc() or this template stuff.

> +		/*
> +		 * handle the SPI_MASTER_MUST_*_SG
> +		 * note that the situation with tx_buf and rx_buf both NULL
> +		 * is checked and handled inside spi_transfer_one_message
> +		 */
> +		if ((!xfer->tx_buf) && (xfer->rx_buf) &&
> +		    (master->flags & SPI_MASTER_MUST_TX_SG)) {
> +			ret =3D spi_map_null(master, tx_dev,
> +					   &xfer->tx_sg, &xfer->rx_sg,
> +					   master->page_tx,
> +					   DMA_TO_DEVICE);
> +			if (ret !=3D 0) {
> +				spi_unmap_buf(master, rx_dev, &xfer->rx_sg,
> +					      DMA_FROM_DEVICE);
> +				return ret;
> +			}
> +		}

Why does the transmit handling use a scatterlist allocated for receive
(and vice versa)?  This goes back to the lack of clarity about what
spi_map_null() is doing.

>  		if (max_tx) {
> -			tmp =3D krealloc(master->dummy_tx, max_tx,
> -				       GFP_KERNEL | GFP_DMA);
> -			if (!tmp)
> -				return -ENOMEM;
> -			master->dummy_tx =3D tmp;
> -			memset(tmp, 0, max_tx);
> +			if (max_tx > PAGE_SIZE) {
> +				tmp_tx =3D krealloc(master->dummy_tx, max_tx,
> +						  GFP_KERNEL | GFP_DMA);
> +				if (!tmp_tx)
> +					return -ENOMEM;
> +				master->dummy_tx =3D tmp_tx;
> +				memset(tmp_tx, 0, max_tx);
> +			} else {
> +				tmp_tx =3D master->page_tx;
> +			}

This idea is fine but should be a separate patch.

I'd expect it should be about as cheap to change the realloc to be the
max of max_tx and PAGE_SIZE (the code was written on the basis that we'd
basically get that behaviour from the allocator anyway most of the
time though IIRC it will work in chunks smaller than a page) but this
does save us the memset() on the transmit path which is handy.

--frrXvU3mT8dlRds5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVWzCoAAoJECTWi3JdVIfQ/r4H/0D23g88WxBNHVE+IPficUki
hKBVatrs7oUfTdptHv7UZkVU0usx8NfQLY6wHyQ3tgb5xhQnrA32FZepy9uDXfoW
a2Zh+6TTmQAdPjZBw7muCBfvlOWsNHRl4xEzaV5vUlBM9hgiVGgANnz6PKrlshbK
4/bS7q/pSmT0LCnlzC9+dR1QzouylvwURE+H8ohJhO91YQRfCwAL1pK5512GkQ0d
9oYiHaaoHqwljvTfKGbe08Jrx1EQSZQYqlQZNlqWItuSc4ccg5w/va1fluiWuCPO
YL7WdssiSbe+xmaJpfvL/b8j9VBc3sjFKbbVLHZypoY+5G6+TN0VPNvf/b5DMFw=
=XLUx
-----END PGP SIGNATURE-----

--frrXvU3mT8dlRds5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
