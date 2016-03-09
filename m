From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] spi/spi-xilinx:  Add clock support
Date: Wed, 9 Mar 2016 08:53:47 +0000
Message-ID: <4EED9C67BE3EF440A606099F8E34C5282652EA84@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1457426528-15247-1-git-send-email-shubhraj@xilinx.com>
 <20160309024200.GD3898@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160309024200.GD3898-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



> -----Original Message-----
> From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Wednesday, March 09, 2016 8:12 AM
> To: Shubhrajyoti Datta
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Soren Brinkmann; Michal Simek; Shubhrajyoti
> Datta
> Subject: Re: [PATCH] spi/spi-xilinx: Add clock support
> 
> On Tue, Mar 08, 2016 at 02:12:08PM +0530, Shubhrajyoti Datta wrote:
> 
> > +	xspi->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(xspi->clk)) {
> > +		dev_err(&pdev->dev, "input clock not found.\n");
> > +		return PTR_ERR(xspi->clk);
> > +	}
> 
> This changes the DT binding but does not update the binding document.

Thanks for review fixed  in v2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
