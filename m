From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi_mpc83xx: test below 0 on
	unsigned irq	in	mpc83xx_spi_probe()
Date: Fri, 25 Apr 2008 13:25:06 +0200
Message-ID: <1209122706.31117.8.camel@gentoo-jocke.transmode.se>
References: <480FA234.1000601@tiscali.nl>
	<00ed01c8a58c$b4a5fa40$1df1eec0$@Tjernlund@transmode.se>
Reply-To: joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	'lkml' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: 'Roel Kluin' <12o3l-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <00ed01c8a58c$b4a5fa40$1df1eec0$@Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On Wed, 2008-04-23 at 23:55 +0200, Joakim Tjernlund wrote:
> > -----Original Message-----
> > From: linuxppc-dev-bounces+joakim.tjernlund=transmode.se-mnsaURCQ41sdnm+yROfE0A@public.gmane.org [mailto:linuxppc-dev-
> > bounces+joakim.tjernlund=transmode.se-mnsaURCQ41sdnm+yROfE0A@public.gmane.org] On Behalf Of Roel Kluin
> > Sent: den 23 april 2008 22:55
> > To: galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
> > Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; lkml
> > Subject: [PATCH 1/2] spi_mpc83xx: test below 0 on unsigned irq in mpc83xx_spi_probe()
> > 
> > mpc83xx_spi->irq is unsigned, so the test fails
> > 
> > Signed-off-by: Roel Kluin <12o3l-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
> 
> hmm, I got a pretty large 83xx spi patch queued at dbrownell. I hope
> that one can be applied first. Then you probably need to rediff this patch.
> 
> David, any progress on my patch?

David, heard nothing from you in a while. Don't you get my mails?

   Jocke 

> 
>  Jocke
> > ---
> > diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
> > index be15a62..033fd51 100644
> > --- a/drivers/spi/spi_mpc83xx.c
> > +++ b/drivers/spi/spi_mpc83xx.c
> > @@ -454,12 +454,12 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)
> >  		goto put_master;
> >  	}
> > 
> > -	mpc83xx_spi->irq = platform_get_irq(dev, 0);
> > -
> > -	if (mpc83xx_spi->irq < 0) {
> > -		ret = -ENXIO;
> > +	ret = platform_get_irq(dev, 0);
> > +	if (ret < 0)
> >  		goto unmap_io;
> > -	}
> > +
> > +	mpc83xx_spi->irq = ret;
> > +	ret = 0;
> > 
> >  	/* Register for SPI Interrupt */
> >  	ret = request_irq(mpc83xx_spi->irq, mpc83xx_spi_irq,
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> > 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
