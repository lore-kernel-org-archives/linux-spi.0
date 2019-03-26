From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v8 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Tue, 26 Mar 2019 19:42:18 +0300
Message-ID: <86e65614-814a-e8b8-fdbe-4b7b033e4938@cogentembedded.com>
References: <1548658158-5460-1-git-send-email-masonccyang@mxic.com.tw>
 <1548658158-5460-2-git-send-email-masonccyang@mxic.com.tw>
 <75c4642b-536e-f596-158d-387a63a5f6c5@cogentembedded.com>
 <OF7C1EB3FC.1ABCD2C2-ON482583C8.002D7A69-482583C8.002E899C@mxic.com.tw>
 <2fa6af66-de08-be37-7cdf-ccbf1e50ceb0@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2fa6af66-de08-be37-7cdf-ccbf1e50ceb0@cogentembedded.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 03/25/2019 10:12 PM, Sergei Shtylyov wrote:

>>>> +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
>>>> +               const struct spi_mem_op *op,
>>>> +               u64 *offs, size_t *len)
>>>> +{
>>>> +   struct rpc_spi *rpc = spi_controller_get_devdata(spi->controller);
>>>
>>>> +   if (op->dummy.nbytes) {
>>>> +      rpc->smenr |= RPC_SMENR_DME;
>>>> +      rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes);
>>>
>>>    SMDMCR.DMCYC is in bits -- you forgot to multiply by 8.
>>
>> ?
>>
>> It's dummy cycles setting, i.e,. 0 is 1 cycle dummy and
> 
>    Yeah, I should've written "cycles", sorry about that.

   I also should've mentioned that w/o this change the "read SFDP" command
returns garbage and the flash doesn't work.

[...]

MBR, Sergei
