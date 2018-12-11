From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Date: Tue, 11 Dec 2018 21:11:26 +0100
Message-ID: <20181211201126.vl6s7sesnzukbybt@pengutronix.de>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
 <20181211011428.GH3004@sirena.org.uk>
 <20181211071300.7xxmzhfj26qt2tle@pengutronix.de>
 <20181211115601.GB6686@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181211115601.GB6686@sirena.org.uk>
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

On Tue, Dec 11, 2018 at 11:56:01AM +0000, Mark Brown wrote:
> On Tue, Dec 11, 2018 at 08:13:00AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Dec 11, 2018 at 01:14:28AM +0000, Mark Brown wrote:
> =

> > > It looked like there was an unanswered question about if patch 2 was
> > > needed or not?  Marek?
> =

> > I cannot find an unanswered question. There is a workaround that Marek
> > introduced in 6fd8b8503a0dcf66510314dc054745087ae89f94 that might not be
> > needed any more with my patch 2. So it's the other way round: If Marek's
> > problem is fixed by patch 2, my patch is the better one. I have problems
> > with SCK changing polarity when CS is already asserted in the presence
> > of Marek's change. After my change they are gone. Even if this
> > workaround is superflous now, it doesn't hurt and IMHO the question if
> > it is needed or not should not delay my fix.
> =

> That was the unanswered question.

FTR: your reference to an "unanswered question" wasn't optimal either. I
had to search my inbox for a while to determine what you could have
meant :-)

> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.

I'm always willing to learn how to make my mails more cooperative.

I'd hope that even when offline you have a linux.git at hand to resolve
what I meant with "6fd8b8503a0dcf66510314dc054745087ae89f94". Apart from
this unannotated commit hash it's not clear to me what else could have
been improved here.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
