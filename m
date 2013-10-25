From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 2/2] spi: Use stable dev_name for ACPI enumerated SPI slaves
Date: Fri, 25 Oct 2013 16:09:47 +0200
Message-ID: <1530227.7u44IdW1Bp@vostro.rjw.lan>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com> <1382703540-3769-3-git-send-email-jarkko.nikula@linux.intel.com> <20131025125909.GA12932@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3678682.1027DfbcGu"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
	linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20131025125909.GA12932@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--nextPart3678682.1027DfbcGu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, October 25, 2013 01:59:09 PM Mark Brown wrote:
> On Fri, Oct 25, 2013 at 03:19:00PM +0300, Jarkko Nikula wrote:
> > Current spi bus_num.chip_select "spix.y" based device naming scheme may not
> > be stable enough to be used in name based matching, for instance within
> > ALSA SoC subsystem.
> 
> I'm happy with this from the SPI side modulo Raphael's comments - are
> folks happy from the ACPI side?

I think yes in general, but I'd like to understand why the ACPI_HANDLE()
thing doesn't work as expected.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--nextPart3678682.1027DfbcGu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAABCAAGBQJSanuxAAoJEILEb/54YlRx13sQAIma44w/ksmY8FRR94k0iG78
VzAHCpXZhxd43ZjSRviAAyQINT+h6N4fFWT32ZjZqwEYNRkfDUjuy5RdR5MwD+iT
becubgM7R8qS2dZsxu0N/1kKF5KjjFXpz3uynSz3yna5BYECRZo+NHgXlMynpOI1
f0yz760d0RTu/KMvMzkdpPT6g5Cjg8E01adpW1xlCvqKi2Fp2M57uXJnlLZHv1d7
82PgQasM2XD0lqOGhx7HqzQc6WF6SKnycJ/RoFjc7Z/97iWzKhgzDLrLsd8qL98D
lPEkjnpmcwW2YckvALqrm8lVS9UCmIe2pL75ylJw4HyJjpJeYhbjo0fRshaQ9nTj
qGwAydIyEFIze+5rqRizrNd2K1ckXTt2dQTxRPNOY7219n6I4x4kNvM/CdxcJ5Bx
dBH0HhKp54tUzoeiTrRvyW71jV0vuqcPQr3r0ckGxDMEi5EumlycLWtg1CUHbGjl
8Uq2bf8c2ZsyPicpQ9esJuY3HtjlD4iqDGuCImZwCGm5iyFeSo2GMMquSmuFlu0k
v25VRYRvwD13lLF5+KggPgTtU5iRNxd/6i9chkeeubrT9g5euBNOuO3XQqcJlbYs
oDDfRvqlln3Avan93hkRRuhE25g8BKQyo3NxIdVeOgxl65BIKdAc8mce/sMY3e/u
rXuKs7sNSyQ82Z2sNGCf
=0M2M
-----END PGP SIGNATURE-----

--nextPart3678682.1027DfbcGu--

