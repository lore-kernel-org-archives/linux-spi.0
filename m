From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/qspi: fix multiple "unregister" api entries.
Date: Tue, 19 Nov 2013 19:48:43 +0000
Message-ID: <20131119194843.GR2674@sirena.org.uk>
References: <1384890344-2085-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYQNNDjzvANyiJW1"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384890344-2085-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mYQNNDjzvANyiJW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2013 at 01:15:44AM +0530, Sourav Poddar wrote:
> There are multiple instances of "unregister" api in remove path, which
> came in while rebasing. Remove the unappropriate one.

Applied, thanks.

--mYQNNDjzvANyiJW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSi8CYAAoJELSic+t+oim9uMIP/2kK5OdUpu5UGtxZBYaPdKhs
VZ4cQQ324JuknnMKJ7fPe19v0Noecrd8sOilMz+rBPF6FiLTliR6PPCSDooZTmaN
aSF0sawtD0YV+AKQxhJnFy+wVJjCs3oCVXS68GtN8lKROhxcThxqmMPKDRn+Ftyx
VK9Q86Z47kZrMFWiym2jXVQFC0osDdCTihl5XUjjC+iZIbvHr8xuF++nxOk8msy9
mHekXy65QHcE11mpyWgyneaY5x43T3JGAePkPJrcuVu342hy/CRLC6wXUBsRIEPc
qPhY1qAvDagSV+RMQiEJB3J5v4DsaOwI1U/f5xHoSIg12n4Tql2LGB0SC5gqyPQG
nEc3TwkwNe/pfF5hv7zaojyD4js7lHXM6dZHJL7HzMBjhdecWFMRbvY2Cm1GAanr
9QRdU4m2WSFa9FqvLnE2VyoxfcXQPP3IrA1VH3XTFFy01V6yp9MCWF11DlE4WlY2
MuC/lYTF5GH397s6BxXq/krp8t54EdZYcqPLTyMYPVzYrpRjAdT0fH+I6ScDVnOz
cULEUBUCnvA/bjGmTt2+xrDbtJbQJc2+IcumwRF4+6rH1d2lvNiI0Ka32oNLRrmV
XP5Rh563QSaonGeCIr2QyH12+wtOwvkanvmJwkrWoVpDQacmyR0gAlki5xpWrckF
QXV0knXAh2xxJVQADPGB
=kX4o
-----END PGP SIGNATURE-----

--mYQNNDjzvANyiJW1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
