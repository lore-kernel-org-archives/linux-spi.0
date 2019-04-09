From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Tue, 9 Apr 2019 14:20:50 +0300
Message-ID: <869a1c6d-cfa6-35e9-592b-4e0937530e31@cogentembedded.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <231f7423-bf13-99f8-427b-530f5446348b@cogentembedded.com>
 <OF7F1B534F.B934A9FE-ON482583D0.001DC618-482583D0.001FE84B@mxic.com.tw>
 <6d60bbef-a8ef-849e-33f3-3db35cefc09f@cogentembedded.com>
 <OFAEA16021.C7F7B095-ON482583D1.0031A13D-482583D1.00335085@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFAEA16021.C7F7B095-ON482583D1.0031A13D-482583D1.00335085@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/03/2019 12:20 PM, masonccyang@mxic.com.tw wrote:

[...]
>> >> > +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>> >> > +   if (ret)
>> >> > +      return ret;
>> >> > +
>> >> > +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>> >> > +                &desc->info.op_tmpl, &offs, &len);
>> >> > +
>> >> > +   regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, 0);
>> >> > +   regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RBURST(32) |
>> >> > +           RPC_DRCR_RBE);
>> >> > +
>> >> > +   regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
>> >> > +   regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
>> >>
>> >>    So you're not even trying to support flashes larger than the
>> read dirmap?
>> >> Now I don't think it's acceptable (and I have rewritten this code
>> internally).
>> >
>> > what about the size comes form mtd->size ?
>>
>>    I'm not talking about size here; we should use the full address.
>> I'm attaching
>> my patch...
> 
> okay,got it!
> what about just
> -      regmap_write(rpc->mfd->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
> +      regmap_write(rpc->mfd->regmap, RPC_DREAR,
> +                   RPC_DREAR_EAV(offs >> 25) | RPC_DREAR_EAC(1));
> 
> because only > 64MByte size make RPC_DREAR_EAV() work.

   Seems OK now, after Boris' reply.

> thanks & best regards,
> Mason

[...]

MBR, Sergei
