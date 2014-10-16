From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi/rockchip: fix bug that case spi can't go as fast
 as slave request
Date: Thu, 16 Oct 2014 12:26:36 +0200
Message-ID: <20141016102636.GE2200@sirena.org.uk>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
 <1413372349-4254-1-git-send-email-addy.ke@rock-chips.com>
 <20141015130452.GD27755@sirena.org.uk>
 <543F8CD2.1010302@rock-chips.com>
 <20141016093410.GB2200@sirena.org.uk>
 <543F96DB.40403@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Cc: heiko@sntech.de, dianders@chromium.org, grant.likely@linaro.org,
	robh+dt@kernel.org, amstan@google.com, sonnyrao@google.com,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	olof@lixom.net, hj@rock-chips.com, kever.yang@rock-chips.com,
	xjq@rock-chips.com, huangtao@rock-chips.com, zyw@rock-chips.com,
	yzq@rock-chips.com, zhenfu.fang@rock-chips.com, cf@rock-chips.com,
	zhangqing@rock-chips.com, hl@rock-chips.com, wei.luo@rock-chips.com
To: addy ke <addy.ke@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <543F96DB.40403@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 05:58:51PM +0800, addy ke wrote:

Please fix your mailer to word wrap within paragraphs.

> On 2014/10/16 17:34, Mark Brown wrote:

> >> If we set the rate unconditionally here, clk_set_rate() will be executed in each spi transfer.

> > Is that really such a high cost?

> Not high cost, but  I think if the default spi_clk is enough, we do not need to set spi_clk again.

> Maybe we can only set spi_clk as (2 * MAX_SCLK_OUT) in probe().

It's not too bad to do it where it is, it just seems better to be
simpler.

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUP51bAAoJECTWi3JdVIfQsqUIAIBGJkL6Jkve/Hu047z7xaaz
iNtIkYoYq8em30yzbYyH2YKXog+D4HRng6bR1rI/Pil0bfPliYMFiHJBz3l3XfrO
TgNcyZE3Lm1CWOOuADLmmvtzz+z70tSXJRVPPplFPXU9OQrZBdzo3ZRSMMOyzXfl
UFMIndIcr0A6hDkPNsldHLrpkVitI7ceZjG86nDu/uPtqQRj1Nzl0J67w5EzmNLN
oByideJoYAv0oYWnUHe/EPpRQz7JYlilZ5DoCpNUP0HKWeYhtgU51r37vzB5glg0
SyUHKqp94ysx3ZDsUMm9pSUvQz3y8KJxj8wiszqkbnw4Nohz2f+B3+6UpMoYQn0=
=9p8j
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--
