From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/7] spi: spi-fsl-dspi: Add support for TCFQ transfer mode
Date: Wed, 28 Jan 2015 19:03:42 +0000
Message-ID: <20150128190342.GE21293@sirena.org.uk>
References: <1422356608-15961-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356608-15961-2-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6940705788445701169=="
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk,
 B44548@freescale.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 Li.Xiubo@freescale.com, linux-kernel@vger.kernel.org, stefan@agner.ch,
 linux-spi@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org,
 shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
To: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422356608-15961-2-git-send-email-bhuvanchandra.dv@toradex.com>
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


--===============6940705788445701169==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UAlHjJyhZOsh4iI+"
Content-Disposition: inline


--UAlHjJyhZOsh4iI+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 27, 2015 at 04:33:28PM +0530, Bhuvanchandra DV wrote:

> TCFQ is interrupt of Transfer Complete Flag in DSPI module.
> EOQ is interrupt of End of Queue Flag in DSPI module.
> For adopting of different platform, either of them is a way of DSPI
> transfer data. This patch add TCF support for DSPI module  in other platform.

I can't really understand what the purpose of this is, sorry.  What are
these modes and why would one choose one over the other?  Your changelog
suggests this is being done per board which implies that it's tuning for
performance but that's usually something that should be done in device
drivers, not the device tree - perhaps the tuning will change over time
as the driver is optimized or perhaps it varies depending on the
transfer.

The code mentions a DMA option as well, generally where it's available
DMA is something that's chosen at runtime based on the length of the
transfer.

--UAlHjJyhZOsh4iI+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyTKOAAoJECTWi3JdVIfQPKcH/3Erd0oqBbMx2yTzxFxA7J+w
KStS/tk19QvU1KJHTUi/CdoTkejfrmG5p8EL8xpfzBz3ZRXO8jnu7ux4hbP5AfoP
tRHFmWrronc4CMiyU/319oWHxA+GZS9mUa6uYncqy6wIuZiYRS1RUVFliNuf0pcr
26P4ScT4MakcnNWh70PDIddzmKZk3MjMksr3iUCp+CHf5cAAYAclyOZ3KQ5xWQsX
SkCpQt5Kb29f7DC7tSbnJQVeff/kJy8Yuxb98kqqsLSSZVvxlj5ctGzZa480wmo/
+lKJFRam+VoljjCZjXVedzAsgibfhoc09Bpue1tAzjwLaOb1VLDqdmteDjG6xJA=
=C6j2
-----END PGP SIGNATURE-----

--UAlHjJyhZOsh4iI+--


--===============6940705788445701169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6940705788445701169==--
