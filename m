From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Add Macronix MX25F0A NAND
 controller
Date: Tue, 18 Jun 2019 09:29:01 +0200
Message-ID: <20190618092901.3bdd9f61@collabora.com>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
        <1555320234-15802-3-git-send-email-masonccyang@mxic.com.tw>
        <20190512151820.4f2dd9da@xps13>
        <OF074A1F06.5C1A58BE-ON482583FD.0031CD95-482583FD.003437AD@mxic.com.tw>
        <20190520142333.390091d5@xps13>
        <OFADC47344.0F9941B2-ON48258403.002336E3-48258403.003141F0@mxic.com.tw>
        <20190527144250.71908bd9@xps13>
        <OFE923A8E5.50375C30-ON48258409.0009AE1B-48258409.00119767@mxic.com.tw>
        <20190617143510.4ded5728@xps13>
        <OF1C1397B4.241DC339-ON4825841D.000482A2-4825841D.0007B67E@mxic.com.tw>
        <20190618081436.5d488320@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>, bbrezillon@kernel.org,
        broonie@kernel.org, christophe.kerello@st.com,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        dwmw2@infradead.org, geert@linux-m68k.org, juliensu@mxic.com.tw,
        lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marcel.ziswiler@toradex.com,
        marek.vasut@gmail.com, mark.rutland@arm.com, paul.burton@mips.com,
        richard@nod.at, robh+dt@kernel.org, stefan@agner.ch,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190618081436.5d488320@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 18 Jun 2019 08:14:36 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> > > > > > 
> > > > > > How to make all #CS keep high for NAND to enter 
> > > > > > low-power standby mode if driver don't use "legacy.select_chip()"     
> > ?   
> > > > > 
> > > > > See commit 02b4a52604a4 ("mtd: rawnand: Make ->select_chip()     
> > optional  
> > > > > when ->exec_op() is implemented") which states:
> > > > > 
> > > > >         "When [->select_chip() is] not implemented, the core is     
> > assuming  
> > > > >    the CS line is automatically asserted/deasserted by the driver     
> > > > >    ->exec_op() implementation."     
> > > > > 
> > > > > Of course, the above is right only when the controller driver     
> > supports  
> > > > > the ->exec_op() interface.     
> > > > 
> > > > Currently, it seems that we will get the incorrect data and error
> > > > operation due to CS in error toggling if CS line is controlled in     
> > > > ->exec_op().     

Oh, and please provide the modifications you added on top of this patch.
Right now we're speculating on what you've done which is definitely not
an efficient way to debug this sort of issues.
