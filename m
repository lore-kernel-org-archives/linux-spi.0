From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Tue, 22 Mar 2016 17:39:52 +0000
Message-ID: <20160322173952.GF2566@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SXJj2kVWw/JBQDhF"
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160322173546.40d24cc2-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SXJj2kVWw/JBQDhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 22, 2016 at 05:35:46PM +0100, Thomas Petazzoni wrote:

> Has there been any discussion on whether dynamically adding the MBus
> window is a good idea, as opposed to statically defining it in the
> board .dts ?

> So far, the only driver that was using dynamically allocated MBus is
> the PCIe controller driver, because there is no way in advanced to know
> the number and memory window requirements of the PCIe devices that will
> be connected to the system.

> For all other windows (BootROM, crypto SRAM and more recently network
> related SRAM), we are using statically allocated windows.

Is this a case where we used to use static assignment because we didn't
have a mechanism for dynamic assignment but now have a mechanism for
dynamic assignment?  In other words is there any advantage to doing the
assignments statically given that we can do them dynamically?

--SXJj2kVWw/JBQDhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW8YNnAAoJECTWi3JdVIfQQNIH/iHqb9zqrtEKwwi9GaiuDDYU
QJ6T8267T7bxzs31H+SRX8OLrLbmCtiok+McdfBd8cAv7EdgEhxWXj9aJaDlv5Ry
C25bRXqRcVxKuXb23axaei2GfJnbrVpq9pOIH4k9DFs6SdHahFDmP4y1O5UCzghC
cnv21YxfLFfXu9iSMWmECRzr2ni0a3rVWd7pQ0El7EQwvRrvIyrBMZI8P2rwgdqP
Sfw4SINkj0yhee5jPP3l2B2hIu5pjsmur8xOSIPqhti+GqmBucXDCKE4fhOp8OwO
wrPxPA7KbDNEhhNIIhPO7tpK/NKNO8MsdOzFe4qZnzwbyfW0KcWDJ7Tz/xbaKdk=
=1+Al
-----END PGP SIGNATURE-----

--SXJj2kVWw/JBQDhF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
