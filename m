From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 1/5] treewide: Consolidate Apple DMI checks
Date: Tue, 01 Aug 2017 15:35:04 +0300
Message-ID: <1501590904.29303.316.camel@linux.intel.com>
References: <cover.1501570421.git.lukas@wunner.de>
         <20f8b74b83ed45171583fe501182c93e5c6eb4d9.1501570421.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Ronald Tschalaer <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>,
        Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Daniel Roschka <danielroschka-d2qyoUQsf3ABe69/dCFm4g@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
        Matt Fleming <matt-mF/unelCI9GS6iBeEJttW/XRex20P6io@public.gmane.org>,
        Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Michael Jamet <michael.jamet-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Yehezkel Bernat <yehezkel.bernat-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20f8b74b83ed45171583fe501182c93e5c6eb4d9.1501570421.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2017-08-01 at 14:10 +0200, Lukas Wunner wrote:
> We're about to amend ACPI bus scan with DMI checks whether we're
> running
> on a Mac to support Apple device properties in AML.  The DMI checks
> are
> performed for every single device, adding overhead for everything x86
> that isn't Apple, which is the majority.  Rafael and Andy therefore
> request to perform the DMI match only once and cache the result.
> 
> Outside of ACPI various other Apple DMI checks exist and it seems
> reasonable to use the cached value there as well.  Rafael, Andy and
> Darren suggest performing the DMI check in arch code and making it
> available with a header in include/linux/platform_data/x86/.
> 
> To this end, add early_platform_quirks() to arch/x86/kernel/quirks.c
> to perform the DMI check and invoke it from setup_arch().  Switch over
> all existing Apple DMI checks, thereby fixing two deficiencies:
> 
> * They are now #defined to false on non-x86 arches and can thus be
>   optimized away if they're located in cross-arch code.
> 
> * Some of them only match "Apple Inc." but not "Apple Computer, Inc.",
>   which is used by BIOSes released between January 2006 (when the
> first
>   x86 Macs started shipping) and January 2007 (when the company name
>   changed upon introduction of the iPhone).


I like the idea, though I can repeat what I commented on your Github
page.

We might need to distinguish 2006 vs 2007 Apple hardware. Thus, my
proposal was to use unsigned int (as bitwise flags) instead of bool and
provide two definitions for the hardware. Set those bits accordingly.
In case of most of the checks it will be the same as in this patch, but
leaves a flexibility of a choice.

> 
> Cc: Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: H. Peter Anvin <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
> Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Cc: Matt Fleming <matt-mF/unelCI9GS6iBeEJttW/XRex20P6io@public.gmane.org>
> Cc: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Michael Jamet <michael.jamet-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Yehezkel Bernat <yehezkel.bernat-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Suggested-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Suggested-by: Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
> ---
> Changes v3 -> v4:
> - Extend consolidation of Apple DMI checks to the entire tree
>   instead of just the ACPI core. (Rafael, Andy, Darren)
> 
>  arch/x86/include/asm/setup.h            |  1 +
>  arch/x86/kernel/early-quirks.c          |  4 ++--
>  arch/x86/kernel/quirks.c                | 10 +++++++++
>  arch/x86/kernel/setup.c                 |  2 ++
>  drivers/acpi/osi.c                      | 37 +++++++-----------------
> ---------
>  drivers/acpi/pci_root.c                 |  4 ++--
>  drivers/acpi/sbs.c                      | 25 ++--------------------
>  drivers/firmware/efi/apple-properties.c |  5 ++---
>  drivers/pci/quirks.c                    |  5 +++--
>  drivers/thunderbolt/icm.c               | 13 ++++--------
>  drivers/thunderbolt/tb.c                |  4 ++--
>  include/linux/platform_data/x86/apple.h | 13 ++++++++++++
>  12 files changed, 51 insertions(+), 72 deletions(-)
>  create mode 100644 include/linux/platform_data/x86/apple.h
> 
> diff --git a/arch/x86/include/asm/setup.h
> b/arch/x86/include/asm/setup.h
> index e4585a393965..a65cf544686a 100644
> --- a/arch/x86/include/asm/setup.h
> +++ b/arch/x86/include/asm/setup.h
> @@ -39,6 +39,7 @@ static inline void vsmp_init(void) { }
>  #endif
>  
>  void setup_bios_corruption_check(void);
> +void early_platform_quirks(void);
>  
>  extern unsigned long saved_video_mode;
>  
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-
> quirks.c
> index d907c3d8633f..a70a65ae798a 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -12,10 +12,10 @@
>  #include <linux/pci.h>
>  #include <linux/acpi.h>
>  #include <linux/delay.h>
> -#include <linux/dmi.h>
>  #include <linux/pci_ids.h>
>  #include <linux/bcma/bcma.h>
>  #include <linux/bcma/bcma_regs.h>
> +#include <linux/platform_data/x86/apple.h>
>  #include <drm/i915_drm.h>
>  #include <asm/pci-direct.h>
>  #include <asm/dma.h>
> @@ -593,7 +593,7 @@ static void __init apple_airport_reset(int bus,
> int slot, int func)
>  	u64 addr;
>  	int i;
>  
> -	if (!dmi_match(DMI_SYS_VENDOR, "Apple Inc."))
> +	if (!x86_apple_machine)
>  		return;
>  
>  	/* Card may have been put into PCI_D3hot by grub quirk */
> diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
> index 0bee04d41bed..eaa591cfd98b 100644
> --- a/arch/x86/kernel/quirks.c
> +++ b/arch/x86/kernel/quirks.c
> @@ -1,6 +1,7 @@
>  /*
>   * This file contains work-arounds for x86 and x86_64 platform bugs.
>   */
> +#include <linux/dmi.h>
>  #include <linux/pci.h>
>  #include <linux/irq.h>
>  
> @@ -656,3 +657,12 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,
> 0x6fc0, quirk_intel_brickland_xeon_
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2083,
> quirk_intel_purley_xeon_ras_cap);
>  #endif
>  #endif
> +
> +bool x86_apple_machine;
> +EXPORT_SYMBOL(x86_apple_machine);
> +
> +void __init early_platform_quirks(void)
> +{
> +	x86_apple_machine = dmi_match(DMI_SYS_VENDOR, "Apple Inc.")
> ||
> +			    dmi_match(DMI_SYS_VENDOR, "Apple
> Computer, Inc.");
> +}
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3486d0498800..77b3c3af7cba 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1206,6 +1206,8 @@ void __init setup_arch(char **cmdline_p)
>  
>  	io_delay_init();
>  
> +	early_platform_quirks();
> +
>  	/*
>  	 * Parse the ACPI tables for possible boot-time SMP
> configuration.
>  	 */
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index 723bee58bbcf..19cdd8a783a9 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -27,6 +27,7 @@
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> +#include <linux/platform_data/x86/apple.h>
>  
>  #include "internal.h"
>  
> @@ -257,12 +258,11 @@ bool acpi_osi_is_win8(void)
>  }
>  EXPORT_SYMBOL(acpi_osi_is_win8);
>  
> -static void __init acpi_osi_dmi_darwin(bool enable,
> -				       const struct dmi_system_id *d)
> +static void __init acpi_osi_dmi_darwin(void)
>  {
> -	pr_notice("DMI detected to setup _OSI(\"Darwin\"): %s\n", d-
> >ident);
> +	pr_notice("DMI detected to setup _OSI(\"Darwin\"): Apple
> hardware\n");
>  	osi_config.darwin_dmi = 1;
> -	__acpi_osi_setup_darwin(enable);
> +	__acpi_osi_setup_darwin(true);
>  }
>  
>  static void __init acpi_osi_dmi_linux(bool enable,
> @@ -273,13 +273,6 @@ static void __init acpi_osi_dmi_linux(bool
> enable,
>  	__acpi_osi_setup_linux(enable);
>  }
>  
> -static int __init dmi_enable_osi_darwin(const struct dmi_system_id
> *d)
> -{
> -	acpi_osi_dmi_darwin(true, d);
> -
> -	return 0;
> -}
> -
>  static int __init dmi_enable_osi_linux(const struct dmi_system_id *d)
>  {
>  	acpi_osi_dmi_linux(true, d);
> @@ -481,30 +474,16 @@ static struct dmi_system_id acpi_osi_dmi_table[]
> __initdata = {
>  		     DMI_MATCH(DMI_PRODUCT_NAME, "1015PX"),
>  		},
>  	},
> -
> -	/*
> -	 * Enable _OSI("Darwin") for all apple platforms.
> -	 */
> -	{
> -	.callback = dmi_enable_osi_darwin,
> -	.ident = "Apple hardware",
> -	.matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> -		},
> -	},
> -	{
> -	.callback = dmi_enable_osi_darwin,
> -	.ident = "Apple hardware",
> -	.matches = {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer,
> Inc."),
> -		},
> -	},
>  	{}
>  };
>  
>  static __init void acpi_osi_dmi_blacklisted(void)
>  {
>  	dmi_check_system(acpi_osi_dmi_table);
> +
> +	/* Enable _OSI("Darwin") for Apple platforms. */
> +	if (x86_apple_machine)
> +		acpi_osi_dmi_darwin();
>  }
>  
>  int __init early_acpi_osi_init(void)
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 9eec3095e6c3..6fc204a52493 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -33,6 +33,7 @@
>  #include <linux/acpi.h>
>  #include <linux/slab.h>
>  #include <linux/dmi.h>
> +#include <linux/platform_data/x86/apple.h>
>  #include <acpi/apei.h>	/* for acpi_hest_init() */
>  
>  #include "internal.h"
> @@ -431,8 +432,7 @@ static void negotiate_os_control(struct
> acpi_pci_root *root, int *no_aspm)
>  	 * been called successfully. We know the feature set
> supported by the
>  	 * platform, so avoid calling _OSC at all
>  	 */
> -
> -	if (dmi_match(DMI_SYS_VENDOR, "Apple Inc.")) {
> +	if (x86_apple_machine) {
>  		root->osc_control_set = ~OSC_PCI_EXPRESS_PME_CONTROL;
>  		decode_osc_control(root, "OS assumes control of",
>  				   root->osc_control_set);
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index ad0b13ad4bbb..a18463799ad7 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -31,7 +31,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/delay.h>
>  #include <linux/power_supply.h>
> -#include <linux/dmi.h>
> +#include <linux/platform_data/x86/apple.h>
>  
>  #include "sbshc.h"
>  #include "battery.h"
> @@ -58,8 +58,6 @@ static unsigned int cache_time = 1000;
>  module_param(cache_time, uint, 0644);
>  MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
>  
> -static bool sbs_manager_broken;
> -
>  #define MAX_SBS_BAT			4
>  #define ACPI_SBS_BLOCK_MAX		32
>  
> @@ -632,31 +630,12 @@ static void acpi_sbs_callback(void *context)
>  	}
>  }
>  
> -static int disable_sbs_manager(const struct dmi_system_id *d)
> -{
> -	sbs_manager_broken = true;
> -	return 0;
> -}
> -
> -static struct dmi_system_id acpi_sbs_dmi_table[] = {
> -	{
> -		.callback = disable_sbs_manager,
> -		.ident = "Apple",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc.")
> -		},
> -	},
> -	{ },
> -};
> -
>  static int acpi_sbs_add(struct acpi_device *device)
>  {
>  	struct acpi_sbs *sbs;
>  	int result = 0;
>  	int id;
>  
> -	dmi_check_system(acpi_sbs_dmi_table);
> -
>  	sbs = kzalloc(sizeof(struct acpi_sbs), GFP_KERNEL);
>  	if (!sbs) {
>  		result = -ENOMEM;
> @@ -677,7 +656,7 @@ static int acpi_sbs_add(struct acpi_device
> *device)
>  
>  	result = 0;
>  
> -	if (!sbs_manager_broken) {
> +	if (!x86_apple_machine) {
>  		result = acpi_manager_get_info(sbs);
>  		if (!result) {
>  			sbs->manager_present = 1;
> diff --git a/drivers/firmware/efi/apple-properties.c
> b/drivers/firmware/efi/apple-properties.c
> index c473f4c5ca34..9f6bcf173b0e 100644
> --- a/drivers/firmware/efi/apple-properties.c
> +++ b/drivers/firmware/efi/apple-properties.c
> @@ -18,8 +18,8 @@
>  #define pr_fmt(fmt) "apple-properties: " fmt
>  
>  #include <linux/bootmem.h>
> -#include <linux/dmi.h>
>  #include <linux/efi.h>
> +#include <linux/platform_data/x86/apple.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/ucs2_string.h>
> @@ -191,8 +191,7 @@ static int __init map_properties(void)
>  	u64 pa_data;
>  	int ret;
>  
> -	if (!dmi_match(DMI_SYS_VENDOR, "Apple Inc.") &&
> -	    !dmi_match(DMI_SYS_VENDOR, "Apple Computer, Inc."))
> +	if (!x86_apple_machine)
>  		return 0;
>  
>  	pa_data = boot_params.hdr.setup_data;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6967c6b4cf6b..ba7b7c64379e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -25,6 +25,7 @@
>  #include <linux/sched.h>
>  #include <linux/ktime.h>
>  #include <linux/mm.h>
> +#include <linux/platform_data/x86/apple.h>
>  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>  #include "pci.h"
>  
> @@ -3447,7 +3448,7 @@ static void
> quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>  {
>  	acpi_handle bridge, SXIO, SXFP, SXLV;
>  
> -	if (!dmi_match(DMI_BOARD_VENDOR, "Apple Inc."))
> +	if (!x86_apple_machine)
>  		return;
>  	if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
>  		return;
> @@ -3492,7 +3493,7 @@ static void
> quirk_apple_wait_for_thunderbolt(struct pci_dev *dev)
>  	struct pci_dev *sibling = NULL;
>  	struct pci_dev *nhi = NULL;
>  
> -	if (!dmi_match(DMI_BOARD_VENDOR, "Apple Inc."))
> +	if (!x86_apple_machine)
>  		return;
>  	if (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
>  		return;
> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index bdaac1ff00a5..53250fc057e1 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -13,9 +13,9 @@
>   */
>  
>  #include <linux/delay.h>
> -#include <linux/dmi.h>
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> +#include <linux/platform_data/x86/apple.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> @@ -102,11 +102,6 @@ static inline u64 get_route(u32 route_hi, u32
> route_lo)
>  	return (u64)route_hi << 32 | route_lo;
>  }
>  
> -static inline bool is_apple(void)
> -{
> -	return dmi_match(DMI_BOARD_VENDOR, "Apple Inc.");
> -}
> -
>  static bool icm_match(const struct tb_cfg_request *req,
>  		      const struct ctl_pkg *pkg)
>  {
> @@ -176,7 +171,7 @@ static int icm_request(struct tb *tb, const void
> *request, size_t request_size,
>  
>  static bool icm_fr_is_supported(struct tb *tb)
>  {
> -	return !is_apple();
> +	return !x86_apple_machine;
>  }
>  
>  static inline int icm_fr_get_switch_index(u32 port)
> @@ -517,7 +512,7 @@ static bool icm_ar_is_supported(struct tb *tb)
>  	 * Starting from Alpine Ridge we can use ICM on Apple
> machines
>  	 * as well. We just need to reset and re-enable it first.
>  	 */
> -	if (!is_apple())
> +	if (!x86_apple_machine)
>  		return true;
>  
>  	/*
> @@ -1011,7 +1006,7 @@ static int icm_start(struct tb *tb)
>  	 * don't provide images publicly either. To be on the safe
> side
>  	 * prevent root switch NVM upgrade on Macs for now.
>  	 */
> -	tb->root_switch->no_nvm_upgrade = is_apple();
> +	tb->root_switch->no_nvm_upgrade = x86_apple_machine;
>  
>  	ret = tb_switch_add(tb->root_switch);
>  	if (ret)
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index 1b02ca0b6129..0b22ad9d68b4 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -7,7 +7,7 @@
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/delay.h>
> -#include <linux/dmi.h>
> +#include <linux/platform_data/x86/apple.h>
>  
>  #include "tb.h"
>  #include "tb_regs.h"
> @@ -453,7 +453,7 @@ struct tb *tb_probe(struct tb_nhi *nhi)
>  	struct tb_cm *tcm;
>  	struct tb *tb;
>  
> -	if (!dmi_match(DMI_BOARD_VENDOR, "Apple Inc."))
> +	if (!x86_apple_machine)
>  		return NULL;
>  
>  	tb = tb_domain_alloc(nhi, sizeof(*tcm));
> diff --git a/include/linux/platform_data/x86/apple.h
> b/include/linux/platform_data/x86/apple.h
> new file mode 100644
> index 000000000000..079e816c3c21
> --- /dev/null
> +++ b/include/linux/platform_data/x86/apple.h
> @@ -0,0 +1,13 @@
> +#ifndef PLATFORM_DATA_X86_APPLE_H
> +#define PLATFORM_DATA_X86_APPLE_H
> +
> +#ifdef CONFIG_X86
> +/**
> + * x86_apple_machine - whether the machine is an x86 Apple Macintosh
> + */
> +extern bool x86_apple_machine;
> +#else
> +#define x86_apple_machine false
> +#endif
> +
> +#endif

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
