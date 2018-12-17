From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v3 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
Date: Mon, 17 Dec 2018 14:23:29 +0100
Message-ID: <a4c18176-783b-70db-4668-31cc332705a7@gmail.com>
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-2-git-send-email-masonccyang@mxic.com.tw>
 <557c8114-2819-7be3-21b8-02918aa89c04@cogentembedded.com>
 <OFAE786891.A102E46D-ON48258366.002779D7-48258366.002A5C36@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFAE786891.A102E46D-ON48258366.002779D7-48258366.002A5C36@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/17/2018 08:42 AM, masonccyang@mxic.com.tw wrote:
> Hi Sergei,
> 
> 
>> > +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
>> > +            const void *tx_buf, void *rx_buf)
>> > +{
>> > +   u32 smenr, smcr, data, pos = 0;
>> > +   int ret = 0;
>> > +
>> > +   regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
>> > +              RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
>> > +              RPC_CMNCR_BSZ(0));
>> > +   regmap_write(rpc->regmap, RPC_SMDRENR, 0x0);
>> > +   regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
>> > +   regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
>> > +   regmap_write(rpc->regmap, RPC_SMADR, rpc->addr);
>> > +
>> > +   if (tx_buf) {
>> > +      smenr = rpc->smenr;
>> > +
>> > +      while (pos < rpc->xferlen) {
>> > +         u32 nbytes = rpc->xferlen  - pos;
>> > +
>> > +         regmap_write(rpc->regmap, RPC_SMWDR0,
>> > +                 get_unaligned((u32 *)(tx_buf + pos)));
>> > +
>> > +         if (nbytes > 4) {
>> > +            nbytes = 4;
>> > +            smcr = rpc->smcr |
>> > +                   RPC_SMCR_SPIE | RPC_SMCR_SSLKP;
>> > +         } else {
>> > +            smcr = rpc->smcr | RPC_SMCR_SPIE;
>> > +         }
>> > +
>> > +         regmap_write(rpc->regmap, RPC_SMENR, smenr);
>> > +         regmap_write(rpc->regmap, RPC_SMCR, smcr);
>> > +         ret = wait_msg_xfer_end(rpc);
>> > +         if (ret)
>> > +            goto out;
>> > +
>> > +         pos += nbytes;
>> > +         smenr = rpc->smenr & ~RPC_SMENR_CDE &
>> > +                    ~RPC_SMENR_ADE(0xf);
>> > +      }
>> > +   } else if (rx_buf) {
>> > +      while (pos < rpc->xferlen) {
>> > +         u32 nbytes = rpc->xferlen  - pos;
>> > +
>> > +         if (nbytes > 4)
>> > +            nbytes = 4;
>> > +
>> > +         regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
>> > +         regmap_write(rpc->regmap, RPC_SMCR,
>> > +                 rpc->smcr | RPC_SMCR_SPIE);
>>
>>    Hm... our flash chip (Spansion S25FS512S) doesn't get detected; it
> sends
>> JEDEC ID bytes 0..3 repeatedly, unless I copy the SSLKP logic from the
> writing
>> branch above...
> 
> Do you switch the SW1, SW2, SW3, SW13, SW31 and SW10 to on-board QSPI
> mode ?
> Because R-Car D3 Draak board default is booting from HyperFlsah.

So this puts us back to the original discussion -- the driver should
support HF mode as well IMO.

> what follows is my booting log, FYI.
> ------------------------------------------------------------------
> [    1.625053] m25p80 spi5.0: s25fl129p1 (16384 Kbytes)
> [    1.634391] 12 fixed-partitions partitions found on MTD device spi5.0
> [    1.642198] Creating 12 MTD partitions on "spi5.0":
> [    1.647598] 0x000000000000-0x000000040000 : "Bank 1 - Boot parameter"
> [    1.660893] 0x000000040000-0x000000180000 : "Bank 1 - Loader-BL2"
> [    1.671287] 0x000000180000-0x0000001c0000 : "Bank 1 - Certification"
> -----------------------------------------------------------------------
> 
>>
>> > +         ret = wait_msg_xfer_end(rpc);
>> > +         if (ret)
>> > +            goto out;
>> > +
>> > +         regmap_read(rpc->regmap, RPC_SMRDR0, &data);
>> > +         memcpy_fromio(rx_buf + pos, (void *)&data, nbytes);
>> > +         pos += nbytes;
>>
>>    ... and it skips byte 4 unless I copy the code from the end of the
> writing
>> branch, clearing CDE/ADE. But even then the byte 4 reads as 0x03
> instead of 0.
> 
> yup, I think this is some kind of RPC HW limitation,
> in RPC manual I/O mode, it only could read 4 bytes data w/ one command.
> 
> That is, one command + read 4 bytes data + read 4 bytes data + read 4
> bytes data + ...
> will get the incorrect data.
> 
> That's why RPC in manual I/O mode, driver only could do,
> one command + read 4 bytes data; one command + read 4 bytes data and so on.
> 
> But RPC in external address space read mode(here we call it direct
> mapping read mode)
> is ok for one command + read 4 bytes data + read 4 bytes data + ....

I think the U-Boot driver solves those problems, since it works in both
RPC and HF mode on all of Gen3 boards , not just D3 in non-standard SPI
boot configuration. Please take a look.

-- 
Best regards,
Marek Vasut
