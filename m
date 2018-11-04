From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 11/11] spi: pxa2xx: Deal with the leftover garbage in
 TXFIFO
Date: Sun, 4 Nov 2018 13:19:01 +0100
Message-ID: <20181104121901.GW23864@amd>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-12-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hc4757KF+wLS/WHK"
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010170936.316862-12-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--hc4757KF+wLS/WHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:09:36, Lubomir Rintel wrote:
> There doesn't seem to be a way to empty TXFIFO on MMP2. The datasheet is
> super-secret and the method described in Armada 16x manual won't work:
>=20
>   "The TXFIFO and RXFIFO are cleared to 0b0 when the SSPx port is reset or
>   disabled (by writing a 0b0 to the <Synchronous Serial Port Enable> field
>   in the SSP Control Register 0)."
>=20
>   # devmem 0xd4037008           # read SSSR
>   0x0000F204
>   # devmem 0xd4037000 32 0x80   # SSE off in SSCR0
>   # devmem 0xd4037000 32 0x87   # SSE on
>   # devmem 0xd4037008
>   0x0000F204
>          ^ TXFIFO level is still 2. Sigh.
>=20
> The OLPC 1.75 boot firmware leaves two bytes in the TXFIFO. Those are
> basically throwaway bytes used in response to the messages from the EC.
> The OLPC kernel copes with this by power-cycling the hardware. Perhaps
> the firmware should do this instead.
>=20
> Other than that, there's not much we can do other than complain loudly
> until the garbage gets drained and discard the actual data... For the
> OLPC EC this will work just fine and pushing more data to TXFIFO would
> break further transactions.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hc4757KF+wLS/WHK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve47UACgkQMOfwapXb+vJ0kQCgoz2t2PBI0Wsd+Q8gcUWHfqCX
G80AoJoac16+K78lqYwRylFytYLxCjR8
=13JX
-----END PGP SIGNATURE-----

--hc4757KF+wLS/WHK--
