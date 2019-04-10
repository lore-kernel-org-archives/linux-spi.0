From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: pxa2xx: use a module softdep for dw_dmac
Date: Wed, 10 Apr 2019 16:28:20 +0100
Message-ID: <20190410152820.GT6106@sirena.org.uk>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
 <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
 <20190410125612.GR6106@sirena.org.uk>
 <6eeaf42f4d3f42c58546c429194213b8@asem.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wiiWofWi8Et/oezL"
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Flavio Suligoi <f.suligoi@asem.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6eeaf42f4d3f42c58546c429194213b8@asem.it>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--wiiWofWi8Et/oezL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 02:05:38PM +0000, Flavio Suligoi wrote:
> Hi Mark,

> > While this isn't going to hurt anything and might actually help so it's
> > fine doesn't this also suggest that there's an issue with deferred probe
> > going on as well?

> I think that the problem could be related to how the DMA channel is reque=
sted.
> At the moment the function used are:

> pxa2xx_spi_dma_setup --> dma_request_slave_channel_compat -->
> --> __dma_request_slave_channel_compat --> dma_request_slave_channel -->
> --> dma_request_chan

> Actually the final function "dma_request_chan" return
> the channel number or "-EPROBE_DEFER" if it's not ready.
> But this information ("-EPROBE_DEFER") is lost in the penultimate functio=
n=20
> "dma_request_slave_channel", which return only the chann, if all is ok, or
> NULL, in case of errors.
> So the deferral mechanism is not used.

Right, yes - that analysis seems correct.  The interfaces seem a bit
weird here but fixing them looks like the most complete and robust fix.

--wiiWofWi8Et/oezL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyuC5QACgkQJNaLcl1U
h9AzTQf/R/KL3VH0zEc0hVwvrBj1cDrGwBjBmXW9R97WwaXIq1RcLAJp9jazopLd
siILLz9Fl/KtflQ3YgkgdyizttANuiXYEf0PSWMzeTkUXlaIcIrKYjrMPZtpvCZi
crpQq730PNf3sbtH+AqNQl1Dgo2LO82hsNekA4irONWIKNRP6EUyccd5BtcbUdp3
AQUEAd1EDYeOKFI8EHbY4GBHu9hN53Bak1CBmd5y3LsA9P5jfA7dsFkGILTTesII
DqA0NiLQEcKppgE/IRaK+DmlWXnAk+KKVQOho+QWcQz/PvyrEg62r8c7GsRo2dFe
C8YNkpxNhOcXxCPou5xpMwPjQNF46g==
=TuEH
-----END PGP SIGNATURE-----

--wiiWofWi8Et/oezL--
