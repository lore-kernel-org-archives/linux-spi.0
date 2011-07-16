From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 4/7] at91: remove non used at91_spi.h
Date: Sat, 16 Jul 2011 13:56:55 +0200
Message-ID: <20110716115655.GA1992@pengutronix.de>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
	<1310687525-22486-4-git-send-email-plagnioj@jcrosoft.com>
	<4E2028E1.1060603@vollmann.ch>
	<20110715154636.GA20678@game.jcrosoft.org>
	<4E206E7D.2070708@vollmann.ch>
	<20110716105752.GD20678@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1259048447=="
Cc: spi-devel-general@lists.sourceforge.net,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-arm-kernel@lists.infradead.org, Detlef Vollmann <dv@vollmann.ch>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110716105752.GD20678@game.jcrosoft.org>
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


--===============1259048447==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > About the SPI driver:
> > From Documentation/spi/spi-summary:
> > "At this writing, Linux has no slave side programming interface."
> > So there's no SPI framwork that covers the slave side.
> This what I mean use the SPI framework and add the SPI Slave support there

[CCing spi-devel]

If you talk about SPI slaves, be sure to have read Grant's comments in

http://thread.gmane.org/gmane.linux.kernel.spi.devel/7401

to see what would be needed for slave support. Short note: Would be
seperate subsystem, master subsystem is of limited use. I think a few
slave-drivers would be nice to evaluate, so one can get a feeling if a
subsystem makes sense and if so, how it could look like.

Detlef, have you posted your slave driver so far?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4hfIcACgkQD27XaX1/VRtl/gCePmM3F148LozUSMHEvusExEUV
6PYAoKlj9VvVEMofjbARMOZ53MMKM73c
=Dc59
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--


--===============1259048447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1259048447==--
