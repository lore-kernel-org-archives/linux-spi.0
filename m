From: "Arce, Abraham" <x0066660@ti.com>
Subject: RE: [PATCH v1 2/3] OMAP4: Ethernet: KS8851 Board Support
Date: Wed, 5 May 2010 19:47:41 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DEEC153@dlee03.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043DEEB8C1@dlee03.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C7096@dbde02.ent.ti.com>
 <27F9C60D11D683428E133F85D2BB4A53043DEEB8D1@dlee03.ent.ti.com>
 <20100505171938.GX29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>
To: Tony Lindgren <tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100505171938.GX29604@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> > > > +
> > > > +static void omap_ethernet_init(void)
> > > > +{
> > > > +	gpio_request(ETHERNET_KS8851_POWER_ENABLE, "ethernet");
> > > > +	gpio_direction_output(ETHERNET_KS8851_POWER_ENABLE, 1);
> > > > +	gpio_request(ETHERNET_KS8851_QUART, "quart");
> > > > +	gpio_direction_output(ETHERNET_KS8851_QUART, 1);
> > > > +	gpio_request(ETHERNET_KS8851_IRQ, "ks8851");
> > >
> > > Any reason for not checking return value of gpio_request()?
> > >
> >
> > Thought initially about them as dedicated lines for ethernet avoiding
> > both reasons to check for a gpio's request:
> >
> >  1. invalid gpio
> >  2. already claimed gpio
> 
> You still need to check for the result.
> 

Is the below approach ok? Using goto would make it better?

        int status;

        status = gpio_request(ETHERNET_KS8851_POWER_ENABLE, "ethernet");
        if (status < 0)
                return status;

        gpio_request(ETHERNET_KS8851_QUART, "quart");
        if (status < 0) {
                gpio_free(ETHERNET_KS8851_POWER_ENABLE);
                return status;
        }

        gpio_request(ETHERNET_KS8851_IRQ, "ks8851");
        if (status < 0) {
                gpio_free(ETHERNET_KS8851_POWER_ENABLE);
                gpio_free(ETHERNET_KS8851_QUART);
                return status;
        }

        gpio_direction_output(ETHERNET_KS8851_POWER_ENABLE, 1);
        gpio_direction_output(ETHERNET_KS8851_QUART, 1);
        gpio_direction_input(ETHERNET_KS8851_IRQ);

Best Regards
Abraham
