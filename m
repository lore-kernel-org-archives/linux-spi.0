From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 3/9] mtd: spi-nor: unify read opcode variants with ST
 SPI FSM
Date: Thu, 10 Apr 2014 15:47:13 +0800
Message-ID: <20140410074711.GG24100@localhost>
References: <1397064774-31784-1-git-send-email-computersforpeace@gmail.com>
 <1397064774-31784-3-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397064774-31784-3-git-send-email-computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Apr 09, 2014 at 10:32:48AM -0700, Brian Norris wrote:
> serial_flash_cmds.h defines our opcodes a little differently. Let's
> borrow its naming, since it's borrowed from the SFDP standard, and it's
> more extensible.
> 
> This prepares us for merging serial_flash_cmds.h and spi-nor.h opcode
> listing.
> 
> Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 16 ++++++++--------
>  include/linux/mtd/spi-nor.h   | 24 ++++++++++++++++--------
Please also change the fsl-quadspi.c which also uses the opcodes.


thanks
Huang Shijie



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
