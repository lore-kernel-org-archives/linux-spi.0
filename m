From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 2/2] SPI: Add SPI driver for most known i.MX SoCs
Date: Sun, 21 Jun 2009 15:53:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0906211552330.17040@axis700.grange>
References: <1245235220-23816-1-git-send-email-s.hauer@pengutronix.de>
	<1245235220-23816-2-git-send-email-s.hauer@pengutronix.de>
	<1245235220-23816-3-git-send-email-s.hauer@pengutronix.de>
	<Pine.LNX.4.64.0906172010400.4218@axis700.grange>
	<4A39F255.2090301@free.fr>
	<Pine.LNX.4.64.0906181028120.5779@axis700.grange>
	<4A3E2EB4.90806@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	David Brownell <david-b@pacbell.net>,
	linux-arm-kernel@lists.arm.linux.org.uk,
	spi-devel-general@lists.sourceforge.net
To: Julien Boibessot <julien.boibessot@free.fr>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <4A3E2EB4.90806@free.fr>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
List-Id: linux-spi.vger.kernel.org

On Sun, 21 Jun 2009, Julien Boibessot wrote:

> Guennadi Liakhovetski a =E9crit :
> > On Thu, 18 Jun 2009, Julien Boibessot wrote:
> > =

> >   =

> > > > Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > > =

> > > > on a i.MX31 with a DAC124S085.
> > > >         =

> > > Which maximum sampling speed can you achieve with this new SPI driver=
 ?
> > >     =

> > =

> > Is "sampling speed" at all applicable to a DAC? =

> Oups... sorry I thought it was an ADC.
> > If you mean at which rate I could output values, then I did not and cou=
ld
> > not measure it due to a hardware bug on my system.
> >   =

> ok. Let me know when it's working again.

Well, it is working - sort of. I can set a couple of values on output =

lines, but not too often... So, I could test the SPI driver, but could not =

put it under load.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
