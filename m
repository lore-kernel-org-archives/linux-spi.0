From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 29/30] spi: s3c64xx: move to generic dmaengine API
Date: Thu, 18 Apr 2013 17:46:42 +0100
Message-ID: <20130418164642.GM13687@opensource.wolfsonmicro.com>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-30-git-send-email-arnd@arndb.de>
 <201304172205.35526.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dnd11iroZwpv/0M5"
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kukjin Kim <kgene.kim@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>,
	Padma Venkat <padma.kvr@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201304172205.35526.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--dnd11iroZwpv/0M5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2013 at 10:05:35PM +0200, Arnd Bergmann wrote:
> On Thursday 11 April 2013, Arnd Bergmann wrote:

> > +               use_dma = 0;
> > +               if (sdd->rx_dma.ch && sdd->tx_dma.ch &&
> > +                   (xfer->len > ((FIFO_LVL_MASK(sdd) >> 1) + 1)))
> >                         use_dma = 1;

> Can you try just reverting this hunk? It's actually not required and
> comes from an earlier version of the patch. I assumed it was harmless,
> but it's the only think I see that should actually make a difference
> in my patch for the case of !CONFIG_SAMSUNG_DMADEV.

That's not it, the checks are now needed - otherwise we get a null
pointer dereference in prepare_dma() instead.  What's actually gone
wrong is that your ifdefs are for SAMSUNG_DMADEV instead of S3C_DMA
so s3c64xx is trying to use dmaengine.  The driver doesn't actually
check to see if it failed to get the channels so it then tries to do the
transfer with a missing channel which unsurprisingly fails.

--dnd11iroZwpv/0M5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRcCNbAAoJELSic+t+oim9nU8QAJN4GclZdpeo2pjHguKoNC2z
EFQypSaAn8vxvMeO5B+nr2TXKSAyalp7WtAW/8gF7XyvzxwgXdXKIFWcxrLlsZIW
tx2xI091vmcx+OxGKQawqwHgoYXD94gvhag69Ccu2gTX9JHdEIY5O/YtGwypGyqW
BQ+uYH8P1SVzkGW/LMXrjfpKuIxjwtSqQfnb6TL6EVapl3ULfDAEpw1e47Wd/Qb+
552DXDCvfofE6r38Mh8IBPg8ZZ/KlrBXoCwrWSTlzRPwRsX18hHTBBWdSt0Fto8t
RR/mgOc2I5k+VVmm+pLfmdhqLJl05AX1qg5TcV9uHVE1twNZIcxaEKJ6wLvhyLu+
qML5ftLt65lqCMdmTMCzON+WZAHt6r99XH7h734T7f8qH5bOaPZulvyEIjalk5H9
ZQQtj/+c9Z9wlkYsg82m1qdyAWdsSNLsKFL02CoHrUGum7Rfeo+8Grk7Y6Q1ez8e
voihFNSfFMvyh2p4gBwNQIMMuZm8C/nRVjtQZvj3Q3fK7jHJlY+aAIOldKqmRG8j
ayBhWEqWLXx1lopHc99KursM+2jMEdzoufUXqr2iBLPaptMB721qhLg+8o3ndEUZ
uXDe0EylmgA5MNFF04Jtw4HwmBwMe2nVnQsj/BMjaCsCcaPjtuCmEWPuYEkJt4rv
UXqXxYbcp0o2A6ThQTEC
=OlPH
-----END PGP SIGNATURE-----

--dnd11iroZwpv/0M5--
