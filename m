From: masonccyang@mxic.com.tw
Subject: Re: [PATCH v13 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD driver
Date: Tue, 4 Jun 2019 08:52:44 +0800
Message-ID: <OF6FE801F4.46B471FF-ON4825840F.0003D358-4825840F.0004D419@mxic.com.tw>
References: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw> <1558423174-10748-2-git-send-email-masonccyang@mxic.com.tw> <20190603130235.GW4797@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        mark.rutland@arm.com, miquel.raynal@bootlin.com,
        robh+dt@kernel.org, sergei.shtylyov@cogentembedded.com
To: "Lee Jones" <lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190603130235.GW4797@dell>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Jones,

> > +static int rpc_mfd_probe(struct platform_device *pdev)
> 
> Remove the "mfd" from the nomenclature.

okay, will fix.

> 
> > +   struct device_node *flash;
> > +   const struct mfd_cell *cell;
> > +   struct resource *res;
> > +   struct rpc_mfd *rpc;
> > +   void __iomem *base;
> > +
> > +   flash = of_get_next_child(pdev->dev.of_node, NULL);
> > +   if (!flash) {
> > +      dev_warn(&pdev->dev, "no flash node found\n");
> > +      return -ENODEV;
> > +   }
> > +
> > +   if (of_device_is_compatible(flash, "jedec,spi-nor")) {
> > +      cell = &rpc_spi_ctlr;
> > +   } else if (of_device_is_compatible(flash, "cfi-flash")) {
> > +      cell = &rpc_hf_ctlr;
> > +   } else {
> > +      dev_warn(&pdev->dev, "unknown flash type\n");
> > +      return -ENODEV;
> > +   }
> 
> Are there going to be more children coming?

No, just spi-nor or cfi-flash.

The operation mode is decided at booting time by HW pin configuration.
Can't change spi-nor or cfi-flash mode at run-time.

> 
> If not, I'd argue that this is not an MFD.
> 

umm, agreed.

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
