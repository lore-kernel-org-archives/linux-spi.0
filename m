From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: mvebu: Add support for SPI controller in Armada
	370/XP
Date: Tue, 05 Feb 2013 14:57:02 +0100
Message-ID: <51110FAE.4070700@free-electrons.com>
References: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1359995888-2385-1-git-send-email-ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Ezequiel,

On 02/04/2013 05:38 PM, Ezequiel Garcia wrote:
> The Armada 370 and Armada XP SoC has an SPI controller.
> This patch adds support for this controller in Armada 370
> and Armada XP SoC common device tree files.
> 
> Cc: Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Cc: Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 28276fe..22340d5 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -145,6 +145,28 @@
>  			clocks = <&gateclk 17>;
>  			status = "disabled";
>  		};
> +
> +		spi0: spi@d0010600 {
> +			compatible = "marvell,orion-spi";
> +			reg = <0xd0010600 0x50>;

Currently the driver only use the 5th first register. All of the other
mvebu platform declare the last register at offset 0x28. The Armada
370 SoC have also the last register at offset 0x28. Only for the
Armada XP SoC there are more registers and we have a the last register
at offset 0x50. Obviously the driver won't use these extra register.

So I think that the best for now is to declare:
			reg = <0xd0010600 0x28>;

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cell-index = <0>;
> +			interrupts = <30>;
> +			clocks = <&coreclk 0>;
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@d0010680 {
> +			compatible = "marvell,orion-spi";
> +			reg = <0xd0010680 0x50>;
and here:
			reg = <0xd0010680 0x28>;

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cell-index = <1>;
> +			interrupts = <92>;
> +			clocks = <&coreclk 0>;
> +			status = "disabled";
> +		};
>  	};
>  };
>  
> 

Once it will be fixed, for this patch you can add my

Acked-by: Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>


Regards,
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
