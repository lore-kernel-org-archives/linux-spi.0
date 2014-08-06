From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/12] spi: sh-msiof: Configure DMA slave bus width
Date: Wed, 6 Aug 2014 21:36:23 +0100
Message-ID: <20140806203623.GW17528@sirena.org.uk>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
 <1407329949-5695-8-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kJlOB0td3EGXEEtS"
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407329949-5695-8-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kJlOB0td3EGXEEtS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2014 at 02:59:04PM +0200, Geert Uytterhoeven wrote:
> The new Renesas R-Car Gen2 DMA Controller driver (rcar-dmac) requires
> explicit configuration of the DMA slave bus width.
> Hardcode the DMA transfer size to 4 bytes, as MSIOF DMA is limited to
> 32-bit words.

Applied, thanks.

--kJlOB0td3EGXEEtS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT4pHEAAoJELSic+t+oim9VMoP/1EgrIQwtywULQg02bazBtOY
OllfIauTXe1qr49RfFRr1elpp5G6/vlGb+0gQytNXajCJWXXOg9iaSBNESYkpawX
XXXK65GJi88BKRtUHjmTpaFJpteWz2ZpaBWP0oAeY/Tpm4Q6l1p1x6ZktldS6NM3
EC7uBWqxbRbcBS7eJZ3TtlZsjFFmsq9GUqEH966V3KS583T3w/VwNZgDPVjDgsLm
EHH9zb3EzbyjXZWF8pfC34Gt8b6Bn/prm4kkgtLfWxEJfHF+SbAmXDO5zJZuHqee
ynZ9oYGKyj8iLaNsfA9lkSsv+GTwcSxlQNUeaOORxB2u1rX/95Q/Pzz8PTa/fZEP
P3rxx3pr8psSXim2LN01q1oPIgvzKau/jA3M4eyOWQgOlBa0Dxo6piyqQW7PR7zp
XT8yUqaQMXa2mjptFD+A0idDTy3X9RVTE1ujFhFXk/BVQey1cKxxfH4gomdksYwL
L1So+jd1T9W4sbzBVUfjVZKCI0oV7bbjZ5mtDH5TAzjXwPcvDx0yiGU9BLmgn6uT
2WHkblSY+2gqoz7g5FGXQkAi2M4oqlSKgq1DjUfFgdk0dszi+cG8lfEQlGaVcl+x
PPkjfSCJlyZPKQo1Iygd8m8i8611Mjo4J7qtfjDmsbpoxTA+wJ1XzbgtI2wS0PUR
ftmcVSRsiuXFebAac7bW
=+Yjb
-----END PGP SIGNATURE-----

--kJlOB0td3EGXEEtS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
