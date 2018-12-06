From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
Date: Thu, 6 Dec 2018 10:02:11 +0100
Message-ID: <93bb36af-8bdb-c90e-3777-62fe1a48f76a@gmail.com>
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com>
 <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
 <84e3c55b-687e-28f6-0a7c-1c48c822ef05@gmail.com>
 <OFC9FB54F8.34B3A8B7-ON4825835B.00267480-4825835B.0029455C@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFC9FB54F8.34B3A8B7-ON4825835B.00267480-4825835B.0029455C@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/06/2018 08:30 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> >> Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
> driver
>> >>
>> >> On 12/03/2018 10:18 AM, Mason Yang wrote:
>> >> > Add a driver for Renesas R-Car Gen3 RPC SPI controller.
>> >> >
>> >> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> >>
>> >> What changed in this V2 ?
>> >>
>> >> [...]
>> >
>> > see some description in [PATH v2 0/2]
>>
>> I don't see any V2: list there.
>>
> 
> including
> 1) remove RPC clock enable/dis-able control,
> 2) patch run time PM,
> 3) add RPC module software reset,
> 4) add regmap,
> 5) other coding style and so on.

Please include a detailed changelog in each subsequent patch series.

>> >> > +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
>> >> > +            const void *tx_buf, void *rx_buf)
>> >> > +{
>> >> > +   u32 smenr, smcr, data, pos = 0;
>> >> > +   int ret = 0;
>> >> > +
>> >> > +   regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD |
> RPC_CMNCR_SFDE |
>> >> > +              RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
>> >> > +              RPC_CMNCR_BSZ(0));
>> >> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0x0);
>> >> > +   regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
>> >> > +   regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
>> >> > +   regmap_write(rpc->regmap, RPC_SMADR, rpc->addr);
>> >> > +
>> >> > +   if (tx_buf) {
>> >> > +      smenr = rpc->smenr;
>> >> > +
>> >> > +      while (pos < rpc->xferlen) {
>> >> > +         u32 nbytes = rpc->xferlen  - pos;
>> >> > +
>> >> > +         regmap_write(rpc->regmap, RPC_SMWDR0,
>> >> > +                 *(u32 *)(tx_buf + pos));
>> >>
>> >> *(u32 *) cast is probably not needed , fix casts globally.
>> >
>> > It must have it!
>>
>> Why ?
> 
> Get a compiler warning due to tx_bug is void *, as Geert replied.

The compiler warning is usually an indication that this is something to
check, not silence with a type cast.

> Using get_unaligned(), patched code would be
> -----------------------------------------------------
> regmap_write(rpc->regmap, RPC_SMWDR0,
>                  get_unaligned((u32 *)(tx_buf + pos)));                
> ----------------------------------------------------

Do you need the cast if you use get_unaligned() ?

>> >> > +         rpc->xferlen = *(u32 *)len;
>> >> > +         rpc->totalxferlen += *(u32 *)len;
>> >> > +      } else {
>> >> > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>> >> > +               (op->data.nbytes)) | RPC_SMENR_SPIDB
>> >> > +               (fls(op->data.buswidth >> 1));
>> >>
>> >> Drop parenthesis around fls()
>> >
>> > ?
>> > no way.
>>
>> I would really appreciate it if you could explain things instead.
>>
>> Geert already did so, by pointing out this is a confusing code
>> formatting problem and how it should be fixed, so no need to repeat
>> that. But I hope you understand how that sort of explanation is far more
>> valuable than "no way" kind of reply.
> 
> okay, understood.
> 
> 
>> >> > +
>> >> > +   xfercnt = xferpos;
>> >> > +   rpc->xferlen = xfer[--xferpos].len;
>> >> > +   rpc->cmd = RPC_SMCMR_CMD(((u8 *)xfer[0].tx_buf)[0]);
>> >>
>> >> Is the cast needed ?
>> >
>> > yes!
>>
>> Why ?
> 
> Get a compiler warning due to tx_bug is void *, as Geert replied.

> Using get_unaligned(), patched code would be
> ---------------------------------------------------------------
>  rpc->cmd = RPC_SMCMR_CMD(get_unaligned((u8 *)xfer[0].tx_buf));
> ----------------------------------------------------------------

See above

>> >> > +   rpc->smenr = RPC_SMENR_CDE | RPC_SMENR_CDB(fls(xfer[0].tx_nbits
>> >>> 1));
>> >> > +   rpc->addr = 0;
>> >> > +
>> >> > +   if (xfercnt > 2 && xfer[1].len && xfer[1].tx_buf) {
>> >> > +      rpc->smenr |= RPC_SMENR_ADB(fls(xfer[1].tx_nbits >> 1));
>> >> > +      for (i = 0; i < xfer[1].len; i++)
>> >> > +         rpc->addr |= (u32)((u8 *)xfer[1].tx_buf)[i]
>> >> > +               << (8 * (xfer[1].len - i - 1));
>> >> > +
>> >> > +      if (xfer[1].len == 4)
>> >> > +         rpc->smenr |= RPC_SMENR_ADE(0xf);
>> >> > +      else
>> >> > +         rpc->smenr |= RPC_SMENR_ADE(0x7);
>> >> > +   }
>> >> > +
>> >> > +   switch (xfercnt) {
>> >> > +   case 2:
>> >> > +      if (xfer[1].rx_buf) {
>> >> > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>> >> > +                  (xfer[1].len)) | RPC_SMENR_SPIDB(fls
>> >> > +                  (xfer[1].rx_nbits >> 1));
>> >> > +      } else if (xfer[1].tx_buf) {
>> >> > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>> >> > +                  (xfer[1].len)) | RPC_SMENR_SPIDB(fls
>> >> > +                  (xfer[1].tx_nbits >> 1));
>> >> > +      }
>> >> > +      break;
>> >> > +
>> >> > +   case 3:
>> >> > +      if (xfer[2].len && xfer[2].rx_buf && !xfer[2].tx_buf) {
>> >> > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>> >> > +                  (xfer[2].len)) | RPC_SMENR_SPIDB(fls
>> >> > +                  (xfer[2].rx_nbits >> 1));
>> >>
>> >> It seems this SMENR pattern repeats itself throughout the driver, can
>> >> this be improved / deduplicated ?
>> >
>> > It seems no way!
>>
>> Why ?
> 
> okay, I patch this with for( ) loop.

Please do, let's see how it looks .

>> >> > +      } else if (xfer[2].len && xfer[2].tx_buf && !xfer[2].rx_buf) {
>> >> > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>> >> > +                  (xfer[2].len)) | RPC_SMENR_SPIDB(fls
>> >> > +                  (xfer[2].tx_nbits >> 1));
>> >> > +      }
>> >> > +      break;
>> >> > +
>> >> > +   case 4:
>> >> > +      if (xfer[2].len && xfer[2].tx_buf) {
>> >> > +         rpc->smenr |= RPC_SMENR_DME;
>> >> > +         rpc->dummy = RPC_SMDMCR_DMCYC(xfer[2].len);
>> >> > +      }
>> >> > +
>> >> > +      if (xfer[3].len && xfer[3].rx_buf) {
>> >> > +         rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
>> >> > +                  (xfer[3].len)) | RPC_SMENR_SPIDB(fls
>> >> > +                  (xfer[3].rx_nbits >> 1));
>> >> > +      }
>> >> > +      break;
>> >> > +
>> >> > +   default:
>> >> > +      break;
>> >> > +   }
>> >> > +}
>> >> > +
>> >> > +static int rpc_spi_xfer_message(struct rpc_spi *rpc, struct
>> >> spi_transfer *t)
>> >> > +{
>> >> > +   int ret;
>> >> > +
>> >> > +   ret = rpc_spi_set_freq(rpc, t->speed_hz);
>> >> > +   if (ret)
>> >> > +      return ret;
>> >> > +
>> >> > +   ret = rpc_spi_io_xfer(rpc,
>> >> > +               rpc->xfer_dir == SPI_MEM_DATA_OUT ?
>> >> > +               t->tx_buf : NULL,
>> >> > +               rpc->xfer_dir == SPI_MEM_DATA_IN ?
>> >> > +               t->rx_buf : NULL);
>> >> > +
>> >> > +   return ret;
>> >> > +}
>> >> > +
>> >> > +static int rpc_spi_transfer_one_message(struct spi_master *master,
>> >> > +               struct spi_message *msg)
>> >> > +{
>> >> > +   struct rpc_spi *rpc = spi_master_get_devdata(master);
>> >> > +   struct spi_transfer *t;
>> >> > +   int ret;
>> >> > +
>> >> > +   rpc_spi_transfer_setup(rpc, msg);
>> >> > +
>> >> > +   list_for_each_entry(t, &msg->transfers, transfer_list) {
>> >> > +      if (!list_is_last(&t->transfer_list, &msg->transfers))
>> >> > +         continue;
>> >> > +      ret = rpc_spi_xfer_message(rpc, t);
>> >> > +      if (ret)
>> >> > +         goto out;
>> >> > +   }
>> >> > +
>> >> > +   msg->status = 0;
>> >> > +   msg->actual_length = rpc->totalxferlen;
>> >> > +out:
>> >> > +   spi_finalize_current_message(master);
>> >> > +   return 0;
>> >> > +}
>> >> > +
>> >> > +static const struct regmap_range rpc_spi_volatile_ranges[] = {
>> >> > +   regmap_reg_range(RPC_SMRDR0, RPC_SMRDR0),
>> >> > +   regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0),
>> >>
>> >> Why is SMWDR volatile ?
>> >
>> > No matter is write-back or write-through.
>>
>> Oh, do you want to assure the SMWDR value is always written directly to
>> the hardware ?
> 
> yes,
> 
>>
>> btw. I think SMRDR should be precious ?
> 
> so, you think I should drop
> regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0)

No, I am asking whether SMRDR should be marked precious or not.

[...]

> CONFIDENTIALITY NOTE:
> 
> This e-mail and any attachments may contain confidential information
> and/or personal data, which is protected by applicable laws. Please be
> reminded that duplication, disclosure, distribution, or use of this
> e-mail (and/or its attachments) or any part thereof is prohibited. If
> you receive this e-mail in error, please notify us immediately and
> delete this mail as well as its attachment(s) from your system. In
> addition, please be informed that collection, processing, and/or use of
> personal data is prohibited unless expressly permitted by personal data
> protection laws. Thank you for your attention and cooperation.
> 
> Macronix International Co., Ltd.

Can you do something about this ^ please ?

-- 
Best regards,
Marek Vasut
