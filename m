From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND
 controller
Date: Mon, 27 May 2019 14:42:50 +0200
Message-ID: <20190527144250.71908bd9@xps13>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
        <1555320234-15802-3-git-send-email-masonccyang@mxic.com.tw>
        <20190512151820.4f2dd9da@xps13>
        <OF074A1F06.5C1A58BE-ON482583FD.0031CD95-482583FD.003437AD@mxic.com.tw>
        <20190520142333.390091d5@xps13>
        <OFADC47344.0F9941B2-ON48258403.002336E3-48258403.003141F0@mxic.com.tw>
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
In-Reply-To: <OFADC47344.0F9941B2-ON48258403.002336E3-48258403.003141F0@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

masonccyang@mxic.com.tw wrote on Thu, 23 May 2019 16:58:02 +0800:

> Hi Miquel,
> 
> > >   
> > > > > +
> > > > > +static void mxic_nand_select_chip(struct nand_chip *chip, int   
> chipnr) 
> > > > 
> > > > _select_target() is preferred now   
> > > 
> > > Do you mean I implement mxic_nand_select_target() to control #CS ?
> > > 
> > > If so, I need to call mxic_nand_select_target( ) to control #CS ON
> > > and then #CS OFF in _exec_op() due to nand_select_target()<in   
> nand_base,c>  
> > > is still calling chip->legacy.select_chip ?  
> > 
> > You must forget about the ->select_chip() callback. Now it should be
> > handled directly from the controller driver. Please have a look at the
> > commit pointed against the marvell_nand.c driver.  
> 
> I have no Marvell NFC datasheet and have one question.
> 
> In marvell_nand.c, there is no xxx_deselect_target() or 
> something like that doing #CS OFF.
> marvell_nfc_select_target() seems always to make one of chip or die
> #CS keep low.
> 
> Is it right ?

Yes, AFAIR there is no "de-assert" mechanism in this controller.

> 
> How to make all #CS keep high for NAND to enter 
> low-power standby mode if driver don't use "legacy.select_chip()" ?

See commit 02b4a52604a4 ("mtd: rawnand: Make ->select_chip() optional
when ->exec_op() is implemented") which states:

        "When [->select_chip() is] not implemented, the core is assuming
	the CS line is automatically asserted/deasserted by the driver
	->exec_op() implementation."

Of course, the above is right only when the controller driver supports
the ->exec_op() interface. 

So if you think it is not too time consuming and worth the trouble to
assert/deassert the CS at each operation, you may do it in your driver.


Thanks,
Miquèl
