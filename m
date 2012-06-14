From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH 5/9] ARM: kirkwood: use devicetree for orion-spi
Date: Thu, 14 Jun 2012 11:31:35 +0200
Message-ID: <20120614093135.GE4799@lunn.ch>
References: <1339324322-29388-6-git-send-email-andrew@lunn.ch>
 <201206132110.31011.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, machael-QKn5cuLxLXY@public.gmane.org,
	Michael Walle <micheal-QKn5cuLxLXY@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201206132110.31011.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 13, 2012 at 09:10:30PM +0000, Arnd Bergmann wrote:
> On Sunday 10 June 2012, Andrew Lunn wrote:
> > @@ -26,6 +26,11 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
> >         { }
> >  };
> >  
> > +struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
> > +       OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
> > +       {},
> > +};
> > +
> >  static void __init kirkwood_dt_init(void)
> >  {
> 
> How about instead adding the clkdev for "f1010600.spi" so you don't need the auxdata?

We either have auxdata and clean clock code, or no auxdata and messy
clock code with lots of aliases.

The auxdata is also not limited to the name of the clocks. It allows
me to diff the kernel log for a DT boot and a none DT boot of the same
box and see they are identical. I've found a few typo's that way, and
not been hindered by noise of the devices changing name is useful.

Once we have the clock tree described in DT, then i think it makes
sense to remove these auxdata entries.

      Andrew
