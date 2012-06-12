From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH 5/9] ARM: kirkwood: use devicetree for orion-spi
Date: Tue, 12 Jun 2012 14:13:43 -0400
Message-ID: <20120612181343.GG14756@titan.lakedaemon.net>
References: <1339324322-29388-6-git-send-email-andrew@lunn.ch>
	<20120610170620.GW14756@titan.lakedaemon.net>
	<20120612120433.GA17893@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, machael-QKn5cuLxLXY@public.gmane.org,
	Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>, Michael Walle <micheal-QKn5cuLxLXY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120612120433.GA17893-g2DYL2Zd6BY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 12, 2012 at 02:04:33PM +0200, Andrew Lunn wrote:
> > > +		spi@10600 {
> > > +			compatible = "marvell,orion-spi";
> > > +			#address-cells = <1>;
> > > +			#size-cells = <0>;
> > > +			cell-index = <0>;
> > > +			reg = <0x10600 0x28>;
> > > +			status = "disabled";
> > > +		};
> > > +
> 
> > > index fa51586..0942139 100644
> > > --- a/arch/arm/mach-kirkwood/board-dt.c
> > > +++ b/arch/arm/mach-kirkwood/board-dt.c
> > > @@ -26,6 +26,11 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
> > >  	{ }
> > >  };
> > >  
> > > +struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
> > > +	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
> > 
> > Isn't this ---------------------------------^^^^^^^^^^ defined somewhere?
> 
> Yes, there is a #define for this. However, in this case, i think the
> number actually tells you more. The dtsi file has the number, not some
> symbolic representation. Also, some platforms, e.g. Dove, have more
> than one spi controller. Having the number there makes it easier to
> see the mapping between the node in DT and the name used in the
> platform device. If we use the #define it means making an indirection
> via kirkwood.h for a human to see the mapping.
> 
> However, i can change it...

Nope, good point.  If no one else pipes up, leave it as is.

thx,

Jason.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
