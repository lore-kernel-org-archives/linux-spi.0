From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/1 resend] spi: Using Trigger number to
 transmit/receive data
Date: Tue, 14 Oct 2014 14:08:30 +0200
Message-ID: <20141014120830.GS27755@sirena.org.uk>
References: <1413248264-3685-1-git-send-email-cm-hiep@jinso.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z5R++VQVird/TDtY"
Cc: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
	ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413248264-3685-1-git-send-email-cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Z5R++VQVird/TDtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2014 at 09:57:43AM +0900, Cao Minh Hiep wrote:
> From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
>=20
> Hi Geert,
>=20
> Here is the verion 2 of the QSPI patch, I have added the DMA support on i=
t.
> In order to use DMA When the DMA is available.=20
> This patch supports for r8a7790 SOC and developed base on the upstream-v3=
=2E17-rc7
> and have tested on the Lager board.
> Please review it when you have time!

You appear to be resending this about a week after the last send -
please don't do that, you should allow longer for review.

--Z5R++VQVird/TDtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUPRI6AAoJECTWi3JdVIfQndgH+gMGleTnyVSMWwqykBuRaoRz
aua1DJlLxB8f3l9Eqssd/o5up4MSNaS87NRziPIkaPU2Hx+4zYMBh7qNGmu+QFKv
Mozp9IGS2/wKu7I4eDXza4Sz6WrFustvXm0/0diVnrqsMbH3vblUP8y2FtYUgmYu
YWqdQ6IEdUmKMa8X3vB3i9hq4imwGco4we3/gi3rIV3UPxlZZvgB6XP9Rd0fQzMD
G+FHiTvEMDtPnN85uAx0tf4O621H6ZFtD7db9GQ1CkPh1IAX07rxXkFPAU50MeH2
a8yshRn9yusovBxfRciQGNWjK3otCCsiI3PgaUt5ufX8LCDquVjHxNTqlCu7jSc=
=9/dq
-----END PGP SIGNATURE-----

--Z5R++VQVird/TDtY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
