From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/4] spi: meson: Add support for Amlogic Meson SPIFC
Date: Mon, 24 Nov 2014 18:55:05 +0000
Message-ID: <20141124185505.GE7712@sirena.org.uk>
References: <1416669702-7841-1-git-send-email-b.galvani@gmail.com>
 <1416669702-7841-4-git-send-email-b.galvani@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7sjjZzazJd4OX9P7"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Jerry Cao <jerry.cao-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>,
	Victor Wan <victor.wan-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
To: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416669702-7841-4-git-send-email-b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--7sjjZzazJd4OX9P7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 22, 2014 at 04:21:41PM +0100, Beniamino Galvani wrote:
> This is a driver for the Amlogic Meson SPIFC (SPI flash controller),
> which is one of the two SPI controllers available on the SoC. It
> doesn't support DMA and has a 64-byte unified transmit/receive buffer.

Applied, thanks.

--7sjjZzazJd4OX9P7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc38JAAoJECTWi3JdVIfQ1VkIAILkSXvspAENmsjVW5ktnEy4
/79f7Gc0md7x8Qig7ixDPY0OXpVBw/3SEFwho+I3E5gcbCakahu/HWe3AvF6G4PF
aFHx+bpBcvnBj731GKXQdNNZXpd4taJyxMqTnO/qEOaBPqS9z149YTCth5T+QVCf
bhr9N1Tjz6GonIHmsq86PJW3eSvM80qQiHCmau2k9pzD2zteTCLS/7uB5dWCuvNb
7f7kckvWogbRyYNUB7BiUO1Fi+m7ORz3yd8a2yaBsNKG6xo85bZmcX7HKO6Pawpp
kzmsvt/9uGbIAlTT7msh6MNwoZRPTBOhc66vGe298nlKV7DZvzOR4eo07PKUAvE=
=7kd6
-----END PGP SIGNATURE-----

--7sjjZzazJd4OX9P7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
