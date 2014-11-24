From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: spi-mxs: Fix mapping from vmalloc-ed buffer to
 scatter list
Date: Mon, 24 Nov 2014 18:58:17 +0000
Message-ID: <20141124185817.GG7712@sirena.org.uk>
References: <1416215672-31554-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1416215672-31554-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x9uCfsizvaabZDbV"
Cc: marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416215672-31554-2-git-send-email-ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--x9uCfsizvaabZDbV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 17, 2014 at 09:14:32AM +0000, Charles Keepax wrote:
> We can only use page_address on memory that has been mapped using kmap,
> when the buffer passed to the SPI has been allocated by vmalloc the page
> has not necessarily been mapped through kmap. This means sometimes

Applied, thanks.

--x9uCfsizvaabZDbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3/IAAoJECTWi3JdVIfQ8KgH/1dRDIJwu/Tc8QPJKRbMRA5g
qY+aIo5+ZJAYKd8SX92ypHG3fQKVOpcHeEAYIom1iaPLm8gf+x+jNLkhW+DfIo0A
0mYvPwFQUhSbE83y+rTRu5oXQJy9u88vtSu/EDynzEoUB3ieok4JZUPKtr0h5wf3
EQCDJ5xHZzeZYLFi4w6393aPakR0u6ZxAjGRUExpb1/KEkOoi1kS29sF1E8TcnW9
6ZeeUXKEx/0qiLNUPwcLZgp/XTOHQAbO5RjO88zm9PZyuYPGlpRsRhJ5Wwui9pRh
HTFhfGuLuBQNsfF93XDQCP6Cff2WGiFsAafsI00ZLMyKZiZvE0cNCkDnL98dfSw=
=Gu1B
-----END PGP SIGNATURE-----

--x9uCfsizvaabZDbV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
