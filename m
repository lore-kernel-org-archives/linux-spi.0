From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v3 2/6] ACPI / x86: Consolidate Apple DMI checks
Date: Thu, 20 Jul 2017 13:26:26 -0700
Message-ID: <20170720202626.GA16076@fury>
References: <cover.1499983092.git.lukas@wunner.de>
 <CAJZ5v0hh-rtfi6T3ebHYdqXn85W_gV_NDPU_XaRudM=T91Rziw@mail.gmail.com>
 <1500561223.29303.150.camel@linux.intel.com>
 <6875377.ba0xIR7deM@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6875377.ba0xIR7deM@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 20, 2017 at 04:49:48PM +0200, Rafael Wysocki wrote:
> On Thursday, July 20, 2017 05:33:43 PM Andy Shevchenko wrote:
> > On Thu, 2017-07-20 at 16:27 +0200, Rafael J. Wysocki wrote:
> > > On Thu, Jul 20, 2017 at 4:03 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > > > On Sat, Jul 15, 2017 at 12:03:31AM +0200, Rafael J. Wysocki wrote:
> > > > > On Friday, July 14, 2017 12:36:19 AM Lukas Wunner wrote:
> > > > > > 
> > 
> > 
> > > > I guess I could introduce a new <linux/apple.h> but I hate the
> > > > insane
> > > > proliferation of additional files in include/linux/.
> > > 
> > > There is include/linux/platform_data/x86/ so maybe put it in there?
> > 
> > Just suggested the same :-)

Yes please, this is precisely why we created this directory.

> > 
> > > >  I could merge the contents of apple_bl.h and apple-gmux.h into that
> > > > new header to
> > > > reduce the number of files a bit.
> > > > 
> > > > Struggling to find a solution that's nice and clean.  Any ideas?
> > > 
> > > I guess you still want it to work if someone configures the kernel
> > > without CONFIG_ACPI, although that's slightly debatable, so the
> > > variable should be defined somewhere in the arch code I suppose.
> > > 
> > > I also guess you could add something like arch/x86/platform/apple/ and
> > > put the checks and the variable in there (in which case I'd call it
> > > x86_apple_machine or similar).
> > 
> > I'm not sure if we can use drivers/platform/x86 for this, either agreed
> > way is fine to me.
> 
> No, because of the ACPI involvement.  That needs to go under arch/ IMO.

We have an example, silead_dmi.c, which extracts properties based on the DMI
match, and adds them to the i2c client device. While I suppose we could do
something like this, the drivers affected are really not "platform drivers", but
rather common drivers with platform specific properties. I concur with Rafael.

-- 
Darren Hart
VMware Open Source Technology Center
