From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] spi: allocate spi_board_info entries one by one
Date: Tue, 28 Feb 2017 10:24:17 -0800
Message-ID: <20170228182417.GA20776@dtor-ws>
References: <20170228041857.13292-1-dmitry.torokhov@gmail.com>
 <20170228041857.13292-3-dmitry.torokhov@gmail.com>
 <20170228091650.eiypppxblfhh33pb@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170228091650.eiypppxblfhh33pb-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Feb 28, 2017 at 09:16:50AM +0000, Mark Brown wrote:
> On Mon, Feb 27, 2017 at 08:18:56PM -0800, Dmitry Torokhov wrote:
> > Lists of spi_board_info entries registered with spi_register_board_info()
> > can be quite long; instead of forcing memory allocator find contagious
> 
> Do you have numbers on that?

Hm, so the largest array seems to be in
arch/blackfin/mach-bf537/boards/stamp.c at max of 43 entries. The new
board info is ether 60 or 72 bytes, so we get 2 or 3K table. Not above
page, but still could be packed I think.

If we decide that we want to keep single chunk I'll just change the
allocation to kcalloc. Let me know.

We should probably redo patch #1 to avoid allocating empty property sets
anyway.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
