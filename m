From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH] spi-orion: remove uneeded spi_info
Date: Sun, 3 Jun 2012 23:51:22 +0200
Message-ID: <201206032351.22925.michael@walle.cc>
References: <1338754215-16022-1-git-send-email-michael@walle.cc>
	<20120603210424.GM14756@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "open list:SPI SUBSYSTEM" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120603210424.GM14756-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Jason,

Am Sonntag 03 Juni 2012, 23:04:24 schrieb Jason Cooper:
> On Sun, Jun 03, 2012 at 10:10:14PM +0200, Michael Walle wrote:
> > This was formerly used to store the tclk value. Remove it.
> > 
> > Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
> > ---
> > 
> >  drivers/spi/spi-orion.c |    5 -----
> >  1 files changed, 0 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> > index dfd04e9..2760450 100644
> > --- a/drivers/spi/spi-orion.c
> > +++ b/drivers/spi/spi-orion.c
> > @@ -45,7 +45,6 @@ struct orion_spi {
> > 
> >  	void __iomem		*base;
> >  	unsigned int		max_speed;
> >  	unsigned int		min_speed;
> > 
> > -	struct orion_spi_info	*spi_info;
> > 
> >  	struct clk              *clk;
> >  
> >  };
> > 
> > @@ -450,12 +449,9 @@ static int __init orion_spi_probe(struct
> > platform_device *pdev)
> > 
> >  	struct spi_master *master;
> >  	struct orion_spi *spi;
> >  	struct resource *r;
> > 
> > -	struct orion_spi_info *spi_info;
> > 
> >  	unsigned long tclk_hz;
> >  	int status = 0;
> > 
> > -	spi_info = pdev->dev.platform_data;
> > -
> > 
> >  	master = spi_alloc_master(&pdev->dev, sizeof *spi);
> >  	if (master == NULL) {
> >  	
> >  		dev_dbg(&pdev->dev, "master allocation failed\n");
> > 
> > @@ -476,7 +472,6 @@ static int __init orion_spi_probe(struct
> > platform_device *pdev)
> > 
> >  	spi = spi_master_get_devdata(master);
> >  	spi->master = master;
> > 
> > -	spi->spi_info = spi_info;
> > 
> >  	spi->clk = clk_get(&pdev->dev, NULL);
> 
> It's not relevant to this patch, but later in the patch series, you
> initialize this device via devicetree.  Did you add the clock node?  Is
> there a dependency for this series that I missed?

i added the original device name by using the auxdata in 
of_platform_populate(). See "[PATCH 2/3] ARM: kirkwood: use devicetree for 
orion-spi"

-- 
Michael

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
