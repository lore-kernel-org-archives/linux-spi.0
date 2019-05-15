From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND
 controller
Date: Wed, 15 May 2019 14:08:58 +0200
Message-ID: <20190515140858.77213af9@xps13>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
        <1555320234-15802-3-git-send-email-masonccyang@mxic.com.tw>
        <20190512151820.4f2dd9da@xps13>
        <OF8A566F14.A2F0F576-ON482583FB.002E7E32-482583FB.003068BA@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        geert@linux-m68k.org, juliensu@mxic.com.tw, lee.jones@linaro.org,
        liang.yang@amlogic.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, paul.burton@mips.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF8A566F14.A2F0F576-ON482583FB.002E7E32-482583FB.003068BA@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi masonccyang@mxic.com.tw,

masonccyang@mxic.com.tw wrote on Wed, 15 May 2019 16:48:46 +0800:

> Hi Miquel,
> 
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +//
> > > +// Copyright (C) 2019 Macronix International Co., Ltd.
> > > +//
> > > +// Authors:
> > > +//   Mason Yang <masonccyang@mxic.com.tw>
> > > +//   zhengxunli <zhengxunli@mxic.com.tw>  
> > 
> > This is not a valid name.
> > 
> > Also if he appears here I suppose he should be credited in the
> > module_authors() macro too.  
> 
> I think Li should maintain this NAND driver later, 

This entry is for the authors of the driver.

If he will maintain the driver, then add a new entry in MAINTAINERS.

> > > +}
> > > +
> > > +static const struct nand_controller_ops mxic_nand_controller_ops = {
> > > +   .exec_op = mxic_nand_exec_op,
> > > +};
> > > +
> > > +static int mx25f0a_nand_probe(struct platform_device *pdev)
> > > +{
> > > +   struct mtd_info *mtd;
> > > +   struct mx25f0a_mfd *mfd = dev_get_drvdata(pdev->dev.parent);
> > > +   struct mxic_nand_ctlr *mxic;
> > > +   struct nand_chip *nand_chip;
> > > +   int err;
> > > +
> > > +   mxic = devm_kzalloc(&pdev->dev, sizeof(struct mxic_nand_ctlr),
> > > +             GFP_KERNEL);  
> > 
> > mxic for a NAND controller structure is probably not a name meaningful
> > enough.  
> 
> How about *fmc or *mxic_fmc ?

fmc is fine, even if I personally prefer nfc for NAND flash controller.
Here the 'm' in fmc stands for 'memory' but I am not sure if the
controller can manage something else than NAND flash anyway?


Thanks,
Miquèl
