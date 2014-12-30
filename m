From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] spi/spidev: Convert to use unified device property API
Date: Tue, 30 Dec 2014 09:37:14 +0200
Message-ID: <20141230073714.GD1386@lahna.fi.intel.com>
References: <1419846074-240217-1-git-send-email-mika.westerberg@linux.intel.com>
 <20141229160316.GO17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141229160316.GO17800@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 29, 2014 at 04:03:16PM +0000, Mark Brown wrote:
> On Mon, Dec 29, 2014 at 11:41:14AM +0200, Mika Westerberg wrote:
> > This will allow the driver to match using DT compatible property if the
> > device has ACPI _HID of "PRP0001" and accompanying "compatible" property
> > listed in _DSD.
> 
> Which nobody should be doing since it's already totally broken for
> something to be using this on the DT side except in the one case of the
> Rohm device which is listed there.  I don't want to merge anything which
> allows the breakage we're seeing with people putting spidev in their DTs
> to be propagated into ACPI, at most we should have something that
> specifically identifies individual devices only.

It is pretty convenient for testing SPI bus and that's why I thought
it would be good to have possibility to enumerate this in similar way
than DT does but I understand your point.
