From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: efm32: use $vendor,$device scheme for compatible
 string
Date: Tue, 25 Mar 2014 17:49:58 +0000
Message-ID: <20140325174957.GA2269@sirena.org.uk>
References: <1395756019-23989-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1395759110-10747-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZa61AII3s1sGKYx"
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395759110-10747-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YZa61AII3s1sGKYx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2014 at 03:51:50PM +0100, Uwe Kleine-K=F6nig wrote:
> Wolfgang Sang pointed out that "efm32,$device" is non-standard. So use the
> common scheme and prefix device with "efm32-". The old compatible string
> is left in place until arch/arm/boot/dts/efm32* is fixed.

Applied, thanks.

--YZa61AII3s1sGKYx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMcHCAAoJELSic+t+oim9nBEP/RGmSp/VhdzuelCApbAZWkCQ
Hh+EUHoOZ3VunuiSQAzwjxipgOqPRegXojz3U/x/8XARIWmbm7ymcyC4VMjeIvhU
VD77XjKSdmWDTLwe0mWNsYJrw+BibfHp4i60J8Cr/XjBZFqPSABBFnfaE6vKZvhp
R5DW3ghumQgCre865Djx9DLkuR6UY+keYvTBW9/uJBr9ZR18WED4wvhb4vYiHgIp
d9RzPkL7KY8jbfiBYxl+fHcV+7+rgjTb2s1JVxIXWDecKaeah6SbU0ehB18sorEd
1ziT5sb7zTk2G05CHu1KD01xQYbD/eP8iT+O4v81fFgCBy1yGvYUb+B+fjeI2J4e
7PmnPaqUkEbAZF94sLfTRZ9qgLv3wfuHo05YKJqsVpBrwrGqDWNC89VT/G3hrPj2
990bdbvLUlJ5qu6WRkztODIP3gjX+pcGEubyIfHPbavsW7ji9ofW3iNyriuE5Yxj
6Cx9Z9MXBkMUFQcFHf2+Jajp62/CAF6UA8SSsA2JkOkKOLdMws+QQVw99vStTx2N
KSOwXLspx7BpKtDgtzTfT2g9vBl3KxZMaVLzB9xY88WjTdF4bJVvIKeHFjYnq+nk
sqtBtmdNHDK1fz9e/A4k/ysioLea28Y6gzPHh/gmsRZnTa4THLma+y99flI4JMMt
Tso4FAuCvMfZebVDcErh
=+aie
-----END PGP SIGNATURE-----

--YZa61AII3s1sGKYx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
