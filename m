From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/15] spi: img-spfi: Implement dual and quad mode
Date: Mon, 30 Jul 2018 16:30:34 +0100
Message-ID: <20180730153034.GM5789@sirena.org.uk>
References: <20180722212010.3979-1-afaerber@suse.de>
 <20180722212010.3979-11-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="um2V5WpqCyd73IVb"
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        linux-spi@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180722212010.3979-11-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--um2V5WpqCyd73IVb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2018 at 11:20:05PM +0200, Andreas F=E4rber wrote:

>  #define SPFI_CONTROL_GET_DMA			BIT(9)
> -#define SPFI_CONTROL_SE			BIT(8)
> +#define SPFI_CONTROL_SE				BIT(8)
> +#define SPFI_CONTROL_TX_RX			BIT(1)

Random reindent of _SE there?

> +			/*
> +			 * Disable SPFI for it not to interfere with
> +			 * pending transactions
> +			 */
> +			spfi_writel(spfi, spfi_readl(spfi, SPFI_CONTROL)
> +			& ~SPFI_CONTROL_SPFI_EN, SPFI_CONTROL);
>  			return 0;

The indentation on the second line of the write is very confusing, it
should be indented relative to the first line.

> +	if (!list_is_last(&xfer->transfer_list, &master->cur_msg->transfers) &&
> +		/*
> +		 * For duplex mode (both the tx and rx buffers are !NULL) the
> +		 * CMD, ADDR, and DUMMY byte parts of the transaction register
> +		 * should always be 0 and therefore the pending transfer
> +		 * technique cannot be used.
> +		 */
> +		(xfer->tx_buf) && (!xfer->rx_buf) &&
> +		(xfer->len <=3D SPFI_DATA_REQUEST_MAX_SIZE) && !is_pending) {
> +		transact =3D (1 & SPFI_TRANSACTION_CMD_MASK) <<

This is again *really* hard to read - having the comment in the middle
of the condidional for the if statement, then indenting the code within
the if statement to the same depth is just super confusing. =20

--um2V5WpqCyd73IVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltfLxkACgkQJNaLcl1U
h9CRZAf+LLcEEOfRSAY1EH5vz7zDOEnw4gK30aibUvhN9OgRdg3m5MfBShffYGNq
M7zScjBY9bHhcsyEYdyU8NCPHYEq/VvmpLf+59mekYYcxZ/LxUs92fKF8XV+yMZ2
b4F0Mczv2DL08wsoeYGoTWioZ+of4nuDgiCm4KAUTHcrZqtUIvj1l5YDDJuyMPQb
kObK5Ek6i+FZRkq+71IT82fHZbHt01BhGca7CfQWIgxuHvbyCudAyYjMMpPLmcxs
JVebbmM9Bas6Eqp3FtVLVu5d3Oy1Ut/sq7OqDgWv0QmLMirZ9e31Wkzcl5cfoUQl
Z65uarkrVQVcxYQt2IHLluaik6StCQ==
=o2Zn
-----END PGP SIGNATURE-----

--um2V5WpqCyd73IVb--
