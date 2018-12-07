From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
Date: Fri, 7 Dec 2018 19:03:10 +0300
Message-ID: <b89fb13a-4fe2-d3ca-7e12-7ac6b11455f6@cogentembedded.com>
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-3-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544181199-3373-3-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 12/07/2018 02:13 PM, Mason Yang wrote:

> Document the bindings used by the Renesas R-Car Gen3 RPC controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> new file mode 100644
> index 0000000..a191f70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,38 @@
> +Renesas R-Car Gen3 RPC controller Device Tree Bindings
> +------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "renesas,r8a77995-rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area
> +- reg-names: should contain "rpc_regs" and "dirmap"

   Please drop this "rpc_" thing, I think "regs" should be enough.

> +- interrupts: interrupt line connected to the RPC controller
> +- clock-names: should contain "clk_rpc"

   Please drop this "clk_" thing. BTW, what's with the RPCD2 clock?

> +- clocks: should contain 1 entries for the module's clock
> +- rpc-mode: should contain "rpc-spi-flash" for rpc spi mode or
> +			   "rpc-hyperflash" for rpc hyerflash mode.

   I think the prop should be called "renesas,rpc-mode" and the values should be
just "spi" and "hyperflash". 

[...]

MBR, Sergei
