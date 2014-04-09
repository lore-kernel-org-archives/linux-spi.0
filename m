From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/9] mtd: spi-nor: drop \t after #define
Date: Wed, 9 Apr 2014 10:56:56 -0700
Message-ID: <20140409175656.GF32070@ld-irv-0074>
References: <1397064774-31784-1-git-send-email-computersforpeace@gmail.com>
 <201404091940.14392.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201404091940.14392.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Apr 09, 2014 at 07:40:14PM +0200, Marek Vasut wrote:
> On Wednesday, April 09, 2014 at 07:32:46 PM, Brian Norris wrote:
> > +#define OPCODE_DUAL_READ        0x3b    /* Read data bytes (Dual SPI) */
> > +#define OPCODE_QUAD_READ        0x6b    /* Read data bytes (Quad SPI) */
> 
> This is still a little non-standard -- or rather -- inconsistent here. You 
> should use space after #define and \t after the name I'd say. I'd also say these 
> two slipped your attention as the others do it just like that.

Thanks. I think I noticed this at one point, but in my patch juggling, I
never straightened it out. I'll send v2 eventually. And in the meantime,
I'm keeping my patches here:

  http://git.infradead.org/users/norris/linux-mtd.git/shortlog/refs/heads/spinor

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
