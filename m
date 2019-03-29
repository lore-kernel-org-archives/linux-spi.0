From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Fri, 29 Mar 2019 11:44:51 +0100
Message-ID: <2741fba1-9aab-d044-15db-54d09e12d309@gmail.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 3/29/19 9:20 AM, Mason Yang wrote:

[...]

> +struct rpc_spi {
> +	struct clk *clk_rpc;
> +	void __iomem *base;
> +	void __iomem *dirmap;
> +	void __iomem *wbuf;

Shouldn't all this stuff somehow come from the MFD driver ?

> +	struct regmap *regmap;
> +	u32 cur_speed_hz;
> +	u32 cmd;
> +	u32 addr;
> +	u32 dummy;
> +	u32 smcr;
> +	u32 smenr;
> +	u32 xferlen;
> +	u32 totalxferlen;
> +	enum spi_mem_data_dir xfer_dir;
> +	struct reset_control *rstc;
> +};
> +
[...]


-- 
Best regards,
Marek Vasut
