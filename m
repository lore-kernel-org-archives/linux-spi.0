From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: clps711x: Use devm_gpio_request()
Date: Fri, 10 Jan 2014 13:27:37 +0000
Message-ID: <20140110132737.GN29039@sirena.org.uk>
References: <1389358925-466-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p1Od3smaOkJqivj4"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389358925-466-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--p1Od3smaOkJqivj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 10, 2014 at 05:02:05PM +0400, Alexander Shiyan wrote:
> This patch replaces gpio_request() with devm_ API.
> As a result this simplifies error path and eliminates "remove"
> function.

Applied, thanks.

--p1Od3smaOkJqivj4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSz/VGAAoJELSic+t+oim99usP/2hpb1nowlBz0BGgKp33b79v
dm6Wjgfess4/WeHHn6oZ06+kZFuvK/oiod0ZKaCmzI0vA0XNEd6SEQADW0ypaO30
Nw3lh02ylmOnzktauHcY0kP+9drFnOvzMFuERxss3pPkCOXZBSfUj5Bdk4r3454O
vqLENn7jf8iwOk0iWr+SGj3TAZ1YWXTH1rnyToxjlmsTURk4p1PTx8pgn9GHbi6q
7HVqu7rcNIuokgyX/IxOum3ku4JU1lyq/l52AgbjqGB/Pu+fN3ylq5quUad9gvuU
bnvscSVFKGQuIvVlbSaAsbas3Dbr+2U1QSAfSKGO0m8Fm75adQEQtzgMZ5NVPH90
HNWG1T6dsr4TWgF0R42e7a0upzcOZObvAdrHmXhYBHl533MmxOvDc3elGfex7Caf
TSnxY01VDqRpwji/v3PGr5BVpBG26MNTYVbRVBnaBc7rGGQK69cz5VIOH9JPZrw6
1gEP3KMlz75B/Rze8uecmbI6VXCZyoiXGtQdKtH9S2StzBK+2t500jw1cdRsypL9
PfxNnnmlZx/z6STsaXoxklQKPZ4sFO/i9QAWRfFDavw9VagxxXn4FfGlQUukc0be
GhYPzrVwOmBurB5ht9hunNt8oX0Yd7757JK4zahpcOzU83TyLmKIQzvZxPg0OFQV
J3kYqz8RkF6CRw9K6ROt
=zyD9
-----END PGP SIGNATURE-----

--p1Od3smaOkJqivj4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
