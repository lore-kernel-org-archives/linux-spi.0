From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: bcm2835: driver for "auxiliar" spi1/spi2
Date: Thu, 18 Jun 2015 11:58:48 +0100
Message-ID: <20150618105848.GE14071@sirena.org.uk>
References: <5582933E.1050500@martin.sperl.org>
 <55829B18.4030609@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NI/YJYXQ/j0wYS88"
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55829B18.4030609-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--NI/YJYXQ/j0wYS88
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2015 at 12:19:04PM +0200, Noralf Tr=F8nnes wrote:

> There is also an aux mini uart that shares interrupt with spi1/2.
> The AUXIRQ register determines the interrupt source. How should this
> sharing be done? This uart is really only useful on the Compute Module
> since it's pins overlap the pl011 uart pins on the other boards.
> This is how the mini uart is used/setup downstream:
> https://github.com/raspberrypi/linux/pull/1008

Linux supports shared interrupts perfectly fine, though it sounds like
this is actually a cascaded interrupt (the demux is another interrupt
controller) which we also support just fine.

--NI/YJYXQ/j0wYS88
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVgqRnAAoJECTWi3JdVIfQCpsH/RJpegEpLQmNW70ecUd4YEXW
7xVwQfLJT7IbaGyrJNO656f1UMRVgTr+ScmCF+4E1yNgyXneR+52BHoTDzx0Wcyn
Cp5FamU6gQ/CBIVQv28gKpLuzyypWoRqiBElfhqNZGUAt5hXXOTr2ru60j7FXY/O
TcvtaTyfQwoFYSVohmjRqgiHE1W0LcGVYVHxmQqfhEqiImc7cBtRQbpr/SL7cEKy
cF+ZMEF61ckRMNtiRZTP30HvrmJhDNL4T9viHhgjvudHYuL9Q88YXzs7ctIOvX9S
3PyXUsKnNzsHnNSGwbwvzSnyeGq1YxdBS4+3gV4wRmXcN/CrQpUxQLiqZzdqTUY=
=B70G
-----END PGP SIGNATURE-----

--NI/YJYXQ/j0wYS88--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
