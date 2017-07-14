From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 2/6] ACPI / x86: Consolidate Apple DMI checks
Date: Sat, 15 Jul 2017 00:03:31 +0200
Message-ID: <14565365.Cyeb0SINmK@aspire.rjw.lan>
References: <cover.1499983092.git.lukas@wunner.de> <a0c795358306954294e7fe31ec974f3c51b56f4c.1499983092.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <a0c795358306954294e7fe31ec974f3c51b56f4c.1499983092.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday, July 14, 2017 12:36:19 AM Lukas Wunner wrote:
> We're about to amend device scan with multiple checks whether we're
> running on a Mac.  Speed that up by performing the DMI match only once
> and caching the result.
> 
> Switch over existing Apple DMI checks, thereby fixing two deficiencies:
> 
> * They only match "Apple Inc." but not "Apple Computer, Inc.", which is
>   used by BIOSes released between January 2006 (when the first x86 Macs
>   started shipping) and January 2007 (when the company name changed upon
>   introduction of the iPhone).
> 
> * They are now #defined to false on non-x86 arches and can thus be
>   optimized away by the compiler.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> Changes v2 -> v3:
> - Newly inserted patch in v3 to avoid repeated DMI checks for Apple
>   hardware:  The result of the first DMI check in osi.c is cached.
>   Two other existing DMI checks are converted to use the result.
>   Because one of them is in a module (sbs.ko), the bool is_apple_system
>   needs to be exported.  On non-x86, the DMI checks and Apple-specific
>   code are omitted altogether. (Andy, Rafael)
> 
>  drivers/acpi/osi.c      |  4 ++++
>  drivers/acpi/pci_root.c |  3 +--
>  drivers/acpi/sbs.c      | 24 +-----------------------
>  include/linux/acpi.h    |  6 ++++++
>  4 files changed, 12 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index cd953ae10238..6c253d4006b4 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -258,12 +258,16 @@ bool acpi_osi_is_win8(void)
>  EXPORT_SYMBOL(acpi_osi_is_win8);
>  
>  #ifdef CONFIG_X86
> +bool is_apple_system;
> +EXPORT_SYMBOL(is_apple_system);

Maybe prepend the name of this variable with acpi_ to indicate that this is
ACPI-specific.

Other than that, I'm basically fine with the changes in this series, but
I need to have a closer look at them.

Thanks,
Rafael

