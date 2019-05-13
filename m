From: Mark Brown <broonie@kernel.org>
Subject: Re: [resend] [PATCH 5/5] spi: bcm2835aux: support effective_speed_hz
Date: Mon, 13 May 2019 16:12:14 +0100
Message-ID: <20190513151214.GB5168@sirena.org.uk>
References: <20190223150705.10729-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5581634880545130080=="
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: kernel@martin.sperl.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190223150705.10729-1-kernel@martin.sperl.org>
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


--===============5581634880545130080==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 23, 2019 at 03:07:05PM +0000, kernel@martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
>=20
> Setting spi_transfer->effective_speed_hz in transfer_one so that
> it can get used in cs_change_delay configured with delay as a muliple
> of SPI clock cycles.

This needs rebasing against current code.

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzZiU4ACgkQJNaLcl1U
h9DUMwf9HVUWCWikiFC7SUxOGSqhM2/tdziY9oZvOLbKO5fqkF9etxS2JQMCLyFK
SOceSXWZO+JOX5BR780dE6Mi4OwWjt7edeQmhGfrz6FbQ2kBOTeDyx5VVg2UCm4x
fphwn4/EwX1IQAz6ZBqmVE1WSuZBede/dT+7GeRKRRMlhqY8r8T1AElKOKbQsdlO
RbZ8SaizniMo68tqXDX595rt9Vy73yeAE2WFchucJjQPzj9mU6gDzoyBv6b9EL/R
jBegJsUNzmrdlDL4I0wAIdLrOZiF+LTN5EUZDTlV5R5do8eLl9ErRHQyF9iAExpO
vqGdIyW/QMtJXQvxOHrEsO6ce9CiBw==
=3EQn
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--


--===============5581634880545130080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5581634880545130080==--
