From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v4 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
Date: Fri, 4 Jan 2019 16:42:41 +0300
Message-ID: <710badb0-c4db-a44b-dba1-01faf2f51a9d@cogentembedded.com>
References: <1545634358-17485-1-git-send-email-masonccyang@mxic.com.tw>
 <1545634358-17485-2-git-send-email-masonccyang@mxic.com.tw>
 <12cb2574-8ec9-d756-756a-d7fbbd5c7069@cogentembedded.com>
 <OFC561D699.9746ACDB-ON4825836F.000CB709-4825836F.00184155@mxic.com.tw>
 <0f21cd94-08ad-befa-649e-ba191b0e33bc@cogentembedded.com>
 <OFE79BC6CE.BE217C13-ON48258377.001FBC09-48258377.00243859@mxic.com.tw>
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
In-Reply-To: <OFE79BC6CE.BE217C13-ON48258377.001FBC09-48258377.00243859@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 01/03/2019 09:35 AM, masonccyang@mxic.com.tw wrote:

[...]
>> >> > +#define RPC_CMNCR_MOIIO3(val)   (((val) & 0x3) << 22)
>> >> > +#define RPC_CMNCR_MOIIO2(val)   (((val) & 0x3) << 20)
>> >> > +#define RPC_CMNCR_MOIIO1(val)   (((val) & 0x3) << 18)
>> >> > +#define RPC_CMNCR_MOIIO0(val)   (((val) & 0x3) << 16)
>> >> > +#define RPC_CMNCR_MOIIO_HIZ   (RPC_CMNCR_MOIIO0(3) |
>> >> RPC_CMNCR_MOIIO1(3) | \
>> >> > +             RPC_CMNCR_MOIIO2(3) | RPC_CMNCR_MOIIO3(3))
>> >> > +#define RPC_CMNCR_IO3FV(val)   (((val) & 0x3) << 14)
>> >> > +#define RPC_CMNCR_IO2FV(val)   (((val) & 0x3) << 12)
>> >>
>> >>    Like I said, the above 2 aren't documented in the manual v1.00...
>> >
>> > okay, add a description as:
>> > /* RPC_CMNCR_IO3FV/IO2FV are undocumented bit, but must be set */
>> > #define RPC_CMNCR_IO3FV(val)    (((val) & 0x3) << 14)
>> > #define RPC_CMNCR_IO2FV(val)    (((val) & 0x3) << 12)
>> > #define RPC_CMNCR_IO0FV(val)    (((val) & 0x3) << 8)
>> > #define RPC_CMNCR_IOFV_HIZ      (RPC_CMNCR_IO0FV(3) | RPC_CMNCR_IO2FV(3) | \
>> >                                   RPC_CMNCR_IO3FV(3))
>> >
>> > is it ok?
>>
>>    Yes. But would have been enough if you just commented with // on
>> the same line --
>> it seems these are legal now...
> 
> on the same line is over 80 char,
> #define RPC_CMNCR_IO3FV(val)    (((val) & 0x3) << 14) // undocumented bit, but must be set
> #define RPC_CMNCR_IO2FV(val)    (((val) & 0x3) << 12) // undocumented bit, but must be set
> 
> or just
> #define RPC_CMNCR_IO3FV(val)    (((val) & 0x3) << 14) // undocumented bit
> #define RPC_CMNCR_IO2FV(val)    (((val) & 0x3) << 12) // undocumented bit
> is it ok ?

   The second variant would be enough.

[...]

>> >> > +   ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
>> >> > +   if (ret)
>> >> > +      return ret;
>> >> > +
>> >> > +   rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
>> >> > +                &desc->info.op_tmpl, &offs, &len);
>> >> > +
>> >> > +   regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_SFDE |
>> >> > +           RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
>> >> > +           RPC_CMNCR_BSZ(0));
>> >>
>> >>    Why not set this in the probing time and only set/clear the MD bit?
>> >>
>> >
>> > same above!
>> > Make sure the value in these register are setting correctly
>> > before RPC starting a SPI transfer.
>>
>>    You can set it once and only change the bits you need to change afterwards.
>> What's wrong with it?
>>
> 
> if so, it will patch to:
> ------------------------------------------------------
> regmap_read(rpc->regmap, RPC_CMNCR, &data);
> data &= ~RPC_CMNCR_MD;
> regmap_write(rpc->regmap, RPC_CMNCR, data);
> ------------------------------------------------------
> Do you think this way is better ?

    No, this one is better:

	regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, 0);

> maybe this is better,
> write(read(rpc->regs + RPC_CMNCR) & ~RPC_CMNCR_MD,
>         rpc->regs + RPC_CMNCR);

   It's effectively the same code as your 1st variant...
 
[...]
>> >> > +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
>> >> > +               struct spi_message *msg)
>> >> > +{
>> >> [...]
>> >> > +   for (i = xfercnt - 1; i < xfercnt && xfercnt > 1; i++) {
>> >> > +      if (xfer[i].rx_buf) {
>> >> > +         rpc->smenr |=
>> >> > +            RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
>> >> > +            RPC_SMENR_SPIDB
>> >> > +            (ilog2((unsigned int)xfer[i].rx_nbits));
>> >>
>> >>    Mhm, I would indent this contination line by 1 extra tab...
>> >>
>> >> > +      } else if (xfer[i].tx_buf) {
>> >> > +         rpc->smenr |=
>> >> > +            RPC_SMENR_SPIDE(rpc_bits_set(xfer[i].len)) |
>> >> > +            RPC_SMENR_SPIDB
>> >> > +            (ilog2((unsigned int)xfer[i].tx_nbits));
>> >>
>> >>    And this one...
>> >
>> > like this ?
>> > --------------------------------------------------------------------
>> >          for (i = xfercnt - 1; i < xfercnt && xfercnt > 1; i++) {
>> >                  if (xfer[i].rx_buf) {
>> >                          rpc->smenr |=
>> >                                  RPC_SMENR_SPIDE(rpc_bits_set(xfer
>> [i].len)) |
>> >                                  RPC_SMENR_SPIDB(
>> >                                          ilog2((unsigned int)xfer
>> [i].rx_nbits));
>> >                  } else if (xfer[i].tx_buf) {
>> >                          rpc->smenr |=
>> >                                  RPC_SMENR_SPIDE(rpc_bits_set(xfer
>> [i].len)) |
>> >                                  RPC_SMENR_SPIDB(
>> >                                          ilog2((unsigned int)xfer
>> [i].tx_nbits));
>>
>>    I didn't mean you need to leave ( on the first line, can be left
>> on the  new
>> line, as before.
>>
> 
> how about this style ?
> -------------------------------------------------------------------------------------
>          for (i = xfercnt - 1; i < xfercnt && xfercnt > 1; i++) {
>                  if (xfer[i].rx_buf) {
>                          rpc->smenr |= RPC_SMENR_SPIDE(
>                                          rpc_bits_set(xfer[i].len)) |
>                                        RPC_SMENR_SPIDB(
>                                          ilog2((unsigned int)xfer[i].rx_nbits));
>                  } else if (xfer[i].tx_buf) {
>                          rpc->smenr |= RPC_SMENR_SPIDE(
>                                          rpc_bits_set(xfer[i].len)) |
>                                        RPC_SMENR_SPIDB(
>                                          ilog2((unsigned int)xfer[i].tx_nbits));
>                  }
>          }

   Looks even worse...

> ------------------------------------------------------------------------------------------
> 
> best regards,
> Mason

[...]

MBR, Sergei
