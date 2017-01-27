From: Dan O'Donovan <dan@emutex.com>
Subject: Re: [PATCH v3 3/3] spi: acpi: Initialize modalias from of_compatible
Date: Fri, 27 Jan 2017 10:35:32 +0000
Message-ID: <1114c19b-5398-799e-8302-ff87adf9d8a3@emutex.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1485187737-22414-1-git-send-email-dan@emutex.com>
 <1485187737-22414-4-git-send-email-dan@emutex.com>
 <CAHp75Vf0NaEFnxWPt9NAa5-jWMM091Y+Tg8D=Du0uECDVoWW4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vf0NaEFnxWPt9NAa5-jWMM091Y+Tg8D=Du0uECDVoWW4Q@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 01/23/2017 05:11 PM, Andy Shevchenko wrote:
> On Mon, Jan 23, 2017 at 6:08 PM, Dan O'Donovan <dan@emutex.com> wrote:
>> From: Crestez Dan Leonard <leonard.crestez@intel.com>
>>
>> When using devicetree spi_device.modalias is set to the compatible
>> string with the vendor prefix removed. For SPI devices described via
>> ACPI the spi_device.modalias string is initialized by acpi_device_hid.
>> When using ACPI and DT ids this string ends up something like "PRP0001".
>>
>> Change acpi_register_spi_device to use the of_compatible property if
>> present. This makes it easier to instantiate spi drivers through ACPI
>> with DT ids.
>> +       /*
>> +        * Populate modalias from compatible property if available,
>> +        * otherwise use native ACPI information
>> +        */
>> +       if ((!adev->data.of_compatible) ||
>> +           acpi_of_modalias(adev, spi->modalias, sizeof(spi->modalias)))
> Same comment as in patch 2.
Thanks for the feedback, Andy.  The check on of_compatible is redundant,
because its repeated in acpi_of_modalias(), so I'll remove it here (and
in patch 2) to reduce this to one line.  v4 on the way.
>> +               strlcpy(spi->modalias, acpi_device_hid(adev),
>> +                       sizeof(spi->modalias));
> Could this be one line?
I couldn't see a way to reduce this to one line without exceeding 80
chars or adding another line somewhere else, so I'll leave this one as
it is if that's ok.
