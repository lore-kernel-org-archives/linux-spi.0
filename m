From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v7 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Wed, 23 Jan 2019 21:06:55 +0300
Message-ID: <7a2bf711-f51e-82b0-b0c0-5d67f2c1d043@cogentembedded.com>
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-3-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548227352-14910-3-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 01/23/2019 10:09 AM, Mason Yang wrote:

> Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> new file mode 100644
> index 0000000..305bd10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,46 @@
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +--------------------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +		"renesas,rcar-gen3-rpc" as a fallback, i.e.,
> +		"renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc".
> +		"renesas,r8a7795-rpc"	(R-Car H3)
> +		"renesas,r8a7796-rpc"	(R-Car M3-W)
> +		"renesas,r8a77965-rpc"	(R-Car M3-N)
> +		"renesas,r8a77970-rpc"	(R-Car V3M)
> +		"renesas,r8a77980-rpc"	(R-Car V3H)
> +		"renesas,r8a77990-rpc"	(R-Car E3)
> +		"renesas,r8a77995-rpc"	(R-Car D3)
> +- reg: should contain three register areas:

   The driver now handles "dirmap" and "wbuf" resources as optional --
you need to document that.

[...]

MBR, Sergei
