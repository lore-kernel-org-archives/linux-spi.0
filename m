From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
Date: Wed, 12 Dec 2018 20:47:54 +0300
Message-ID: <b7082295-51b6-110f-d29b-734c90861f8a@cogentembedded.com>
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
> +- interrupts: interrupt line connected to the RPC controller

   Required prop but it's missing in your example below...

> +- clock-names: should contain "clk_rpc"
> +- clocks: should contain 1 entries for the module's clock
> +- rpc-mode: should contain "rpc-spi-flash" for rpc spi mode or
> +			   "rpc-hyperflash" for rpc hyerflash mode.
> +
> +Example:
> +
> +	rpc: rpc@ee200000 {
> +		compatible = "renesas,r8a77995-rpc";
> +		reg = <0 0xee200000 0 0x8100>, <0 0x08000000 0 0x4000000>;
> +		reg-names = "rpc_regs", "dirmap";
> +		clocks = <&cpg CPG_MOD 917>;
> +		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +		resets = <&cpg 917>;
> +		clock-names = "clk_rpc";
> +		rpc-mode = "rpc-spi-flash";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
[...]

MBR, Sergei
