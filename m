From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 6/6] atmel_spi: fix warning In function
	'atmel_spi_dma_map_xfer'
Date: Sun, 21 Nov 2010 03:19:34 +0100
Message-ID: <20101121021934.GH4216@game.jcrosoft.org>
References: <20101120214820.GG8942@pengutronix.de>
	<616676.83025.qm@web180301.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>, linux-kernel@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: David Brownell <david-b@pacbell.net>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <616676.83025.qm@web180301.mail.gq1.yahoo.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On 14:59 Sat 20 Nov     , David Brownell wrote:
> =

> =

> --- On Sat, 11/20/10, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>=
 wrote:
> =

> > > +=A0=A0=A0 =A0=A0=A0 void
> > *nonconst_tx =3D (void *)xfer->tx_buf; /* shut up gcc */
> =

> Reads like a bad patch to me. Fix the bug,
> don't just silence GCC.  Or at least use
> a better comment mentioning a constness
> cast problems).

ok I change the comment

Best Regards,
J.
