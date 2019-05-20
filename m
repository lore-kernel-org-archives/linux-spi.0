From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND
 controller
Date: Mon, 20 May 2019 14:23:33 +0200
Message-ID: <20190520142333.390091d5@xps13>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
        <1555320234-15802-3-git-send-email-masonccyang@mxic.com.tw>
        <20190512151820.4f2dd9da@xps13>
        <OF074A1F06.5C1A58BE-ON482583FD.0031CD95-482583FD.003437AD@mxic.com.tw>
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
In-Reply-To: <OF074A1F06.5C1A58BE-ON482583FD.0031CD95-482583FD.003437AD@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

masonccyang@mxic.com.tw wrote on Fri, 17 May 2019 17:30:21 +0800:

> Hi Miquel,
> 
> > > +
> > > +static void mxic_nand_select_chip(struct nand_chip *chip, int chipnr)  
> > 
> > _select_target() is preferred now  
> 
> Do you mean I implement mxic_nand_select_target() to control #CS ?
> 
> If so, I need to call mxic_nand_select_target( ) to control #CS ON
> and then #CS OFF in _exec_op() due to nand_select_target()<in nand_base,c>
> is still calling chip->legacy.select_chip ?

You must forget about the ->select_chip() callback. Now it should be
handled directly from the controller driver. Please have a look at the
commit pointed against the marvell_nand.c driver.

[...]

> > > +   if (!mxic)
> > > +      return -ENOMEM;
> > > +
> > > +   nand_chip = &mxic->nand;
> > > +   mtd = nand_to_mtd(nand_chip);
> > > +   mtd->dev.parent = pdev->dev.parent;
> > > +   nand_chip->ecc.priv = NULL;
> > > +   nand_set_flash_node(nand_chip, pdev->dev.parent->of_node);
> > > +   nand_chip->priv = mxic;
> > > +
> > > +   mxic->mfd = mfd;
> > > +
> > > +   nand_chip->legacy.select_chip = mxic_nand_select_chip;  
> > 
> > Please don't implement legacy interfaces. You can check in
> > marvell_nand.c how this is handled now:
> > 
> > b25251414f6e mtd: rawnand: marvell: Stop implementing ->select_chip()
> >   
> 
> Does it mean chip->legacy.select_chip() will phase-out ?

Yes it will.

Thanks,
Miquèl
