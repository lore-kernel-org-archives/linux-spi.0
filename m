From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
Date: Mon, 17 Dec 2018 21:55:25 +0300
Message-ID: <bfda743d-4aa0-732f-e240-9435647a4856@cogentembedded.com>
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-2-git-send-email-masonccyang@mxic.com.tw>
 <557c8114-2819-7be3-21b8-02918aa89c04@cogentembedded.com>
 <OFAE786891.A102E46D-ON48258366.002779D7-48258366.002A5C36@mxic.com.tw>
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
In-Reply-To: <OFAE786891.A102E46D-ON48258366.002779D7-48258366.002A5C36@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 12/17/2018 10:42 AM, masonccyang@mxic.com.tw wrote:

>> > +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
>> > +            const void *tx_buf, void *rx_buf)
>> > +{
>> > +   u32 smenr, smcr, data, pos = 0;
>> > +   int ret = 0;
>> > +
>> > +   regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
>> > +              RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
>> > +              RPC_CMNCR_BSZ(0));
>> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0x0);
>> > +   regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
>> > +   regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
>> > +   regmap_write(rpc->regmap, RPC_SMADR, rpc->addr);
>> > +
>> > +   if (tx_buf) {
>> > +      smenr = rpc->smenr;
>> > +
>> > +      while (pos < rpc->xferlen) {
>> > +         u32 nbytes = rpc->xferlen  - pos;
>> > +
>> > +         regmap_write(rpc->regmap, RPC_SMWDR0,
>> > +                 get_unaligned((u32 *)(tx_buf + pos)));
>> > +
>> > +         if (nbytes > 4) {
>> > +            nbytes = 4;
>> > +            smcr = rpc->smcr |
>> > +                   RPC_SMCR_SPIE | RPC_SMCR_SSLKP;
>> > +         } else {
>> > +            smcr = rpc->smcr | RPC_SMCR_SPIE;
>> > +         }
>> > +
>> > +         regmap_write(rpc->regmap, RPC_SMENR, smenr);
>> > +         regmap_write(rpc->regmap, RPC_SMCR, smcr);
>> > +         ret = wait_msg_xfer_end(rpc);
>> > +         if (ret)
>> > +            goto out;
>> > +
>> > +         pos += nbytes;
>> > +         smenr = rpc->smenr & ~RPC_SMENR_CDE &
>> > +                    ~RPC_SMENR_ADE(0xf);
>> > +      }
>> > +   } else if (rx_buf) {
>> > +      while (pos < rpc->xferlen) {
>> > +         u32 nbytes = rpc->xferlen  - pos;
>> > +
>> > +         if (nbytes > 4)
>> > +            nbytes = 4;
>> > +
>> > +         regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
>> > +         regmap_write(rpc->regmap, RPC_SMCR,
>> > +                 rpc->smcr | RPC_SMCR_SPIE);
>>
>>    Hm... our flash chip (Spansion S25FS512S) doesn't get detected; it sends
>> JEDEC ID bytes 0..3 repeatedly, unless I copy the SSLKP logic from the writing
>> branch above...
> 
> Do you switch the SW1, SW2, SW3, SW13, SW31 and SW10 to on-board QSPI mode ?
> Because R-Car D3 Draak board default is booting from HyperFlsah.

   I was testing your patch on the V3H-based Condor and Starter Kit boards --
it should have worked without much ado...
   It works with *our* driver, living under drivers/mtd/spi-nor/ (which makes
it outdated, AFAIU) and I was going to push it upstream before I learned about
your driver. :-)

> what follows is my booting log, FYI.
> ------------------------------------------------------------------
> [    1.625053] m25p80 spi5.0: s25fl129p1 (16384 Kbytes)

   So another Spansion flash?

> [    1.634391] 12 fixed-partitions partitions found on MTD device spi5.0
> [    1.642198] Creating 12 MTD partitions on "spi5.0":
> [    1.647598] 0x000000000000-0x000000040000 : "Bank 1 - Boot parameter"
> [    1.660893] 0x000000040000-0x000000180000 : "Bank 1 - Loader-BL2"
> [    1.671287] 0x000000180000-0x0000001c0000 : "Bank 1 - Certification"
> -----------------------------------------------------------------------
> 
>>
>> > +         ret = wait_msg_xfer_end(rpc);
>> > +         if (ret)
>> > +            goto out;
>> > +
>> > +         regmap_read(rpc->regmap, RPC_SMRDR0, &data);
>> > +         memcpy_fromio(rx_buf + pos, (void *)&data, nbytes);
>> > +         pos += nbytes;
>>
>>    ... and it skips byte 4 unless I copy the code from the end of the writing
>> branch, clearing CDE/ADE. But even then the byte 4 reads as 0x03 instead of 0.
> 
> yup, I think this is some kind of RPC HW limitation,
> in RPC manual I/O mode, it only could read 4 bytes data w/ one command.

   Thank for the info -- seems worth a comment though...

> That is, one command + read 4 bytes data + read 4 bytes data + read 4 bytes data + ...
> will get the incorrect data.

   What if we want to read less than 4 bytes (the ID read requests SPI_NOR_MAX_ID_LEN
(6) bytes, i.e. 4 + 2)? You seem to always expect 4 bytes...

> That's why RPC in manual I/O mode, driver only could do,
> one command + read 4 bytes data; one command + read 4 bytes data and so on.

   The question is why it just duplicates the ID bytes 0..3 on the 2nd iteration
in our case...

> But RPC in external address space read mode(here we call it direct mapping read mode)
> is ok for one command + read 4 bytes data + read 4 bytes data + ....

   Sounds promising... if only we could make the probing work. :-)

> thanks & best regards,
> Mason

MBR, Sergei
