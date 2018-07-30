From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 14/15] spi: img-spfi: Finish every transfer cleanly
Date: Mon, 30 Jul 2018 16:35:03 +0100
Message-ID: <20180730153503.GO5789@sirena.org.uk>
References: <20180722212010.3979-1-afaerber@suse.de>
 <20180722212010.3979-15-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O3WNCzIuUImKerqE"
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        linux-spi@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180722212010.3979-15-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--O3WNCzIuUImKerqE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2018 at 11:20:09PM +0200, Andreas F=E4rber wrote:
> From: Ionela Voinescu <ionela.voinescu@imgtec.com>
>=20
> Before this change, the interrupt status bit that signaled
> the end of a transfer was cleared in the wait_all_done
> function. That functionality triggered issues for DMA
> duplex transactions where the wait function was called
> twice, in both the TX and RX callbacks.

Again, is this not a fix?

--O3WNCzIuUImKerqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltfMCYACgkQJNaLcl1U
h9BZmAf/QwgRuAnirIDhBewibP4c4V9oElrLpan9KExyh8toALsp037PJxbaO9oN
sCnn3i2vHYQPNmM92QOn24RQf5wE3KbuqDeS+5podX+Js+xX7VBqTT6X63KvtR6j
5R1wZ8XD0Nla/K8eNPoG55mbVNgFxeSwkVeQy2HU3JYo0Bzx6ShxDqkaBKFnoMkC
I0RoWsX2xV0DLcfRhQRRSpEIe2dtV++GR48Nfs2Auw8ZpAYukTZBik4DQ9ZwgEro
pP9MYuuGcW6TNGIqIDybg2DK2snVR9QBmCQv96IpTI9grZJiKBEQimOtw3eJ0qip
6RdZjmm9JC60Ejak/3jBUqfQTbuH7Q==
=ZyLh
-----END PGP SIGNATURE-----

--O3WNCzIuUImKerqE--
