From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/3] spi: allocate spi_board_info entries one by one
Date: Tue, 28 Feb 2017 09:16:50 +0000
Message-ID: <20170228091650.eiypppxblfhh33pb@sirena.org.uk>
References: <20170228041857.13292-1-dmitry.torokhov@gmail.com>
 <20170228041857.13292-3-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qa7cbgdit6d63urd"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170228041857.13292-3-dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qa7cbgdit6d63urd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 27, 2017 at 08:18:56PM -0800, Dmitry Torokhov wrote:
> Lists of spi_board_info entries registered with spi_register_board_info()
> can be quite long; instead of forcing memory allocator find contagious

Do you have numbers on that?

--qa7cbgdit6d63urd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli1QAEACgkQJNaLcl1U
h9Drswf/aYo6ILH0OTZNi3IC2B6aq4R4QS/AwPwFZ3OT39unjv8Z+wZNQkEfDXBC
JJSjoKjXwK+fliWVdeD7oIfQi6QKVKvofHo9DakZQH382wY3wiI0yPIKk4jhxW0O
ca8fJrZqrtjN8wp51Zs2fSNkfPwBnBu/SB+4iJWrAO+2qr8h3ds5876z6CUlhdfT
Jcheao28HkFksW4o5yReZGtlCtl1y0mVIbGzG4RimCuOQbbV2Tv1mQDmfw9nWVDO
cOOzvPx6D+MwbvEvK6pIUotlPHhn25O9XQMGXlqH2FHvQ4qzlhjwjeWNFrfBLIlY
hIsAB9C4rGRdY8RHtw7eMSBxRaTBrQ==
=/uGs
-----END PGP SIGNATURE-----

--qa7cbgdit6d63urd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
