From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Thu, 24 Jan 2019 14:31:11 +0300
Message-ID: <93e1f97e-7afd-4a3e-b059-9f66390efa56@cogentembedded.com>
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
 <bb63b646-b549-dc3b-a604-17ba156e735c@gmail.com>
 <OF767ACC95.EECC73BE-ON4825838C.000BD6A3-4825838C.000D23A6@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: masonccyang@mxic.com.tw, bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, zhengxunli@mxic.com.tw
To: Marek Vasut <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF767ACC95.EECC73BE-ON4825838C.000BD6A3-4825838C.000D23A6@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 01/24/2019 05:23 AM, masonccyang@mxic.com.tw wrote:

>> [...]
>>
>> > +module_platform_driver(rpc_spi_driver);
>>
>> RPC is not a SPI controller, it's a SPI and HF controller.
>>
>> Also, how difficult will it be to add the HF support ?
> 
> One of my customers needs RPC SPI driver for our company's Octal-Flash,MX25UW51245G.
> We don't have HF product and hope you could understanding.

   I'm looking into the HF support (we have a driver internally).

> 
> thanks & best regards,
> Mason

MBR, Sergei
