From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 3/3] spi: acpi: Initialize modalias from of_compatible
Date: Mon, 30 Jan 2017 10:41:33 +0100
Message-ID: <CAJZ5v0hAoOQN+d4iBSgSkkYHBOy-Pt9HLrKG4SjcQUB6Ya1bgA@mail.gmail.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1485187737-22414-1-git-send-email-dan@emutex.com> <1485187737-22414-4-git-send-email-dan@emutex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
To: "Dan O'Donovan" <dan@emutex.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485187737-22414-4-git-send-email-dan@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 23, 2017 at 5:08 PM, Dan O'Donovan <dan@emutex.com> wrote:
> From: Crestez Dan Leonard <leonard.crestez@intel.com>
>
> When using devicetree spi_device.modalias is set to the compatible
> string with the vendor prefix removed. For SPI devices described via
> ACPI the spi_device.modalias string is initialized by acpi_device_hid.
> When using ACPI and DT ids this string ends up something like "PRP0001".
>
> Change acpi_register_spi_device to use the of_compatible property if
> present. This makes it easier to instantiate spi drivers through ACPI
> with DT ids.
>
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> ---
>  drivers/spi/spi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 656dd3e..4b562e8 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1722,13 +1722,21 @@ static acpi_status acpi_register_spi_device(struct spi_master *master,
>                 return AE_OK;
>         }
>
> +       /*
> +        * Populate modalias from compatible property if available,
> +        * otherwise use native ACPI information
> +        */
> +       if ((!adev->data.of_compatible) ||
> +           acpi_of_modalias(adev, spi->modalias, sizeof(spi->modalias)))
> +               strlcpy(spi->modalias, acpi_device_hid(adev),
> +                       sizeof(spi->modalias));
> +
>         if (spi->irq < 0)
>                 spi->irq = acpi_dev_gpio_irq_get(adev, 0);
>
>         acpi_device_set_enumerated(adev);
>
>         adev->power.flags.ignore_parent = true;
> -       strlcpy(spi->modalias, acpi_device_hid(adev), sizeof(spi->modalias));
>         if (spi_add_device(spi)) {
>                 adev->power.flags.ignore_parent = false;
>                 dev_err(&master->dev, "failed to add SPI device %s from ACPI\n",
> --

Mark, any objections here?

Thanks,
Rafael
