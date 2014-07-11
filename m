From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: core: Fix check for dma_map_sg() failures
Date: Fri, 11 Jul 2014 13:57:27 +0100
Message-ID: <20140711125727.GO30458@sirena.org.uk>
References: <1404998973-19425-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8YDLdOu/DaKXZo9W"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404998973-19425-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8YDLdOu/DaKXZo9W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2014 at 03:29:32PM +0200, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>=20
> According to Documentation/DMA-API.txt, dma_map_sg() returns 0 on failure.
> As spi_map_buf() returns an error code, convert zero into -ENOMEM.
> Keep the existing check for negative numbers just in case.

Applied both, thanks.

--8YDLdOu/DaKXZo9W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTv980AAoJELSic+t+oim9sYwQAJDgKENYtsvRI454BTuk3XEV
pX/GLnxBrRuoFA9prhYrkVRvu7maaCb7WrvEVBLVi+Utvgaes9r7LERIVtDpvbzk
3mYMbcArcRuE5iJLIErEM4zV6YNhSTKjUDVH46hoYC/8O6VVkEl/7Mv+0iU86hLw
C7t1FhUOJs+negEOqhNy/89icy6uBt+MiMh2/GbvzUNcYJhKmFFDunYB2MuCOyAM
abXE4JIpvsmLrmvehllqUqj8sesaYX3o36Pwr2/6vaQBowjB9gLA7CkMNzBnaeCT
GxFKU9pjzIwS52uRf2dPbkv62ywDg57as4HQGcLiM9h1vWO0el2uDru3amm6bGXL
IoQ2giD9+kq1mPuPT+A/v/DRFfznuVB9lVGHt38Nyv3nuTSo18GF2AjQwVFd0uuf
Dxchf/y0VKZNyEeg+lQbG/APjWTtVLA809G2q6/cz3k9Qlas2OTqV3/CFZUKhlAM
yFgV3U0taP5VUWMN7wYwn967mp/Q5FXzblOUdoAJnwjmcoK5IRfqhNP2a7tmvO2j
14K5PLLXuoNKXYRVKPTk+q+d56pzk7hRcMHYC/7cJ0YYbeGUoqt0cE2MPrytuBPL
VjOjuneDITMZlXpwwpEgNHOACgCQ9idmi4JNYXiJ9DKeZRH7R3XTOQJesSFae3Or
ATWefCuGYb/+7TOYnLgP
=XEK9
-----END PGP SIGNATURE-----

--8YDLdOu/DaKXZo9W--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
