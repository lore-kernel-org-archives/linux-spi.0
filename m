From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v9 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Fri, 29 Mar 2019 13:49:58 +0300
Message-ID: <5e841334-7cd7-3b5f-77d2-bb39bf8ec8b7@cogentembedded.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-4-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, lee.jones@linaro.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553847606-18122-4-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 03/29/2019 11:20 AM, Mason Yang wrote:

> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> new file mode 100644
> index 0000000..577986b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> @@ -0,0 +1,57 @@
> +Renesas R-Car Gen3 RPC-IF MFD controller Device Tree Bindings
> +---------------------------------------------------------------------

   Too many dashes. :-)

> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +		"renesas,rcar-gen3-rpc" as a fallback.
> +		supported SoC-specific values are:
> +		"renesas,r8a77995-rpc"	(R-Car D3)
> +- reg: should contain three register areas:
> +	first for the base address of rpc-if registers,
> +	second for the direct mapping read mode and
> +	third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clocks: should contain 1 entries for the module's clock
> +- clock-names: should contain "rpc"

   What about the "power-domains" and "resets" props?

> +- #address-cells: should be 1
> +- #size-cells: should be 0

   Why? You don't have the "reg" props in the sub-devices...

> +
> +Required nodes:
> +	spi:
> +	Node for configuring the SPI controller driver.
> +	Required properties:
> +		compatible = "renesas,rcar-rpc-spi";

   Sigh... you were supposed to only place the flash device sub-nodes
under the "main" device node, we don't add the virtual devices to DT,
there's no matching sub-device in the hardware. You don't have to
describe these sub-devices in DT, you can register the simple platform
devices. 

> +
> +	hf:
> +	Node for configuring the hyperflash controller driver.
> +	Required properties:
> +		compatible = "renesas,rcar-rpc-hf";
> +
> +Example:
> +
> +	rpc_mfd: rpc-mfd@ee200000 {

   Just "rpc: rpc-if@ee200000, please.

[...]

MBR, Sergei
