From: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [Patch v2 1/3] spi: qup: Remove chip select function
Date: Sat, 21 Jun 2014 13:56:46 -0500
Message-ID: <20140621185646.GA2601@qualcomm.com>
References: <1402601652-24641-1-git-send-email-agross@codeaurora.org>
 <1402601652-24641-2-git-send-email-agross@codeaurora.org>
 <20140621101303.GE5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Daniel Sneddon <dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>,
	Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140621101303.GE5099-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, Jun 21, 2014 at 11:13:03AM +0100, Mark Brown wrote:
> On Thu, Jun 12, 2014 at 02:34:10PM -0500, Andy Gross wrote:
> > This patch removes the chip select function.  Chip select should instead be
> > supported using GPIOs, defining the DT entry "cs-gpios", and letting the SPI
> > core assert/deassert the chip select as it sees fit.
> 
> Why?

The chip select control inside the controller is buggy.  It is supposed to
automatically assert the chip select based on the activity in the controller,
but it is buggy and doesn't work at all.  So instead we elect to use GPIOs.

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
