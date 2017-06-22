From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/3] ACPI / property: Support Apple _DSM properties
Date: Thu, 22 Jun 2017 11:54:39 +0200
Message-ID: <20170622095439.vquuet562i5scl3n@wunner.de>
References: <cover.1498044532.git.lukas@wunner.de>
 <8ce38be1389dfb0527961ccd0dedb609802b59c1.1498044532.git.lukas@wunner.de>
 <20170622080655.GS629@lahna.fi.intel.com>
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
In-Reply-To: <20170622080655.GS629@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 22, 2017 at 11:06:55AM +0300, Mika Westerberg wrote:
> On Wed, Jun 21, 2017 at 08:05:53PM +0200, Lukas Wunner wrote:
> > +	props = acpi_evaluate_dsm_typed(adev->handle, apple_prp_uuid, 1, 0,
> > +					NULL, ACPI_TYPE_BUFFER);
> > +	if (!props || !props->buffer.length)
> > +		goto out_free;
> > +
> > +	version = props->buffer.pointer[0];
> > +	ACPI_FREE(props);
> > +	if (version != 3) {
> > +		acpi_handle_err(adev->handle,
> > +				"unsupported properties version %u\n", version);
> 
> I don't think this is error. More like debug if anything.

It would be good to be able to google for this message to detect if there
are ever Macs out there which return something different than "3" to this
_DSM call.  How about KERN_WARN or KERN_INFO?

The AppleACPIPlatform.kext which shipped with 10.4.11 (2007) already checked
for a return value of 3 and the newest Macs still return "3", so this has
never changed in at least 10 years and the whole issue is thus theoretical.
I just wanted to be compatible to what macOS does, they check for "3" and
abort if the return value is different.


> > +	if (skipped)
> > +		acpi_handle_err(adev->handle,
> > +				"skipped %u properties: wrong type\n", skipped);
> 
> Same here.

This would be a firmware bug.  We've got FW_BUG, FW_WARN, FW_INFO defined in
include/linux/printk.h.  Granted this is not high priority, but FW_WARN or
at least FW_INFO would seem to be justified.


> > +	WARN_ON(free_space != (void *)newprops + newsize);
> 
> Again, there is not need to scare the user if we can't parse these. We
> can log an error here and give up but definitely no need to trigger
> backtrace and register dump.

This is not for parse errors but programming errors.  free_space is a
pointer into the newprops allocation.

If (free_space < newprops + newsize) then the allocation was too large
and we're wasting memory.

If (free_space > newprops + newsize) then the allocation was too small
and we've corrupted memory behind the allocation.

I'm fairly sure the WARN_ON will never trigger but what do I know? :-)


Thanks!

Lukas
