From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 3/4] fix module autoloading for ACPI enumerated devices
Date: Wed, 15 Jan 2014 09:16:43 +0800
Message-ID: <1389748603.2336.9.camel@rzhang1-mobl4>
References: <1389686417.3309.8.camel@rzhang1-mobl4>
	 <20140114144155.GQ15567@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org, rjw@rjwysocki.net,
	grant.likely@secretlab.ca, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140114144155.GQ15567@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 2014-01-14 at 14:41 +0000, Mark Brown wrote:
> On Tue, Jan 14, 2014 at 04:00:17PM +0800, Zhang Rui wrote:
> > On Mon, 2014-01-13 at 17:35 +0000, Mark Brown wrote:
> > > On Mon, Jan 13, 2014 at 09:48:31PM +0800, Zhang Rui wrote:
> > > > ACPI enumerated devices has ACPI style _HID and _CID strings,
> > > > all of these strings can be used for both driver loading and matching.
> 
> > If this piece of code is used in an *SPI* driver for an ACPI enumerated
> > spi device, the spi driver module_alias is "acpi:INTABCD", but
> > the uevent of its spi device node is
> > "spi:INTABCD" (PREFIX:spi_device->modalias).
> 
> OK that makes sense, but what does this have to do with the _HID and
> _CID methods?

If an ACPI enumerated SPI device has a _HID and a _CID,
both of them need to be exposed in 'uevent', so that a driver that
matches _CID can also have a chance to be probed. This can not be done
by the current code, thus we need special handling of ACPI enumerated
SPI devices.

>   Surely we're just replacing spi: with acpi: in the uevent?

yes.

thanks,
rui
