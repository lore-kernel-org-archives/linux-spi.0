From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 0/2] spi: Add Renesas R-Car Gen3 RPC SPI driver
Date: Sun, 9 Dec 2018 18:37:52 +0300
Message-ID: <1148d04d-96b1-ef91-e3d9-2603e9a5c6fc@cogentembedded.com>
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/07/2018 02:13 PM, Mason Yang wrote:

> This Renesas R-Car Gen3 RPC SPI driver is based on Boris's new
> spi-mem direct mapping read/write mode [1][2].
> 
> v3 patch is according to Marek and Geert's comments including:
> 1) soc_device_mach() to set up RPC_PHYCNT_STRTIM.
> 2) get_unaligned()
> 3) rpc-mode for rpi-spi-flash or rpc-hyperflash.
> 4) coding style and so on.
> 
> 
> v2 patch including:
> 1) remove RPC clock enable/dis-able control,
> 2) patch run time PM, 
> 3) add RPC module software reset, 
> 4) add regmap,
> 5) other coding style and so on.
> 
> thanks for your review.
> 
> best regards,
> Mason
> 
> [1] https://patchwork.kernel.org/patch/10670753
> [2] https://patchwork.kernel.org/patch/10670747
> 
> 
> Mason Yang (2):
>   spi: Add Renesas R-Car Gen3 RPC SPI controller driver
>   dt-binding: spi: Document Renesas R-Car Gen3 RPC controller bindings

   Probably a stupid question: how did you test this driver (especially
the dirmap related parts)?

MBR, Sergei
