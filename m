From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Tue, 29 Mar 2016 09:47:58 -0700
Message-ID: <20160329164758.GQ2350@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <10747635.WkGeFaKqdy@wuerfel>
 <20160325223922.GG5028@sirena.org.uk>
 <29105031.S6XB0bXn2i@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xiprIVX1FSGBv8kC"
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <29105031.S6XB0bXn2i@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xiprIVX1FSGBv8kC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2016 at 02:39:10PM +0200, Arnd Bergmann wrote:
> On Friday 25 March 2016 22:39:22 Mark Brown wrote:

> > So there are some complicated constraints that make it hard to allocate
> > from the bus space?

> Yes, it's basically an optimization problem: the closer you can squeeze
> everything together, the more address space you have left for RAM and/or
> PCI.

But there are allocation constraints that make that hard?

> What we really have though is additional registers that belong to
> the SPI controller and that are not part of internal-regs, so
> we need to move it up one level out of the internal-regs node in order
> to add more registers:

That seems fine, it's part of the controller binding.

> I think it makes a lot of sense to define a separate window for each CS
> at boot time, just so you don't have to reprogram the windows manually.
> After all, the entire point of the direct mode is to avoid having to
> do any of the setup work, and have the SPI master set the right CS
> itself based on the MBus ID that is used for accessing the slave mmio
> window. This is also required if we want to enable things like
> XIP (DaX) mappings for file systems on a SPI-NOR flash.

Well, in the cases where we have one device on the bus then it's not a
big deal since we can check what the last thing we set was.  The direct
access stuff is going to have trouble if we have multiple devices on the
bus since we try to mix it with non-MMIO access we run the risk of
conflicting simultaneous use unless we continue to route everything
through the SPI subsystem (like we do with the current flash read
support).

It really only makes a difference if the reprogramming process happens a
lot and is expensive relative to the transfers and that doesn't seem
like something I'd expect.

--xiprIVX1FSGBv8kC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+rG9AAoJECTWi3JdVIfQQqUH/0DFMXZVGPsiAhBHZxk3mEP0
yO+Mf/gP8odQFXXAsnxAL5qEPfaxWTYFxpAhzOmNMSu34I1RMitF97wHXfsu/2j9
pX1t/XShHJQMyS6ind2M+Uc4t97BJkPFXzpiMiRsmrAixBZjpYFXvmEhNLj4SCd8
EeB7IioiRHR6m9k2FfN1pT5JRx4z/876+gQAuk1O++ujhu7SeAsehtTUCHt3IuUO
7iVNXirH6lUYtoVK2aadJZghCcQ8ojn1VnlXI7mNStqjgOV2kFrKijCPP/CIIuKf
Ze1qznmC8RgOdZ+gQkGn25AKLc1+BVQq9qVnXQxKMGyP/g06RJCXpLvKH2L6Mvs=
=gMDf
-----END PGP SIGNATURE-----

--xiprIVX1FSGBv8kC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
