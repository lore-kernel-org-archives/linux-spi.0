From: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH v2] gpio: mcp23s08: convert driver to DT
Date: Thu, 14 Feb 2013 13:22:22 +0100
Message-ID: <201302141322.22263.poeschel@lemonage.de>
References: <1360583563-10707-1-git-send-email-larsi@wh2.tu-dresden.de>
	<201302131213.08631.poeschel@lemonage.de>
	<CACRpkdbJ=KiwVoeK2TgO8kMuYQ2U-LaUOdL1d7w-q+9Ggb-JnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Lars Poeschel <larsi-myOXECIRRCL4ajHJ1XSv27NAH6kLmebB@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACRpkdbJ=KiwVoeK2TgO8kMuYQ2U-LaUOdL1d7w-q+9Ggb-JnA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 13 February 2013 at 13:51:12, Linus Walleij wrote:
> On Wed, Feb 13, 2013 at 12:13 PM, Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org> 
wrote:
> > On Monday 11 February 2013 at 22:25:51, Grant Likely wrote:
> >> However, is the pullup selection per-gpio line? If so, then why not
> >> encode it into the flags field of the gpio specifier?
> > 
> > Yes, the pullup is per-gpio line. I am working on that. It turns out,
> > that this is a bit difficult for me, as there is no real documentation
> > and no other driver is doing it or something similar yet. Exception are
> > very few gpio soc drivers where situation is a bit different. They seem
> > to rely an fixed global gpio numbers and they are always memory mapped.
> > But as I said I am working on it...
> 
> Part of your problem is that pull-up is pin control territory.
> 
> We invented that subsystem for a reason, and that reason
> was that the GPIO subsystem had a hard time accomodating
> things like this.
> 
> If you look in drivers/pinctrl/pinctrl-abx500.c which is my
> latest submitted pinctrl driver you can see that this is basically
> a quite simple GPIO chip, we just model it as a pin controller
> with a GPIO front-end too exactly because it can do things
> like multiplexing, pull-up and pull-down.
> 
> Have you considered this approach?

No, I haven't. And although this doesn't solve all my problems, I like the 
idea very much! Thank you for this! But at the moment it looks to me that 
this could be a bit overkill for setting this single register and I don't 
think this is, what Grant meant me to do. 
Anyway, I will have a deeper look at this.

Thanks,
Lars

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
