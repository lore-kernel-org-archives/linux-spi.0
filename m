From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V3] spi: sun4i: disable clocks in the remove function
Date: Thu, 7 Dec 2017 10:18:47 +0100
Message-ID: <20171207091847.rf76dol6iqcfeomr@flea.lan>
References: <20171206152005.yfbyylu6tbe5gnnv@flea.lan>
 <1512631227-27334-1-git-send-email-takuo.koguchi.sw@hitachi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ndm6iijuv74uzg3v"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khoroshilov-ufN2psIa012HXe+LvDLADg@public.gmane.org,
        takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Takuo Koguchi <takuo.koguchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1512631227-27334-1-git-send-email-takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ndm6iijuv74uzg3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 07, 2017 at 04:20:14PM +0900, Takuo Koguchi wrote:
> mclk and hclk need to be disabled. Since pm_runtime_disable does
> not disable the clocks, use pm_runtime_force_suspend instead.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Takuo Koguchi <takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ndm6iijuv74uzg3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlopB3MACgkQ0rTAlCFN
r3SFuA//eCEZdN9jbaMftCBmzcFq8MFBDRAAIojv1OVchrVfPtJiPC2TSJS+TCgv
tioughQ6X96UkFJr7hQjO6KGK8NxaH6cHbUPQ+TwK4iN1Y0p/oibBx6xIl/b7sW2
Sl/e8g6XWN4jGNz9JgfFyCgGQhI8efQUQKn0qxUWixs/OCjymDxMfLzgN45wCRNj
yDH3ueM/qtuVz72dt0VOgJ0dgrf1u+s8uKRESQnQ4xBn3g6hcR7oRApAmF68102C
bOdlXXeDiQZ9n8TPRayrgy9N1wDc4l6kawWzu63hbIyNw/j8BEhFUMW+HiyveTOn
zDlr3BAtpxSHdkwRXpV5PqxOypTbwu7bI1k1w0RJ8Vm6Fliewk4+UyoXPoNQOIw9
8NXs1YgimXvnWQ9IKpsfWt935Sx2iUe12uSXIbkKFXfklPOcJTCm5cmfcytnTOaV
3IkHQnxekZVdguJ7c9LyJak8c28pq2BbTi3YRIe/ZiYh2vyfQsWrudvydNk5BFnH
SDgdRg+uUmBOc8aLbJYZgkhePmHG3GqypQm329HgZZD0bFqg/NbZKtRP2ifvdjfm
QWM9Fz171dD/gSMPkj3PcZ1ZeEa3A3yvSjTyIGdCkLX97wcqlqYM8h5VgjFAdjzT
0mxLavG4mFWSqtQ+YTfuFRLMjaIW9b54oFtF95iBnIUNMRLN/pA=
=Ilyd
-----END PGP SIGNATURE-----

--ndm6iijuv74uzg3v--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
