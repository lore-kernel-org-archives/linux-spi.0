From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 2/2] bindings: spi: Add clock entries for spi-xilinx
Date: Thu, 10 Mar 2016 22:21:37 -0800
Message-ID: <20160311062137.GN3173@xsjsorenbubuntu>
References: <1457611865-40120-1-git-send-email-shubhraj@xilinx.com>
 <1457611865-40120-2-git-send-email-shubhraj@xilinx.com>
 <56E16B1F.3050701@metafoo.de>
 <4EED9C67BE3EF440A606099F8E34C5282652FCBB@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4EED9C67BE3EF440A606099F8E34C5282652FCBB-4lKfpRxZ5enZMOc0yg5rMog+Gb3gawCHQz34XiSyOiE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 2016-03-10 at 21:20:39 -0800, Shubhrajyoti Datta wrote:
>=20
>=20
> > -----Original Message-----
> > From: Lars-Peter Clausen [mailto:lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org]
> > Sent: Thursday, March 10, 2016 6:10 PM
> > To: Shubhrajyoti Datta; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: Soren Brinkmann; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Michal Simek;
> > broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Shubhrajyoti Datta
> > Subject: Re: [PATCHv3 2/2] bindings: spi: Add clock entries for spi=
-xilinx
> >=20
> > On 03/10/2016 01:11 PM, Shubhrajyoti Datta wrote:
> > [...]
> > > @@ -7,6 +7,9 @@ Required properties:
> > >  - interrupts		: Property with a value describing the interrupt
> > >  			  number.
> > >  - interrupt-parent	: Must be core interrupt controller
> > > +- clocks: Input clock specifier. Refer to common clock bindings.
> > > +- clock-names: tuple listing input clock names.
> > > +	Required elements: "spi_fclk"
> >=20
> > Sorry for being pedantic, but the core has two clock input "" and
> > "ext_spi_clk". Which one is "spi_fclk"?
>=20
> However for all my designs I adhere to the recommendation see below b=
oth are from the same clock source.
> I  named it spi_fclk.
>=20
> Do you think I should have 2 clocks requests on the same clock.
>=20
>=20
> http://www.xilinx.com/support/documentation/ip_documentation/axi_quad=
_spi/v2_00_a/ds843_axi_quad_spi.pdf
>=20
> page 12
>=20
> 15. It is recommended that the AXI4 interface clock and EXT_SPI_CLK c=
lock originate from the same clock source.

If they can be separate they should both be modeled in the CCF. There i=
s
no issue of them coming from the same source.
Also, the name should map to the name from the spec, as Lars pointed ou=
t
already. You should not invent new names for clocks that are clearly
defined in the data sheet.

	S=C3=B6ren
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
