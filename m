From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/10] ARM: mx28: Add SPI pinmux into imx28.dtsi
Date: Mon, 6 Aug 2012 10:29:17 +0800
Message-ID: <20120806022915.GB18471@S2101-09.ap.freescale.net>
References: <1344007575-11448-1-git-send-email-marex@denx.de>
	<1344007575-11448-11-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Attila Kinali <attila-HB9FjVmMKa7tRgLqZ5aouw@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1344007575-11448-11-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Aug 03, 2012 at 05:26:15PM +0200, Marek Vasut wrote:
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Attila Kinali <attila-HB9FjVmMKa7tRgLqZ5aouw@public.gmane.org>
> Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
> CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/boot/dts/imx28.dtsi |   39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index badc76a..4a0f12c 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -507,6 +507,45 @@
>  					fsl,voltage = <1>;
>  					fsl,pull-up = <0>;
>  				};
> +
> +				spi0_pins_a: spi0@0 {
> +					reg = <0>;
> +					fsl,pinmux-ids =
> +						<0x2000 0x2010 0x2020 0x2030
> +						0x2040 0x2050 0x2060 0x2070
> +						0x2080 0x2090 0x20a0>;

Please follow the new format, one id per line with a comment afterward.

> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				spi1_pins_a: spi1@0 {
> +					reg = <0>;
> +					fsl,pinmux-ids =
> +						<0x20c0 0x20d0 0x20e0 0x20f0>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				spi2_pins_a: spi2@0 {
> +					reg = <0>;
> +					fsl,pinmux-ids =
> +						<0x2100 0x2110 0x2120
> +						0x2130 0x2140 0x2150>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				spi3_pins_a: spi3@0 {
> +					reg = <0>;
> +					fsl,pinmux-ids =
> +						<0x2180 0x2190 0x21a0 0x21b0>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};

I do not accept patch adding pinctrl settings alone.  Instead, I want
them to be added together with the users (board dts).  That said, we
do not want to enumerate all the possible pinctrl settings but just
the ones being used.

>  			};
>  
>  			digctl@8001c000 {
> -- 
> 1.7.10.4
> 

-- 
Regards,
Shawn


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
