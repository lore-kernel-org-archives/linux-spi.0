From: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] spi: qup: Add DMA capabilities
Date: Fri, 27 Jun 2014 13:58:30 -0500
Message-ID: <20140627185830.GB13621@qualcomm.com>
References: <1403816781-31008-1-git-send-email-agross@codeaurora.org>
 <20140627105057.GF23300@sirena.org.uk>
 <20140627155422.GA13621@qualcomm.com>
 <20140627162411.GO32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Daniel Sneddon <dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>,
	Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140627162411.GO32514-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jun 27, 2014 at 05:24:11PM +0100, Russell King - ARM Linux wrote:

<snip>

> > > It would be better to use the core DMA mapping code rather than open
> > > coding.  This code won't work for vmalloc()ed addresses, or physically
> > > non-contiguous addresses unless there's an IOMMU fixing things up.
> > 
> > Ah, ok.  So I just need a to setup the scatter gather page list and then do a
> > dma_map_sg.  I'll resend once I have this in place.
> 
> Note that DMA from vmalloc'd memory is non-coherent on some platforms,
> even if you use the DMA API.

Thankfully, that isn't the case on this platform.  As as the QUP controller is
only on Qualcomm chipsets, we don't have to worry about it being used on other
platforms.


-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
