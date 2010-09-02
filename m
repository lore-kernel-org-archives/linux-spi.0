From: =?iso-8859-15?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 1/6] spi-imx: add CSPI and eCSPI support for i.MX51 MCU
Date: Thu, 2 Sep 2010 17:11:56 +0200
Message-ID: <19583.48828.125104.712979@ipc1.ka-ro>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<20100902145357.GL14214@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Jason Wang <jason77.wang@gmail.com>, s.hauer@pengutronix.de,
	grant.likely@secretlab.ca, amit.kucheria@canonical.com,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100902145357.GL14214@pengutronix.de>
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

Hi,

> > -	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35()) {
> > +	/* i.MX51 has two eCSPI and one CSPI controllers, eCSPI controllers a=
re
> > +	 * not compatible with existing SPI controllers on other i.MX platfor=
ms,
> > +	 * while CSPI controller is 100% compatible with the one on the i.MX3=
5.
> > +	 * We set the platform device id to 2 for this CSPI at i.MX51 board i=
nit
> > +	 * level to distinguish it from two eCSPI controllers.
> > +	 */
> This comment is missing in Sascha's driver.  I like it.
> BTW, I'd like to make use of platform ids in this driver.  This would
> make this ugly "on imx51 id2 is a cspi" distinction unnecessary.
> =

> > +	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35() ||
> > +	    (cpu_is_mx51() && (pdev->id =3D=3D 2))) {
I'd prefer a flag in the platform_data that tells the driver to act as
an eCSPI driver. This way the information about eCSPI or not would be
where it belongs (in the arch specific code).


Lothar Wa=DFmann
-- =

___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=E4ftsf=FChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
