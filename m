From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 4/7] ARM: mxs: Add SPI clock into clk framwork
Date: Tue, 26 Jun 2012 14:16:11 +0200
Message-ID: <201206261416.11599.marex@denx.de>
References: <1340477033-2761-1-git-send-email-marex@denx.de>
	<1340477033-2761-4-git-send-email-marex@denx.de>
	<20120626065428.GM2342@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>,
	Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120626065428.GM2342-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Shawn Guo,

> On Sat, Jun 23, 2012 at 08:43:50PM +0200, Marek Vasut wrote:
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
> > Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
> > CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> > Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> > Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> > CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
> > Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
> > ---
> > 
> >  drivers/clk/mxs/clk-imx28.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> > index 003b0f3..d22b926 100644
> > --- a/drivers/clk/mxs/clk-imx28.c
> > +++ b/drivers/clk/mxs/clk-imx28.c
> > @@ -149,21 +149,25 @@ static struct clk_lookup xbus_lookups[] __initdata
> > = {
> > 
> >  static struct clk_lookup ssp0_lookups[] __initdata = {
> >  
> >  	{ .dev_id = "imx28-mmc.0", },
> > 
> > +	{ .dev_id = "imx28-spi.0", },
> > 
> >  	{ .dev_id = "80010000.ssp", },
> >  
> >  };
> >  
> >  static struct clk_lookup ssp1_lookups[] __initdata = {
> >  
> >  	{ .dev_id = "imx28-mmc.1", },
> > 
> > +	{ .dev_id = "imx28-spi.1", },
> > 
> >  	{ .dev_id = "80012000.ssp", },
> >  
> >  };
> >  
> >  static struct clk_lookup ssp2_lookups[] __initdata = {
> >  
> >  	{ .dev_id = "imx28-mmc.2", },
> > 
> > +	{ .dev_id = "imx28-spi.2", },
> > 
> >  	{ .dev_id = "80014000.ssp", },
> >  
> >  };
> >  
> >  static struct clk_lookup ssp3_lookups[] __initdata = {
> >  
> >  	{ .dev_id = "imx28-mmc.3", },
> > 
> > +	{ .dev_id = "imx28-spi.3", },
> > 
> >  	{ .dev_id = "80016000.ssp", },
> >  
> >  };
> 
> These changes should not be needed, as the driver will only be probed
> from device tree.

So why are those imx28-mmc there ? Shall these not be removed then ?

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
