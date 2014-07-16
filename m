From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 trivial 3/6] spi: topcliff-pch: Update error messages
 for dmaengine_prep_slave_sg() API
Date: Wed, 16 Jul 2014 23:22:59 +0100
Message-ID: <20140716222259.GM17528@sirena.org.uk>
References: <1405095208-14642-1-git-send-email-geert+renesas@glider.be>
 <1405095208-14642-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a58rN+WbXIGauCK9"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405095208-14642-3-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--a58rN+WbXIGauCK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 11, 2014 at 06:13:25PM +0200, Geert Uytterhoeven wrote:
> Commit 16052827d98fbc13c31ebad560af4bd53e2b4dd5 ("dmaengine/dma_slave:
> introduce inline wrappers") changed the code to use the new API, but forgot
> to update the error messages.

Applied, thanks.

--a58rN+WbXIGauCK9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxvtAAAoJELSic+t+oim9dtQP/1U4t7TkGni1oHWiD95/Lu7L
LZYib4t9jwcvqOGLmFMBJNUI2Fhmg54yu1pOKhN/yLFyrBWccaVs7x78qOytd7LZ
sSVf8xirL3UCxYAJvuvpeM9ZYQnSIaLpzdr3y2hlagNzummKWSgS0zIlc5jCJmV1
qIL3yeePJNUG1KIkqbbrYkhWvIElkkba9PhMHdlC8xHuYcU7yNnoE0oBR/1NZNG9
zRVgbVc8LZU7hw+If0AxtkTtYX5/Mcuj18vWq6Rx//Na6N8900hLl2EZJUclFumR
ItVJEwapEVvyyYIi12HblDpBozuVUhbPs003QgGCy5Vpc6hvg7c5rYyBkQn28zWe
tEW7zwodmB5MCKMvYYJ0gr2LmoQ/J/2wQXfop2GHclN+/IPOM/nXRHjeHG0IBo6X
M3SYQ7BLCMuBG0o1Pc44HdvFevqTRqx3dMHdpQX8ZY7D+t6fRZJdKsc285YujQnX
SHBUVWwTlExx2IBXibaDtg+dBGRgiI3FyBWLg+v4u+5jGXUQSO5nzBgcDD1djuJE
2iObN1gq/tGsEWBUt7SSAOUkKK4n9BNwDfTCykiFRqGp3+CGNML/bJP216H+Upjd
cTQ7P8rBTkypFyBK9WqaP4JhsPOXqtI6hp4JeOkqMBnsSk7mO+kVWd4pz2ZbbvnZ
PNzMBKfpu9T34FszEGbp
=hfoY
-----END PGP SIGNATURE-----

--a58rN+WbXIGauCK9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
