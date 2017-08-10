From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 03/16] mtd: spi-falcon: drop check of boot select
Date: Thu, 10 Aug 2017 16:05:15 +0100
Message-ID: <20170810150515.w66ksbfexbcegy6z@sirena.org.uk>
References: <20170808225247.32266-1-hauke@hauke-m.de>
 <20170808225247.32266-4-hauke@hauke-m.de>
 <20170809114421.oo2bunardgw3p4tk@sirena.org.uk>
 <0DAF21CFE1B20740AE23D6AF6E54843F1EA0A385@IRSMSX101.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s6uae5i4hoypg7dc"
Cc: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>,
        "ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org"
        <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
        "john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org" <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "Mehrtens, Hauke" <hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "kishon-l0cyMroinI0@public.gmane.org" <kishon-l0cyMroinI0@public.gmane.org>,
        "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: "Langer, Thomas" <thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0DAF21CFE1B20740AE23D6AF6E54843F1EA0A385-kPTMFJFq+rF9qrmMLTLiibfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--s6uae5i4hoypg7dc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 02:02:16PM +0000, Langer, Thomas wrote:
> > On Wed, Aug 09, 2017 at 12:52:34AM +0200, Hauke Mehrtens wrote:

> > > Do not check which flash type the SoC was booted from before
> > > using this driver. Assume that the device tree is correct and use this
> > > driver when it was added to device tree. This also removes a build
> > > dependency to the SoC code.

> > Why?  Is this assumption reliably true?

> Yes. We only have one type of flash interface in the device tree, as they=
=20
> are connected to the shared EBU (External Bus Unit).

That sounds board specific but this is a driver for a SoC?  In any case
this needs to end up in the commit log.

--s6uae5i4hoypg7dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmMdioACgkQJNaLcl1U
h9BYlAgAgCDu3huZzBs6oYvZZ+POaY/GV5Cs55enzpxuT8F87rnOrYbTGQw66HzP
+4Foc1xogiJOKDNSs+BpPiuFTo/zvwu+ApKkEE8OeaDOQh4gVhCag/OUKz9z5hAZ
ZvSHQud2xiO1FjFZeLFB1KGEA9jb9ltOjWdJxqdiv1S9mV4ITiVho//mhTNf6HcL
RMiKTeDmSz37Q3X1vgrnQehpTYgqUHYCzr/NjUjsJ3nATLZpr8bLbLhh4YKalxqj
Elnt3lXSauR4/LfcfwpSqRYfeMP/LhWAHMRRJpSMLqFVAyWgndZP9IXm9mP4fXia
R3yhSmQxzNY7qhWMoY1vQAfNsr4hwA==
=HdUK
-----END PGP SIGNATURE-----

--s6uae5i4hoypg7dc--
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
