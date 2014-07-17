From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ARM: DTS: fix the chip select gpios definition in
 the SPI nodes
Date: Thu, 17 Jul 2014 19:49:44 +0100
Message-ID: <20140717184944.GE17528@sirena.org.uk>
References: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
 <1405523950-2231-5-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1mpN54+oXr72ab9j"
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	Olof Johansson <olof@lixom.net>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1405523950-2231-5-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--1mpN54+oXr72ab9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2014 at 05:19:10PM +0200, Javier Martinez Canillas wrote:
> From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>=20
> This patch replaces the "cs-gpio" from "controller-data" node
> as was specified in the old binding and uses the standard
> "cs-gpios" property expected by the SPI core as is defined now
> in the spi-s3c64xx driver DT binding.

I've applied this one too since everything here really ought to go in
together and we should probably try to get this into v3.16 - Kukjin,
please say if this is an issue and I can revert.

--1mpN54+oXr72ab9j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyBrFAAoJELSic+t+oim9GrAQAIuX0t+BTxKUVhElJCfpCPku
1hvwJ6/BdEiz0P7O5vmBMyiWC458B1F0f5pNiy85ELQ6uPi6jAN6UwcrDBQzD1yQ
DUF763gYtyd4Ug2u/UrfJB/DAYAahteEWM7RNPZQBmxIlUMLvghje/ls9nFq1Q1c
tZUHrZ2RQi+hyBzPQWi4iO2MBM9p8ILAPtoVx6CeDPne1lmbKOEUIiiLdufcmj5H
06/Q+ah3NyJa9qB3jmUN+CJzDCc3dwGMzCkMLj6OG/94yb8n7e74BWuByfAmCclt
JMTTko0aYl7CHE7/hGvZ5/f/q0LkTAbuuRxCpkZeGFoeDBuGFdlrMgG/hzFirkGm
X0iCV2VclgwuCcdw22yFAZna7gB9w6e11AW1YvJZIKpPLJ3c5D0fostPJ7RwbE1/
HP3hwzQoU1Q6vZ5AasjVteoxZL4UgkBCyZFNMI0yBm7XgXdYK1qe/l67/S6YXvlF
c0dsA+nr9pF/tFTu2sILYC4KxJm9Qf7kx2Jrin/NR3RUyppKtoxESad8Mlh3YT38
bt3ktUUPA9xs+6iz1jF+1h5ngF2LsGkx156LBVdhluAZocHISe/pQaQHem/7GTDp
FXFdDyA05pnZHacBQsm1LLaUqIA8qkJ0X5SFDQyS+N/RRUnff47HdyQ7CqHiHcjJ
CaokWmCD/cQktEsINexM
=OHro
-----END PGP SIGNATURE-----

--1mpN54+oXr72ab9j--
