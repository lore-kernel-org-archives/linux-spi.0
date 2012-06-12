From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH 5/9] ARM: kirkwood: use devicetree for orion-spi
Date: Tue, 12 Jun 2012 14:04:33 +0200
Message-ID: <20120612120433.GA17893@lunn.ch>
References: <1339324322-29388-6-git-send-email-andrew@lunn.ch>
 <20120610170620.GW14756@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, machael-QKn5cuLxLXY@public.gmane.org,
	Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	Michael Walle <micheal-QKn5cuLxLXY@public.gmane.org>
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120610170620.GW14756-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> > +		spi@10600 {
> > +			compatible = "marvell,orion-spi";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			cell-index = <0>;
> > +			reg = <0x10600 0x28>;
> > +			status = "disabled";
> > +		};
> > +

> > index fa51586..0942139 100644
> > --- a/arch/arm/mach-kirkwood/board-dt.c
> > +++ b/arch/arm/mach-kirkwood/board-dt.c
> > @@ -26,6 +26,11 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
> >  	{ }
> >  };
> >  
> > +struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
> > +	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
> 
> Isn't this ---------------------------------^^^^^^^^^^ defined somewhere?

Hi Jason

Yes, there is a #define for this. However, in this case, i think the
number actually tells you more. The dtsi file has the number, not some
symbolic representation. Also, some platforms, e.g. Dove, have more
than one spi controller. Having the number there makes it easier to
see the mapping between the node in DT and the name used in the
platform device. If we use the #define it means making an indirection
via kirkwood.h for a human to see the mapping.

However, i can change it...

	 Andrew
