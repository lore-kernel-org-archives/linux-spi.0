From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Wed, 23 Mar 2016 12:54:48 +0000
Message-ID: <20160323125448.GM2566@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de>
 <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LE/9QIphVMc2cJ9L"
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56F2852C.5010006-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LE/9QIphVMc2cJ9L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 23, 2016 at 12:59:40PM +0100, Stefan Roese wrote:
> On 23.03.2016 12:33, Mark Brown wrote:

> > No, there's two separate things here.  The big problem with what you
> > originally sent was that you were defining a window per SPI device but
> > this is a part of the SPI controller so having to change windows per
> > device is just going to make the code more complex.

> I'm sorry, but this sentence is not totally clear to me: Do you mean
> that the "more complex" code in v2 with the MBus window reconfiguration
> is not good? Or do you mean that in the RFC version, the switching
> between the SPI devices was too complex?

I haven't looked at your new code at all.  What I'm saying is that
specifying a per-device MBus window seems like pointless complexity.

> >  There's also the
> > separate issue of where any MBus windows we get come up with.

> Could you also please explain this in more detail? What do you mean
> with that? Do you mean the physical address, that is defined in the
> DT for this MBus window?

I had thought that this was what this subthread was about but you
appeared to be confused.

--LE/9QIphVMc2cJ9L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW8pIVAAoJECTWi3JdVIfQLBUIAIE5NsFLP/I3JeyBCssjOCw4
cX4yC6Pq0CsnLtFFsfXF0M68VAlYoR80arN72FNhkPB4TILxc4JctOkZH+sW1VB4
B9foFTuqXztlmiNzPwVLgfFE/YNCSV4QndlUG9EtPAPMhFHP3FPm9a+KxU17nDdX
n6o5h6qXO/lTTKBB0amLBT4od8BmcOjfISW7dAlFIJ1Fums/tarfUu1XiPcvaSc8
LsCPLXCb7c6QNqFNW9ndqICH7juTplCoZg7NRCjHpXke4Vy+GZAgznWDnR/mKc9g
QHOITGJON6JvkBRTtMvnp6wV8WU7kT/bqIhO0P8OxnSXkEgmlmHMbpFGzsFVmko=
=j2xJ
-----END PGP SIGNATURE-----

--LE/9QIphVMc2cJ9L--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
