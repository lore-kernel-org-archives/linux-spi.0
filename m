From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] fix module autoloading for ACPI enumerated devices
Date: Thu, 16 Jan 2014 20:51:49 +0800
Message-ID: <1389876709.3010.6.camel@rzhang1-mobl4>
References: <1389689198-2641-1-git-send-email-rui.zhang@intel.com>
	 <1389689198-2641-4-git-send-email-rui.zhang@intel.com>
	 <20140116122819.GO15567@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org,
	rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140116122819.GO15567-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2014-01-16 at 12:28 +0000, Mark Brown wrote:
> On Tue, Jan 14, 2014 at 04:46:37PM +0800, Zhang Rui wrote:
> > ACPI enumerated devices has ACPI style _HID and _CID strings,
> > all of these strings can be used for both driver loading and matching.
> > 
> > Currently, in Platform, I2C and SPI bus, the ACPI style driver matching
> > is supported by invoking acpi_driver_match_device() in bus .match() callback.
> > But, the module autoloading is still broken.
> 
> Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> modulo the PAGE_SIZE stuff Mika noted - unless this changes radically
> please just assume I'm OK with it.

thanks.

-rui
