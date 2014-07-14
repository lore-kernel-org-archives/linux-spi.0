From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 trivial 3/6] spi: topcliff-pch: Update error messages
 for dmaengine_prep_slave_sg() API
Date: Mon, 14 Jul 2014 18:23:55 +0100
Message-ID: <20140714172355.GA16531@sirena.org.uk>
References: <1405095208-14642-1-git-send-email-geert+renesas@glider.be>
 <1405095208-14642-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
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


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 11, 2014 at 06:13:25PM +0200, Geert Uytterhoeven wrote:
> Commit 16052827d98fbc13c31ebad560af4bd53e2b4dd5 ("dmaengine/dma_slave:
> introduce inline wrappers") changed the code to use the new API, but forgot
> to update the error messages.

I seem to be missing a lot of patches in this series and the cover
letter, what's going on with regard to dependencies and so on?

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxBIoAAoJELSic+t+oim9CwkQAIID5k7n/YReXQJ52QGpJH6Z
seMIbt6/DEKjpJeRd5UpP3Sn8ItIlX0EI/CeCT2OOQM064EoWawv6I9vR9yUIS3u
HdQSyXGyQ1BEP/DLX+0arvOm+Q8AZYxbKtLUQ5scHPTpMMwEOc7jfe+KOtgP8d+S
76Q07PrZu5qhf6U0E8KIUZbnNN+Gh4JY6ebj1vHd5eCxP987fDEcQdh0A4GxdoHV
GY3vBo1owffnIfpjePQnF3H6hEVg41O/FtSdrCgybdaGql1pI7vf3zj/ARi3/uan
io3AvKpAQU5unIFxS9JaWFBNRRqrvjXw0mzQnyVGuunCjI01vKqEjAbIz34Dn5/P
nl4PhkSzAFZMV1Yx09NFFFPpAJFsosG1PhZr+z/FoRtNqoSfepxtBzkaqwSxZiwL
MB02g1PngCk2h7/tXCZfXy1Ak2D8XvGiYk9gkzjdIGSa8hbviM1LJ+bleqDdV80s
OCkpXAK5ssM0NQxjNTPNK8tEnNGShXdyodM5hRcxxMGAjqImWo/h4/CKDr5c8nYl
KXG7sbGJJGrKD0f2PFPkctoxC/Eujns1sOh2GkxrhHAddxDPeGVNBprFCV0Q1ium
LfiTCMDi0Jcn+i9v0BAA+gB7OP8dPVj6z3qunmBHplaZzeDBu8TXmSiKLd6uFEkF
zFA8FjXXlOpklzN8U58r
=Dd7Q
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
