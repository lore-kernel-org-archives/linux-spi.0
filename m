From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v3 6/7] Documentation: add the binding file for Quadspi
 driver
Date: Wed, 18 Dec 2013 19:21:12 +0100
Message-ID: <20131218182112.GK8064@book.gsilab.sittig.org>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <1387184330-14448-7-git-send-email-b32955@freescale.com>
 <20131218153029.GF8064@book.gsilab.sittig.org>
 <20131218160355.GA1145@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Huang Shijie <b32955@freescale.com>, dwmw2@infradead.org,
	computersforpeace@gmail.com, angus.clark@st.com,
	lee.jones@linaro.org, marex@denx.de, pekon@ti.com,
	sourav.poddar@ti.com, broonie@linaro.org,
	linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	b44548@freescale.com, b18965@freescale.com, shawn.guo@linaro.org,
	devicetree@vger.kernel.org
To: Huang Shijie <shijie8@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131218160355.GA1145@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 19, 2013 at 00:03 +0800, Huang Shijie wrote:
> 
> On Wed, Dec 18, 2013 at 04:30:29PM +0100, Gerhard Sittig wrote:
> > > +++ b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
> > > [ ... ]
> > > +Example:
> > > +
> > > +qspi0: quadspi@40044000 {
> > > +	compatible = "fsl,vf610-qspi";
> > > +	reg = <0x40044000 0x1000>;
> > > +	interrupts = <0 24 0x04>;
> > > [ ... ]
> > > +};
> > 
> > [ ... ]
> > I'd suggest to use symbolic names for the flags in the last
> > interrupt specifier cell, as you do for clock items.
> I will use the symbolic name if it has.
> But if it not have a symbolic name, i have to keep it as it is now.

To avoid potential confusion:  I meant symbolic names for the
_flags_ of the interrupt specifier (i.e. trigger type and
polarity).  The <dt-bindings/interrupt-controller/irq.h> file has
IRQ_TYPE_LEVEL_HIGH with value 4 for you.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
