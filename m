From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 1/3] acpi: Rename acpi_gsi_get_irq_type to
 acpi_dev_get_irq_type and export symbol
Date: Sun, 13 Dec 2015 02:30:24 +0200
Message-ID: <CAHp75Vc-KpVAqPwXQWxiLcMoDQ68TOydwfLT=xWHRfnsPtKf8w@mail.gmail.com>
References: <1449963004-8391-1-git-send-email-christophe-h.ricard@st.com>
	<1449963004-8391-2-git-send-email-christophe-h.ricard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Christophe Ricard <christophe-h.ricard@st.com>
To: Christophe Ricard <christophe.ricard@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1449963004-8391-2-git-send-email-christophe-h.ricard@st.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Dec 13, 2015 at 1:30 AM, Christophe Ricard
<christophe.ricard@gmail.com> wrote:
> acpi_gsi_get_irq_type could be use out of gsi purpose.
>
> Rename and make it available as a resource function.
>
> Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
> ---
>  drivers/acpi/gsi.c      | 21 +--------------------
>  drivers/acpi/resource.c | 26 ++++++++++++++++++++++++++
>  include/linux/acpi.h    |  1 +
>  3 files changed, 28 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> index fa4585a..ee9e0f2 100644
> --- a/drivers/acpi/gsi.c
> +++ b/drivers/acpi/gsi.c
> @@ -17,25 +17,6 @@ enum acpi_irq_model_id acpi_irq_model;
>
>  static struct fwnode_handle *acpi_gsi_domain_id;
>
> -static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
> -{
> -       switch (polarity) {
> -       case ACPI_ACTIVE_LOW:
> -               return trigger == ACPI_EDGE_SENSITIVE ?
> -                      IRQ_TYPE_EDGE_FALLING :
> -                      IRQ_TYPE_LEVEL_LOW;
> -       case ACPI_ACTIVE_HIGH:
> -               return trigger == ACPI_EDGE_SENSITIVE ?
> -                      IRQ_TYPE_EDGE_RISING :
> -                      IRQ_TYPE_LEVEL_HIGH;
> -       case ACPI_ACTIVE_BOTH:
> -               if (trigger == ACPI_EDGE_SENSITIVE)
> -                       return IRQ_TYPE_EDGE_BOTH;
> -       default:
> -               return IRQ_TYPE_NONE;
> -       }
> -}
> -
>  /**
>   * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
>   * @gsi: GSI IRQ number to map
> @@ -82,7 +63,7 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>
>         fwspec.fwnode = acpi_gsi_domain_id;
>         fwspec.param[0] = gsi;
> -       fwspec.param[1] = acpi_gsi_get_irq_type(trigger, polarity);
> +       fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
>         fwspec.param_count = 2;
>
>         return irq_create_fwspec_mapping(&fwspec);
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 15d22db..bd1b945 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -23,6 +23,7 @@
>  #include <linux/export.h>
>  #include <linux/ioport.h>
>  #include <linux/slab.h>
> +#include <linux/irq.h>
>
>  #ifdef CONFIG_X86
>  #define valid_IRQ(i) (((i) != 0) && ((i) != 2))
> @@ -333,6 +334,31 @@ unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable)
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_irq_flags);
>
> +/**
> + * acpi_dev_get_irq_type - Determine irq type.
> + * @triggering: Triggering type as provided by ACPI.
> + * @polarity: Interrupt polarity as provided by ACPI.
> + */
> +u32 acpi_dev_get_irq_type(u32 triggering, u32 polarity)
> +{
> +       switch (polarity) {
> +       case ACPI_ACTIVE_LOW:
> +               return triggering == ACPI_EDGE_SENSITIVE ?
> +                      IRQ_TYPE_EDGE_FALLING :
> +                      IRQ_TYPE_LEVEL_LOW;
> +       case ACPI_ACTIVE_HIGH:
> +               return triggering == ACPI_EDGE_SENSITIVE ?
> +                      IRQ_TYPE_EDGE_RISING :
> +                      IRQ_TYPE_LEVEL_HIGH;
> +       case ACPI_ACTIVE_BOTH:
> +               if (triggering == ACPI_EDGE_SENSITIVE)
> +                       return IRQ_TYPE_EDGE_BOTH;
> +       default:
> +               return IRQ_TYPE_NONE;
> +       }
> +}
> +EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
> +
>  static void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
>  {
>         res->start = gsi;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d863e12..162e0e7 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -299,6 +299,7 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
>  bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
>                                          struct resource_win *win);
>  unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable);
> +u32 acpi_dev_get_irq_type(u32 triggering, u32 polarity);

Commit message doesn't describe why you changed return type to u32. I
actually vote for pure C type since it doesn't seem like a direct
hardware value, though let me check rest or the patches.

>  bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>                                  struct resource *res);
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With Best Regards,
Andy Shevchenko
