From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH 2/3] acpi i2c: Initialize info.type from of_compatible
Date: Fri, 17 Jun 2016 15:07:39 +0300
Message-ID: <2ca8f355-bb28-8b68-7579-e26eaee3550a@intel.com>
References: <cover.1466014238.git.leonard.crestez@intel.com>
 <13cb5b7766b1b25a2bb61ce0053a38f6f440907b.1466014238.git.leonard.crestez@intel.com>
 <20160616081145.GU1740@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>,
	Jarkko Nikula <jarkko.nikula@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160616081145.GU1740@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 06/16/2016 11:11 AM, Mika Westerberg wrote:
> On Wed, Jun 15, 2016 at 09:30:28PM +0300, Crestez Dan Leonard wrote:
>> When using devicetree i2c_board_info.type is set to the compatible
>> string with the vendor prefix removed. For I2C devices described via
>> ACPI the i2c_board_info.type string is set to the ACPI device name. When
>> using ACPI and DT ids this string ends up something like "PRP0001:00".
>>
>> If the of_compatible property is present try to use that instead. This
>> makes it easier to instantiate i2c drivers through ACPI with DT ids.
> 
> Adding Jarkko -- he was the original author of I2C/SPI device naming in
> ACPI. Since this only affects devices with PRP0001 in their _HID/_CID,
> it should not break anything.

It's possible to have something like this:

            Name (_HID, "XXX1234")
            Name (_CID, "PRP0001")
            Name (_DSD, Package () {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package () {
                    Package () {"compatible", "vendor,x1234"},
                }
            })

With these patches the i2c device name changes from "XXX1234:00" to
"x1234". This would happen even if a driver matches the XXX1234 acpi ID.
It's not clear if anyone actually uses that or if this change would be
harmful.

It theory it would be possible to use of_compatible for naming only if
there are no other real IDs. I don't think it's worthwhile.
