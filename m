From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Wed, 29 Jun 2016 17:21:27 +0100
Message-ID: <20160629162127.GA6247@sirena.org.uk>
References: <1467027248-6191-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160627122448.GU28202@sirena.org.uk>
 <20160628092234.GG1711@lahna.fi.intel.com>
 <20160628114742.GM17217@sirena.org.uk>
 <20160628143528.GK1711@lahna.fi.intel.com>
 <20160628150752.GO17217@sirena.org.uk>
 <20160628152338.GN1711@lahna.fi.intel.com>
 <20160628161822.GQ17217@sirena.org.uk>
 <20160629091304.GP1711@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160629091304.GP1711-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 29, 2016 at 12:13:04PM +0300, Mika Westerberg wrote:
> On Tue, Jun 28, 2016 at 05:18:22PM +0100, Mark Brown wrote:

> > So you're saying that it's not possible for ACPI to use anything
> > *except* an explicitly listed compatible string to bind?  What we want
> > to avoid is any ACPI tables that explicitly list spidev since that's a
> > total abstraction failure.

> That's exactly what I'm saying. We never match using the node name
> (which is always 32-bit "string" like "SPI0"). For PRP0001 match to
> succeeed you need to have "compatible" property.

> Without the "compatible" property you get a warning from ACPI core:

>   \_SB.SPI1.SPID requires 'compatible' property

> and it will not match anything.

But can that compatible string be spidev and be matched via the paths DT
uses while still ensuring that enough of the OF matching code is enabled
to cause the check to warn?  That's the problem.

Life would be a lot eaiser if Intel would use DT where it's appropriate,
or if the OF in ACPI stuff were more transparent and needed fewer
special cases.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXc/WDAAoJECTWi3JdVIfQlksH/AoLmgaNjpRRIF05+sHpxxm1
3M2ag8O9MmySYMU+gdZsSUw/hKbi7/Lft21jaqIJE6CYx5O6uX928k39fc2mwEFn
Zs5bUFQMKA8iD+/LeVLA/VaW++DqWrxlVoE0ocTCy0ifJNv5zIhHC86pu9UMHBSW
AJloZdCvyVS8cq2Eh79gYcRr4R4vFdCM8R4GsIhqVcyd9RVbH6BcwTHzWgRVXgQN
W25bOBRTFVF9rNxu2AqLJsN9yM49QKlVEr1dCvBuqCQ1lowx9ImBctyx6giB4YfO
LHv4HqqE+4Aq2O9NDtPSR9Ym5LQrwEyc6ACKQPiMN0JMXFzNimdcgDl5ZbUGa3M=
=jXM1
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
