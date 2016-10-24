From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 17/28] spi: fsl-espi: avoid processing uninitalized data
 on error
Date: Mon, 24 Oct 2016 18:27:13 +0100
Message-ID: <20161024172713.GI17252@sirena.org.uk>
References: <20161017220342.1627073-1-arnd@arndb.de>
 <20161017221355.1861551-5-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3VRmKSg17yJg2MZg"
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Heiner Kallweit <heiner.kallweit-S0/GAf8tV78@public.gmane.org>,
        Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161017221355.1861551-5-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3VRmKSg17yJg2MZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 18, 2016 at 12:13:38AM +0200, Arnd Bergmann wrote:
> When we get a spurious interrupt in fsl_espi_irq, we end up
> processing four uninitalized bytes of data, as shown in this
> warning message:

This doesn't apply against current code, please check and resend.

--3VRmKSg17yJg2MZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYDkRsAAoJECTWi3JdVIfQJFUH/2iEFnU08q4GierZmizEGrah
NhWz2hA+H/Yzoww8qONrNfTVLbbjM3UlevbZ0K53hTnULSwRpPk/pKImSwq0eR1w
QKZDEwggaVnryK3yJ4XqQN7FmA3D9rmNX2+XmMajkLJ6RfigaD66zBj33yUgA7Ks
Jn8jPLBiH37APnyJ30Exgs6MsJQCDmevqeuA8qOAg/5Lm39OsF1qbsibQXb05jje
keV29B+YOoy15AlHV62krMBrdEYlg1HAl6VSVuAVoECXd7dGg/cZY1HnsJWol5cL
mJ5Ssxm8Nz/098tbmPCRIAQ2/pfDAFOR7GdMdIqHJ6yThAX9fswRfPgntytGUUo=
=Aro3
-----END PGP SIGNATURE-----

--3VRmKSg17yJg2MZg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
