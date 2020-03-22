From: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH AUTOSEL 5.5 01/41] spi: spi-omap2-mcspi: Handle DMA size
 restriction on AM65x
Date: Sun, 22 Mar 2020 15:37:39 -0400
Message-ID: <20200322193739.GO4189@sasha-vm>
References: <20200316023319.749-1-sashal@kernel.org>
 <20200316115057.GB5010@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200316115057.GB5010-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Mar 16, 2020 at 11:50:57AM +0000, Mark Brown wrote:
>On Sun, Mar 15, 2020 at 10:32:39PM -0400, Sasha Levin wrote:
>> From: Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>
>>
>> [ Upstream commit e4e8276a4f652be2c7bb783a0155d4adb85f5d7d ]
>>
>> On AM654, McSPI can only support 4K - 1 bytes per transfer when DMA is
>> enabled. Therefore populate master->max_transfer_size callback to
>> inform client drivers of this restriction when DMA channels are
>> available.
>
>As ever this only provides information to other drivers which may be
>buggy.

I'll drop it, thanks!

-- 
Thanks,
Sasha
