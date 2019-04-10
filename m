From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Wed, 10 Apr 2019 20:53:12 +0300
Message-ID: <3f4a77a9-0c2a-b3c3-c97e-a3c84df90ef0@cogentembedded.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <a2dc294f-f2a1-2469-1f44-db67f9b8cc10@cogentembedded.com>
 <OFC7F0028A.CFF6BD04-ON482583D8.00084FA1-482583D8.0008985F@mxic.com.tw>
 <2095d059-8276-a01a-7c3a-da4647f7b7df@gmail.com>
 <OF75EDBF48.5C308F1B-ON482583D8.0027A537-482583D8.002C0A64@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw, Marek Vasut <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF75EDBF48.5C308F1B-ON482583D8.0027A537-482583D8.002C0A64@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 04/10/2019 11:01 AM, masonccyang@mxic.com.tw wrote:

>> >> > +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc
>> > *desc,
>> >> > +               u64 offs, size_t len, const void *buf)
>> >> > +{
>> >> > +   struct rpc_spi *rpc =
>> >> > +         spi_controller_get_devdata(desc->mem->spi->controller);
>> >> > +   int ret;
>> >> > +
>> >> > +   if (offs + desc->info.offset + len > U32_MAX)
>> >> > +      return -EINVAL;
>> >> > +
>> >> > +   if (len > RPC_WBUF_SIZE)
>> >> > +      len = RPC_WBUF_SIZE;
>> >> > +
>> >> > +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>> >> > +   if (ret)
>> >> > +      return ret;
>> >> > +
>> >> > +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>> >> > +                &desc->info.op_tmpl, &offs, &len);
>> >> > +
>> >> > +   regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD,
>> > RPC_CMNCR_MD);
>> >> > +
>> >> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0);
>> >> > +
>> >> > +   regmap_update_bits(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_STRTIM(7) |
>> >> > +            RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF,
>> >> > +            RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);
>> >> > +
>> >> > +   memcpy_toio(rpc->wbuf, buf, len);
>> >>
>> >>    Wait, doesn't the manual say that the whole 256-byte buffer should be
>> >> filled?
> 
> it could be less than 256 bytes, i.e., 128 bytes to rpc->wbuf !

   The gen3 manual 1.50 contradicts:

Note: This area should be accessed sequentially from the start address and transfer size
to the device is 256-byte unit. All Write Buffer area should be filled with transfer data
in every transfer. When accessing non-sequentially or at random, the operation is not
guaranteed. After Write Buffer Operation, this cache area must be cleared by DRCR.RCF bit.

>  I think that short chunks have to be written w/o WBUF (done,
>> > in fact,
>> >> by the HF driver).
>> >>
>> >
>> > From spi-nor.c layer always transfer 256 bytes data with page program
>> > command.
>>
>> Does that apply even for flashes with not-256-byte pages ?
>>
> 
> I think it needs to patch in case of nor->page_size = 512 bytes.

   What needs to patch what? :-)

> thanks & best regards,
> Mason

MBR, Sergei
