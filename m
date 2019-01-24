From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Thu, 24 Jan 2019 02:51:59 +0100
Message-ID: <bb63b646-b549-dc3b-a604-17ba156e735c@gmail.com>
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 1/23/19 8:09 AM, Mason Yang wrote:
> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

> +#define RPC_CMNCR		0x0000	// R/W

Is there any reason for using those horrible C++ comments ?

[...]

> +module_platform_driver(rpc_spi_driver);

RPC is not a SPI controller, it's a SPI and HF controller.

Also, how difficult will it be to add the HF support ?

> +MODULE_AUTHOR("Mason Yang <masonccyang@mxic.com.tw>");
> +MODULE_DESCRIPTION("Renesas R-Car Gen3 RPC-IF SPI controller driver");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best regards,
Marek Vasut
