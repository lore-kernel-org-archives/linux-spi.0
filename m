From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sun4i: Set bits_per_word_mask to only support 8
 bits word length
Date: Tue, 4 Mar 2014 11:08:51 +0800
Message-ID: <20140304030851.GW2411@sirena.org.uk>
References: <1393770310.4044.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3vzEv62CJKAheONn"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393770310.4044.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3vzEv62CJKAheONn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2014 at 10:25:10PM +0800, Axel Lin wrote:
> This controller only supports 8 bits word length.
> Set bits_per_word_mask so spi core will reject transfers that attempt to use
> an unsupported bits_per_word value.

Applied, thanks.

--3vzEv62CJKAheONn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFUO/AAoJELSic+t+oim9LtIP/3AmXib9CWCN9Yacu1x5qcjQ
V/hInWpU6Xj2HYF3sHmJ8eEXuWJvkswW/5K8piXl6I3prjtf2XKyYQat4YLqoMJs
vh06nbsOAt+bQkFkbOjaUJQA3W/rapNMtFwCJoLQcTzBKH4C9MwjE3Ow0fo08FRr
XQjlmiZNTPIIgvyRaCv2MtojdnfbWO0NcurZUtQ+Rz54C7pP07wy5ykv0Z2HDl5C
6KcWYCBUXh2qQainlGcOBsaqygVy6Qm1CFUky+IoG/IkuwP0g48hUYfGJfEu2IhF
kkZgFw/xZvX3Kw3OMZZStS8mVS/tqYUv3YVpt1AFgXWdPi27NXEM4pdZc/aEI5X0
6dc2mOrTrOFiuJ0GIq2mdAdGqh7Wb8UD2SmCRUQ9BEfIiQaTSturNKQo6ucgzTvn
m6kgYb8RTaCsokd3lbipYJVAVcYQLEke/ULkS0ciC9SBXD5AoBSkTEN8HjNOfBJF
KOiQyCQa4EswWPwvHa6wyyuWjBIuMRuFgmN9McxNBrDlhQanoWVVQT08e1Ig9t74
DSFkbpvrt3Y991vWrZXuBb2XCcnY97p08V074Tz4LA5HNuMC3f1b2EYrRE52D/89
5vCdiFRWwzui5V1It1AsSJXRMBC4gUF24Ibw4VI4Kcx+SmLZytnFDxT3D6C6Z2E7
vlafM+kzphxpq+0g67+o
=oqNd
-----END PGP SIGNATURE-----

--3vzEv62CJKAheONn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
