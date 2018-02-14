From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion: Rework GPIO CS handling
Date: Wed, 14 Feb 2018 16:26:37 +0000
Message-ID: <20180214162637.GH12658@sirena.org.uk>
References: <CAMuHMdUaLV522qihJibmTO1NR6NK0DNjMT8soGvLsi=ffGg71A@mail.gmail.com>
 <92369661c99f83e656004288fcc06a510b4b8c58.1517007569.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
To: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <92369661c99f83e656004288fcc06a510b4b8c58.1517007569.git.jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2018 at 11:56:10PM +0100, Jan Kundr=E1t wrote:

> +			if (status) {
> +				dev_err(&pdev->dev,
> +					"Can't request GPIO for CS %d\n",
> +					master->cs_gpios[i]);
> +				goto out_rel_master;
> +			}
> +			if (spi->unused_hw_gpio =3D=3D -1) {
> +				dev_info(&pdev->dev,
> +					"Selected unused HW CS#%d "
> +					"for any GPIO CSes\n", i);

Don't split log messages over multiple lines, it gets in the way of
anyone searching for them in the code.  Please send a followup patch
fixing this.

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqEYzwACgkQJNaLcl1U
h9AarAf/VTu5T+3t76RxTdhU2LwPOgr7niAanv80+2gNxiFLYXhAm5uI8KxftocH
EzGhaXEnuIrNGEFsKhv4YNyhjkQsk4hihHuME/fAwBcnAImhz2sIOmSYsmgGHL4S
yXyLG6DgKeb08hkwCgV8saUyjSLeUjTQIssEVtdgGFo8IME6h7FOmNPnTr7NKQiX
eD2XfBwUZRpoeo3x4xyLJGpcaZg80DhaCmZc1wzDfe66WXBWuP5N2V9X8YxNRwbL
f1ZoPoJ+Z4iN9Ee+Dzaj6hyY7k1u2mvVXl+ezaczce+kjw8tVc5z5EBM7ndxrMcM
sIIWun42XhaoUQ8jYNmvEHvicnI/Nw==
=YbPa
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
