From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] mc13xxx-core: Prepare for separate spi and i2c
 backends.
Date: Thu, 19 Jan 2012 15:35:11 +0800
Message-ID: <20120119073509.GE2247@S2101-09.ap.freescale.net>
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
 <1326934894-29516-2-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1326934894-29516-2-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Forgot to mention in my last reply that I recently added device tree
probe support for mc13xxx-core which has hit the mainline, so you may
need to rebase this series, or you will be asked by Samuel to anyway,
I guess :)

One nit on the subject of this patch: you may want to have prefix
"mfd: mc13xxx-core: ..." to align with the other two patches in the
series.

-- 
Regards,
Shawn

On Thu, Jan 19, 2012 at 12:01:32PM +1100, Marc Reilly wrote:
> This patch abstracts the bus specific operations from the driver core.
> Read and write handlers are introduced and generic initialization is
> consolidated into mc13xxx_comon_init. The irq member is removed because
> it is unused.
> 
> Signed-off-by: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
