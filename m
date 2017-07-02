From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 2/4] ACPI / property: Support Apple _DSM properties
Date: Sun, 2 Jul 2017 13:07:19 +0200
Message-ID: <20170702110719.GA825@wunner.de>
References: <cover.1498636759.git.lukas@wunner.de>
 <e72ce423489dd604ae98ad3b76e07caf944cb581.1498636759.git.lukas@wunner.de>
 <CAHp75VdjOcPkd0_g05_OW6amxHjf2zdJ9jKyH7q2AgzGMr-h4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, x86@kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdjOcPkd0_g05_OW6amxHjf2zdJ9jKyH7q2AgzGMr-h4w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 28, 2017 at 09:53:49PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 28, 2017 at 8:20 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > While the rest of the world has standardized on _DSD as the way to store
> > device properties in AML (introduced with ACPI 5.1 in 2014), Apple has
> > been using a custom _DSM to achieve the same for much longer (ever since
> > they switched from DeviceTree-based PowerPC to Intel in 2005, verified
> > with MacOS X 10.4.11).
[snip]
> > +static void acpi_retrieve_apple_properties(struct acpi_device *adev)
> > +{
> > +       unsigned int i, j, newsize = 0, numprops, skipped = 0;
> > +       union acpi_object *props, *newprops;
> > +       void *free_space;
> > +
> > +       if (!IS_ENABLED(CONFIG_X86) || !dmi_match(DMI_SYS_VENDOR, "Apple Inc."))
> > +               return;
> 
> You are using this in few places, perhaps it makes sense to do in
> (maybe) header like
> drivers/acpi/apple.h
> 
> static inline bool is_apple_system(void)
> {
>    return IS_ENABLED(CONFIG_X86) && dmi_match(DMI_SYS_VENDOR, "Apple Inc.");
> }
> 
> I know this makes more LOCs, the rationale is to keep such
> deterministic things in one place (basically maintenance).

You mean like is_uv_system() for SGI UltraViolet?

I could add a global bool is_apple_system which is set early during boot,
then the DMI check would only have to be performed once.  The bool would
be #defined to false on non-x86 arches via a header file which would have
to live in include/linux/.  I could add an x86-specific config option
such as CONFIG_X86_APPLE which would allow removal of all Mac-specific
quirks and behaviour by likewise #defining is_apple_system to false.

I'm not sure if the x86 maintainers will approve of this.  Next thing
you know, someone wants to add the same thing for Dell or whatever.
OTOH the amount of code to deal with Apple quirks may justify it.
Adding x86 maintainers to cc.  Ingo, Thomas, Peter, any opinion?

My concern is that this series is bikeshedded / postponed indefinitely
if it is made to depend on such bigger changes.  (The discussion of
which is legitimate of course.)

Thanks,

Lukas
