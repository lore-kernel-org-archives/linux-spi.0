From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 3/6] ACPI / property: Don't evaluate objects for devices w/o handle
Date: Sat, 15 Jul 2017 00:04:19 +0200
Message-ID: <24196256.m9Mta9fufR@aspire.rjw.lan>
References: <cover.1499983092.git.lukas@wunner.de> <5bb94a3e70e38b5a40933878dc52d8b5deeb6ae6.1499983092.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5bb94a3e70e38b5a40933878dc52d8b5deeb6ae6.1499983092.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Friday, July 14, 2017 12:36:19 AM Lukas Wunner wrote:
> Fabricated devices such as LNXPWRBN lack a handle, causing evaluation
> of _CCA and _DSD to always fail with AE_BAD_PARAMETER.  While that is
> merely a (negligible) waste of processing power, evaluating a _DSM for
> them (such as Apple's device properties _DSM which we're about to add)
> results in an ugly error:
> 
>     ACPI: \: failed to evaluate _DSM (0x1001)
> 
> Avoid by not evaluating _DSD and the upcoming _DSM for devices without
> handle.
> 
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/acpi/property.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 9364398204e9..27a9294c843c 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -338,6 +338,9 @@ void acpi_init_properties(struct acpi_device *adev)
>  
>  	INIT_LIST_HEAD(&adev->data.subnodes);
>  
> +	if (!adev->handle)
> +		return;
> +
>  	/*
>  	 * Check if ACPI_DT_NAMESPACE_HID is present and inthat case we fill in
>  	 * Device Tree compatible properties for this device.
> 

This can go in separately AFAICS.

Thanks,
Rafael

