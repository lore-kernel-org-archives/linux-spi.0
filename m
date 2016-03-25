From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Fri, 25 Mar 2016 22:39:22 +0000
Message-ID: <20160325223922.GG5028@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <4319407.5A4b1VspuB@wuerfel>
 <20160325155032.GH2566@sirena.org.uk>
 <10747635.WkGeFaKqdy@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <10747635.WkGeFaKqdy@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2016 at 09:58:40PM +0100, Arnd Bergmann wrote:
> On Friday 25 March 2016 15:50:32 Mark Brown wrote:

> > Why are we even doing that though?  Like I say it just seems pointlessly
> > unhelpful for users.  Are we really saying that every single system has
> > to go through and manually modify their DT so that they can use this
> > entirely in SoC feature?  That doesn't seem like winning...

> I don't remember the exact details, but I think we had come up with
> a generic constraint solving algorithm to pick appropriate windows for
> each device with a (close to) minimal use of physical address space,

So there are some complicated constraints that make it hard to allocate
=66rom the bus space?

> > > way: if we just use the existing binding, the spi host driver can
> > > simply call devm_ioremap_resource() to see if there is a map
> > > for a given chipselect and otherwise fall back to the current
> > > mode.

> > Why does the binding have to be in the client device to do that?

> I don't understand the question. The client device here is the SPI
> controller, right? That doesn't need to have a special binding, it
> just needs to list the registers relative to the mbus address space
> like any other device, and that is independent of how we implement
> it.

If you're saying we're doing a binding per chip select presumably that
binding appears in the SPI device even if it's the controller driver
that parses it.  This was what the original patch did, I pushed back
since it's a fairly common pattern for poor quality bindings where
people for some reason want to add per device properties for whatever
new feature they want to support instead of doing it at the controller
level (and ideally just doing it without requring any configuration).

> It looks like Stefan's patch tricks here by creating an incompatible
> binding for mbus that bypasses the address mapping.

I've not looked at the patch and honestly nobody has been talking about
any generic binding, all I've seen is the per device property in the
original patch.

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW9b4YAAoJECTWi3JdVIfQGPEH/2Q7LKiHm2G9gX5FhW6mnKAf
hNzUpQZxgESGnTohoFRQtA3pvynPU1NAj/DmkrPUtu1nIcCXLHGO30uBnnnb9bEU
+Dym04sNdK2NGT8y3rAhibGVceZ/izcAyWmNZFU7UjEH2ZdLFXdInwgpuiLvmqX4
aLvx/610FhZhKKKTyULfGTvuBwcUgu1xmYZ/Bj96VF9Uc1o7RwvSpZKNBvCamJSs
jOKSscKat1p+AfvdovD1kVlPxIcnG6jkDObnwiFi3/AkspwFkwcMM+PsZINOMkjJ
pxfuPJZBzouBPZPpx9xrc2LnvRjOvTrqV8/KGpnG5fkLkeJTT0acuuxtsprMFwM=
=3KRB
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
