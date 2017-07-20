From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 2/6] ACPI / x86: Consolidate Apple DMI checks
Date: Thu, 20 Jul 2017 17:33:43 +0300
Message-ID: <1500561223.29303.150.camel@linux.intel.com>
References: <cover.1499983092.git.lukas@wunner.de>
         <a0c795358306954294e7fe31ec974f3c51b56f4c.1499983092.git.lukas@wunner.de>
         <14565365.Cyeb0SINmK@aspire.rjw.lan> <20170720140353.GA4761@wunner.de>
         <CAJZ5v0hh-rtfi6T3ebHYdqXn85W_gV_NDPU_XaRudM=T91Rziw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Darren Hart <dvhart@infradead.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hh-rtfi6T3ebHYdqXn85W_gV_NDPU_XaRudM=T91Rziw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2017-07-20 at 16:27 +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 20, 2017 at 4:03 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Sat, Jul 15, 2017 at 12:03:31AM +0200, Rafael J. Wysocki wrote:
> > > On Friday, July 14, 2017 12:36:19 AM Lukas Wunner wrote:
> > > > 


> > I guess I could introduce a new <linux/apple.h> but I hate the
> > insane
> > proliferation of additional files in include/linux/.
> 
> There is include/linux/platform_data/x86/ so maybe put it in there?

Just suggested the same :-)

> >  I could merge the contents of apple_bl.h and apple-gmux.h into that
> > new header to
> > reduce the number of files a bit.
> > 
> > Struggling to find a solution that's nice and clean.  Any ideas?
> 
> I guess you still want it to work if someone configures the kernel
> without CONFIG_ACPI, although that's slightly debatable, so the
> variable should be defined somewhere in the arch code I suppose.
> 
> I also guess you could add something like arch/x86/platform/apple/ and
> put the checks and the variable in there (in which case I'd call it
> x86_apple_machine or similar).

I'm not sure if we can use drivers/platform/x86 for this, either agreed
way is fine to me.

Darren?

> 
> Then invoke the check from acpi_osi_dmi_table[] code and the
> early-quirks.c one is only needed for !CONFIG_ACPI.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
