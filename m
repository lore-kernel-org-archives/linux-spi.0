From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [v2,2/2] spi: bitbang: convert to using core message queue
Date: Wed, 17 Jul 2013 16:33:43 +0200
Message-ID: <20130717143343.GA32014@pengutronix.de>
References: <Pine.LNX.4.64.1301091507120.13376@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	Linus Walleij <linus.walleij@linaro.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org,
	kernel@pengutronix.de
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1301091507120.13376@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jan 09, 2013 at 03:08:59PM +0100, Guennadi Liakhovetski wrote:
> The SPI subsystem core now manages message queues internally. Remove =
the
> local message queue implementation from the spi-bitbang driver and
> migrate to the common one.
>=20
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
It works fine for me on an efm32 board communicating with an ks8851.
Maybe the mmc problem is to be found in the mmc subsystem?

Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
