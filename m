From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/3] ACPI / property: Support Apple _DSM properties
Date: Thu, 22 Jun 2017 13:24:28 +0200
Message-ID: <20170622112428.q3hpwpfs4xwumued@wunner.de>
References: <cover.1498044532.git.lukas@wunner.de>
 <8ce38be1389dfb0527961ccd0dedb609802b59c1.1498044532.git.lukas@wunner.de>
 <20170622080655.GS629@lahna.fi.intel.com>
 <20170622095439.vquuet562i5scl3n@wunner.de>
 <20170622100422.GX629@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170622100422.GX629@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 22, 2017 at 01:04:22PM +0300, Mika Westerberg wrote:
> On Thu, Jun 22, 2017 at 11:54:39AM +0200, Lukas Wunner wrote:
> > On Thu, Jun 22, 2017 at 11:06:55AM +0300, Mika Westerberg wrote:
> > > On Wed, Jun 21, 2017 at 08:05:53PM +0200, Lukas Wunner wrote:
> > > > +	props = acpi_evaluate_dsm_typed(adev->handle, apple_prp_uuid, 1, 0,
> > > > +					NULL, ACPI_TYPE_BUFFER);
> > > > +	if (!props || !props->buffer.length)
> > > > +		goto out_free;
> > > > +
> > > > +	version = props->buffer.pointer[0];
> > > > +	ACPI_FREE(props);
> > > > +	if (version != 3) {
> > > > +		acpi_handle_err(adev->handle,
> > > > +				"unsupported properties version %u\n", version);
> > > 
> > > I don't think this is error. More like debug if anything.
> > 
> > It would be good to be able to google for this message to detect if there
> > are ever Macs out there which return something different than "3" to this
> > _DSM call.  How about KERN_WARN or KERN_INFO?
> 
> Well, this is something the user might see and then gets confused on the
> grounds: is my machine somehow broken?

And indeed it might be:  Conceivably, Apple may change the format of the
properties and then once again the SPI slave won't be able to initialize.
In that case it seems beneficial to provide a clue as to the cause in dmesg.

Thanks,

Lukas
