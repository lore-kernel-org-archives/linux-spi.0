From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/5] spi: imx: mx51-ecspi: Move some initialisation to
 prepare_message hook.
Date: Mon, 3 Dec 2018 09:18:55 +0100
Message-ID: <20181203081855.ic7ok6gtvoyc2nzv@pengutronix.de>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181130064709.6998-3-u.kleine-koenig@pengutronix.de>
 <AM0PR04MB4532C74AD347B0A30EDB7FC489AE0@AM0PR04MB4532.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Robin Gong <yibin.gong@nxp.com>, Marek Vasut <marex@denx.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4532C74AD347B0A30EDB7FC489AE0@AM0PR04MB4532.eurprd04.prod.outlook.com>
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

Hello,

On Mon, Dec 03, 2018 at 08:00:21AM +0000, Robin Gong wrote:
> >  	/*
> >  	 * Wait until the changes in the configuration register CONFIGREG @@
> Seems we don't need this commit anymore, your patch fix it by the way?
> =

> commit 6fd8b8503a0dcf66510314dc054745087ae89f94
> Author: Marek Vasut <marex@denx.de>
> Date:   Wed Dec 18 18:31:47 2013 +0100
> =

>     spi: spi-imx: Fix out-of-order CS/SCLK operation at low speeds

I don't know, that's why I put Marek on Cc and talked to him in irc. I
couldn't lure him into testing on his machine if this indeed fixes his
problem.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
