From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/7] spi: spi-fsl-dspi: Add support for TCFQ transfer mode
Date: Thu, 29 Jan 2015 12:13:20 +0000
Message-ID: <20150129121320.GI21293@sirena.org.uk>
References: <1422356608-15961-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356608-15961-2-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150128190342.GE21293@sirena.org.uk>
 <1422533049999.91114@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+b69FlTXZi5jeJ9W"
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"stefan@agner.ch" <stefan@agner.ch>,
	"shawn.guo@linaro.org" <shawn.guo@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"B44548@freescale.com" <B44548@freescale.com>,
	"Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: "BhuvanChandra.DV" <bhuvanchandra.dv@toradex.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422533049999.91114@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--+b69FlTXZi5jeJ9W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 29, 2015 at 11:58:25AM +0000, BhuvanChandra.DV wrote:

> As far as i understood the major difference between the two modes are when
> the interrupt to trigger, as EOQ mode will trigger the interrupt at end of
> queue and TCF will trigger the interrupt at every frame transfer. Probably
> mode selection shouldn't be a device tree property, but i don't see any
> automatic way to choose between the modes.
> Maybe a config would be more appropriate?

Or if there's either no particular reason to choose one over the other
or one is always better then just pick one in the driver and don't worry
about implementing both.

--+b69FlTXZi5jeJ9W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyiPfAAoJECTWi3JdVIfQERQH/RQ8TEoE6Fq+doSDczZ7ViUg
rj51hTC1gzhgNtgICDzMjuurX/qxvC2pNCxZUWzxgG/Hh5V+7pjFi6+zmlyPp4xA
qG8ktLi2WoowWa2pYJa+rmA2Z5JYwha5GY0JsEDntA/da+oyc9DUN6osvyHXcGvq
mbTfmaXYtlEV+MfhqX0kWtBfqIdDUs8PDHcbrdp1ot0DQjO8KikvBebQNfOnVxrf
kApfPtNXTkaCs1mkekI3IXnwTW+UDKIy2xbldZUQOzPffwTNaQhfZ4BcpO8LLYOr
cxkpZD8MLgyuJ9KaHrVqMoaFY9ohKDUa+l+XFSDaMf2LcTfw9uY9o4u6k+pXPSQ=
=j3xY
-----END PGP SIGNATURE-----

--+b69FlTXZi5jeJ9W--
