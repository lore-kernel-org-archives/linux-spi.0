From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: nuc900: Cleanup spi-nuc900.h header
Date: Mon, 30 Dec 2013 12:46:37 +0000
Message-ID: <20131230124637.GW31886@sirena.org.uk>
References: <1388384802-32660-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s3puAW9DMBtS2ARW"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388384802-32660-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--s3puAW9DMBtS2ARW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 30, 2013 at 11:56:42AM +0530, Sachin Kamat wrote:
> Commit 54ecf4f05637 ("ARM: w90x900: move platform_data definitions")
> moved the file to the current location but forgot to remove the pointer
> to its previous location. Clean it up. While at it also change the header
> file protection macros appropriately.

Applied, thanks.

--s3puAW9DMBtS2ARW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwWspAAoJELSic+t+oim9vn0P/iXZ+mvLh5FtruX9Cg7zVLSd
0L3muGQ3B9sel3pX2PQXAQyKVUiKazAw7HEo/BvLlfSUhg6kGWZVM/hujJZC+GW6
3Aw4x1M82//jy7Yf+56V54Ms5qts7pRQSMESB5rMKOuisGqxbYLRsGND7sLxPcDH
+W9IbCoszt97KXh7gaHl2+6wf6oaugj2XtjHfSmlVee5FBqMYMJN0Bdjmwc2g7Pg
UbHr1b2BC8IBx3bnOlNif66HDlCm6zkuXAqVXVzBwhe+CDunxiOVicwkUE/hit5z
6rV17oDGso7Dl7yg87IfDnDUg5QGHocCa8R53NxZdzrYKVbuFC6/l7jrIzQSDeMn
5W2Med+uI3oMMBXULrlUFT2F6PmBlSJ7QCXBW/P1F95HB9LD2M5RWoqn7eN9TEi6
j1JPnTUVWSfIX5wkxGAH55ZwrXFiR2M2YePLroAtqqLBDk9KZCz7r9LKw0leFEX3
qRVmQtO8UsV5X5ZMBGDHbGe1Gpoe6/Nie0Kesrtpkf9K+3kMZyof+1mj8HIAiSpP
uXRHW4ZfQf9x+G6BVDmh47X6cj3srxcDOyZLvpkq66pbTF5Uchkfwo/EKnVEMLwJ
IeDu9kQB8QVQcJx1pVp+igDdAt6QSCo182cqVuo7Uu9BDzD7V30VQUAl1td28Woq
8Guh4HJvWHZBjiPA5xhj
=i6jt
-----END PGP SIGNATURE-----

--s3puAW9DMBtS2ARW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
