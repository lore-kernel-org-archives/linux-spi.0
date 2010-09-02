From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/6] spi-imx: add CSPI and eCSPI support for i.MX51 MCU
Date: Thu, 2 Sep 2010 19:57:21 +0200
Message-ID: <20100902175720.GU14214@pengutronix.de>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<20100902145357.GL14214@pengutronix.de>
	<19583.48828.125104.712979@ipc1.ka-ro>
	<20100902172908.GD2464@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Jason Wang <jason77.wang@gmail.com>, s.hauer@pengutronix.de,
	grant.likely@secretlab.ca, amit.kucheria@canonical.com,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org,
	Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
To: Baruch Siach <baruch@tkos.co.il>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100902172908.GD2464@tarshish>
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

Hello,

On Thu, Sep 02, 2010 at 08:29:09PM +0300, Baruch Siach wrote:
> Hi Lothar,
> =

> On Thu, Sep 02, 2010 at 05:11:56PM +0200, Lothar Wa=DFmann wrote:
> > > > -	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35()) {
> > > > +	/* i.MX51 has two eCSPI and one CSPI controllers, eCSPI controlle=
rs are
> > > > +	 * not compatible with existing SPI controllers on other i.MX pla=
tforms,
> > > > +	 * while CSPI controller is 100% compatible with the one on the i=
.MX35.
> > > > +	 * We set the platform device id to 2 for this CSPI at i.MX51 boa=
rd init
> > > > +	 * level to distinguish it from two eCSPI controllers.
> > > > +	 */
> > > This comment is missing in Sascha's driver.  I like it.
> > > BTW, I'd like to make use of platform ids in this driver.  This would
> > > make this ugly "on imx51 id2 is a cspi" distinction unnecessary.
> > > =

> > > > +	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35() ||
> > > > +	    (cpu_is_mx51() && (pdev->id =3D=3D 2))) {
> > I'd prefer a flag in the platform_data that tells the driver to act as
> > an eCSPI driver. This way the information about eCSPI or not would be
> > where it belongs (in the arch specific code).
> =

> But this also increases the size of driver code, since the compiler can =

> resolve cpu_is_* at compile time, and drop the dead code. Maybe an is_ecs=
pi =

> macro will make the above code clearer.
If you ask me the cleanest approach is using platform ids.  That is the
devices on mx51 could be called:

	imx51-ecspi.0
	imx51-ecspi.1
	imx51-cspi.0

I don't know what the implications on driver code size is, but I can
imagine that if done carefully the driver doesn't need to be bigger.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
