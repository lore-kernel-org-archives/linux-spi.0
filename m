From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v3 8/9] spi: rockchip: modify DMA max burst to 1
Date: Thu, 3 Sep 2015 21:41:43 +0800
Message-ID: <55E84E17.2090409@rock-chips.com>
References: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
 <1441101524-1700-1-git-send-email-shawn.lin@rock-chips.com>
 <20150903125429.GA12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>,
	Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Olof Johansson <olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150903125429.GA12027-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2015/9/3 20:54, Mark Brown wrote:
> On Tue, Sep 01, 2015 at 05:58:44PM +0800, Shawn Lin wrote:
>
>> Generic dma controller on Rockchips' platform cannot support
>> DMAFLUSHP instruction which make dma to flush the req of non-aligned
>> or non-multiple of what we need. That will cause an unrecoverable
>> dma bus error. The saftest way is to set dma max burst to 1.
>
> If this is a quirk of the DMA controller why is it being fixed with a
> property specific to the SPI controller?  Can't the DMA controller just
> override the burst size?
>

Cool...that's a good question. Actually DMA controller can't do that 
since block peripheral controller(e.g sd/emmc, they always access data 
by block-512Bytes.) can't meet the case. So It's hard for dma controller 
know who is the caller, and what should be done.

The only thing dma controller can do is avoid to execute DMAFLUSHP on 
its own. But how about peripheral controller trigger non-multiple 
access? So that's what I mentioned on covery letter that we should do 
"broken things" for both dma controller and some peripherals.

>> +#define ROCKCHIP_SPI_BORKEN_BURST_LEN (1<<0) /* broken burst len*/
>
> This is misspelt.

Woops, sorry for the bit. Thanks, Mark.

>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
