From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 3/3] acpi spi: Initialize modalias from of_compatible
Date: Tue, 19 Jul 2016 10:08:02 +0300
Message-ID: <20160719070802.GO14693@lahna.fi.intel.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1d26e956f12fcd86ad915659adeb86e242b96ac7.1468409668.git.leonard.crestez@intel.com>
 <CAJZ5v0jPfx0DEKkfJ8ma2_+emtbSrCv3KrmRGP7gG-6j6h3yfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jarkko Nikula <jarkko.nikula@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	linux-spi <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Octavian Purdila <octavian.purdila@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jPfx0DEKkfJ8ma2_+emtbSrCv3KrmRGP7gG-6j6h3yfw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jul 13, 2016 at 02:22:02PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 13, 2016 at 1:53 PM, Crestez Dan Leonard
> <leonard.crestez@intel.com> wrote:
> > When using devicetree spi_device.modalias is set to the compatible
> > string with the vendor prefix removed. For SPI devices described via
> > ACPI the i2c_board_info.type string is initialized by acpi_device_hid.
> > When using ACPI and DT ids this string ends up something like "PRP0001".
> >
> > Change acpi_register_spi_device to use the of_compatible property if
> > present. This makes it easier to instantiate spi drivers through ACPI
> > with DT ids.
> >
> > Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> 
> Same as for the i2c patch: it looks good to me, but I'd prefer to get
> a word from Mika on it too.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
