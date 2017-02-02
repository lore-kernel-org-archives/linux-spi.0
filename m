From: Dan O'Donovan <dan@emutex.com>
Subject: Re: [PATCH v4 1/3] ACPI / bus: Export acpi_of_modalias equiv of
 of_modalias_node
Date: Thu, 2 Feb 2017 13:30:21 +0000
Message-ID: <dc44d52c-12f7-46f2-0594-b487edacd8a1@emutex.com>
References: <1485187737-22414-1-git-send-email-dan@emutex.com>
 <1485523815-9629-1-git-send-email-dan@emutex.com>
 <1485523815-9629-2-git-send-email-dan@emutex.com>
 <2538517.VnXrn8zi1x@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jarkko Nikula <jarkko.nikula@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2538517.VnXrn8zi1x@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 02/02/2017 11:41 AM, Rafael J. Wysocki wrote:
> On Friday, January 27, 2017 01:30:13 PM Dan O'Donovan wrote:
>> From: Crestez Dan Leonard <leonard.crestez@intel.com>
>>
>> When using devicetree stuff like i2c_client.name or spi_device.modalias
>> is initialized to the first DT compatible id with the vendor prefix
>> stripped. Since some drivers rely on this try to replicate it when using
>> ACPI with DT ids.
>>
>> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
>> Signed-off-by: Dan O'Donovan <dan@emutex.com>
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> First off, the original author of the patch doesn't seem to be reachable under
> the Intel address any more, so his S-o-b is meaningless and it shouldn't be
> there.  In such cases you can send the patch as From: you and give a credit
> to the original author in the changelog.
>
> Second, as Mark said ->
>
>> ---
>>  drivers/acpi/bus.c      | 35 +++++++++++++++++++++++++++++++++++
>>  include/acpi/acpi_bus.h |  1 +
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 95855cb..8b9657f 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -677,6 +677,41 @@ static bool acpi_of_match_device(struct acpi_device *adev,
>>  	return false;
>>  }
>>  
>> +/**
>> + * acpi_of_modalias - Like of_modalias_node for ACPI with DT ids
>> + * @adev:	ACPI device object to match.
>> + * @outstr:	Pointer to buffer for result
>> + * @outlen:	Length of outstr value
>> + *
>> + * This is a counterpart of of_modalias_node() for struct acpi_device
>> + * objects. If there is a compatible string for @adev, copy it to the
>> + * @outstr location with the vendor prefix stripped.
>> + *
>> + * Returns 0 on success or negative errno on failure.
>> + */
>> +int acpi_of_modalias(struct acpi_device *adev, char *outstr, size_t outlen)
> -> this could be a bool function and you could provide something like
> acpi_set_modalias() doing the entire
>
> if (!acpi_of_modalias(adev, outstr, outlen))
>                strlcpy(outstr, dev_name(&adev->dev), outlen);
>
> thing, so that its users don't have to duplicate this conditional.
>
> And then acpi_of_modalias() could be static and the only thing to export
> would be acpi_set_modalias().
Thanks Mark and Rafael for the latest feedback.  Those suggestions make
sense.  I'll send an updated patch-set soon.
>
>> +{
>> +	const union acpi_object *of_compatible;
>> +	const union acpi_object *obj;
>> +	const char *str, *chr;
>> +
>> +	of_compatible = adev->data.of_compatible;
>> +	if (!of_compatible)
>> +		return -ENODEV;
>> +
>> +	if (of_compatible->type == ACPI_TYPE_PACKAGE)
>> +		obj = of_compatible->package.elements;
>> +	else /* Must be ACPI_TYPE_STRING. */
>> +		obj = of_compatible;
>> +
>> +	str = obj->string.pointer;
>> +	chr = strchr(str, ',');
>> +	strlcpy(outstr, chr ? chr + 1 : str, outlen);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_of_modalias);
>> +
>>  static bool __acpi_match_device_cls(const struct acpi_device_id *id,
>>  				    struct acpi_hardware_id *hwid)
>>  {
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index 4242c31..351b4a4 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -522,6 +522,7 @@ void acpi_bus_trim(struct acpi_device *start);
>>  acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
>>  int acpi_match_device_ids(struct acpi_device *device,
>>  			  const struct acpi_device_id *ids);
>> +int acpi_of_modalias(struct acpi_device *adev, char *outstr, size_t outlen);
>>  int acpi_create_dir(struct acpi_device *);
>>  void acpi_remove_dir(struct acpi_device *);
> Thanks,
> Rafael
>
>

