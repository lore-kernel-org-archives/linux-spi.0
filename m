From: Cestonaro Thilo <thilo.cestonaro-RJz4owOZxyXQFUHtdCDX3A@public.gmane.org>
Subject: Re: mtdblock read sector and cache_data == NULL
Date: Tue, 11 Feb 2014 09:46:56 +0100
Message-ID: <52F9E380.7050700@ts.fujitsu.com>
References: <52F9E10F.8060904@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52F9E10F.8060904-RJz4owOZxyXQFUHtdCDX3A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

hey,

forget it :) ... I got confused ....

Greetings Thilo

On 11.02.2014 09:36, Cestonaro Thilo wrote:
> Hey,
>
> I think the cache_data buffer is used uninitialized in case no write
> prepends the first read.
>
> Initialization of cache_data buffer:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/mtd/mtdblock.c?id=refs/tags/v3.14-rc2#n300
> --------------------
>
>     if (!(mbd->mtd->flags & MTD_NO_ERASE) && mbd->mtd->erasesize) {
>         mtdblk->cache_size = mbd->mtd->erasesize;
>         mtdblk->cache_data = NULL;
>     }
> ----------------
>
> And later in do_cached_read it is just used with mtdblock->cache_data +
> offset.
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/mtd/mtdblock.c?id=refs/tags/v3.14-rc2#n243
>
> The only allocation I can find is in writesector function, so I figured
> that the mtd_read will get NULL+offset in the first read.
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/mtd/mtdblock.c?id=refs/tags/v3.14-rc2#n272
>
> Is it correct to place the same if unlikely stuff in the
> mtdblock_readsect function like in the mtdblock_writesect one?
>
> Greetings
> Thilo
>


-- 
With best regards
Thilo Cestonaro

FTS PBG PDG WPS R&D EPC

Fujitsu Technology Solutions GmbH
Buergermeister-Ulrich-Str. 100
86199 Augsburg
Germany

Tel.: +49 (0)821 804 2328
Fax: +49 (0)821 804 82328
E-mail: thilo.cestonaro-RJz4owOZxyXQFUHtdCDX3A@public.gmane.org

Web: http://ts.fujitsu.com
Company details: http://ts.fujitsu.com/imprint

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
