From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 4/4] spi: dw: migrate to generic queue infrastructure
Date: Thu, 23 Jan 2014 19:51:48 +0000
Message-ID: <20140123195148.GL11727@sirena.org.uk>
References: <cover.1390481412.git.baruch@tkos.co.il>
 <cb13f97edb9250d51bc03d27bcc3ddda93821bf9.1390481413.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jl+DbTnyraiZ/loT"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cb13f97edb9250d51bc03d27bcc3ddda93821bf9.1390481413.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Jl+DbTnyraiZ/loT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2014 at 03:05:59PM +0200, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>

This looks good from a scan through, can you go futher and use
transfer_one()?

--Jl+DbTnyraiZ/loT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4XLRAAoJELSic+t+oim9UmUP+gOUzOfBowsH9OSVV2sNeOyS
Co4o/XyFMfsv1l3NTtFiWsgGFZAVu+vsPUFydgng6CdXxebCyC/bZ5lyxuo262nT
/d4mspgjyyEdNdvok1yOaF2dBjJkIG0iaghUy7WWARuSJcj565ANMprGHlStZqHb
FfM+rVboTG4cYYqT6Xo09QXlEw28fs4uJ7LsskgEpv0FailceOS8ae9uUQPAeLWh
grRjlw73JVmQkpCcVy/D+M9Q1Jht6eQSSPF3kS9djomCOjjnWWaLzWAKCPRQyGMZ
iS+u7Bp8eCumtHlFRq17FSjAyzA4EYlG+yTE9h3iiloJhX8xQP3zyCa2PeJM2qf9
SpBPMRcH9aD9Yw6UfclVwbRx9baTzFV3O8PXXqp6dXqLbTGLgVQtMOI6TuAN5FWP
n5pdFtrCptWDWnkd9Uuc9YW1hVvCV8n6xWHGQD7oYN1HQ/WpH1lRFy4Xxwyibmdo
yKbus3Ydk12utelSSX7I8Llc38HFa0UhstR3YjgYeFfo5S4UMVR2DLyPrG1g5Bny
AuqkgPP+FKqa3n9w6C1zZCQbydslR5Kbneu7HOSj52x07VPUsXt/JegA1LrOq9gs
PrhNidqCJ5q0Ngpnq6L588dkkwguv2JPzVngguH2xofVOe6BKKMmC/97+q7P2lI/
dhG6bfEKdks29UnZ1yGS
=YKOr
-----END PGP SIGNATURE-----

--Jl+DbTnyraiZ/loT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
