From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/1] spi: spi-fsl-qspi: call spi_unregister_controller
Date: Tue, 12 Mar 2019 12:24:09 +0000
Message-ID: <20190312122409.GD6983@sirena.org.uk>
References: <20190312101203.14207-1-volker.haspel@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        han.xu@nxp.com, john.ogness@linutronix.de
To: Volker Haspel <volker.haspel@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312101203.14207-1-volker.haspel@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 11:12:02AM +0100, Volker Haspel wrote:
> Changes since v1:
>  * use devm_spi_register_controller() instead of calling
>    spi_unregister_controller() in the remove function

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyHpOgACgkQJNaLcl1U
h9DjtQgAg5eiDB3pBA1vGOD4u4Xy5yMzK8wjQMOqxRAQ73fPQF9KQhm9vS+vdgOA
UrWrpMUXubQN1SAIDu2WP7XNz5xiAx4U4Clz29xsLeagiGPQ7pvxoK13WNA2iaoy
8DwgOmx2qpTGNWh3X1NNIKMVVOD7MnAnGNGGT7s1AfnANb3jr10j7iaLDRrR8+o0
i9K5Cjbh+2JHZ6KNOGBYIV7toLDGC8PX34MhMfeY7EMTxbTGrAhFt/uflOYi5YHY
cpsjrZ1tyfbpDLYQ+jPGRGfZ0Tk0YO19oguBoUwf4Kd1AirPfUb45XE4cGPQfJ2T
IlW6mPvjUSvMJc7CLW3dPd3ZE+DQBg==
=aWMA
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
