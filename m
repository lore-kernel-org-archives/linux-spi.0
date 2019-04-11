From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: pxa2xx: use a module softdep for dw_dmac
Date: Thu, 11 Apr 2019 11:42:12 +0100
Message-ID: <20190411104212.GA7953@sirena.org.uk>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
 <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
 <20190410125612.GR6106@sirena.org.uk>
 <6eeaf42f4d3f42c58546c429194213b8@asem.it>
 <20190410152820.GT6106@sirena.org.uk>
 <7ad025c8049e4e828ce75ef1e41dcbfd@asem.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
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
In-Reply-To: <7ad025c8049e4e828ce75ef1e41dcbfd@asem.it>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 11, 2019 at 07:14:06AM +0000, Flavio Suligoi wrote:

> > Right, yes - that analysis seems correct.  The interfaces seem a bit
> > weird here but fixing them looks like the most complete and robust fix.

> Ok Mark, I'll fix this problem as soon as I can, using EPROBE_DEFER.
> For now, in my application, I use the patch that I already sent,
> with the "softdep" workaround:

> MODULE_SOFTDEP("pre: dw_dmac");

> I tested it a lot, with more than 2000 cold reboot (automatic
> switch on/off using a controlled power supply) and it always worked good.

Right, and to be clear that patch is good and useful independently of
the deferred probe fix so assuming nothing else comes up in review I'll
apply it.

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyvGgIACgkQJNaLcl1U
h9A0zwf6AirGRh8bQQli94rYunYRwRhABvSKVNVzjNeqW24AoyboZcJZQcx/mc54
H/sAv4CsbVbYE+zrc1HtH/tV4fDucGRAuBGMAnUDOCCqbPYJWfLr+JfT3bqIiqX2
xY7sw7D9zv9HeSh2zOZzSFniLz59BiJ/iPf+FQC86UGwOZGD7ObiGcUbhQHuqYXT
4DYwgPTMpp4lFCZXnSXXJarOhgbXAW1qgAIRBNHkeRcns49p5K9otzxQX/S5BJ/i
8Wc5VqAHlqpDAeRN0slBFk5b46GrfCM0vvBiumcl0IZhxESXSN5lneqpIohPF0nq
r1/WWyaRdIE36xqIMv02mAgujBqkmQ==
=2+YG
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
