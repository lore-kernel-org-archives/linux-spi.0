From: masonccyang@mxic.com.tw
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND controller
Date: Thu, 23 May 2019 16:58:02 +0800
Message-ID: <OFADC47344.0F9941B2-ON48258403.002336E3-48258403.003141F0@mxic.com.tw>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw> <1555320234-15802-3-git-send-email-masonccyang@mxic.com.tw>
        <20190512151820.4f2dd9da@xps13> <OF074A1F06.5C1A58BE-ON482583FD.0031CD95-482583FD.003437AD@mxic.com.tw> <20190520142333.390091d5@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        geert@linux-m68k.org, juliensu@mxic.com.tw, lee.jones@linaro.org,
        liang.yang@amlogic.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, paul.burton@mips.com, richard@nod.at,
        robh+dt@kernel.org, stefan@agner.ch, zhengxunli@mxic.com.tw
To: "Miquel Raynal" <miquel.raynal@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190520142333.390091d5@xps13>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Miquel,

> > 
> > > > +
> > > > +static void mxic_nand_select_chip(struct nand_chip *chip, int 
chipnr) 
> > > 
> > > _select_target() is preferred now 
> > 
> > Do you mean I implement mxic_nand_select_target() to control #CS ?
> > 
> > If so, I need to call mxic_nand_select_target( ) to control #CS ON
> > and then #CS OFF in _exec_op() due to nand_select_target()<in 
nand_base,c>
> > is still calling chip->legacy.select_chip ?
> 
> You must forget about the ->select_chip() callback. Now it should be
> handled directly from the controller driver. Please have a look at the
> commit pointed against the marvell_nand.c driver.

I have no Marvell NFC datasheet and have one question.

In marvell_nand.c, there is no xxx_deselect_target() or 
something like that doing #CS OFF.
marvell_nfc_select_target() seems always to make one of chip or die
#CS keep low.

Is it right ?

How to make all #CS keep high for NAND to enter 
low-power standby mode if driver don't use "legacy.select_chip()" ?

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
