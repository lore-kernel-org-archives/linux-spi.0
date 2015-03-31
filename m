From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: xilinx: Use standard num-cs binding
Date: Tue, 31 Mar 2015 12:16:51 +0100
Message-ID: <20150331111651.GL2869@sirena.org.uk>
References: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek@xilinx.com>
 <20150308190012.GV28806@sirena.org.uk>
 <2a81c738-f7e2-4387-b04c-05c9892ba8e4@BN1AFFO11FD026.protection.gbl>
 <20150327175318.GG1743@sirena.org.uk>
 <1bd88fda-314c-496a-ba8b-e9292f9c411b@BY2FFO11FD023.protection.gbl>
 <20150331054714.GA2869@sirena.org.uk>
 <74214fc9-e5e4-42db-bd85-51ed02975388@BN1AFFO11FD026.protection.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dlMgOrHkEHzMql2b"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <74214fc9-e5e4-42db-bd85-51ed02975388-reflc3kr++MPoeFrVf1fn+hlVc3/7hDbVaz/vdPVXQ4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dlMgOrHkEHzMql2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 31, 2015 at 10:16:57AM +0200, Michal Simek wrote:
> On 03/31/2015 07:47 AM, Mark Brown wrote:

> > num-cs *is* a software setting.

> ok - what to do with that? Remove it because it shouldn't be passed via DT?

Well, there's a lot of existing users to check and clean up some of
which currently rely on it which will take time to deal with.  Removing
it while some drivers rely on using it isn't ideal.

--dlMgOrHkEHzMql2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGoIiAAoJECTWi3JdVIfQ8fQH/RFZVTsnXw4fHJfrIJEHJ7uC
sRYrzU1d89f4JsiYj2U+SJVlwgervoUX7q8Xr4fXjc5KLGxAftdYMBXuQBApKwRI
1lo22VjclrLXe1rYYeke3q+IL94JUXXrlqLnBXivebLPJPjbpGmVdFY7gvvLEjDA
WkV7v6GT1up+jrKub6B7VuCO0T8orS6eeJXIWsZ0vRtCeYGBSMw6ae4HY+UZ66n8
Ubj9l+hXd6NS4xv1zJYgYx4wMZSOekgYWQJXRAY7Mqd4xmMpmSExr/mmMRModi5K
SmXYJ1cMUMX1R53Dn9BX5fjvky0oIxCLBFqTx0uovvtePxgwbrKAeTdvnhvkHX8=
=qUUK
-----END PGP SIGNATURE-----

--dlMgOrHkEHzMql2b--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
