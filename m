From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 5/7] drivers: Introduce device lookup variants by
 ACPI_COMPANION device
Date: Thu, 1 Aug 2019 15:21:06 +0300
Message-ID: <20190801122106.GU23480@smile.fi.intel.com>
References: <20190723221838.12024-1-suzuki.poulose@arm.com>
 <20190723221838.12024-6-suzuki.poulose@arm.com>
 <20190726202353.GA963@kunai>
 <20190801115856.GS23480@smile.fi.intel.com>
 <20190801120830.GA1659@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190801120830.GA1659@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 01, 2019 at 02:08:30PM +0200, Wolfram Sang wrote:
> On Thu, Aug 01, 2019 at 02:58:56PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 26, 2019 at 10:23:54PM +0200, Wolfram Sang wrote:
> > > On Tue, Jul 23, 2019 at 11:18:36PM +0100, Suzuki K Poulose wrote:
> > > > Add a generic helper to match a device by the ACPI_COMPANION device
> > > > and provide wrappers for the device lookup APIs.
> > > > 
> > > > Cc: Len Brown <lenb@kernel.org>
> > > > Cc: linux-acpi@vger.kernel.org
> > > > Cc: linux-spi@vger.kernel.org
> > > > Cc: Mark Brown <broonie@kernel.org>
> > > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Cc: Wolfram Sang <wsa@the-dreams.de>
> > > > Cc: linux-i2c@vger.kernel.org
> > > > Cc: Mark Brown <broonie@kernel.org>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > 
> > > From my side, OK:
> > > 
> > > Acked-by: Wolfram Sang <wsa@the-dreams.de> # I2C parts
> > > 
> > > yet you missed to cc the I2C ACPI maintainers. Done so now.
> > 
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Thanks, Wolfram, for notifying.
> 
> Sure. There seems to be a problem, though? Please check:
> 
> [PATCH 1/3] i2c: Revert incorrect conversion to use generic helper
> 
> which came in today.

It's again not Cc'ed to all parties.
But OK, looks good to me.
Tough may be Jarkko can test all this.

-- 
With Best Regards,
Andy Shevchenko
