From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] spi: sh-hspi: Do not specifically request shyway_clk
 clock
Date: Fri, 14 Mar 2014 08:50:01 +0900
Message-ID: <20140313234958.GA28137@verge.net.au>
References: <1394699450-31286-1-git-send-email-horms+renesas@verge.net.au>
 <2144304.qo37EGpAOW@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@linaro.org>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2144304.qo37EGpAOW@avalon>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Mar 13, 2014 at 11:10:25AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thank you for the patch.
> 
> On Thursday 13 March 2014 17:30:50 Simon Horman wrote:
> > Rather than requesting the shyway_clk call clk_get with
> > the device and a NULL con_id.
> > 
> > This is in keeping with the way that clk_get() is called
> > on other drivers used by Renesas Gen 1 SoCs. And I believe
> > it is compatible with supplying clocks via DT, unlike the current code.
> > 
> > It appears to me that the two uses of this driver are
> > the r8a7778 and r8a7779 SoCs. Both of which have already clocks setup
> > to allow this driver to continue to work with this change applied.
> 
> If I'm not mistaken the hspi clocks on r8a7778 are children of clkp, while the 
> shyway clock is a alias to clks. The only r8a7778 documentation I have access 
> to is in Japanese so I'm not 100% sure, but I believe the MSTP007 parent clock 
> should be clks.
> 
> The problem is not present in our r8a7779 code, the MSTP007 parent is clks 
> there.

Thanks for noticing that. I'll send a patch fix the r8a7778 clock code.

> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  drivers/spi/spi-sh-hspi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
> > index 82d2f92..e975892 100644
> > --- a/drivers/spi/spi-sh-hspi.c
> > +++ b/drivers/spi/spi-sh-hspi.c
> > @@ -274,9 +274,9 @@ static int hspi_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	}
> > 
> > -	clk = clk_get(NULL, "shyway_clk");
> > +	clk = clk_get(&pdev->dev, NULL);
> >  	if (IS_ERR(clk)) {
> > -		dev_err(&pdev->dev, "shyway_clk is required\n");
> > +		dev_err(&pdev->dev, "couldn't get clock\n");
> >  		ret = -EINVAL;
> >  		goto error0;
> >  	}
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
