From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCHv3 2/2] bindings: spi: Add clock entries for spi-xilinx
Date: Fri, 11 Mar 2016 05:20:39 +0000
Message-ID: <4EED9C67BE3EF440A606099F8E34C5282652FCBB@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1457611865-40120-1-git-send-email-shubhraj@xilinx.com>
 <1457611865-40120-2-git-send-email-shubhraj@xilinx.com>
 <56E16B1F.3050701@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56E16B1F.3050701-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org]
> Sent: Thursday, March 10, 2016 6:10 PM
> To: Shubhrajyoti Datta; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Soren Brinkmann; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Michal Simek;
> broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Shubhrajyoti Datta
> Subject: Re: [PATCHv3 2/2] bindings: spi: Add clock entries for spi-xilinx
> 
> On 03/10/2016 01:11 PM, Shubhrajyoti Datta wrote:
> [...]
> > @@ -7,6 +7,9 @@ Required properties:
> >  - interrupts		: Property with a value describing the interrupt
> >  			  number.
> >  - interrupt-parent	: Must be core interrupt controller
> > +- clocks: Input clock specifier. Refer to common clock bindings.
> > +- clock-names: tuple listing input clock names.
> > +	Required elements: "spi_fclk"
> 
> Sorry for being pedantic, but the core has two clock input "" and
> "ext_spi_clk". Which one is "spi_fclk"?

However for all my designs I adhere to the recommendation see below both are from the same clock source.
I  named it spi_fclk.

Do you think I should have 2 clocks requests on the same clock.


http://www.xilinx.com/support/documentation/ip_documentation/axi_quad_spi/v2_00_a/ds843_axi_quad_spi.pdf

page 12

15. It is recommended that the AXI4 interface clock and EXT_SPI_CLK clock originate from the same clock source.
> 
> - Lars

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
