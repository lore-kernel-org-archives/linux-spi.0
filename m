From: masonccyang@mxic.com.tw
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND controller
Date: Wed, 15 May 2019 17:18:35 +0800
Message-ID: <OFBFE3CB74.F4E01135-ON482583FB.00313C7E-482583FB.003323B4@mxic.com.tw>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw> <1555320234-15802-3-git-send-email-masonccyang@mxic.com.tw> <20190512151820.4f2dd9da@xps13> <OF8A566F14.A2F0F576-ON482583FB.002E7E32-482583FB.003068B1@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        geert@linux-m68k.org, juliensu@mxic.com.tw, lee.jones@linaro.org,
        liang.yang@amlogic.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, "Miquel Raynal" <miquel.raynal@bootlin.com>,
        paul.burton@mips.com, richard@nod.at, robh+dt@kernel.org,
        stefan@agner.ch, zhengxunli@mxic.com.tw
To: "Miquel Raynal" <miquel.raynal@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF8A566F14.A2F0F576-ON482583FB.002E7E32-482583FB.003068B1@LocalDomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Miquel,

Sorry, previous email missed this mxic_nand_data_xfer() reply.

This Flash Memory Controller implemented the Buffer read-write data 
transfer 
for SPI mode and raw NAND mode.

That is each time driver write to the transmit of the TXD port and the 
data 
is shifted out, new data is received in RXD port. 
By transmitting the entire buffer without reading any data, driver are 
losing
the received data.

Actually the mxic_nand_data_xfer() is a copy of mxic_spi_data_xfer().

https://github.com/torvalds/linux/blame/master/drivers/spi/spi-mxic.c 

therefore, I plan to patch this part to MFD as a common code for 
both raw NAND and SPI.

i.e,. 
In driver/mfd/mxic-mfd.c, we have mxic_mfd_data_xfer() and 

here call mxic_mfd_data_xfer() for raw NAND data read-write.


> > > +static int mxic_nand_data_xfer(struct mxic_nand_ctlr *mxic, const 
void *txbuf,
> > > +                void *rxbuf, unsigned int len)
> > > +{
> > 
> > There is not so much code shared, why not separating this function for
> > rx and tx cases?
> > 
> > > +   unsigned int pos = 0;
> > > +
> > > +   while (pos < len) {
> > > +      unsigned int nbytes = len - pos;
> > > +      u32 data = 0xffffffff;
> > > +      u32 sts;
> > > +      int ret;
> > > +
> > > +      if (nbytes > 4)
> > > +         nbytes = 4;
> > > +
> > > +      if (txbuf)
> > > +         memcpy(&data, txbuf + pos, nbytes);
> > > +
> > > +      ret = readl_poll_timeout(mxic->mfd->regs + INT_STS, sts,
> > > +                sts & INT_TX_EMPTY, 0, USEC_PER_SEC);
> > 
> > Using USEC_PER_SEC for a delay is weird
> > 
> > > +      if (ret)
> > > +         return ret;
> > > +
> > > +      writel(data, mxic->mfd->regs + TXD(nbytes % 4));
> > > +
> > > +      if (rxbuf) {
> > > +         ret = readl_poll_timeout(mxic->mfd->regs + INT_STS, sts,
> > > +                   sts & INT_TX_EMPTY, 0,
> > > +                   USEC_PER_SEC);
> > > +         if (ret)
> > > +            return ret;
> > > +
> > > +         ret = readl_poll_timeout(mxic->mfd->regs + INT_STS, sts,
> > > +                   sts & INT_RX_NOT_EMPTY, 0,
> > > +                   USEC_PER_SEC);
> > > +         if (ret)
> > > +            return ret;
> > > +
> > > +         data = readl(mxic->mfd->regs + RXD);
> > > +         data >>= (8 * (4 - nbytes));
> > 
> > What is this? Are you trying to handle some endianness issue?
> 
> yes,
> 
> > 
> > > +         memcpy(rxbuf + pos, &data, nbytes);
> > > +         WARN_ON(readl(mxic->mfd->regs + INT_STS) &
> > > +            INT_RX_NOT_EMPTY);
> > > +      } else {
> > > +         readl(mxic->mfd->regs + RXD);
> > > +      }
> > > +      WARN_ON(readl(mxic->mfd->regs + INT_STS) & INT_RX_NOT_EMPTY);
> > > +
> > > +      pos += nbytes;
> > > +   }
> > > +
> > > +   return 0;
> > > +}

thanks for your review.

best regards,
Mason

--

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================
