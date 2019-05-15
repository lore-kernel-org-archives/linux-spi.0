From: masonccyang@mxic.com.tw
Subject: Re: [PATCH v3 4/4] dt-bindings: mfd: Document Macronix MX25F0A controller
 bindings
Date: Wed, 15 May 2019 15:36:29 +0800
Message-ID: <OF0FD6EB50.C92AD6D4-ON482583FB.00285AB8-482583FB.0029CAB7@mxic.com.tw>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw> <1555320234-15802-5-git-send-email-masonccyang@mxic.com.tw> <20190512152328.49576a0f@xps13>
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
In-Reply-To: <20190512152328.49576a0f@xps13>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Miquel,


> > +Macronix MX25F0A MultiFunction Device Tree Bindings
> > +----------------------------------------------------
> > +
> > +MX25F0A is a MultiFunction Device with SPI and raw NAND, which
> > +supports either spi host controller or raw nand controller.
> 
> Acronyms in plain English should be in upper case.

okay, will fix.

> > +Example:
> > +
> > +   mxic: mx25f0a@43c30000 {
> > +      compatible = "mxic,mx25f0a";
> > +      reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
> > +      reg-names = "regs", "dirmap";
> > +
> > +      /* spi */
> > +      clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
> > +      clock-names = "send_clk", "send_dly_clk", "ps_clk";
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      flash@0 {
> > +         compatible = "jedec,spi-nor";
> > +         reg = <0>;
> > +         spi-max-frequency = <25000000>;
> > +         spi-tx-bus-width = <4>;
> > +         spi-rx-bus-width = <4>;
> > +      };
> > +
> > +      /* nand */
> > +      nand-ecc-mode = "soft";
> > +      nand-ecc-algo = "bch";
> > +      nand-ecc-step-size = <512>;
> > +      nand-ecc-strength = <8>;
> 
> Any reason to enforce 512B/8b correction? Why not letting the core
> choose for you depending on the NAND chip's requirements?
> 

I thought here is just a raw NAND DTS example. 
Will remove it.

> 
> Anyway, I think you can have only one or the other (NAND or SPI), not
> both, and you probably should have a compatible or a property to tell
> the kernel which one you are using, right?
> 

yes, you are right.

New DTS is bellow.
-------------------------------------------------------------------------->

Macronix Flash Memory Controller Device Tree Bindings
-----------------------------------------------------

Macronix Flash Memory Controller supports serial and raw Flash, including
NOR and NAND Flash for high throughput and low pin count applications.
It's a MultiFunction Device which supports either SPI host controller or
raw NAND controller.

Required properties:
- compatible: should be "mxic,mfd"
- reg: should contain 2 entries, one for the registers and one for the 
direct
       mapping area in SPI mode.
- reg-names: should contain "regs" and "dirmap"
- interrupts: interrupt line connected to this controller
- SPI:
        - #address-cells: should be 1
        - #size-cells: should be 0
        - clock-names: should contain "ps_clk", "send_clk" and
                       "send_dly_clk"
        - clocks: should contain 3 entries for the "ps_clk", "send_clk"
                  and "send_dly_clk" clocks
- Raw NAND:
        - nand-ecc-mode = "soft";
        - nand-ecc-algo = "bch";

Example:
- SPI mode:

        mxic: mxic-mfd@43c30000 {
                compatible = "mxic,mfd";
                reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
                reg-names = "regs", "dirmap";
                clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
                clock-names = "send_clk", "send_dly_clk", "ps_clk";
                #address-cells = <1>;
                #size-cells = <0>;

                flash@0 {
                        compatible = "jedec,spi-nor";
                        reg = <0>;
                        spi-max-frequency = <25000000>;
                        spi-tx-bus-width = <4>;
                        spi-rx-bus-width = <4>;
                };
        };
 
- Raw NAND mode:

        mxic: mxic-mfd@43c30000 {
                compatible = "mxic,mfd";
                reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
                reg-names = "regs", "dirmap";

                nand-ecc-mode = "soft";
                nand-ecc-algo = "bch";
        };  

---------------------------------------------------------------------< 

thanks for your review.

best regards,
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
