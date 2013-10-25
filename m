From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [RFC 1/2] i2c: Use stable dev_name for ACPI enumerated I2C slaves
Date: Fri, 25 Oct 2013 16:08:08 +0200
Message-ID: <2889412.bEKBLJtgSW@vostro.rjw.lan>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com> <98785510.yWYAtabkbj@vostro.rjw.lan> <526A726F.1030407@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <526A726F.1030407-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday, October 25, 2013 04:30:23 PM Jarkko Nikula wrote:
> On 10/25/2013 04:18 PM, Rafael J. Wysocki wrote:
> > On Friday, October 25, 2013 03:55:29 PM Jarkko Nikula wrote:
> >>
> >> Well, acpi_bus_get_device() is not available for non-ACPI builds and at
> >> least the gcc I used for test build didn't optimize that block away.
> > Well, it should.  ACPI_HANDLE() translates to (NULL) if CONFIG_ACPI
> > is not defined and that causes the check to become "if (NULL)" which
> > should always be dropped by the compiler.
> >
> My very vague memory says the same. I don't know is this gcc version or 
> flag dependent behavior. I got the build error from both i386 build 
> using gcc 4.8.1 and arm build by using make ARCH=arm omap2plus_defconfig 
> and gcc-4.7-arm-linux-gnueabi 4.7.2-4.
> > Does providing a stub acpi_bus_get_device() for !CONFIG_ACPI actually help?
> >
> >
> Hmm, not only. Referencing to dev field in struct acpi_device by 
> dev_name(&adev->dev) here will fail too.

Well, something is not quite right here.

One of the *reasons* for having ACPI_HANDLE() defined this way is to avoid
using explicit CONFIG_ACPI checks, so if that doesn't work, then all of that
becomes a bit pointless.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
