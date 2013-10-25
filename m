From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [RFC 1/2] i2c: Use stable dev_name for ACPI enumerated I2C slaves
Date: Fri, 25 Oct 2013 15:18:01 +0200
Message-ID: <98785510.yWYAtabkbj@vostro.rjw.lan>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com> <6032482.JJ4PNSSnIp@vostro.rjw.lan> <526A6A41.6020909@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <526A6A41.6020909-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Friday, October 25, 2013 03:55:29 PM Jarkko Nikula wrote:
> Hi
> 
> On 10/25/2013 03:52 PM, Rafael J. Wysocki wrote:
> >   
> > +static void i2c_dev_set_name(struct i2c_adapter *adap,
> > +			     struct i2c_client *client)
> > +{
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +	if (ACPI_HANDLE(&client->dev)) {
> > ACPI_HANDLE() already contains an "is CONFIG_ACPI enabled?" check, so the #if
> > around the if (ACPI_HANDLE()) {} is redundant.
> >
> > Similarly for the SPI patch.
> >
> Well, acpi_bus_get_device() is not available for non-ACPI builds and at 
> least the gcc I used for test build didn't optimize that block away.

Well, it should.  ACPI_HANDLE() translates to (NULL) if CONFIG_ACPI
is not defined and that causes the check to become "if (NULL)" which
should always be dropped by the compiler.

Does providing a stub acpi_bus_get_device() for !CONFIG_ACPI actually help?

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
