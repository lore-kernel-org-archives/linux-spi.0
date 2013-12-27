From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 6/6] [RFC] arm: shmobile: genmai reference: Add RSPI nodes
Date: Fri, 27 Dec 2013 17:20:20 +0100
Message-ID: <2198668.ESbmzZvna4@avalon>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org> <1387886210-3634-7-git-send-email-geert+renesas@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1387886210-3634-7-git-send-email-geert+renesas@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

Thank you for the patch.

On Tuesday 24 December 2013 12:56:50 Geert Uytterhoeven wrote:
> Add pinctrl and SPI devices for RSPI on Genmai.
> 
> On this board, only rspi4 is in use. It's bus contains a single device
> (a wm8978 audio codec), for which no bindings are defined yet.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> Cc: devicetree@vger.kernel.org
> ---
>  arch/arm/boot/dts/r7s72100-genmai-reference.dts |   18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> b/arch/arm/boot/dts/r7s72100-genmai-reference.dts index
> 114510f8bf09..6d99630627e4 100644
> --- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> +++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> @@ -43,7 +43,7 @@
>  };
> 
>  &pfc {
> -	pinctrl-0 = <&scif2_pins &ethernet_pins>;
> +	pinctrl-0 = <&scif2_pins &ethernet_pins &rspi4_pins>;

You should add pinctrl-0 and pinctrl-names properties to the spi4 node 
instead. Device nodes should reference their pinctrl configuration directly, 
scif2 and ethernet are exceptions as DT bindings for those devices are not in 
mainline yet.

>  	pinctrl-names = "default";
> 
>  	scif2_pins: serial2 {
> @@ -73,6 +73,12 @@
>  				 "ethernet_int_p1_15";
>  		renesas,function = "ethernet";
>  	};
> +
> +	rspi4_pins: spi4 {
> +		renesas,groups = "rspi4_rspck_p4_0", "rspi4_ssl0_p4_1",
> +				 "rspi4_mosi_p4_2", "rspi4_miso_p4_3";
> +		renesas,function = "rspi4";
> +	};

This node is at the right place and doesn't need to be moved.

>  };
> 
>  &i2c2 {
> @@ -85,3 +91,13 @@
>  		pagesize = <64>;
>  	};
>  };
> +
> +&spi4 {
> +	status = "okay";
> +
> +	codec: wm8978@0 {
> +		compatible = "wlf,wm8978";
> +		reg = <0>;
> +		spi-max-frequency = <5000000>;
> +	};
> +};
-- 
Regards,

Laurent Pinchart

