From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 3/3] spi: acpi: Initialize modalias from of_compatible
Date: Fri, 27 Jan 2017 15:43:27 +0200
Message-ID: <CAHp75VeLy-oTUjgQNATt+gXhCVh-ATDswetLZpE3_7Z-wrF0qw@mail.gmail.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
 <1485187737-22414-1-git-send-email-dan@emutex.com> <1485187737-22414-4-git-send-email-dan@emutex.com>
 <CAHp75Vf0NaEFnxWPt9NAa5-jWMM091Y+Tg8D=Du0uECDVoWW4Q@mail.gmail.com> <1114c19b-5398-799e-8302-ff87adf9d8a3@emutex.com>
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
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1114c19b-5398-799e-8302-ff87adf9d8a3@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 27, 2017 at 12:35 PM, Dan O'Donovan <dan@emutex.com> wrote:
> On 01/23/2017 05:11 PM, Andy Shevchenko wrote:
>> On Mon, Jan 23, 2017 at 6:08 PM, Dan O'Donovan <dan@emutex.com> wrote:

>>> +               strlcpy(spi->modalias, acpi_device_hid(adev),
>>> +                       sizeof(spi->modalias));
>> Could this be one line?
> I couldn't see a way to reduce this to one line without exceeding 80
> chars or adding another line somewhere else, so I'll leave this one as
> it is if that's ok.

80 characters per line is not carved in stone. How many do you have
over? 3 like "s);"?

-- 
With Best Regards,
Andy Shevchenko
