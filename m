From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ARM: spi supports 32bytes buffer for DUAL and QUAD
Date: Fri, 4 Nov 2016 11:06:14 -0600
Message-ID: <20161104170614.vd6cd5ondkg47ljj@sirena.org.uk>
References: <1478248734-32044-1-git-send-email-cm-hiep@jinso.co.jp>
 <1478248734-32044-2-git-send-email-cm-hiep@jinso.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aj7a4gze6mn72kke"
Cc: geert+renesas@glider.be, linux-spi@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
        ryusuke.sakato.bx@renesas.com, linux-renesas-soc@vger.kernel.org,
        nv-dung@jinso.co.jp, h-inayoshi@jinso.co.jp
To: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478248734-32044-2-git-send-email-cm-hiep@jinso.co.jp>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--aj7a4gze6mn72kke
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 04, 2016 at 05:38:54PM +0900, Cao Minh Hiep wrote:
> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>=20
> This patch supports 32bytes of buffer for DUAL and QUAD in QSPI by
> Using Transmit/Receive Buffer Data Triggering Number.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--aj7a4gze6mn72kke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYHMACAAoJECTWi3JdVIfQ/40H/0AqAeT57aR4B/KB/GlcYfMS
brX6x0uTXbPBJJe818f+0YHy8hCmhkwfZhUGWKQqyadd9CjhEiMmKAMSOAAJVlAO
UvbYY/AKES4g9iXl/sPWWUfLJvr83uJ01qK1AKAeMSS0EinzF8lbZGhIbTWydgdG
LdQR3mvz531GRQ+KAdJ9nJFr4ThzDJuhcG14e4x22PNWZkHdkbn8gQcLJLoghbmK
9rfT9M2uXhZColF/CnhAtMCRYnFCZvujLFSR6uVskonZTkvejSO1FSxqqReoBL2o
ZHQLaHKj7OzSXToODftoNVmn7S132czhomn7JHL6596vmSjxWDEx3r1btUe0YJs=
=Sb2B
-----END PGP SIGNATURE-----

--aj7a4gze6mn72kke--
