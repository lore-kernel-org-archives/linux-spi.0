From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Date: Tue, 11 Dec 2018 01:14:28 +0000
Message-ID: <20181211011428.GH3004@sirena.org.uk>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5264927719322542878=="
Cc: Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
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


--===============5264927719322542878==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 10:52:41PM +0100, Uwe Kleine-K=F6nig wrote:

> In my eyes this series is ready to go in. The feedback I got so far was
> only that there could be done still more. And given that patch 2 is a
> fix I'd like to see this in 4.21.

It looked like there was an unanswered question about if patch 2 was
needed or not?  Marek?

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPD3MACgkQJNaLcl1U
h9AoxQf+LAD4Pl6CalbY2GtA8alHYRlKMnsKRqnBlErXW8A5weLHG8rrdQIgE32C
ZSLn0bw5p1za+knDvnPWKLNKDIRfEajbYLGzkXmKW4puG9N2Q3tzIXOa6lh0vBkB
U5LisSa152c+q9O/6cHQthLRUkj/gvifJbZl8Dio0iD6dnGWwnujV/AHyNKTbvP0
d7SG3Qhe7osp92wKVM5RhOdOrMm1p69vM26ph8mj8DXS8/py9LDD7wUbGhaggvp8
OpUMV2/7LWmO4mdYmCqTYuIAJgo69GPatHcDKkjA8mGgqqS5ibvPqWHkF306/uGt
1wFf3AjpjX6J1QjJ1/L+A/KGICSEdw==
=kIjU
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--


--===============5264927719322542878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5264927719322542878==--
