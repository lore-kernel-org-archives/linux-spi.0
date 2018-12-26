From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v4 0/2] spi: Add Renesas R-Car Gen3 RPC SPI driver
Date: Wed, 26 Dec 2018 20:06:13 +0100
Message-ID: <80223417-2919-97c7-d9e3-0d0511a5a517@gmail.com>
References: <1545634358-17485-1-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545634358-17485-1-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/24/18 7:52 AM, Mason Yang wrote:
> Hi Mark,
> 
> This Renesas R-Car Gen3 RPC SPI driver is based on Boris's new
> spi-mem direct mapping read/write mode [1][2].

Again, the RPC is NOT a SPI controller, it is dual SPI/HF controller.

[...]

-- 
Best regards,
Marek Vasut
