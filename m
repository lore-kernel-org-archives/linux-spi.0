From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: add initial set of spi_transfer transformation
 methods
Date: Tue, 1 Dec 2015 21:29:29 +0000
Message-ID: <20151201212929.GV1929@sirena.org.uk>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org>
 <1448888695-2260-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ecnwpyCrI1qOzEAD"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448888695-2260-3-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ecnwpyCrI1qOzEAD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 01:04:53PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> added the following spi_transformation methods:
> * spi_split_transfers_first_page_len_not_aligned -
>   this splits spi_transfers that are not aligned on rx_buf/tx_buf
>   this will create 2 or 3 transfers, where the first 1/2 transfers are
>   just there to allow the last transfer to be fully aligned. These first
>   transfers will have a length less than alignment.
> * spi_split_transfers_maxsize
>   this splits the spi_transfer into multiple independent spi_transfers
>   all of which will be of size max_size or smaller.

Please split this up for review, as I'm fairly sure has been discussed
before smaller, more focused patches with clear changelogs describing
what they are suppose to do are much easier to review.  Start by adding
the framework changes, then add one transformation at once.  This is a
very big patch full of fiddly, unexplained code.

> To start these shall get used by the individual drivers in prepare_messag=
e,
> but some may get moved into spi-core with the correct parametrization in
> spi_master.

As discussed I'm not a big fan of this approach.

> +/* the spi_resource structure used */
> +struct spi_res_replaced_transfers {
> +	spi_res_release_t release;
> +	struct list_head replaced_transfers;
> +	int inserted;
> +	struct spi_transfer xfers[];
> +};

This quite clearly isn't a struct spi_resource, nor does it contain
one...

> +static void __spi_split_transfers_fixup_transfer_addr_and_len(
> +	struct spi_transfer *xfer, int count, int shift)
> +{
> +	int i;
> +
> +	/* fix up transfer length */
> +	xfer[0].len =3D shift;
> +
> +	/* shift all the addresses arround */
> +	for (i =3D 1; i < count; i++) {
> +		xfer[i].len -=3D shift;
> +		xfer[i].tx_buf +=3D xfer[i].tx_buf ? shift : 0;
> +		xfer[i].rx_buf +=3D xfer[i].rx_buf ? shift : 0;
> +		xfer[i].tx_dma +=3D xfer[i].tx_dma ? shift : 0;
> +		xfer[i].rx_dma +=3D xfer[i].rx_dma ? shift : 0;
> +	}
> +}

It's really not clear what this is supposed to do.  Among other things
"shift" appears to be misnamed and anything using tx_dma and rx_dma is
worrying.

I did read a bit further but like I said at the top this is a lot of
complicated code that's not split up enough to be clear.

--ecnwpyCrI1qOzEAD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXhE5AAoJECTWi3JdVIfQYTUH/1RoKSfBPCYyvPr0uNXq8VDX
Qu08TTf5aB3lc8JR4YK6yWBAUaSb4i0p9FVxzOmiNiwgUgcVHj7Ohq2sF8O4ga4+
ejAzrIM+a8F+SyCMTnI8GnAZKukU0NPytbTfCYJrfyHIo3dU9gsVUSulyfJskZ6D
zcUdoQequWstOVb0hLVl39keU9mgdKKnjoz3C0/FIgpm9x5vorV1KgVgSfJVyk/U
mAf23QwHqR47Sg5vT51HAAjy8YoipfWGNclgrXjN15yXWwq5jrhucD3ZflAFOj2l
kaCyZN+567OXnGks9hCc0eZgEZt8+vEnHR1XVR0VsSR4AeU1NXuoF8VNn7xDYbM=
=Hl78
-----END PGP SIGNATURE-----

--ecnwpyCrI1qOzEAD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
