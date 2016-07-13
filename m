From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/3] acpi i2c: Initialize info.type from of_compatible
Date: Wed, 13 Jul 2016 14:20:57 +0200
Message-ID: <CAJZ5v0jz-E0RTBWVzO0Vc_jChUSeSseFeewi1UtsjLudoVP7Pw@mail.gmail.com>
References: <cover.1468409668.git.leonard.crestez@intel.com> <4b9ea75003d78406307cbb392150fb038b1b72f7.1468409668.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jarkko Nikula <jarkko.nikula@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	linux-spi <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Octavian Purdila <octavian.purdila@intel.com>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4b9ea75003d78406307cbb392150fb038b1b72f7.1468409668.git.leonard.crestez@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jul 13, 2016 at 1:53 PM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:
> When using devicetree i2c_board_info.type is set to the compatible
> string with the vendor prefix removed. For I2C devices described via
> ACPI the i2c_board_info.type string is set to the ACPI device name. When
> using ACPI and DT ids this string ends up something like "PRP0001:00".
>
> If the of_compatible property is present try to use that instead. This
> makes it easier to instantiate i2c drivers through ACPI with DT ids.
>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>

Looks good to me, but Mika needs to have a look at it too.

> ---
>  drivers/i2c/i2c-core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 74e5aea..62a1339 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -179,7 +179,13 @@ static int acpi_i2c_get_info(struct acpi_device *adev,
>
>         acpi_dev_free_resource_list(&resource_list);
>
> -       strlcpy(info->type, dev_name(&adev->dev), sizeof(info->type));
> +       if (adev->data.of_compatible) {
> +               ret = acpi_of_modalias(adev, info->type, sizeof(info->type));
> +               if (ret)
> +                       return -EINVAL;
> +       } else {
> +               strlcpy(info->type, dev_name(&adev->dev), sizeof(info->type));
> +       }
>
>         return 0;
>  }
> --


Thanks,
Rafael
