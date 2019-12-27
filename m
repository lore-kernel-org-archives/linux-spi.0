From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: dw: use "smp_mb()" to avoid sending spi data error
Date: Fri, 27 Dec 2019 00:22:40 +0000
Message-ID: <20191227002239.GH27497@sirena.org.uk>
References: <1577352088-35856-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U3BNvdZEnlJXqmh+"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, fengsheng <fengsheng5@huawei.com>
To: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1577352088-35856-1-git-send-email-kong.kongxinwei@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2019 at 05:21:28PM +0800, Xinwei Kong wrote:
> this patch will add memory barrier to ensure this "struct dw_spi *dws"
> to complete data setting before enabling this SPI hardware interrupt.
> eg:
> it will fix to this following low possibility error in testing environment
> which using SPI control to connect TPM Modules

> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -288,6 +288,8 @@ static int dw_spi_transfer_one(struct spi_controller =
*master,
>  	dws->rx_end =3D dws->rx + transfer->len;
>  	dws->len =3D transfer->len;
> =20
> +	smp_mb();
> +
>  	spi_enable_chip(dws, 0);

I'd be much more comfortable here if I understood what this was
supposed to be syncing - what exactly gets flushed here and why
is a memory barrier enough to ensure it's synced?  A comment in
the code would be especially good so anyone modifying the code
understands this in future.

--U3BNvdZEnlJXqmh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4FTs8ACgkQJNaLcl1U
h9C/WQf+LWz7dH90awV46vXCMPAFHsxgAk2e4Cef1PIjV2AqD5tpjkaJCKTPaO9r
RZG3L+gFrMzq2VUYQoeENjQqFg1wJsK+yaU/1jPCsdypAX2rb1shLZAClxic0uDG
JjtToZii33DOzReaNdi0pH3yGkGgekgDWwfQkC/QCpUt/jHsSSI0qpEOHYhsOy8h
ig9uUTFMMXqV2zNqwfjwu/JFFieJS0v8oVcx1MdYhPoSvUArIAoGq9VTekrRMzcm
VfSpwRNpVIvK3aiWlesqhkYPd8QGaAwCNBgM+8OO83mkORSQU+PQbvlCE62Tp4ND
ZWFeeiOPOwN9q9DP1SfDItYPTebcQg==
=ZE9Q
-----END PGP SIGNATURE-----

--U3BNvdZEnlJXqmh+--
