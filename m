From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: xilinx: Use standard num-cs binding
Date: Sun, 8 Mar 2015 19:00:12 +0000
Message-ID: <20150308190012.GV28806@sirena.org.uk>
References: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BcZrms9gUsdgyR6a"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BcZrms9gUsdgyR6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2015 at 01:55:14PM +0100, Michal Simek wrote:
> Use standard num-cs binding property and setup
> "xlnx,num-ss-bits" as deprecated.

Why?  These properties mean different things - num-cs is a bit confused
and is the total number of available chip selects for the system (which
could include GPIOs) while num-ss-bits is the size of the bitfield
(which could include things not actually mapped out properly/successfully=
=20
or something if the hardware designers were feeling particularly inspired).

I'm not convinced num-cs ever made any sense.

--BcZrms9gUsdgyR6a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/Jw7AAoJECTWi3JdVIfQFuUH/iGrogTvEN2ibylzo/fvGwuw
mnp69cL2y5sjdegiaYcSchqAZxMqQHz/AeHJBvF5rlB+rb2Xdo4tsrqhZy5iK8iJ
PaTBXvX5gcG0cIZaHp7hvq1AY5rM/HUWpDl7bvDYl/JsBIv2eTIQe+NwTr5GrXYd
RCK2fkOj73GdHEqaRpAOG+3uHbyzmJtJbW7fq3xfDeaf9nb+loZq7pqgyUUVV6Lq
4e/nf2WKn7Wr7YkZ1ezZSRmUBuA/G1z04qDvEzBFBpGj6sktPJEFOyd07fcyaLBD
px0qEWRTZ8tNLuZFx4lXWLOmZBWCb3uPjpax4pMxXViiQJUCz0d04bwGH/KSWX0=
=iZtX
-----END PGP SIGNATURE-----

--BcZrms9gUsdgyR6a--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
