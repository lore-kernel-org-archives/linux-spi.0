From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Fri, 10 Jan 2020 21:31:19 +0200
Message-ID: <20200110193119.GI32742@smile.fi.intel.com>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chenxiang66-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org,
        linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, fengsheng5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        wanghuiqiang <wanghuiqiang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, liusimin4-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6db83881-927c-d11c-9c77-23a45892ddab-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jan 10, 2020 at 02:58:54PM +0000, John Garry wrote:
> On 10/01/2020 14:07, Mark Brown wrote:
> > On Fri, Jan 10, 2020 at 11:55:37AM +0000, John Garry wrote: >

...

> > > I will note that PRP0001+"jedec,spi-nor" compatible DSD seems to be the
> > > defacto method to describe the SPI NOR-compat part for ACPI - that's what
> > > I'm using. We could add properties there, but that seems improper.
> > 
> > OK, so that's just reusing the DT binding in which case everything
> > that's valid for the DT binding should also be valid for ACPI - I
> > thought that actually worked automatically without you having to do
> > anything in the code but ICBW.
> 
> I thought that it would be improper as we could be mixing ACPI methods to
> describe the serial bus (SPI Serial Bus Connection Resource Descriptor) and
> also DT properties which could conflict, like CS active high.
> 
> However I do see extra properties than "compatible" being added in DSD for
> PRP0001:
> https://patchwork.ozlabs.org/patch/662813/ (see EEPROM part)

PRP method is only for vendors to *test* the hardware in ACPI environment.
The proper method is to allocate correct ACPI ID.

Properties (_DSD in ACPI) may be used in the same way as for DT if we have no
other means in ACPI specification for them.

> And if we were to do this, I think that we would need to add some
> device_property_read_u32("spi-rx-bus-width", ...), etc calls in the SPI FW
> parsing for ACPI path - I couldn't see that.

It's okay as long as you have ACPI ID.

P.S. Most of the sensor drivers were updated in order to support ACPI PRP
method due to DIY hobbyist on IoT sector and embedded devices. This should not
be an official way how we support hardware on ACPI-based platforms.

-- 
With Best Regards,
Andy Shevchenko
