From: masonccyang@mxic.com.tw
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND controller
Date: Mon, 24 Jun 2019 17:05:16 +0800
Message-ID: <OFFCBB8981.B840C87C-ON48258423.00311FA8-48258423.0031EBDD@mxic.com.tw>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw> <1555320234-15802-3-git-send-email-masonccyang@mxic.com.tw>
        <20190512151820.4f2dd9da@xps13> <OF074A1F06.5C1A58BE-ON482583FD.0031CD95-482583FD.003437AD@mxic.com.tw>
        <20190520142333.390091d5@xps13> <OFADC47344.0F9941B2-ON48258403.002336E3-48258403.003141F0@mxic.com.tw>
        <20190527144250.71908bd9@xps13> <OFE923A8E5.50375C30-ON48258409.0009AE1B-48258409.00119767@mxic.com.tw>
        <20190617143510.4ded5728@xps13> <OF1C1397B4.241DC339-ON4825841D.000482A2-4825841D.0007B67E@mxic.com.tw>
        <20190618081436.5d488320@collabora.com> <20190618092901.3bdd9f61@collabora.com>
        <OF5EAF94EB.AE31CF59-ON4825841E.002A2C38-4825841E.002C60BF@mxic.com.tw> <20190619100904.6b759377@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: bbrezillon@kernel.org,
        "Boris Brezillon" <boris.brezillon@collabora.com>,
        broonie@kernel.org, christophe.kerello@st.com,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        dwmw2@infradead.org, geert@linux-m68k.org, juliensu@mxic.com.tw,
        lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marcel.ziswiler@toradex.com,
        marek.vasut@gmail.com, mark.rutland@arm.com, paul.burton@mips.com,
        richard@nod.at, robh+dt@kernel.org, stefan@agner.ch,
        zhengxunli@mxic.com.tw
To: "Miquel Raynal" <miquel.raynal@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190619100904.6b759377@xps13>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Miquel, 


> > > > > > > > > How to make all #CS keep high for NAND to enter 
> > > > > > > > > low-power standby mode if driver don't use 
> > "legacy.select_chip()" 
> > > > > ? 
> > > > > > > > 
> > > > > > > > See commit 02b4a52604a4 ("mtd: rawnand: Make 
->select_chip() 
> > > > > optional 
> > > > > > > > when ->exec_op() is implemented") which states:
> > > > > > > > 
> > > > > > > >         "When [->select_chip() is] not implemented, the 
core 
> > is 
> > > > > assuming 
> > > > > > > >    the CS line is automatically asserted/deasserted by the 
 
> > driver 
> > > > > > > >    ->exec_op() implementation." 
> > > > > > > > 
> > > > > > > > Of course, the above is right only when the controller 
driver 
> > 
> > > > > supports 
> > > > > > > > the ->exec_op() interface. 
> > > > > > > 
> > > > > > > Currently, it seems that we will get the incorrect data and  

> > error
> > > > > > > operation due to CS in error toggling if CS line is 
controlled 
> > in 
> > > > > > > ->exec_op(). 
> > > 
> > > Oh, and please provide the modifications you added on top of this 
patch.
> > > Right now we're speculating on what you've done which is definitely 
not
> > > an efficient way to debug this sort of issues. 
> > 
> 
> We really need to see the datasheet of the NAND chip which has a
> problem and how this LPM mode is advertized to understand what the
> chip expects and eventually how to work-around it.
> 
> > The patch is to add in beginning of ->exec_op() to control CS# low and 

> > before return from ->exec_op() to control CS# High.
> > i.e,.
> > static in mxic_nand_exec_op( )
> > {
> >  cs_to_low();
> > 
> > 
> > 
> >  cs_to_high();
> >  return;
> > }
> > 
> > But for nand_onfi_detect(), 
> > it calls nand_read_param_page_op() and then nand_read_data_op().
> > mxic_nand_exec_op() be called twice for nand_onfi_detect()
> 
> Yes, this is expected and usually chips don't care.

As I replied to Boris's email previously.
I think I have fixed the problem and the root cause is the our NFC's TX 
FIFO 
counter do a unnecessary reset in CS control function.
currently, doing CS# control in ->exec_op() is OK to me.

In addition, by Jones's comments about MFD, 
I will re-submit this raw NAND ctlr driver instead of MFD and raw-nand. 
----------------------------------------------------------------------->
MFD is for registering child devices of chips which offer 
genuine cross-subsystem functionality. 

It is not designed for mode selecting, or as a place to shove shared code 
just because a better location doesn't appear to exist. 
------------------------------------------------------------------------<

thanks & best regards,
Mason






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
