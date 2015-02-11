From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm53xx: use msecs_to_jiffies for conversion
Date: Wed, 11 Feb 2015 10:14:33 +0800
Message-ID: <20150211021433.GN2593@finisterre.sirena.org.uk>
References: <1423408265-23116-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N/GrjenRD+RJfyz+"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423408265-23116-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--N/GrjenRD+RJfyz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 08, 2015 at 10:11:05AM -0500, Nicholas Mc Guire wrote:
> Converting milliseconds to jiffies by "val * HZ / 1000" is technically
> ok but msecs_to_jiffies(val) is the cleaner solution and handles all
> corner cases correctly.=20

Applied, thanks.

--N/GrjenRD+RJfyz+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2rsIAAoJECTWi3JdVIfQeGcH/1m5bH4tlpsOhKf7twLeebw3
qva6jf/iqixtQ2bqXOvj+wzBZWmTbOIyexTsv0LEp30klbmNkGQQgrIA/AMFQVeB
uOP45gAv0rltnV4lLNN/sdxkLZXVdjJZXTSEUPbQn2kGeg97eLP/TLCbbWL0Cog9
pVEWP8AmksRiyxpfXYbafLv8sgrPsnS4HJohQXtZC3pWQL5ZEO5VBQaaIMKB1c18
+q1exPzeRscDPcX67gaimwuY9MXEscMd2GqiDwDWCeTEaeI3NlFwEvKlvOyJ8YWN
/ugY0YH8v4R8tZh6hkTkOFv2jx4PM0lIuugwmIVfkkB0gegV2XB0KVSE7iKx90Q=
=wC0q
-----END PGP SIGNATURE-----

--N/GrjenRD+RJfyz+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
