From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Add ACPI probing support
Date: Mon, 4 Jul 2016 15:29:44 +0200
Message-ID: <20160704132944.GE6247@sirena.org.uk>
References: <1467628683-5783-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160704125600.GB6247@sirena.org.uk>
 <20160704130806.GB23527@lahna.fi.intel.com>
 <20160704132048.GC6247@sirena.org.uk>
 <20160704132736.GD23527@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mg8cdxx98+SFDaXr"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160704132736.GD23527-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mg8cdxx98+SFDaXr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 04:27:36PM +0300, Mika Westerberg wrote:
> On Mon, Jul 04, 2016 at 03:20:48PM +0200, Mark Brown wrote:

> > I'm trying to suggest that it'd be nice to write the code to check the
> > IDs and only warns when appropriate.  :)

> Ah right, got it now.

> I'll update the patch then to check the IDs first.

Thanks.

--mg8cdxx98+SFDaXr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXemTGAAoJECTWi3JdVIfQD4EH/As5tC7AuHeHPF9FRix0OgpA
35IYT2CMx7waPMGAcHWnLvkW3AV6bc0rg5PmDv2h6jOL0JMXbKZZ39NPQsTMqAaq
QHGtMCH2zIdgWx3V7An0ZxX2XjXeFXnX8g/FvkNtZFdBujlfroSeIDzrhutM1Trg
B/3DyQqD6ZMpEwEOhOLgA2sjyrI3ej7cjcOXqyrQDw4zTBzrFwxOhx4tMLQnYrgG
92YfR4fQxV8fRBsQ9a4JTNt/fYfOA3crF2ZmIVHjva7O/buoTUKp966oJ3M21qfu
zAKl3rhUGOq+G4KrhgFmx5kbyyGEwyMjmrX8cz+GfdIhF4hpgfvL8PsQqHY7dnM=
=FVlq
-----END PGP SIGNATURE-----

--mg8cdxx98+SFDaXr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
