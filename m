From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [alsa-devel] [PATCHv3 1/3] ACPI: Provide struct acpi_device stub
 for !CONFIG_ACPI builds
Date: Thu, 14 Nov 2013 13:14:17 +0200
Message-ID: <5284B089.1020209@linux.intel.com>
References: <1383309356-25430-1-git-send-email-jarkko.nikula@linux.intel.com> <1384419661-28293-1-git-send-email-jarkko.nikula@linux.intel.com> <1384419661-28293-2-git-send-email-jarkko.nikula@linux.intel.com> <s5hvbzv9u6g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <s5hvbzv9u6g.wl%tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 11/14/2013 12:03 PM, Takashi Iwai wrote:
> At Thu, 14 Nov 2013 11:00:59 +0200,
> Jarkko Nikula wrote:
>> We have a few cases where we want to access struct device dev field in
>> struct acpi_device from generic code that is build also without CONFIG_ACPI.
>>
>> Provide here a minimal struct acpi_device stub that allows to build such a
>> code without adding new #ifdef CONFIG_ACPI churn. This should not increase
>> section sizes if code is protected by ACPI_COMPANION() runtime checks as
>> those will be optimized out by later compiler stages in case CONFIG_ACPI is
>> not set.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> ---
>> Rafael, instead of this we could also have an accessor but adev->dev looked
>> better in actual code and size vmlinux didn't change for x86_64_defconfig
>> with CONFIG_ACPI is not set nor for omap2plus_defconfig.
> This looks too hackish, IMO.  Defining a different dummy struct often
> gives more headaches.  Thinking of the potential risk by misuses, it'd
> be simpler and safer to define a macro like acpi_dev_name() instead.
>
> BTW, is linux/device.h already included in !CONFIG_ACPI case?
>
It is included unconditionally in include/linux/acpi.h.

Your acpi_dev_name() proposal may be good enough for now as adev->dev 
access in generic code (now under CONFIG_ACPI) seems to be anyway around 
dev_name, using only pointer to struct acpi_device or has more things 
that prevents immediate #ifdef CONFIG_ACPI removal there.

But one problem at time. I'll cook a version with acpi_dev_name.

-- 
Jarkko
