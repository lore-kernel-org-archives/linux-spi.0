From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 7/9] mtd: st_spi_fsm: kill duplicate CMD definitions
Date: Thu, 10 Apr 2014 11:59:19 -0700
Message-ID: <20140410185919.GJ32070@ld-irv-0074>
References: <1397064774-31784-1-git-send-email-computersforpeace@gmail.com>
 <1397064774-31784-7-git-send-email-computersforpeace@gmail.com>
 <CAMuHMdWu7YVO_RD-SUfaTw1Jp97i5bm8iX5TzKeqgWAk_iN5qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWu7YVO_RD-SUfaTw1Jp97i5bm8iX5TzKeqgWAk_iN5qQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Apr 10, 2014 at 08:01:55PM +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 9, 2014 at 7:32 PM, Brian Norris
> <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > These are also in serial_flash_cmds.h. (FWIW, I didn't know the C
> > preprocessor allowed redefinitions without warning like this.)
> 
> Cpp only complains when the redefinitions are different.

Good to know. Thanks.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
