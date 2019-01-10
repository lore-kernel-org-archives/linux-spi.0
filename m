From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Thu, 10 Jan 2019 13:26:01 +0300
Message-ID: <dd36d2b3-c0e3-f6a3-56f1-c96f4ae59ece@cogentembedded.com>
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
 <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
 <20190110111601.1dad05a0@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Boris Brezillon <bbrezillon@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110111601.1dad05a0@bbrezillon>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 01/10/2019 01:16 PM, Boris Brezillon wrote:

>>> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>>>
>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>  
>>
>>    You now need to add:
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> May I ask why?

   v5 includes my signed read mode workaround patch.

MBR, Sergei
