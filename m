From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 2/6] ACPI / x86: Consolidate Apple DMI checks
Date: Thu, 20 Jul 2017 16:27:37 +0200
Message-ID: <CAJZ5v0hh-rtfi6T3ebHYdqXn85W_gV_NDPU_XaRudM=T91Rziw@mail.gmail.com>
References: <cover.1499983092.git.lukas@wunner.de> <a0c795358306954294e7fe31ec974f3c51b56f4c.1499983092.git.lukas@wunner.de>
 <14565365.Cyeb0SINmK@aspire.rjw.lan> <20170720140353.GA4761@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170720140353.GA4761@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 20, 2017 at 4:03 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Sat, Jul 15, 2017 at 12:03:31AM +0200, Rafael J. Wysocki wrote:
>> On Friday, July 14, 2017 12:36:19 AM Lukas Wunner wrote:
>> > --- a/drivers/acpi/osi.c
>> > +++ b/drivers/acpi/osi.c
>> > @@ -258,12 +258,16 @@ bool acpi_osi_is_win8(void)
>> >  EXPORT_SYMBOL(acpi_osi_is_win8);
>> >
>> >  #ifdef CONFIG_X86
>> > +bool is_apple_system;
>> > +EXPORT_SYMBOL(is_apple_system);
>>
>> Maybe prepend the name of this variable with acpi_ to indicate that this is
>> ACPI-specific.
>
> It's not really ACPI-specific, osi.c just happens to be the best place
> to set the variable because the acpi_osi_dmi_table[] is checked very
> early during boot.  So early in fact, that I could even replace the
> existing Apple DMI check in arch/x86/kernel/early-quirks.c with
> "is_apple_system".

OK

> These non-ACPI files currently contain an Apple DMI check:
> arch/x86/kernel/early-quirks.c
> drivers/pci/quirks.c (2x)
> drivers/firmware/efi/apple-properties.c
> drivers/thunderbolt/tb.c
> drivers/thunderbolt/icm.c
>
> The latter three do not #include <linux/acpi.h> yet.  Somehow it feels
> odd to include that header to check for presence of an Apple system
> because that's not really ACPI-related.
>
> I guess I could introduce a new <linux/apple.h> but I hate the insane
> proliferation of additional files in include/linux/.

There is include/linux/platform_data/x86/ so maybe put it in there?

>  I could merge the contents of apple_bl.h and apple-gmux.h into that new header to
> reduce the number of files a bit.
>
> Struggling to find a solution that's nice and clean.  Any ideas?

I guess you still want it to work if someone configures the kernel
without CONFIG_ACPI, although that's slightly debatable, so the
variable should be defined somewhere in the arch code I suppose.

I also guess you could add something like arch/x86/platform/apple/ and
put the checks and the variable in there (in which case I'd call it
x86_apple_machine or similar).

Then invoke the check from acpi_osi_dmi_table[] code and the
early-quirks.c one is only needed for !CONFIG_ACPI.

Thanks,
Rafael
