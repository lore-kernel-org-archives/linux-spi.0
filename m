From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/4] ACPI / property: Support Apple _DSM properties
Date: Tue, 4 Jul 2017 00:47:00 +0200
Message-ID: <CAJZ5v0g9wq4-PTHP8-ubVhCDvTa_G677NcQet4DYEJKEqpbKjg@mail.gmail.com>
References: <cover.1498636759.git.lukas@wunner.de> <e72ce423489dd604ae98ad3b76e07caf944cb581.1498636759.git.lukas@wunner.de>
 <CAHp75VdjOcPkd0_g05_OW6amxHjf2zdJ9jKyH7q2AgzGMr-h4w@mail.gmail.com> <20170702110719.GA825@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ronald Tschalaer <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>,
        Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Daniel Roschka <danielroschka-d2qyoUQsf3ABe69/dCFm4g@public.gmane.org>,
        "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "the arch/x86 maintainers" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170702110719.GA825-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Jul 2, 2017 at 1:07 PM, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> On Wed, Jun 28, 2017 at 09:53:49PM +0300, Andy Shevchenko wrote:
>> On Wed, Jun 28, 2017 at 8:20 PM, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
>> > While the rest of the world has standardized on _DSD as the way to store
>> > device properties in AML (introduced with ACPI 5.1 in 2014), Apple has
>> > been using a custom _DSM to achieve the same for much longer (ever since
>> > they switched from DeviceTree-based PowerPC to Intel in 2005, verified
>> > with MacOS X 10.4.11).
> [snip]
>> > +static void acpi_retrieve_apple_properties(struct acpi_device *adev)
>> > +{
>> > +       unsigned int i, j, newsize = 0, numprops, skipped = 0;
>> > +       union acpi_object *props, *newprops;
>> > +       void *free_space;
>> > +
>> > +       if (!IS_ENABLED(CONFIG_X86) || !dmi_match(DMI_SYS_VENDOR, "Apple Inc."))
>> > +               return;
>>
>> You are using this in few places, perhaps it makes sense to do in
>> (maybe) header like
>> drivers/acpi/apple.h
>>
>> static inline bool is_apple_system(void)
>> {
>>    return IS_ENABLED(CONFIG_X86) && dmi_match(DMI_SYS_VENDOR, "Apple Inc.");
>> }
>>
>> I know this makes more LOCs, the rationale is to keep such
>> deterministic things in one place (basically maintenance).
>
> You mean like is_uv_system() for SGI UltraViolet?
>
> I could add a global bool is_apple_system which is set early during boot,
> then the DMI check would only have to be performed once.  The bool would
> be #defined to false on non-x86 arches via a header file which would have
> to live in include/linux/.  I could add an x86-specific config option
> such as CONFIG_X86_APPLE which would allow removal of all Mac-specific
> quirks and behaviour by likewise #defining is_apple_system to false.
>
> I'm not sure if the x86 maintainers will approve of this.  Next thing
> you know, someone wants to add the same thing for Dell or whatever.
> OTOH the amount of code to deal with Apple quirks may justify it.
> Adding x86 maintainers to cc.  Ingo, Thomas, Peter, any opinion?

Well, it doesn't have to go into arch/x86/.

We have drivers/acpi/x86/ now, so you can put it in there, say into
apple.c that will only be built for CONFIG_X86 set.

Then, instead of using a concealed #ifdef in-line, you could do that
openly in a header.

Moreover, having a static bool variable in drivers/acpi/x86/apple.c
would not be super-objectionable IMO.

> My concern is that this series is bikeshedded / postponed indefinitely
> if it is made to depend on such bigger changes.  (The discussion of
> which is legitimate of course.)

Of course, the Apple properties check in scan.c only makes sense if
the system is Apple, but then the dmi_match() adds a bit of overhead
for everything x86 that isn't Apple, which I guess is the majority.
So I'd like that overhead to be reduced if possible.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
