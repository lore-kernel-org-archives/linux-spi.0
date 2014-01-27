From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: tegra114: Use list_is_last() instead of open-coded
Date: Mon, 27 Jan 2014 20:29:30 +0000
Message-ID: <20140127202930.GU11841@sirena.org.uk>
References: <1389766024.7410.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DQyH/uhjXcCb0idi"
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389766024.7410.4.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DQyH/uhjXcCb0idi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2014 at 02:07:04PM +0800, Axel Lin wrote:
> For better readability, and then we can remove the comment for last transfer.

Applied, thanks.

--DQyH/uhjXcCb0idi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5sGnAAoJELSic+t+oim97cMP/186lsnkYPCy/gzm65+VqrEr
EfUrh1r3oH1oASYZ1m+EDc+3n/KhYleg6mjDoxhs+3DqX1d92cN/5UgVXVbuDDjY
1n0FuLmYiVlDwPHYoCoGeM5xPCGZNCsDNuOVoGFneQGT/cy2qQPx8mJjMSes2G1z
2LCaha1cavgLKYDkzGNnXtXnEgPv7BmCtNdRc2m+bxnEDho63kUTifnkmO6ea7kR
cs99lW4XA7ZHeqjxPodAdI7W5NGex6dnxFAflcPz90yeSDmi10YhrRJvEcvaRcEh
eGGzhqfF+c0T0IhwssVzXZnb+edqxcuxthPlymnffDgFF80jnty3/3hm1gIA0NNn
dGNGyT4cyczPjMm31jZIup0UFUpTtcDFzXrZerzp7dHmOyQHw0ICnPOzPq0R0ahr
jFQjnDGBAqRXISrZL4d8OOmTR2A+8jcHkNERmzGuUck6X0/hxqinbnQpR6/lU2Ip
6qfOvAdq9o5hHFW7BxMt79nWUwyBygO/Ur+Fj06fvunOaGyQN1el1DjtMOZU743g
Nafj7X1RxIjf9Qdqk/ZJ5AvgnMLD9BBlaJdbJR13bGnmjC0PMw1SZq+Kz7kKpc3j
2JebMd7h3vhIprPbZ5AYohPVtHlmf7mJ+aPahxnVdYx5xE4RAJQHZZx+k66xdUpg
tPx/G76zjkEq1a1IPeFL
=nvuq
-----END PGP SIGNATURE-----

--DQyH/uhjXcCb0idi--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
