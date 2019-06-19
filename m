From: masonccyang@mxic.com.tw
Subject: Re: [PATCH v13 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF
 controller bindings
Date: Wed, 19 Jun 2019 15:36:20 +0800
Message-ID: <OFE8CD77A1.CDBE040B-ON4825841E.00288DA8-4825841E.0029C76F@mxic.com.tw>
References: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw> <1558423174-10748-4-git-send-email-masonccyang@mxic.com.tw> <0e2994d6-6efc-9f36-f681-609199f20b9f@cogentembedded.com> <20190603130428.GX4797@dell> <02addf64-9f6e-ccc1-2f94-8983456e3ebc@cogentembedded.com> <OFDA7648A0.F1733EA5-ON48258411.002946DF-48258411.002A2F0D@mxic.com.tw> <2671d488-82a1-8720-d9a1-03554d955a38@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms@verge.net.au>, juliensu@mxic.com.tw,
        "Lee Jones" <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        mark.rutland@arm.com, miquel.raynal@bootlin.com,
        robh+dt@kernel.org,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
To: "Marek Vasut" <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2671d488-82a1-8720-d9a1-03554d955a38@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Marek, 

> Subject
> 
> Re: [PATCH v13 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF 

> controller bindings
> 
> On 6/6/19 9:40 AM, masonccyang@mxic.com.tw wrote:
> [...]
> 
> > RPC-IF works either in SPI or HyperFlash is decided by external 
hardware 
> > pins 
> > configuration and it can NOT switch it's operation mode in the run 
time. 
> > This is not like my understanding of MFD.
> 
> Which external hardware pins decide the RPC configuration ?
> 
> It seems to me like PHYCNT register, PHYMEM bitfield, selects what
> device is connected, and then a couple of other bits control the
> communication, but I see nothing which would be tied to any external
> configuration pins.
> 

You may refer to R-Car D3 Draak Eva. board hardware manual 
and start-up guide, i.e., 
Table 2.12 Pin Multiplexing of R-Car D3 Mode setting pins and
set by hardware switch 1, 2, 3, 13, 31 and 10 to configure
booting from SPI mode or HyperFlash mode.

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
