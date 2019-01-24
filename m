From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v7 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Thu, 24 Jan 2019 11:16:43 +0300
Message-ID: <7cdecc93-fc7a-3602-25c2-23107dca2a5e@cogentembedded.com>
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-3-git-send-email-masonccyang@mxic.com.tw>
 <7a2bf711-f51e-82b0-b0c0-5d67f2c1d043@cogentembedded.com>
 <OF87800430.BAF731CA-ON4825838C.0006CCEE-4825838C.00092BDE@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF87800430.BAF731CA-ON4825838C.0006CCEE-4825838C.00092BDE@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 24.01.2019 4:40, masonccyang@mxic.com.tw wrote:

>  > > @@ -0,0 +1,46 @@
>  > > +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>  > > +--------------------------------------------------------------------
>  > > +
>  > > +Required properties:
>  > > +- compatible: should be an SoC-specific compatible value, followed by
>  > > +      "renesas,rcar-gen3-rpc" as a fallback, i.e.,
>  > > +      "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc".
>  > > +      "renesas,r8a7795-rpc" (R-Car H3)
>  > > +      "renesas,r8a7796-rpc" (R-Car M3-W)
>  > > +      "renesas,r8a77965-rpc" (R-Car M3-N)
>  > > +      "renesas,r8a77970-rpc" (R-Car V3M)
>  > > +      "renesas,r8a77980-rpc" (R-Car V3H)
>  > > +      "renesas,r8a77990-rpc" (R-Car E3)
>  > > +      "renesas,r8a77995-rpc" (R-Car D3)
>  > > +- reg: should contain three register areas:
>  >
>  >    The driver now handles "dirmap" and "wbuf" resources as optional --
>  > you need to document that.
>  >
> 
> Why ?

    Because the driver treats "dirmap" and "wbuf" as optional resources.

[...]

> best regards,
> Mason

MBR, Sergei
