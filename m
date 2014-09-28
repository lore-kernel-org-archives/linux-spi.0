From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi:fsl-dspi:add dspi tcfq mode transfer support
Date: Sun, 28 Sep 2014 12:19:56 +0100
Message-ID: <20140928111956.GW27755@sirena.org.uk>
References: <1411640665-20671-1-git-send-email-b44548@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gkEBo/XPSfx+3zOU"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, R64188-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411640665-20671-1-git-send-email-b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gkEBo/XPSfx+3zOU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 06:24:23PM +0800, Chao Fu wrote:

> Remove bitbang:
> Add tcf funtions, DSPI module need get cs change information in a spi tra=
nsfer.
> According cs change, DSPI will give last data the right flag. Bitbang pro=
vide
> cs change behind the last data in a transfer. So DSPI can not deal the la=
st data in
> every transfer properly, so remove the bitbang in the driver.
>
> Merge duplicate code:
> 	dspi_data_from_popr
> 	dspi_data_to_pushr
>=20
> Remove clk reference in regmap I/O:
> Set the clk parament is NULL in devm_regmap_init_mmio_clk, it will avoid =
clk handle
> in every register read/write, and advance tranferring efficiency.

Like Shawn says this is three separate changes so should be three
separate patchess.

--gkEBo/XPSfx+3zOU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJ+7bAAoJECTWi3JdVIfQ1bgH/0alzT6wexVYSsElhjTvrS/h
62WnrFFF/Gcx8sT2DTPPDDIAVWcJX1656Svn1ewqxod0gBXUMcp/zxXJQXEVsTao
icXkeUQ2gUmuErcI1LNrUin41CL1n5P5PHd2NJ1sl0ikQOEwyxetaig3BDu0xQGP
Oaks4js/7CdziFwMlGyG49XxEFsAqlsh92SKbYj65HwsglIzCqOzpZucFWPzJxVv
8FYoOYYzbSKZbrWIn9sGOSUzUD03EtMDmosIfdMs3Rm2YTSjzG+69wFMvYcAhf2X
ZdsOrbmPlz4d4fEMDkiWlQ/SFCRyhyysfrtLt2WAxhqTumlBdHgtFsNoXDI6UHQ=
=7f0l
-----END PGP SIGNATURE-----

--gkEBo/XPSfx+3zOU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
