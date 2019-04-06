From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Sat, 6 Apr 2019 22:59:33 +0300
Message-ID: <724feb3b-2ef9-3ff4-8cad-586162fbc471@cogentembedded.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <231f7423-bf13-99f8-427b-530f5446348b@cogentembedded.com>
 <OF7F1B534F.B934A9FE-ON482583D0.001DC618-482583D0.001FE84B@mxic.com.tw>
 <6d60bbef-a8ef-849e-33f3-3db35cefc09f@cogentembedded.com>
 <OFAEA16021.C7F7B095-ON482583D1.0031A13D-482583D1.00335085@mxic.com.tw>
 <7467d695-8922-16b2-03d4-fb4bbdda125a@cogentembedded.com>
 <20190404211234.5468e7a4@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: masonccyang@mxic.com.tw, bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        zhengxunli@mxic.com.tw
To: Boris Brezillon <boris.brezillon@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404211234.5468e7a4@collabora.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/04/2019 10:12 PM, Boris Brezillon wrote:

[...]
>>>>>>> +static ssize_t rpc_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
>>>>>>> +                   u64 offs, size_t len, void *buf)
>>>>>>> +{
>>>>>>> +   struct rpc_spi *rpc =
>>>>>>> +         spi_controller_get_devdata(desc->mem->spi->controller);
>>>>>>> +   int ret;
>>>>>>> +
>>>>>>> +   if (offs + desc->info.offset + len > U32_MAX)
>>>>>>> +      return -EINVAL;
>>>>>>> +
>>>>>>> +   if (len > 0x4000000)
>>>>>>> +      len = 0x4000000;  
>>>>>>
>>>>>>    Ugh...  
>>>>>
>>>>> by mtd->size ?  
>>>>
>>>>   That'd be better, yes.
>>>>  
>>>
>>> Oops, it seems hard to get mtd->size info. from spi_mem_dirmap,  
>>
>>    It's in desc->info.length, no?
> 
> It's the lengths of the mapping which not necessarily mtd->size, but in
> the SPI NOR case it is :-). Anyway, you should not assume
> dirmapdesc->info.length == memory_device->size.
> 
>>
>>> I would like to keep 0x4000000.  
>>
>>    I'm seeing Boris in the CC's... Boris, is it legitimate to limit
>> a single dirmap read by the memory "window" size? Or should we try to 
>> serve any valid transfer length?
> 
> If by memory window you're talking about the memory region reserved in

   Yes, we have 64 MiB window thru which we can "look into" the large MTD chips.

> the CPU address space, then no. It should not be limited to this size
> if possible.

   Mhm, so we're expected to loop incrementing the window address register
in order to serve the full xfer request?

> Most HW have a way to configure an offset to apply to the spi-mem operation,
> and in that case, the driver should change this
> offset on the fly when one tries to access a region that's outside of
> the currently configured window.

   Well, my question wasn't about that actually -- that seemed quite obvious.

>>>>>>> +
>>>>>>> +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>>>>>>> +   if (ret)
>>>>>>> +      return ret;
>>>>>>> +
>>>>>>> +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>>>>>>> +                &desc->info.op_tmpl, &offs, &len);
>>>>>>> +
>>>>>>> +   regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, 0);
>>>>>>> +   regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RBURST(32) |
>>>>>>> +           RPC_DRCR_RBE);
>>>>>>> +
>>>>>>> +   regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
>>>>>>> +   regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));  
>>>>>>
>>>>>>    So you're not even trying to support flashes larger than the  
>>>> read dirmap?  
>>>>>> Now I don't think it's acceptable (and I have rewritten this code  
>>>> internally).  
>>>>>
>>>>> what about the size comes form mtd->size ?  
>>>>
>>>>    I'm not talking about size here; we should use the full address.
>>>> I'm attaching
>>>> my patch...  
>>>
>>> okay,got it!
>>> what about just
>>> -      regmap_write(rpc->mfd->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
>>> +      regmap_write(rpc->mfd->regmap, RPC_DREAR,
>>> +                   RPC_DREAR_EAV(offs >> 25) | RPC_DREAR_EAC(1));
>>>
>>> because only > 64MByte size make RPC_DREAR_EAV() work.  
>>
>>    Boris, what's your opinion on this?
>>    Note that for the write dirmap we have just 256-byte buffer (reusing
>> the read cache). Is it legitimate to limit the served length to 256 bytes?

> I don't know what the HW is capable of,

   As I said, there's 64 MiB read window, and for the writes we can re-use the
read cache to write (exactly) 256 bytes at a time...

> but drivers should use any try
> they have to dynamically move the memory map window (make it point at a
> different spi-mem offset on demand). Note that dirmap_read/write() are
> allowed to return less than the amount of data requested, in that case
> the caller should continue reading at the offset where things stopped.
> This avoids having to implement a loop that splits things in several
> accesses when the access cannot be done in one step.

   Ah, this somewhat contradicts what you said earlier but seems clear now.
I'll go remove the loops. :-)

MBR, Sergei
