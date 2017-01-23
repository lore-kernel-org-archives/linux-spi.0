From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 2/3] i2c: acpi: Initialize info.type from of_compatible
Date: Mon, 23 Jan 2017 19:10:13 +0200
Message-ID: <CAHp75VdzGLem7c6Ur9Bj1UtJ56XdEii7SgRbe5yT5hew8yQO0g@mail.gmail.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1485187737-22414-1-git-send-email-dan@emutex.com> <1485187737-22414-3-git-send-email-dan@emutex.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1485187737-22414-3-git-send-email-dan@emutex.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 23, 2017 at 6:08 PM, Dan O'Donovan <dan@emutex.com> wrote:
> From: Crestez Dan Leonard <leonard.crestez@intel.com>
>
> When using devicetree i2c_board_info.type is set to the compatible
> string with the vendor prefix removed. For I2C devices described via
> ACPI the i2c_board_info.type string is set to the ACPI device name. When
> using ACPI and DT ids this string ends up something like "PRP0001:00".
>
> If the of_compatible property is present try to use that instead. This
> makes it easier to instantiate i2c drivers through ACPI with DT ids.

> -       strlcpy(info->type, dev_name(&adev->dev), sizeof(info->type));
> +       /*
> +        * Populate modalias from compatible property if available,
> +        * otherwise use native ACPI information
> +        */
> +       if ((!adev->data.of_compatible) ||
> +           acpi_of_modalias(adev, info->type, sizeof(info->type)))

Redundant parens in lvalue. After removing them is it possible to use
one line for it?

> +               strlcpy(info->type, dev_name(&adev->dev), sizeof(info->type));

-- 
With Best Regards,
Andy Shevchenko
