From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6] spi: orion.c: Add direct access mode
Date: Mon, 2 May 2016 16:40:23 +0100
Message-ID: <20160502154023.GI6292@sirena.org.uk>
References: <1461147068-4829-1-git-send-email-sr@denx.de>
 <5726F7F3.9070700@denx.de>
 <8919835.yGyvx4h0Tr@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="byLs0wutDcxFdwtm"
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8919835.yGyvx4h0Tr@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--byLs0wutDcxFdwtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2016 at 09:28:34AM +0200, Arnd Bergmann wrote:
> On Monday 02 May 2016 08:47:15 Stefan Roese wrote:

> > Its been a while since v6 of this direct write access mode has been
> > posted. This is a gentle ping on its status.

> > Arnd / Mark, do you have any additional change requests or are you okay
> > with the current version?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway.

> - you now always send a multiple of four byte in each transfer, are
>   there any downsides in doing this, e.g. some SPI devices that might
>   get confused by receiving additional uninitialized data?

Yes, this will break a large proportion of devices.

--byLs0wutDcxFdwtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXJ3TlAAoJECTWi3JdVIfQUVgH/RUrnQMI+mr2Ddn9hSIvKROo
Gexjc3VQlMU+8LX08rWSGO6LcA0+kSJhZQtZWIw1ULPN4jzQR0DpiFJdHBM9s+Wo
3KDemtTdfh7QDes9Gjtm77A+qy3mYElpYzNA3o6FLAoSKBieXbcfS3N1wRSH52/n
8SQgZ46hNQA6Praq8peKb6SJbyhqWYYY5RVBDIF82PAOrVmKmu0AXP4tGsB1AF1f
SDAngNtaoLZviRV0ZlPgFDflemn59EOUuEM8GBilBo/D5oLxljPgU7HyRC+nIn26
YnvTtrlcScDpQmB5BR776mqDFs3RiqsovJ2TVfwe/lXSySaDCJ9CmJeIjvvhgUc=
=oo9C
-----END PGP SIGNATURE-----

--byLs0wutDcxFdwtm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
