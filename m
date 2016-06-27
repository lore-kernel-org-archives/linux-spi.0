From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Mon, 27 Jun 2016 13:24:48 +0100
Message-ID: <20160627122448.GU28202@sirena.org.uk>
References: <1467027248-6191-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LvvJQ0mOwKOuU4xd"
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1467027248-6191-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LvvJQ0mOwKOuU4xd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 27, 2016 at 02:34:08PM +0300, Mika Westerberg wrote:

> Allow the same devices to be used in ACPI based systems if they provide
> proper DT compatible string.

Please allow a reasonable time for review, especially for an invasive
change like this which needs a bunch of research to figure out how
sensible the infrastructure to shove DT into ACPI is.

--LvvJQ0mOwKOuU4xd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcRsOAAoJECTWi3JdVIfQotoH/1pvbHeewYBs/plvsP3eIxX9
OoTcjBjCp4zLFz4CVu4328pPDeJ45F1Xggd1Y2sWZBiZy4ylz7dRcDKDOO9BqKdn
hmhTnlCvqidrSjl5cU8kCHIkytA2Hawnd8VtTE5rSYcEj5g64UdNzgHk1DcmihTY
BrvDYURAJXgdqftpuJOiGxcVfgOQUwEqnM+10xf545PFl6kEq7a4goKf+FHnvr6M
idJv/ADJBKA2EVZjEZSPvJge9fNiBt9RfWmBi0kN+Rs6+UUZd1JGUpAiT0dR7bVS
lHSlPFX7f6xMApRVuX4HoARMyK7Us9VHjyb/gn5YpUTkviKVdzh2WouACKYh7uQ=
=wN2s
-----END PGP SIGNATURE-----

--LvvJQ0mOwKOuU4xd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
