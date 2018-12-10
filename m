From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Date: Mon, 10 Dec 2018 22:52:41 +0100
Message-ID: <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
To: Mark Brown <broonie@kernel.org>, Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
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

Hello Mark,

On Fri, Nov 30, 2018 at 07:47:04AM +0100, Uwe Kleine-K=F6nig wrote:
> compared to v2 sent with Message-Id:
> 20181123085158.24753-1-u.kleine-koenig@pengutronix.de I squashed in the
> change suggested by Robin (with s/filed/field/). Thanks for testing and
> feedback.

In my eyes this series is ready to go in. The feedback I got so far was
only that there could be done still more. And given that patch 2 is a
fix I'd like to see this in 4.21.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
