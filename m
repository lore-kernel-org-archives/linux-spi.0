From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 2/3] acpi i2c: Initialize info.type from of_compatible
Date: Tue, 19 Jul 2016 10:07:05 +0300
Message-ID: <20160719070705.GN14693@lahna.fi.intel.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <4b9ea75003d78406307cbb392150fb038b1b72f7.1468409668.git.leonard.crestez@intel.com>
 <CAJZ5v0jz-E0RTBWVzO0Vc_jChUSeSseFeewi1UtsjLudoVP7Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jz-E0RTBWVzO0Vc_jChUSeSseFeewi1UtsjLudoVP7Pw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jul 13, 2016 at 02:20:57PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 13, 2016 at 1:53 PM, Crestez Dan Leonard
> <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > When using devicetree i2c_board_info.type is set to the compatible
> > string with the vendor prefix removed. For I2C devices described via
> > ACPI the i2c_board_info.type string is set to the ACPI device name. When
> > using ACPI and DT ids this string ends up something like "PRP0001:00".
> >
> > If the of_compatible property is present try to use that instead. This
> > makes it easier to instantiate i2c drivers through ACPI with DT ids.
> >
> > Signed-off-by: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Looks good to me, but Mika needs to have a look at it too.

Looks good to me,

Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
