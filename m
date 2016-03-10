From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCHv3 2/2] bindings: spi: Add clock entries for spi-xilinx
Date: Thu, 10 Mar 2016 13:39:59 +0100
Message-ID: <56E16B1F.3050701@metafoo.de>
References: <1457611865-40120-1-git-send-email-shubhraj@xilinx.com>
 <1457611865-40120-2-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457611865-40120-2-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/10/2016 01:11 PM, Shubhrajyoti Datta wrote:
[...]
> @@ -7,6 +7,9 @@ Required properties:
>  - interrupts		: Property with a value describing the interrupt
>  			  number.
>  - interrupt-parent	: Must be core interrupt controller
> +- clocks: Input clock specifier. Refer to common clock bindings.
> +- clock-names: tuple listing input clock names.
> +	Required elements: "spi_fclk"

Sorry for being pedantic, but the core has two clock input "s_axi_aclk" and
"ext_spi_clk". Which one is "spi_fclk"?

- Lars

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
