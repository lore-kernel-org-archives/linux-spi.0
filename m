From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] acpi: Export acpi_of_modalias equiv of of_modalias_node
Date: Wed, 13 Jul 2016 14:19:47 +0200
Message-ID: <CAJZ5v0hPE+Qt3yL+Wnzv9CA0=vC1Qgquj7p2JrQpxTexLJPpLA@mail.gmail.com>
References: <cover.1468409668.git.leonard.crestez@intel.com> <fde8d7c9312a887553feab9877a33f01e5ceda47.1468409668.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fde8d7c9312a887553feab9877a33f01e5ceda47.1468409668.git.leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jul 13, 2016 at 1:53 PM, Crestez Dan Leonard
<leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> When using devicetree stuff like i2c_client.name or spi_device.modalias
> is initialized to the first DT compatible id with the vendor prefix
> stripped. Since some drivers rely on this try to replicate it when using
> ACPI with DT ids.
>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/acpi/bus.c      | 36 ++++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h |  1 +
>  2 files changed, 37 insertions(+)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index cb9558e..77a1a80 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -654,6 +654,42 @@ static bool acpi_of_match_device(struct acpi_device *adev,
>         return false;
>  }
>
> +/**
> + * acpi_of_modalias - Like of_modalias_node for ACPI with DT ids
> + * @adev:      ACPI device object to match.
> + * @outstr:    Pointer to buffer for result
> + * @outlen:    Length of outstr value
> + *
> + * If we have a DT id set outstr to the first compatible string with the vendor
> + * prefix stripped, just like of_modalias_node does for devicetree.

I'd say

"This is a counterpart of of_modalias_node() for struct acpi_device
objects.  If there is a compatible string for @adev, copy it to the
@outstr location with the vendor prefix stripped."

> + *
> + * Returns 0 on success or negative errno on failure.
> + */
> +int acpi_of_modalias(struct acpi_device *adev, char *outstr, size_t outlen)
> +{
> +       const union acpi_object *of_compatible;
> +       const union acpi_object *obj;
> +       const char *str, *chr;
> +
> +       of_compatible = adev->data.of_compatible;
> +       if (!of_compatible)
> +               return -ENODEV;
> +
> +       if (of_compatible->type == ACPI_TYPE_PACKAGE)
> +               obj = of_compatible->package.elements;
> +       else /* Must be ACPI_TYPE_STRING. */
> +               obj = of_compatible;
> +
> +       str = obj->string.pointer;
> +       chr = strchr(str, ',');
> +       if (chr)
> +               str = chr + 1;
> +       strlcpy(outstr, str, outlen);

I would prefer

strlcpy(outstr, chr ? chr + 1 : str, outlen);

ie. without the extra assignment.

> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_of_modalias);
> +
>  static bool __acpi_match_device_cls(const struct acpi_device_id *id,
>                                     struct acpi_hardware_id *hwid)
>  {
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 788c6c35..1d8ff0d 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -515,6 +515,7 @@ void acpi_bus_trim(struct acpi_device *start);
>  acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
>  int acpi_match_device_ids(struct acpi_device *device,
>                           const struct acpi_device_id *ids);
> +int acpi_of_modalias(struct acpi_device *adev, char *outstr, size_t outlen);
>  int acpi_create_dir(struct acpi_device *);
>  void acpi_remove_dir(struct acpi_device *);
>
> --

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
