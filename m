From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Fri, 1 Jul 2016 16:50:35 +0200
Message-ID: <20160701145035.GP6247@sirena.org.uk>
References: <20160628152338.GN1711@lahna.fi.intel.com>
 <20160628161822.GQ17217@sirena.org.uk>
 <20160629091304.GP1711@lahna.fi.intel.com>
 <20160629162127.GA6247@sirena.org.uk>
 <20160629163420.GC1711@lahna.fi.intel.com>
 <20160629183101.GN6247@sirena.org.uk>
 <20160629185155.GG1711@lahna.fi.intel.com>
 <20160629192059.GV6247@sirena.org.uk>
 <20160630124931.GD23527@lahna.fi.intel.com>
 <20160701101912.GL23527@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0WzQiIesntPPsVaS"
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160701101912.GL23527-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--0WzQiIesntPPsVaS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 01, 2016 at 01:19:12PM +0300, Mika Westerberg wrote:

> Windows seems to have a similar spidev raw interface in their MITT test
> suite here:

> https://msdn.microsoft.com/fi-fi/windows/hardware/drivers/spb/spi-tests-in-mitt

> It exposes three ACPI SPI devices with ACPI IDs of SPT0001, SPT0002 and
> SPT0003. I'm thinking that instead of using the existing DT compatible
> strings we could use these ACPI IDs in the driver.

Ugh :(  But yes, if there's existing ACPI IDs for this functionality
clearly we should support those.  Probably with an equivalent warning
about how they're only for non-production systems.

--0WzQiIesntPPsVaS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdoM1AAoJECTWi3JdVIfQDQYH/jROBS3AzXFW/TGYQexgLROI
iaDan62sqphiLZpyza717eR0YutnU2EPIz5xAqbRvRNK7W6Nt4PptGZf3OiDBIqA
+4MXIP15vKqhip4aTKAlJ4Xx3Jc/kf1QQKrCNeim4pOH3jus2rPKovd6BACMRYtG
IFPCLOV6aCqISF89gqdqSikoUxCfPCc0S76EZxPVBHnLZlkGh9KJtKbp56zNw/PI
e7BiXMbjXvTf//YBQccER7kgfH4ivKnKhPNqMtnY2q28guRADE8eWS8MwxFMN8Wk
1mYB1KEAKUscm9WRm526l9yy2xnlIeKNhC37dwnoxNkNaqa6FHjo9Rt1imuye2M=
=ozty
-----END PGP SIGNATURE-----

--0WzQiIesntPPsVaS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
