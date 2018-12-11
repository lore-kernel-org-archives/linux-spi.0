From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Date: Tue, 11 Dec 2018 20:40:47 +0000
Message-ID: <20181211204047.GR6686@sirena.org.uk>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
 <20181211011428.GH3004@sirena.org.uk>
 <20181211071300.7xxmzhfj26qt2tle@pengutronix.de>
 <20181211115601.GB6686@sirena.org.uk>
 <20181211201126.vl6s7sesnzukbybt@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0332868653661521675=="
Cc: Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181211201126.vl6s7sesnzukbybt@pengutronix.de>
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


--===============0332868653661521675==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1GSL5ZULXUIqbbH1"
Content-Disposition: inline


--1GSL5ZULXUIqbbH1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 09:11:26PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Dec 11, 2018 at 11:56:01AM +0000, Mark Brown wrote:

> > That was the unanswered question.

> FTR: your reference to an "unanswered question" wasn't optimal either. I
> had to search my inbox for a while to determine what you could have
> meant :-)

At the time I wrote that I didn't actually know, I just knew that I'd
remembered the subthread ended with a question to Marek about if this
was needed.

> > Please include human readable descriptions of things like commits and
> > issues being discussed in e-mail in your mails, this makes them much
> > easier for humans to read especially when they have no internet access.

> I'm always willing to learn how to make my mails more cooperative.

> I'd hope that even when offline you have a linux.git at hand to resolve
> what I meant with "6fd8b8503a0dcf66510314dc054745087ae89f94". Apart from
> this unannotated commit hash it's not clear to me what else could have
> been improved here.

Including the title of the commit.  It's not just about offline usage,
it's also about making the mail easier to read - having to stop and use
another tool to understand what's being talked about is a blocker to the
flow of reading the message.

--1GSL5ZULXUIqbbH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwQIM4ACgkQJNaLcl1U
h9Arlgf/fQIOyHZqRpOQr6RPQfJwGfxbeA8K+7Gvg8QN3IKqr0PgTOMAq+oz3gx9
ndS7UjGHceOuMj7eo6HjDE43OeFETppZH9uBRFf20nrBCvY1ACLAhlzMhPwe6X2r
JBMnTcbDrjaU8+EsSvELc91gyJqLZw/+MNlh6isGXU5qgktqpfOnvxfhGV0a9qhd
/5HEK5DR2WewHe83QuAZruBnuH/vMUqfotib0+Wc0IKKL+TV84NkSe16xJ66lDTc
pb5NZv1NRXosb/hI/qu+Rvo49yCDkycn9wiP/r/NuUY1edsS29MliZEIg0lSSzQm
owBAXW4EcQMQMPhjsvtFvPEtBdsJ5A==
=Nt7v
-----END PGP SIGNATURE-----

--1GSL5ZULXUIqbbH1--


--===============0332868653661521675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0332868653661521675==--
