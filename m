From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/18] spi: rspi: SPI DMA core needs both RX and TX DMA
 to function
Date: Mon, 2 Jun 2014 15:42:21 +0100
Message-ID: <20140602144221.GI31751@sirena.org.uk>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
 <1401716301-29612-10-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gTY1JhLGodeuSBqf"
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401716301-29612-10-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gTY1JhLGodeuSBqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 02, 2014 at 03:38:11PM +0200, Geert Uytterhoeven wrote:
> The SPI DMA core framework needs both RX and TX DMA to function.  As a
> preparation for converting the driver to use this framework, fall back to
> PIO if no DMA channel or only one DMA channel is available.

> This affects only RSPI, which could do DMA transfers for TX-only before.
> RSPI-RZ and QSPI (at least for Single SPI Transfers) will need both RX and
> TX DMA anyway.

Hrm, was this error handling or is it a hardware limitation that it can
only do DMA in one direction?  Perhaps the core ought to be changed to
support that if it's a hardware limit, I honestly hadn't considered that
possibility when I wrote the code.

--gTY1JhLGodeuSBqf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjI1JAAoJELSic+t+oim9ApEQAIREHhmkb6Kvaamc+S02Wn8m
0WBlpcY6hb78iyhL0PEOgCY7sa0bBOQQKpHCFFbKILy7d2hp3vywpR5CqXRbiZb/
KlihOphwt0faEzQvbdPhhEGROJcMOb8aHwcWEIrPnzRSuAXlDVRKzdmgjWYCtoVN
wJSBY3tg7h5cBNTv+taNGUp3u55j8zm8FWPW6YZKvMTlcw1yLtZIyd4RQFzoV/cg
mnIdsB+/tKxzRgbRGCySDH2F2a9WsU4gq8MvjT/1zD3GDfVxLOnwkgOtuA4q94vK
MGveTYWnd4N0KNVtD/wfYHMeUonMTpQV+qablLmzdmOsOEYyKsO1I5xEp9iWC6qv
yQGYiO53UW9DEXveLlIVGf650UkNTaOSSraRxmoOEZb07yL2Ea8oY811QmUmf6B+
p44sOfeH+yxbRkLRyIsknZCFlo1VUC5e8F0H1GO+bJPs/TJJbC7b5J+kIWvgVKRX
MB306Qhi+2E1sI1R9lMIXGbaXhRVZzS6i4IXCM7FCOOrC9QedtZeVBzzP/8IdHZv
7mm1q7/iwIdIpWyr/8Oy9hY3YdXYQX8ueq3hu5UW2/tZf+CO8Dh1PRxpOMDGb++n
LxgXK4H9x7EViWcK2bFUuy7AVA4+n/P72I+dEjLRVGi7vAlx24SvJSmrxPNnLuwb
UCyCwKLS1xNmJgOWMSSC
=4ciu
-----END PGP SIGNATURE-----

--gTY1JhLGodeuSBqf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
