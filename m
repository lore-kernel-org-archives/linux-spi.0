From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
Date: Sat, 22 Dec 2018 17:20:16 +0300
Message-ID: <908cd30d-10d9-a60d-8056-84924557bfbe@cogentembedded.com>
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <0bd07d30-1c0a-ef5b-24ae-dcae3c4721ce@cogentembedded.com>
 <OF1EDC1518.914B7F08-ON48258360.0022FD71-48258360.0033D3DE@mxic.com.tw>
 <c0a83699-05e1-26fa-ca74-ba6f0850cb7b@cogentembedded.com>
 <OF719DFBAE.D0F9F117-ON4825836A.0039EEA3-4825836A.003B28D8@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF719DFBAE.D0F9F117-ON4825836A.0039EEA3-4825836A.003B28D8@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 12/21/2018 01:46 PM, masonccyang@mxic.com.tw wrote:

>> >>> +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
>> >>> +               u64 offs, size_t len, const void *buf)
>> >>> +{
>> >>> +   struct rpc_spi *rpc = spi_master_get_devdata(desc->mem->spi->master);
>> >>> +   int ret;
>> >>> +
>> >>> +   if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
>> >>> +      return -EINVAL;
>> >>> +
>> >>> +   if (WARN_ON(len > RPC_WBUF_SIZE))
>> >>> +      return -EIO;
>> >>
>> >>    Why not write 256 bytes and return w/that?
>> >
>> > in manual 62.3.13 Write Buffer Operation,
>> > transfer size to device is 256-byte unit.
>>
>>    Why not write 256 bytes max and just return 256?
>>
> 
> ?
> I don't get your point.
> 
> here writes 256 byte each time and return 256 (len).

   I mean not aborting the requests for >256 bytes right away (like you do) but
write only 256 bytes and return 256, not -EIO.

[...]
>> >>
>> >>> +      for (i = 0; i < xfer[1].len; i++)
>> >>> +         rpc->addr |= (u32)((u8 *)xfer[1].tx_buf)[i]
>> >>> +               << (8 * (xfer[1].len - i - 1));
>> >>
>> >>    Ugh, you need get_unaligned_*()...
>> >
>> > for accessing a single byte quantity, ((u8 *)xfer[1].tx_buf)[i] ?
>>
>>    Ugh, never start a new line with an operator, lease it on a 1st,

   Sorry -- leave, not lease.

>> broken up line.
> 
> okay, patch it to:
> 
> rpc->addr |= (u32)((u8 *)xfer[1].tx_buf)[i] <<
>                  (8 * (xfer[1].len - i - 1));

   OK, thanks.

[...]

>> [...]
>> >> > +err_put_master:
>> >> > +   spi_master_put(master);
>> >> > +   pm_runtime_disable(&pdev->dev);
>> >> > +
>> >> > +   return ret;
>> >> > +}
>> >> > +
>> >> > +static int rpc_spi_remove(struct platform_device *pdev)
>> >> > +{
>> >> > +   struct spi_master *master = platform_get_drvdata(pdev);
>> >> > +
>> >> > +   pm_runtime_disable(&pdev->dev);
>> >> > +   spi_unregister_master(master);
>> >>
>> >>    No spi_master_put() here?
>> >
>> > put_device() in spi_unregister_master().
>>
>>    Why call spi_master_put() in the probe() method's error path?
>>
> 
> called get_device() in spi_register_master() !

   Hm, this is somewhat asymmetric...

> thanks & best regards,
> Mason

[...]

MBR, Sergei
