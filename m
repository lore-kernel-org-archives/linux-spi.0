From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: sun4i: disable clocks in the remove function
Date: Wed, 6 Dec 2017 16:20:05 +0100
Message-ID: <20171206152005.yfbyylu6tbe5gnnv@flea.lan>
References: <1512573752-13091-1-git-send-email-takuo.koguchi.sw@hitachi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2mew5oj6s7agwvco"
Cc: lkml-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khoroshilov-ufN2psIa012HXe+LvDLADg@public.gmane.org,
        takuo.koguchi.sw-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        Takuo Koguchi <takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takuo Koguchi <takuo.koguchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1512573752-13091-1-git-send-email-takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2mew5oj6s7agwvco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 07, 2017 at 12:22:13AM +0900, Takuo Koguchi wrote:
> mclk and hclk need to be disabled explicitly since pm_runtime_disable does
> not disable the clocks.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Takuo Koguchi <takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/spi/spi-sun4i.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index c5cd635..9011c09 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -525,6 +525,11 @@ static int sun4i_spi_probe(struct platform_device *p=
dev)
> =20
>  static int sun4i_spi_remove(struct platform_device *pdev)
>  {
> +	struct spi_master *master =3D dev_get_drvdata(&pdev->dev);
> +	struct sun4i_spi *sspi =3D spi_master_get_devdata(master);
> +
> +	clk_disable_unprepare(sspi->mclk);
> +	clk_disable_unprepare(sspi->hclk);

And that will in turn create an unbalanced disable call if suspend was
called before the remove, which is very likely.

Why are you not calling pm_runtime_force_suspend? How did you test
that patch?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2mew5oj6s7agwvco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlooCqEACgkQ0rTAlCFN
r3RZXg/+Oo/FkxttUws0+cpdLqc0PfnpADYFzwtpeYrsZ8bhfhOjKv9MRI+XRyYp
srVb52glmMZIPFHckuUe7aSav8xDbxpQ/zFgGmW7aYovJ3mcX5FX9D2AqxvSGde4
7weBb0PjXBVlVBChy0jRgxsES5udi1iPELBd+2AekNPAgv5OGbGr18bJ4lc1PThq
8oLCXUI4mkeM2m+0Aw6ye5EestIseCAHFxLkfqaRfIjl9o6QA7APo+67PZCkXYCX
08xmXkXhL3UjBBvpSWqjqhrn92nJOMNiNW7TfNdJfCHFTZq7gTVrSQ92QaWHKOiU
SbaBX8GqpeQQTbuKyd5GqnnqRPXgiaPXrsCMtM5Ay9O1tSLtpVVwETLn5xpTikSL
mhzEbyK/Yj46dIP/eaQSe6gEqkzctOh2afW2nx8q+1qscX2oK441fKpRwuJA5h0i
ZyT+5/MfhM5fMhxDiYKwetfyYzaB8y5vgEepitDwYAcI9JEXYl5AK5BItWyKEgua
VE1INuW6/132pYMpPmtmzu+Ox7hTksOwMuxHSEoORG4g1P58ESyic/5jtUdtlGer
vUtjeOnWxlbthzZKlmLhTSl/Yd9jOVwk58dLNBpIhPGKtp6TyxWXMRfyFGIlCRIo
RnGaXphlF6lCvh70wM6XhRUDFjn14qLXFx2sRrjAcwA4wdi1WuE=
=8OV9
-----END PGP SIGNATURE-----

--2mew5oj6s7agwvco--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
