From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Date: Tue, 11 Dec 2018 08:13:00 +0100
Message-ID: <20181211071300.7xxmzhfj26qt2tle@pengutronix.de>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
 <20181211011428.GH3004@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181211011428.GH3004@sirena.org.uk>
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

On Tue, Dec 11, 2018 at 01:14:28AM +0000, Mark Brown wrote:
> On Mon, Dec 10, 2018 at 10:52:41PM +0100, Uwe Kleine-K=F6nig wrote:
> =

> > In my eyes this series is ready to go in. The feedback I got so far was
> > only that there could be done still more. And given that patch 2 is a
> > fix I'd like to see this in 4.21.
> =

> It looked like there was an unanswered question about if patch 2 was
> needed or not?  Marek?

I cannot find an unanswered question. There is a workaround that Marek
introduced in 6fd8b8503a0dcf66510314dc054745087ae89f94 that might not be
needed any more with my patch 2. So it's the other way round: If Marek's
problem is fixed by patch 2, my patch is the better one. I have problems
with SCK changing polarity when CS is already asserted in the presence
of Marek's change. After my change they are gone. Even if this
workaround is superflous now, it doesn't hurt and IMHO the question if
it is needed or not should not delay my fix.

If I miss something, can you please point out the message-id?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
