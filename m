From: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: qup: Remove chip select function
Date: Wed, 11 Jun 2014 23:02:17 -0500
Message-ID: <20140612040217.GA32535@qualcomm.com>
References: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
 <1400016884-9568-2-git-send-email-agross@codeaurora.org>
 <1400486858.1464.11.camel@iivanov-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
To: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400486858.1464.11.camel@iivanov-dev>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, May 19, 2014 at 11:07:38AM +0300, Ivan T. Ivanov wrote:
<snip>
 
> > +- num-cs:	total number of chipselects
> 
> My understanding is that "num-cs" have to be parsed by
> master driver, not by core SPI driver.

Right.  I need to parse it and check vs the max cs and use that value to set the
master->num_chipselect

> 
> > -
> > -	/* Disable auto CS toggle and use manual */
> > -	iocontol &= ~SPI_IO_C_MX_CS_MODE;
> 
> Probably we should keep this?

Actually this is cleared in the probe during the initial settings of IO_CONTROL.
So this isn't necessary.


-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
