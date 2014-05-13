From: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: qup: Add support for v1.1.1
Date: Tue, 13 May 2014 17:20:22 -0500
Message-ID: <20140513222022.GA28128@qualcomm.com>
References: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
 <1400016884-9568-5-git-send-email-agross@codeaurora.org>
 <20140513220845.GH20486@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>,
	Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140513220845.GH20486-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, May 13, 2014 at 03:08:45PM -0700, Stephen Boyd wrote:
> On 05/13, Andy Gross wrote:
> > @@ -488,7 +491,7 @@ static int spi_qup_probe(struct platform_device *pdev)
> >  	struct resource *res;
> >  	struct device *dev;
> >  	void __iomem *base;
> > -	u32 data, max_freq, iomode;
> > +	u32 data = 0, max_freq, iomode;
> 
> It looks like data is unused? But actually it's used to print a
> version out and now it will always print version 0. Perhaps that
> printk needs an update?

ACK!  I thought I killed that.  I'll fix that.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
