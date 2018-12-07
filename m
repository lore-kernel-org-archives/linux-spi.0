From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
Date: Fri, 7 Dec 2018 19:23:41 +0100
Message-ID: <ef6446d0-8b7f-08b1-df99-799f75578474@gmail.com>
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <0bd07d30-1c0a-ef5b-24ae-dcae3c4721ce@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0bd07d30-1c0a-ef5b-24ae-dcae3c4721ce@cogentembedded.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/07/2018 07:17 PM, Sergei Shtylyov wrote:
> Hello!
> 
>    I'd already started the v2 driver review before you posted v3, so here goes...
> 
> On 12/03/2018 12:18 PM, Mason Yang wrote:
> 
>> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
>>
>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> [...]
>> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
>> new file mode 100644
>> index 0000000..ac9094e
>> --- /dev/null
>> +++ b/drivers/spi/spi-renesas-rpc.c
>> @@ -0,0 +1,808 @@
> [...]
>> +#define RPC_CMNCR		0x0000	/* R/W */
>> +#define RPC_CMNCR_MD		BIT(31)
>> +#define RPC_CMNCR_SFDE		BIT(24)
> 
>    This bit is undocumented as of the gen3 manual v1.0. I'd like this to be reflected
> in a comment...

FYI, not even in v1.50 .

-- 
Best regards,
Marek Vasut
