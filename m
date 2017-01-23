From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 3/3] spi: acpi: Initialize modalias from of_compatible
Date: Mon, 23 Jan 2017 19:11:43 +0200
Message-ID: <CAHp75Vf0NaEFnxWPt9NAa5-jWMM091Y+Tg8D=Du0uECDVoWW4Q@mail.gmail.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1485187737-22414-1-git-send-email-dan@emutex.com> <1485187737-22414-4-git-send-email-dan@emutex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
To: "Dan O'Donovan" <dan@emutex.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1485187737-22414-4-git-send-email-dan@emutex.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 23, 2017 at 6:08 PM, Dan O'Donovan <dan@emutex.com> wrote:
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

> +       /*
> +        * Populate modalias from compatible property if available,
> +        * otherwise use native ACPI information
> +        */
> +       if ((!adev->data.of_compatible) ||
> +           acpi_of_modalias(adev, spi->modalias, sizeof(spi->modalias)))

Same comment as in patch 2.

> +               strlcpy(spi->modalias, acpi_device_hid(adev),
> +                       sizeof(spi->modalias));

Could this be one line?

-- 
With Best Regards,
Andy Shevchenko
