From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: FW: [PATCH] spi: sirf: Avoid duplicate code in various
 bits_per_word cases
Date: Wed, 15 Jan 2014 16:46:11 +0800
Message-ID: <CAFRkauCK3JJcmSx_1xi_EteY48o7vaatjBTp0L5xF-bRS+JF6A@mail.gmail.com>
References: <1389772636.13585.1.camel@phoenix>
	<5EB3BFCD089AD643B9BB63439F5FD5E9012BC102FB@SHAASIEXM01.ASIA.ROOT.PRI>
	<CAGsJ_4xu2g3K7D-QumwJBCxTvwc06GLE_Mz8uLyAKpHOLgq2Sw@mail.gmail.com>
	<CAFRkauB7DrFy-v0+14PcKjan4YxFiTzC5OruiaHC7mFdDmOXoA@mail.gmail.com>
	<CAGsJ_4y-5PuKA0y7JicDsH5AY159MPnA+qHU5BxnBrGC6WsT=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Zhiwu Song <zhiwu.song-kQvG35nSl+M@public.gmane.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGsJ_4y-5PuKA0y7JicDsH5AY159MPnA+qHU5BxnBrGC6WsT=g@mail.gmail.com>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

>>> Axel, thanks.
>>> it is a good cleanup, but it seems it is not right for txfifo_ctrl and
>>> rxfifo_ctrl?
>>
>> I don't get it.
>> I thought there is no functional change with this patch.
>
> you might want to change
>
>  txfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
>                                         SIRFSOC_SPI_FIFO_WIDTH_WORD;
>  rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
>                                        SIRFSOC_SPI_FIFO_WIDTH_WORD;
>
> to "SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2)  I sspi->word_width" ?
So it is a bug in original code, right? (I mean a bug before applying
this patch.)
I'll re-generate the patch and separate it to 2 patches.
( one for bug fix which may need for stable, the other one for the clean up)

Thanks,
Axel
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
