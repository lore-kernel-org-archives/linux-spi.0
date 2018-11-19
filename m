From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC
 controller bindings
Date: Mon, 19 Nov 2018 14:49:31 +0100
Message-ID: <629a5d6f-5c13-9b24-1c21-461d09f1aa8a@gmail.com>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: boris.brezillon@bootlin.com, juliensu@mxic.com.tw,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        tpiepho@impinj.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 11/19/2018 11:01 AM, Mason Yang wrote:
> Document the bindings used by the Renesas R-Car D3 RPC controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> new file mode 100644
> index 0000000..8286cc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,33 @@
> +Renesas R-Car D3 RPC controller Device Tree Bindings
> +----------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "renesas,rpc-r8a77995"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area
> +- reg-names: should contain "rpc_regs" and "dirmap"
> +- interrupts: interrupt line connected to the RPC SPI controller

Do you also plan to support the RPC HF mode ? And if so, how would that
look in the bindings ? I'd like to avoid having to redesign the bindings
later to handle both the SPI and HF modes.

The HF is roughly a CFI flash with different bus interface.

btw U-Boot has drivers for both the HF and SPI mode:
http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/mtd/renesas_rpc_hf.c
http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/spi/renesas_rpc_spi.c

> +- clock-names: should contain "clk_rpc"
> +- clocks: should contain 1 entries for the CPG Module 917 clocks
> +
> +Example:
> +
> +	rpc: spi@ee200000 {
> +		compatible = "renesas,rpc-r8a77995";
> +		reg = <0 0xee200000 0 0x8100>, <0 0x08000000 0 0x4000000>;
> +		reg-names = "rpc_regs", "dirmap";
> +		clocks = <&cpg CPG_MOD 917>;
> +		clock-names = "clk_rpc";
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


-- 
Best regards,
Marek Vasut
