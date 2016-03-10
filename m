From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCHv2 2/3] spi/spi-xilinx:  Add clock support
Date: Thu, 10 Mar 2016 11:20:53 +0000
Message-ID: <4EED9C67BE3EF440A606099F8E34C5282652F809@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1457513242-11202-1-git-send-email-shubhraj@xilinx.com>
 <1457513242-11202-2-git-send-email-shubhraj@xilinx.com>
 <20160310032948.GI3898@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160310032948.GI3898-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



> -----Original Message-----
> From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Thursday, March 10, 2016 9:00 AM
> To: Shubhrajyoti Datta
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Soren Brinkmann;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Michal Simek; Shubhrajyoti Datta
> Subject: Re: [PATCHv2 2/3] spi/spi-xilinx: Add clock support
> 
> On Wed, Mar 09, 2016 at 02:17:21PM +0530, Shubhrajyoti Datta wrote:
> 
> > +       xspi->clk = devm_clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(xspi->clk)) {
> 
> As someone pointed out on the previous version of the series this will cause
> the driver to fail to probe with existing DTs.  We probably need to explicitly
> handle a -ENOENT as a "this clock will never appear" or something.
I got comments after I sent the v2.
I will update it with Lars comments.
> 
> This also requests a single nameless clock but someone pointed out on the
> previous version there are multiple clocks into the IP.  Even if you only want
> to add one clock right now the clock should probably be named so we can
> scale up

I will add a name.
.
> 
> > +	}
> > +	ret = clk_prepare_enable(xspi->clk);
> 
> Missing blank line here.
Will fix in next version
> 
> > +	if (ret)
> > +		dev_err(&pdev->dev, "Unable to enable clock.\n");
> > +
> 
> This isn't really checking the return code - if we failed to enable the clock we
> should be failing the probe, not just carrying on.
Will fix.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
