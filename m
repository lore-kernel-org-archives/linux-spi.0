From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: Don't request/release DMA channels for each
 SPI transfer
Date: Mon, 09 Jan 2017 08:43:16 +0100
Message-ID: <4bff51ce-2856-88dd-2518-ef8fa0c179e2@samsung.com>
References: <CGME20161229121937eucas1p11cd0bb98b21699b0f773ecaeb7c29d26@eucas1p1.samsung.com>
 <1483013971-26446-1-git-send-email-m.szyprowski@samsung.com>
 <20161231182615.tuukfj5fa4wwkwvj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20161231182615.tuukfj5fa4wwkwvj-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,


On 2016-12-31 19:26, Mark Brown wrote:
> On Thu, Dec 29, 2016 at 01:19:31PM +0100, Marek Szyprowski wrote:
>> Requesting a DMA channel might be a time consuming operation, so there is
>> no need to acquire and release DMA channel for each SPI transfer.
> This doesn't apply against current code, please check and resend.

It fails to apply because of missing commit 
6f8dc9d481759b428a8cb6a17b83821451415ba9
("spi: s3c64xx: Do not use platform_data for DMA parameters") in your 
spi-next,
which is already in v4.10-rc1 and came through dma-engine tree. My patch 
depends on
it and removing this dependency will make a merge conflict later while 
merging to
Linus if I rebase directly onto your spi-next.

IMHO it would be better either to merge v4.10-rc1 to your spi-next 
branch or at
least apply the mentioned patch to your branch before applying this one.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
