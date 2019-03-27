From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v8 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Wed, 27 Mar 2019 13:20:55 +0300
Message-ID: <07bee590-9334-f17f-19dd-f5fd35f44e11@cogentembedded.com>
References: <1548658158-5460-1-git-send-email-masonccyang@mxic.com.tw>
 <1548658158-5460-2-git-send-email-masonccyang@mxic.com.tw>
 <75c4642b-536e-f596-158d-387a63a5f6c5@cogentembedded.com>
 <OF7C1EB3FC.1ABCD2C2-ON482583C8.002D7A69-482583C8.002E899C@mxic.com.tw>
 <2fa6af66-de08-be37-7cdf-ccbf1e50ceb0@cogentembedded.com>
 <86e65614-814a-e8b8-fdbe-4b7b033e4938@cogentembedded.com>
 <OF5BDFBDAB.B66A1ADE-ON482583CA.0006C5C2-482583CA.0008788E@mxic.com.tw>
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
In-Reply-To: <OF5BDFBDAB.B66A1ADE-ON482583CA.0006C5C2-482583CA.0008788E@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 03/27/2019 04:32 AM, masonccyang@mxic.com.tw wrote:

>> >>>> +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
>> >>>> +               const struct spi_mem_op *op,
>> >>>> +               u64 *offs, size_t *len)
>> >>>> +{
>> >>>> +   struct rpc_spi *rpc = spi_controller_get_devdata(spi->controller);
>> >>>
>> >>>> +   if (op->dummy.nbytes) {
>> >>>> +      rpc->smenr |= RPC_SMENR_DME;
>> >>>> +      rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes);
>> >>>
>> >>>    SMDMCR.DMCYC is in bits -- you forgot to multiply by 8.
>> >>
>> >> ?
>> >>
>> >> It's dummy cycles setting, i.e,. 0 is 1 cycle dummy and
>> >
>> >    Yeah, I should've written "cycles", sorry about that.
>>
>>    I also should've mentioned that w/o this change the "read SFDP" command
>> returns garbage and the flash doesn't work.
>>
> 
> Have you checked the dummy cycles setting with logical analysis ?

   I don't have a logic analyzer (if you meant it). However, I dumped all the registers
in your driver and Cogent's own driver, and SMDMCR was set to 0 in your driver and to
7 in our driver -- and only our driver then worked correctly.

> As datasheet mentioned it's dummy cycles depends on the transfer bit size setting = 1, 4 or 8.
> Setting RPC_SMDMCR_DMCYC(0x13) in 8 bits data width I got a 20 dummy cycles.
> Also confirmed these 20 dummy cycles by logical analysis equipment.

[...]

> best regards,
> Mason

MBR, Sergei
