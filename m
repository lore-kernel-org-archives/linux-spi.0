From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v13 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Tue, 18 Jun 2019 14:01:40 +0200
Message-ID: <2671d488-82a1-8720-d9a1-03554d955a38@gmail.com>
References: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw>
 <1558423174-10748-4-git-send-email-masonccyang@mxic.com.tw>
 <0e2994d6-6efc-9f36-f681-609199f20b9f@cogentembedded.com>
 <20190603130428.GX4797@dell>
 <02addf64-9f6e-ccc1-2f94-8983456e3ebc@cogentembedded.com>
 <OFDA7648A0.F1733EA5-ON48258411.002946DF-48258411.002A2F0D@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, robh+dt@kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: masonccyang@mxic.com.tw, Lee Jones <lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFDA7648A0.F1733EA5-ON48258411.002946DF-48258411.002A2F0D@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 6/6/19 9:40 AM, masonccyang@mxic.com.tw wrote:
[...]

> RPC-IF works either in SPI or HyperFlash is decided by external hardware 
> pins 
> configuration and it can NOT switch it's operation mode in the run time. 
> This is not like my understanding of MFD.

Which external hardware pins decide the RPC configuration ?

It seems to me like PHYCNT register, PHYMEM bitfield, selects what
device is connected, and then a couple of other bits control the
communication, but I see nothing which would be tied to any external
configuration pins.

[...]

-- 
Best regards,
Marek Vasut
