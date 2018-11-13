From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: lpspi: Add Slave Mode support for LPSPI
Date: Tue, 13 Nov 2018 10:55:53 -0800
Message-ID: <20181113185553.GH2089@sirena.org.uk>
References: <20181112064439.28584-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fd5uyaI9j6xoeUBo"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112064439.28584-1-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--fd5uyaI9j6xoeUBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2018 at 06:47:08AM +0000, Clark Wang wrote:

This looks fine so I'll apply it but it would have been easier to review
if it were split up a bit.  There's mechanical changes like:

> -static int lpspi_prepare_xfer_hardware(struct spi_master *master)
> +static int lpspi_prepare_xfer_hardware(struct spi_controller *controller)
>  {

...the conversion to controller...

> -	temp = fsl_lpspi->txfifosize >> 1 | (fsl_lpspi->rxfifosize >> 1) << 16;
> +	temp = fsl_lpspi->watermark >> 1 | (fsl_lpspi->watermark >> 1) << 16;

...and this renaming which could be done separately.

--fd5uyaI9j6xoeUBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrHjcACgkQJNaLcl1U
h9CqdAf/eJJqAdJUEK87WQhfD7sBXmFhKGThuhUcgwYKb7isdl1xkibKfN5kgCvk
N12GiRmAS1BogZ+hUXthwW/VbgaZNnD86ks3gFDVtDja+2/c2naA4OUcDYPq4ufu
WGFQc0aXkIh97n4FHBITKwvSGvzh5jjwb86lK5Vs2h3aZWACxYFql4Bt82uF1oQX
0jINrdAw3Fkw3X5pUt9Nrt0RfmhGvDy+ZoD6wHIHAb6rTEfqvI+C36VGU1uq8r7G
4jVzFrRqhhPJmgnLx6u07GrpjTkYBB4tNCqLetvCcDbELXOxl/meNkgyMbAfPVri
MwKKpxO283UBVUpaAH45YPgjaQbbWw==
=X2V7
-----END PGP SIGNATURE-----

--fd5uyaI9j6xoeUBo--
