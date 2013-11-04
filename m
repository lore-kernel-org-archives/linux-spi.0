From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCHv2 1/3] ACPI: Expose struct acpi_device and
 acpi_bus_get_device() to non-ACPI builds
Date: Mon, 4 Nov 2013 23:15:59 +0200
Message-ID: <20131104211559.GA12144@mylly>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1383309356-25430-2-git-send-email-jarkko.nikula@linux.intel.com>
 <3858838.4tAO673dDi@vostro.rjw.lan>
 <5990097.jCz86Yqdpc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
	linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5990097.jCz86Yqdpc@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Nov 04, 2013 at 02:00:45AM +0100, Rafael J. Wysocki wrote:
> On Saturday, November 02, 2013 11:18:31 PM Rafael J. Wysocki wrote:
> > This turns out the cause build problems to happen on some architectures.
> > 
> > I guess it's sufficient to simply define a stub struct acpi_device as
> > 
> > struct acpi_device {
> > 	struct device dev;
> > };
> > 
> > for !CONFIG_ACPI instead.
> 
> Generally, it is a bad idea to #include acpi_bus.h for !CONFIG_ACPI.
> 
Ouch, indeed.

> The appended patch works for me, sorry for stealing part of your changelog.
> 
No problem. Thanks for fixing this up.

-- 
Jarkko
