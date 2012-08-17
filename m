From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/10 V3] MXS SPI driver
Date: Fri, 17 Aug 2012 22:55:39 +0100
Message-ID: <20120817215538.GD18871@opensource.wolfsonmicro.com>
References: <1344007575-11448-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6607193136553357683=="
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
 Shawn Guo <shawn.guo@linaro.org>, Attila Kinali <attila@kinali.ch>,
 Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net, Chris Ball <cjb@laptop.org>,
 Dong Aisheng <b29396@freescale.com>, linux-arm-kernel@lists.infradead.org
To: Marek Vasut <marex@denx.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1344007575-11448-1-git-send-email-marex@denx.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============6607193136553357683==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 03, 2012 at 05:26:05PM +0200, Marek Vasut wrote:
> This patchset adds SPI master support for Freescale i.MX233/i.MX28.
> This is rebased on top of next-20120713. Please consider applying,
> bugs shall now be squashed during the previous two review rounds.

I applied all these except patch 10 (the pinctrl data) which Shawn
wasn't happy with and which seems like it'd make sense to merge via the
arch tree anyway since it's likely to avoid merge conflicts.

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLr3PAAoJEFJkBDiqVpZ4+oUP/jXhe0lj5SZIJikoO7bvD4/b
stHpPRNAovBFPaaIQOPMU3XiuHlLhdXBXBADIS0794HRoeBHctuMhBhVDUcDxY0m
7IKvsPYjmtjndeBveDpLBdTua1aXPO4KmT0i2pwTdALqHu7GEMjIwFRBGU1wALfg
MTrOlhPZ/DyQOce+Hip0gdPoAM544rd1Uq7RKES8NRnuWD3nUNTpkiPtLilSSSpP
gYSp9ctQNv+2SA2d8ogg/Sw8BzLVAKMNfogn98CA/km/+q1wXaKUqjqFhcpI7rkn
fCicvDsf4JtHaWD9hiT2omnAfe6qdgY4XAfUJtOryrlxEhAKx75u33xJBpWb05FO
uRKPl4cjsNHDnaYI+gXo1YFLyaTDsq2M/aFQPH2PsCPx0eXV2oQ6bYy+g1c0hA01
cv1A4riavpLcSxX6ZHZ6gtcSZ+0Wg/7LK+THvLMmGyt6oLHF9frKyJ9p9KT0kl/8
ENfEseQZw3jVvyL7MhFk2uX4FqYu3WxLz+dgTSgwXVEflMBPhgYRaNOL1RlgP6AM
q21Iugax43/gRWtIMamypWPDRCY+SmrHgrKJ49JW+nOcJrXf8nUtc3by9bfWbuHM
Koexz/VNX1RYhd0w+9egx5duXPA8kYejRR1vcBCuLZsBlMJCGwhAcXFCTLCZcSYe
Q8NT9lN6ObMbHBC3cD7r
=g5wp
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--


--===============6607193136553357683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6607193136553357683==--
