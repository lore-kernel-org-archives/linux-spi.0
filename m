From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v11 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
Date: Mon, 22 Apr 2019 14:45:56 +0300
Message-ID: <2714b406-1038-c3e2-be6b-326c073497ea@cogentembedded.com>
References: <1555903925-15292-1-git-send-email-masonccyang@mxic.com.tw>
 <1555903925-15292-4-git-send-email-masonccyang@mxic.com.tw>
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
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555903925-15292-4-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 04/22/2019 06:32 AM, Mason Yang wrote:

> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> new file mode 100644
> index 0000000..ee3bad8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> @@ -0,0 +1,39 @@
> +Renesas R-Car Gen3 RPC-IF MFD controller Device Tree Bindings
> +-------------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +		"renesas,rcar-gen3-rpc" as a fallback.
> +		supported SoC-specific values are:
> +		"renesas,r8a77995-rpc"	(R-Car D3)
> +- reg: should contain three register areas:
> +	first for the base address of rpc-if registers,

   RPC-IF.

> +	second for the direct mapping read mode and
> +	third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clocks: should contain 1 entries for the module's clock
> +- clock-names: should contain "rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +
> +Example:
> +
> +	rpc: rpc-if@ee200000 {
> +		compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
> +		reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>;
> +		reg-names = "regs", "dirmap";

  You forgot to add back the "wbuf" entrees above.

> +		clocks = <&cpg CPG_MOD 917>;
> +		clock-names = "rpc";
> +		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +		resets = <&cpg 917>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		flash@0 {
> +			compatible = "jedec,spi-nor";
> +			reg = <0>;
> +			spi-max-frequency = <40000000>;
> +			spi-tx-bus-width = <1>;
> +			spi-rx-bus-width = <1>;
> +		};
> +	};
> 

MBR, Sergei
