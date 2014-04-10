From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 7/9] mtd: st_spi_fsm: kill duplicate CMD definitions
Date: Thu, 10 Apr 2014 11:58:56 -0700
Message-ID: <20140410185856.GI32070@ld-irv-0074>
References: <1397064774-31784-1-git-send-email-computersforpeace@gmail.com>
 <1397064774-31784-7-git-send-email-computersforpeace@gmail.com>
 <20140410075653.GI4214@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140410075653.GI4214@lee--X1>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Apr 10, 2014 at 08:56:53AM +0100, Lee Jones wrote:
> JOOI, have you build tested your changes?

Yes, I compile-tested yours. (But as Huang noticed, I failed to build
fsl-quadspi; my bad.)

> Non-tested:
>   Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Thanks. I'll be sending out v2 with a few tweaks to the other parts of
this series.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
