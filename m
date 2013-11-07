From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCHv2 1/3] ACPI: Expose struct acpi_device and acpi_bus_get_device() to non-ACPI builds
Date: Thu, 07 Nov 2013 14:34:35 +0100
Message-ID: <2770367.Lf1YV0Qxh5@vostro.rjw.lan>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com> <5990097.jCz86Yqdpc@vostro.rjw.lan> <20131104211559.GA12144@mylly>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
	linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20131104211559.GA12144@mylly>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Monday, November 04, 2013 11:15:59 PM Jarkko Nikula wrote:
> On Mon, Nov 04, 2013 at 02:00:45AM +0100, Rafael J. Wysocki wrote:
> > On Saturday, November 02, 2013 11:18:31 PM Rafael J. Wysocki wrote:
> > > This turns out the cause build problems to happen on some architectures.
> > > 
> > > I guess it's sufficient to simply define a stub struct acpi_device as
> > > 
> > > struct acpi_device {
> > > 	struct device dev;
> > > };
> > > 
> > > for !CONFIG_ACPI instead.
> > 
> > Generally, it is a bad idea to #include acpi_bus.h for !CONFIG_ACPI.
> > 
> Ouch, indeed.
> 
> > The appended patch works for me, sorry for stealing part of your changelog.
> > 
> No problem. Thanks for fixing this up.

Well, unfortunately, this breaks builds for allnoconfig, because <acpi/acpi.h>
is included directly from some header files (not under a CONFIG_ACPI ifdef) and
duplicates the acpi_handle typedef.

So, we'll need to go through the headers, see which ones do that and
replace <acpi/acpi.h> with <linux/acpi.h> (along with adding the stub
definitions for !CONFIG_ACPI).

I'm deferring the patchset for after 3.13-rc1 for this reason.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
