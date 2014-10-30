From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/2 v3] SPI: spi-pxa2xx: Add helpers for regiseters'
 accessing
Date: Thu, 30 Oct 2014 09:12:14 +0200
Message-ID: <1414653134.2396.67.camel@linux.intel.com>
References: <1412783423-9408-1-git-send-email-alvin.chen@intel.com>
	 <1412783423-9408-2-git-send-email-alvin.chen@intel.com>
	 <4656BEB6164FC34F8171C6538F1A595B2E9A90E6@SHSMSX101.ccr.corp.intel.com>
	 <5450CF36.7060105@nexus-software.ie>
	 <4656BEB6164FC34F8171C6538F1A595B2E9A92B3@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Bryan O'Donoghue <pure.logic-SyKdqv6vbfZdzvEItQ6vdLNAH6kLmebB@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Westerberg, Mika" <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Kweh, Hock Leong" <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Ong, Boon Leong" <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"Tan, Raymond" <raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: "Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4656BEB6164FC34F8171C6538F1A595B2E9A92B3-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 2014-10-30 at 01:02 +0000, Chen, Alvin wrote:
> > >
> > 
> > Hi Alvin, Weike.
> > 
> > I'm not clear if these patches apply to the current tip-of-tree.
> > 
> > I thought the action required here, was for a resend of patches to ensure they
> > applied to tip-of-tree ?
> > 
> As I said before, it is based on the slave-dma tree (git.infraded.org) for-linus branch, which will be reapplied on top of v3.19-rc1. 
> 
> That is to say these patches will be applied to slave-dma tree for-linus branch, and then the slave-dma tree for-linus branch will be applied to v3.19.
> Andy, am I right?

All of those patches are in v3.18-rc1, so you may rebase on top of
3.18-rcX safely I guess.


-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
