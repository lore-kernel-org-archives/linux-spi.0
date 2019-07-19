From: masonccyang@mxic.com.tw
Subject: Re: [PATCH v14 2/2] dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF
 controller bindings
Date: Fri, 19 Jul 2019 10:38:56 +0800
Message-ID: <OF43DF9AAE.9EB63E41-ON4825843C.000C61B7-4825843C.000E8D45@mxic.com.tw>
References: <1561023046-20886-1-git-send-email-masonccyang@mxic.com.tw> <1561023046-20886-3-git-send-email-masonccyang@mxic.com.tw> <CAMuHMdUPmj0tAhJ18DhQEbYxP7g4MMBMe0U_2eQFQ7mOq4ZFLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: "Boris Brezillon" <bbrezillon@kernel.org>,
        "Mark Brown" <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms@verge.net.au>, juliensu@mxic.com.tw,
        "Lee Jones" <lee.jones@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux-Renesas" <linux-renesas-soc@vger.kernel.org>,
        "linux-spi" <linux-spi@vger.kernel.org>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUPmj0tAhJ18DhQEbYxP7g4MMBMe0U_2eQFQ7mOq4ZFLQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Geert, 
 
Thanks for your review!

Will fix it as 

+Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
+---------------------------------------------------------
+
+Required properties:
+- compatible: should be an SoC-specific compatible value, followed by
+                                "renesas,rcar-gen3-rpc" as a fallback.
+                                supported SoC-specific values are:
+                                "renesas,r8a77980-rpc"          (R-Car 
V3H)
+                                "renesas,r8a77995-rpc"          (R-Car 
D3)
+- reg: should contain three register areas:
+       first for the base address of RPC-IF registers,
+       second for the direct mapping read mode and
+       third for the write buffer area.
+- reg-names: should contain "regs", "dirmap" and "wbuf"
+- clocks: should contain the clock phandle/specifier pair for the module 
clock.
+- clock-names: should contain "rpc"
+- power-domains: should contain the power domain phandle/secifier pair.
+- resets: should contain the reset controller phandle/specifier pair.
+- #address-cells: should be 1
+- #size-cells: should be 0
+
+  flash: should be represented by a subnode of the RPC-IF node, 
+  which "compatible" property contains "jedec,spi-nor", it presents SPI 
is used.
+
+Example:
+
+                rpc: spi@ee200000 {
+                                compatible = "renesas,r8a77995-rpc", 
"renesas,rcar-gen3-rpc";
+                                reg = <0 0xee200000 0 0x200>, <0 
0x08000000 0 0x4000000>,
+                                      <0 0xee208000 0 0x100>;
+                                reg-names = "regs", "dirmap", "wbuf";
+                                clocks = <&cpg CPG_MOD 917>;
+                                clock-names = "rpc";
+                                power-domains = <&sysc 
R8A77995_PD_ALWAYS_ON>;
+                                resets = <&cpg 917>;
+                                #address-cells = <1>;
+                                #size-cells = <0>;
+
+                                flash@0 {
+                                                compatible = 
"jedec,spi-nor";
+                                                reg = <0>;
+                                                spi-max-frequency = 
<40000000>;
+                                                spi-tx-bus-width = <1>;
+                                                spi-rx-bus-width = <1>;
+                                };
+                };

Is it OK ?

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
