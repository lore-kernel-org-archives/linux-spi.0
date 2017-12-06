From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [RFC] spi: sun6i: disable/unprepare clocks on remove
Date: Wed, 6 Dec 2017 16:20:56 +0100
Message-ID: <20171206152056.wzhoiphql322mvqw@flea.lan>
References: <20171206125028.fqzmy354tgf7afis@agrajag.zerfleddert.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wjvyauiwy4qwejyu"
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171206125028.fqzmy354tgf7afis@agrajag.zerfleddert.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--wjvyauiwy4qwejyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tobias,

On Wed, Dec 06, 2017 at 01:50:29PM +0100, Tobias Jordan wrote:
> sun6i_spi_probe() uses sun6i_spi_runtime_resume() to prepare/enable clock=
s,
> so sun6i_spi_remove() should use sun6i_spi_runtime_suspend() to
> disable/unprepare them.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Fixes: 3558fe900e8af spi: sunxi: Add Allwinner A31 SPI controller driver
> Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> ---
> This was found by LDV, and it looks very suspicious to me, but I'm not
> sure if the fix is that easy. Is suspend() called automatically when the
> driver is removed? If not, is it correct to unconditionally call
> suspend(), or should there be a check for the PM state instead?
>=20
>  drivers/spi/spi-sun6i.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index fb38234249a8..5e5df09e5d04 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -541,6 +541,7 @@ static int sun6i_spi_probe(struct platform_device *pd=
ev)
> =20
>  static int sun6i_spi_remove(struct platform_device *pdev)
>  {
> +	sun6i_spi_runtime_suspend(&pdev->dev);

Yeah, that's not ideal. The best solution would be to call
pm_runtime_force_suspend I guess.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--wjvyauiwy4qwejyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlooCtUACgkQ0rTAlCFN
r3QjYhAAj6c3hnU+aGnr+t9dqWcvvdJq6kaShYuLUPTdVg1d6wfip/lmzx1MJftq
WNhKmxrANKbsFfC7U//X/unUu6UrHOmreIUnf0tgFWmYDQl4Ai7ihswDu6DxQMnw
9COyki7n/fUc8JrDLlWNFurw7amnF/ExIJ1qgh5KM3wBQi0zr1+pD9G2ldmL5dG+
22WRrsj8eWRMdkV9IUxwKAJ9V+2J7xhJin/S+YgPfgoxIwimQEW/hTkTNAQNn6Mb
O65oA3XvJcMHL73CS7GgxaPPxZs3evMKXEz1Xa/VGLxGLg41e9A5R0zcJm/9V+Aw
lT6NVIPLolpjiBd09sNkKNSTRXKaDHx2Kjy2cU8s/OcLSrmXHM6UzKbojx6lQNe/
KbwV8G31sScOuvcO8u64QnYqavht31a0KpZ3EgBHCK8szjA4eu7tnDPOnX/bTnWO
PzWmq8CqFvCCNQdsyOiA+C6JxnqCeLGubOowkBqnl9vV+vZXsuGdpvSgvputsMsI
ILH+8QdTuoEpP3OcMHUr8mJQpUh/1PG/W8amcaEEccFSaYvR9Uz0UMDee3oiOOzx
TWTXxdpUnoCDsQwK2cYkV2IFi1fDtl89AzKYcquGvTgmvGNMBYUaSapsVxKHJ9Lz
tgTWGBdWjxS1RLkRIE6ZJNuhPXA2/fIPO9Vlb8inr/PrLyMXbM8=
=D4HU
-----END PGP SIGNATURE-----

--wjvyauiwy4qwejyu--
