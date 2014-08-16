From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi/pxa2xx-pci: Add common clock framework support in
 PCI glue layer
Date: Sat, 16 Aug 2014 17:20:06 -0500
Message-ID: <20140816222006.GB14537@sirena.org.uk>
References: <1406221854-12828-1-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Kweh Hock Leong <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	chiauee85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406221854-12828-1-git-send-email-chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2014 at 01:10:54AM +0800, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org wrote:
> From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> SPI PXA2XX core layer has dependency on common clock framework
> to obtain information on host supported clock rate. Thus, we
> setup the clock device in the PCI glue layer to enable PCI mode
> host pass in the clock rate information.

Applied, thanks.

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT79kTAAoJELSic+t+oim9JxAQAIVhzet03FzoVmvW9DMgIE1U
KYa/40PFVVhdAyu9teEHw7T21Jzv8GMVw6MRRnelVYHpuLiDiabO6SzkzwfZizcw
R042exNpSMT6TNT1zOffN0q9N3x8Hgkw66P50yC3eYIp4c9tNBVaB5dJq1MqlP0R
ZQiFRhH32KB/EWoR/RZUBFU3nurftreNpOiI+WzOP3Ohyqw7HcKwlQ8g24Rtmule
AhUCLe0WN0BKxbvBGwb+uemSOBlqsBUDt3fhXr95PJcroWgxjYhOD65mfC/n8D4l
dwNd0vz0dtT7uvu6EZ8Y9O1T6jMshE6HKpLYfNckuSN/s09HjLEbjOtF7pL+pyfR
DmPWlEXWL3lt7OUUlbz4PDOf5pe4l1r75UYjGLBSx80+nYaD5uQl4bS7VrDGiBIX
l3GV+X7+7ME+KHwwrU+T+UgmV8kc8azl0dk9DwcHa53XsR85VHzzm96NrWu8G4HD
UC3zLh6ccHOXCv5dxLo0X6vzh3d9KZFDeYlv71X5+yrm7HH7zYVeUYDgaUUX5IyD
t3YR2Gcts7p8peGnA4/ZeDdr7hJdv4HZ1e0a3jXcs98jUmFUiaDAJ0+U00DUsjVi
lG5GgmB7JOoYuxcTxVIPOC2VrWGVpyNuhZKO9JmS/eODUDkT1vUb2qcNfUNwv8od
zicc8iq3w2S45fmtdDE+
=7buL
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
