From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: cadence: Init HW after reading devicetree
 attributes
Date: Fri, 28 Nov 2014 11:42:39 +0000
Message-ID: <20141128114239.GK7712@sirena.org.uk>
References: <1417101138-2619-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nTvpzgBZ+kZgACpu"
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Cercueil <paul.cercueil-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417101138-2619-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nTvpzgBZ+kZgACpu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2014 at 04:12:17PM +0100, Lars-Peter Clausen wrote:
> From: Paul Cercueil <paul.cercueil-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>=20
> This will make it possible to use the settings specified in the devicetree
> to configure the hardware.

Applied both, thanks.

--nTvpzgBZ+kZgACpu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUeF+uAAoJECTWi3JdVIfQP74H/iRLO9srkMRDk5xwC885iCKB
2A3YxzaSwrSHBzjHGlTRx13saBQHD5qRp515/34SrJ4UMVLKkvF+/OOiFjgoeZLw
z3H76VUKvPOnY4s708678T+La1/4UQeThE/USAEjculyyJyK9x2w/GZnOfsD9Agl
h/rRW6fUdSFXWwdebhy0dDTE5BatKiUtNPPqiUjlojJLWOOGFToAcRBMCwX0JN/I
S6F7VMseXD3NdjFl+BOGE3et/48TbNiFEaHoGkjZkdAxE7FVK8V8x61rbc+/gHzz
kCCpyRuZGgvhHkKNF1DOC7PTwTMr8+S6TkKdxRExD2cdvM06GK+mpuoMFUqqMe0=
=gT19
-----END PGP SIGNATURE-----

--nTvpzgBZ+kZgACpu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
