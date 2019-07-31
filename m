From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6] ReST conversion patches not applied yet
Date: Wed, 31 Jul 2019 21:37:12 +0100
Message-ID: <20190731203712.GJ4369@sirena.org.uk>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
 <20190731141734.1fa9ce64@lwn.net>
 <20190731202007.GI4369@sirena.org.uk>
 <20190731172613.32d65ad8@coco.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3714740399510256660=="
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Kleikamp <shaggy@kernel.org>,
 alsa-devel@alsa-project.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Evgeniy Polyakov <zbr@ioremap.net>,
 linux-cifs@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Corbet <corbet@lwn.net>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
 Evgeniy Dushistov <dushistov@mail.ru>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, samba-technical@lists.samba.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190731172613.32d65ad8@coco.lan>
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


--===============3714740399510256660==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XigHxYirkHk2Kxsx"
Content-Disposition: inline


--XigHxYirkHk2Kxsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2019 at 05:26:13PM -0300, Mauro Carvalho Chehab wrote:
> Mark Brown <broonie@kernel.org> escreveu:

> > There were outstanding questions about where it was going to get moved
> > to but if I read the diff correctly it looks like it didn't actually get
> > moved in the end?

> Yeah, it doesn't have the move. My understanding from our discussions
> is that we didn't reach a conclusion.

Yes, that was my understanding too which was why I was surprised to see
this going in.  This is OK then, I'd have acked it.

> In any case, I can send a separate patch with the move part once
> we reach an agreement about what's the best way to proceed (or you
> can do it directly, if you prefer so).

I'm not likely to do anything without someone sending patches, I'm not
clear on the utility of the move with the current division of the
manuals.  I don't know if it makes sense to have an embedded developer's
manual as well?

--XigHxYirkHk2Kxsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1B+/cACgkQJNaLcl1U
h9Ccawf2NvrLW0ujC5HwkDxagYC2dfnUGm4OOyP/LcS7ufD9vxwdAh08IDJFyHJv
4skkK8AdqWOxNms4e9NRiQE51vul7GMBtbp3YezYEiaaB3tMTrWe2rHSEp10OQmH
5WnnpB7KKnUS3UBTwvFRzI1mGWz+klXpzy50z3hsX9UXUArVoqyDRtSY0YDF3+7k
UNhXw0y2taeDMGRzZnOTDxQkejK13T42Oo79xbzylHww8x1vVqV2s4xLTqn2zaN4
W0DIoJIGec2Ewe6JPUio9xvsURtWmWOet6jFLRZO9oiO6uJqrvQde50F6siwwFgY
JMTn2OFfPMPUZVF4ugqAE7qxQaHM
=etK7
-----END PGP SIGNATURE-----

--XigHxYirkHk2Kxsx--


--===============3714740399510256660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3714740399510256660==--
