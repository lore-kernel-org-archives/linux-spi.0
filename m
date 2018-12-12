From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Date: Wed, 12 Dec 2018 09:21:48 +0000
Message-ID: <20181212092148.GA6920@sirena.org.uk>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
 <20181211011428.GH3004@sirena.org.uk>
 <20181211071300.7xxmzhfj26qt2tle@pengutronix.de>
 <20181211115601.GB6686@sirena.org.uk>
 <20181211201126.vl6s7sesnzukbybt@pengutronix.de>
 <20181211204047.GR6686@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1340525942455187310=="
Cc: Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181211204047.GR6686@sirena.org.uk>
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


--===============1340525942455187310==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 08:40:47PM +0000, Mark Brown wrote:
> On Tue, Dec 11, 2018 at 09:11:26PM +0100, Uwe Kleine-K=F6nig wrote:

> > FTR: your reference to an "unanswered question" wasn't optimal either. I
> > had to search my inbox for a while to determine what you could have
> > meant :-)

> At the time I wrote that I didn't actually know, I just knew that I'd
> remembered the subthread ended with a question to Marek about if this
> was needed.

Just to expand on this a bit: the way I'm working here is that I'm
remembering if there's some reason I'm expecting some additional
replies, either because there's someone likely to do review on the
relevant code, there was some specific question I remember or because
there was a discussion that seemed to peter out without conclusion
between people who are likely to respond.  If something like that is
happening I'll leave a bit longer for replies than I might otherwise
(conversely if it's something where it's very unlikely that there will
be any comment I'll tend to leave less time).

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwQ0yoACgkQJNaLcl1U
h9Bn7wf/TLLMY32QQOzcMf5lWIv8sUd0izrZaVfMgE6eRdFZdpcpSpE+fVqK4zPt
w6Qk0MN1hoF8HsJvR7W0Gn0rLb9CgcLYj0qFgbD1JvU/rtOrkP1C4JnB8hAsRHKj
brBBOSsVjy+47KmSR24a17e1/6B9Yvbt62HI6ylAQtpXf7Aom3o6ndAogOkyDyOo
HKCV6xcFZge5/vamJQJ3HxDS4K+EnESq/8u9ORrFetqhaG1Dl74Mt+HzMK58f5w5
mbCFkUJ8r+NbMfTPP3Lyd0smXfLAI4cSMdqod0tVkoX0De9WGsdNhwOnO6kW+FrU
zbk94YmHaVvqy0vqa7CKAvRVNBXhdQ==
=HWCU
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--


--===============1340525942455187310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1340525942455187310==--
