From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/15] spi: img-spfi: RX maximum burst size for DMA is 8
Date: Mon, 30 Jul 2018 16:34:46 +0100
Message-ID: <20180730153446.GN5789@sirena.org.uk>
References: <20180722212010.3979-1-afaerber@suse.de>
 <20180722212010.3979-14-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GEn4szYucjS2InE7"
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        linux-spi@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180722212010.3979-14-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--GEn4szYucjS2InE7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2018 at 11:20:08PM +0200, Andreas F=E4rber wrote:
> From: Ionela Voinescu <ionela.voinescu@imgtec.com>
>=20
> The depth of the FIFOs is 16 bytes. The DMA request line is tied
> to the half full/empty (depending on the use of the TX or RX FIFO)
> threshold. For the TX FIFO, if you set a burst size of 8 (equal to
> half the depth) the first burst goes into FIFO without any issues,
> but due the latency involved (the time the data leaves  the DMA
> engine to the time it arrives at the FIFO), the DMA might trigger
> another burst of 8. But given that there is no space for 2 additonal
> bursts of 8, this would result in a failure. Therefore, we have to
> keep the burst size for TX to 4 to accomodate for an extra burst.

This seems like something that should be sent as a bug fix - doesn't it
fix anything?  If it is a fix then it should've gone at the start of the
series so it's got no dependencies and could be sent to Linus for the
current release.

> While here, move the burst size setting outside of the if/else branches
> as they have the same value for both 8 and 32 bit data widths.

Though this refactoring probably less so.

--GEn4szYucjS2InE7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltfMBUACgkQJNaLcl1U
h9A8fQf8DSTyUdJz3ii5KeP1L+ww020+hxhlkv6pI/+iToSlsTzqljvcJqKoodUd
I3GKROAn1z+oIhdlLTrzq6PbLbGd7/VIK6GR5RG5Y7hRuOBy4dPhvG896r/24s8s
kKZHboyXoKWh841UylnNOKFs7NVSrZJ1B9ru3XczSPD62ge8mYmkuhrzAYBuNdhW
lqiz+ADaMgakHv4cOL5vJPkJFgqGYdHsAtiCY59qfl2huKrhDs8oeFODFlLGB+DK
O8BIwugd0spRSWKIo/cZIqguWPjHn+RT2wUZzWRt1yNnPpXioU2EjHGs3CzVpsfQ
8fXKQOaliO6vHri/IWdvMiSHi+t0ug==
=NzDz
-----END PGP SIGNATURE-----

--GEn4szYucjS2InE7--
