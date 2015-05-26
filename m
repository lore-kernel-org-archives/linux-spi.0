From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] spi: orion: Fix extended baud rates for each Armada
 SoCs
Date: Tue, 26 May 2015 11:38:06 +0100
Message-ID: <20150526103806.GN21577@sirena.org.uk>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6843361491604114282=="
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Tawfik Bayouk <tawfik@marvell.com>,
 Boris BREZILLON <boris.brezillon@free-electrons.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
 Lior Amsalem <alior@marvell.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============6843361491604114282==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0HX8KfI760FczsQW"
Content-Disposition: inline


--0HX8KfI760FczsQW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 11:44:43AM +0200, Gregory CLEMENT wrote:
> The commit df59fa7f4bca "spi: orion: support armada extended baud
> rates" made the assumptions that all the Armada SoCs supported the
> same maximum frequency. However, according the hardware datasheet, the
> maximum frequency supported by the Armada 370 SoC is tclk/4, for the
> Armada XP, Armada 38x and Armada 39x SoCs the limitation is 50MHz and
> for the Armada 375 it is tclk/15.

Applied, thanks.

--0HX8KfI760FczsQW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZE0NAAoJECTWi3JdVIfQUUIH/jrfJnqwetlAXpXqstYlyJL7
dc4XEg9SWg6bQsvWgjxgfs9q+UJae6vYJBGA9NdxZkKfNMsMcopOIKRMN+gItSFp
eD8bCnRcVqWPVRhy2Toib9GhrMsgBlRMeZjgne8lJ409tzCMrbILa5OfEa+0fxPm
JHfgCd6qVgXJVdoS2y1YBoUkbM1NTk7Gt3HjuBzqsq8H7TlkILbdbmL3T3JgCRty
maPyum35bLrTRzwjCLKw7Mw0vHOZLp5gvGUGxPuE1haodXyGBDiIv2EApTt5bLxo
hyfyicPMJNTHKRP6b6eEiPuvA/+/E8mFmH8IzxXV9t40vA65vyoZ4J2Spuz3Qbk=
=HrmS
-----END PGP SIGNATURE-----

--0HX8KfI760FczsQW--


--===============6843361491604114282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6843361491604114282==--
