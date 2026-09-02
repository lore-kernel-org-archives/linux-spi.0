Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352B424646
	for <linux-spi@vger.kernel.org>; Wed,  2 Sep 2026 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380002; cv=none; b=pMQoTfB6S8kHcDPY7HlsXFyEbaWz/kYWde0p08vB2ekFoL532oEkSnkZJTBWEz2pkZMZLqDllctdA2iG17y6svKNr4GkR57GdERXBjqJqw2rh2+QPwSYw6jnzQJTqTtY5IJP3CUlwzAvo2YGImkMw9K7cHaRGtokxbV914mjiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380002; c=relaxed/simple;
	bh=gBn7jCjW9/1RWJD8NyT5yfQPPWsYf3qMJi0i9yM1c48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6Vq8JwJ2E9bTUHUX4lgIeYGMnu1L7dqBqrC4RbINCg2Peg6eLm0YgovbVzTCQGtxfdlc9IpI7E0mYtBnwLHVMkJ4FcRj6x6i3ZMwqCBm6uarqCwewJRwld7OABTCYHYJHXi7LZy15r/i1LFkFxLbXckWgEoIcujTAYs3wXqKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DUOZ8VQI; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DUOZ8VQI"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4b1ba286f6bso215323b6e.1
        for <linux-spi@vger.kernel.org>; Wed, 02 Sep 2026 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788379998; x=1788984798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LK9aotORi87rRhUj6UK1F5F8i5HbF9lJJNEH2vwmoh8=;
        b=DUOZ8VQICwiwhVLAY+mpuOzr91bQI56li5yAzKb3IGSV72GE3S5JBKdNCKdP9vmASq
         +ED7oykENRyJBSbekPGNIjpbtF72/y90RehMQ5SWF0g7VJ8+10d9NPHrwS3WfK9GWA3N
         A0yGuK2JLLqK6cV3fnEw+uKqTxmiuiCdzSI+3BTLNHQQyvhBzd4ODrCBWQDgPPOYikvW
         3kvlM4JGJlVVm7uN2TcLN6+Z88d8Zt+Pmyn6S0abiz/YpCJ0lcIDHZdjrryEOLJ9kbny
         j36ghvqwGWlIP/KShv+/iT1Rh4LuhIoT8MbckAQSmwop9TMDON4WINGrFuIBGn4OjX4B
         EAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788379998; x=1788984798;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LK9aotORi87rRhUj6UK1F5F8i5HbF9lJJNEH2vwmoh8=;
        b=CxVo1b/skHLDaMqRrkBKG+hde/rJaCPITt/yoklfe6zrRsXBhkXXFx42/Yu+pFEem8
         2zIzCKNrOnX9ssEhdy0v+NDQrFxnHEV+e1nl30wptXkFumYwL3UJWVw0GWW1G9sh5y6L
         oj8ZgLr4q4XUfFNmwuNN0wgGAdtKw/2Zu7YMUkB8m8PFAGG/Ho3xv7H48JozgeTLp0V1
         JLqJUVSWymT8Jo/PiroelbxNn+CCwNPj3Uyx4nF1ouAzsXxOcvZ/mvM37MCKG2uy06cQ
         nU53MX9e+JnYBiISzGbycHWtlnOF/U0eMZDxRjLcm23iAaj9FXlkZwvV7ghDWy4u1bjW
         MW8w==
X-Forwarded-Encrypted: i=1; AHgh+Ro+yChzvIMG3kvfaukkCzgbOT2ZYtwN748JEGBuPgtTl5En6WUNvTwvkBCXpQHUs1ydDjg60SBGDws=@vger.kernel.org
X-Gm-Message-State: AFuF++m0NzsD7JX/3HSRKATZAliFHDIhlsXhsNg8RzF7kg7DBgQi/yen
	aePYPZQ6xihEFVSyVN6BIPb3GD32l1lLJ9zIxKZ043czt4si63ri+cwXqSW/3hC8iIs=
X-Gm-Gg: AR+sD11FERUX2YHRe8EEilzdLNefdNzoko2xb674P/BW3mVSlx+pvCpK1HXXyrfx/FY
	o/BBIvzB/pMWHCxm5Gp2j8ZrTOMHpMfOI7mfPVuX73deEcoXAifTis4JR9nU/YbXJW0f2398VEG
	Ip5rmOlDBjJ+y48gdnbM5Tc0IPqv/CP/IOV9JXdNFLMDuWqEjn4+PF+Qgc7jFwEA9A+leI60b/k
	7JYdjuYf8Iftv2956BY76kGO/VCaPH5gsGl0KcnpUviYK3XiNDGSa/B0sWif2yWvHHJ5jsTt7/X
	7vy4g/aILjRqKwWgGE5bRy+PnZSAR4zkZuV8GG1xBk1ond7ZdHN8KU/xOTZAgU0b8FjIwAK9S0J
	AAQ84CVigUndtJbWiFxuNPXnO0Eg/VdVgtgifemTelSnVVL7htPksAbJ2GjyHb1qZG1pCeMUUlE
	pXy3NSiaLFi+NJaPWjoDlxuVDfUzPm+TCTXZSqY/8fbIbKfTydyaj4vhIOklN0+VLK9fj7sixyN
	+ZKKvAj+5OWIDdMSB3FPJROlPt32Uwa/CQcI/Yu
X-Received: by 2002:a05:6808:f89:b0:496:976:acad with SMTP id 5614622812f47-4b7d9e50996mr1248833b6e.1.1788379997955;
        Wed, 02 Sep 2026 13:13:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:518a:9db8:615b:293f? ([2600:8803:e7e4:500:518a:9db8:615b:293f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b698a38f62sm2719950b6e.7.2026.09.02.13.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 13:13:17 -0700 (PDT)
Message-ID: <33e466d8-962b-44a3-bc32-7afb00821428@baylibre.com>
Date: Wed, 2 Sep 2026 15:13:16 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] spi: support simultaneous assertion of multiple CS
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 michael.hennerich@analog.com, broonie@kernel.org,
 marcelo.schmitt1@gmail.com, andriy.shevchenko@intel.com
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <e8870b405f29cc89439701d1fcc7e88781aaab22.1786973376.git.Jonathan.Santos@analog.com>
 <e2016946-83e8-46f5-975d-634a219417e7@baylibre.com>
 <aojo2zHCrBPmt9S/@JSANTO12-L01.ad.analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aojo2zHCrBPmt9S/@JSANTO12-L01.ad.analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/21/26 7:10 PM, Jonathan Santos wrote:
> On 08/18, David Lechner wrote:
>> On 8/17/26 6:32 PM, Jonathan Santos wrote:
>>> Some SPI controllers allow multiple CS lines to be toggled at the same
>>> time. The existing code always used CS index 0 when tracking the last
>>> active CS in spi_set_cs(), and unconditionally set cs_index_mask to
>>> BIT(0) when parsing DT, both forcing the single CS usage.
>>>
>>> Modify spi_set_cs() to iterate last_cs[] using each logical CS index
>>> instead of always reading index 0. Modify of_spi_parse_dt() to build
>>> cs_index_mask from all parsed CS entries rather than hardcoding BIT(0),
>>> so the controller correctly identifies which CS lines belong to a device
>>> when asserting them simultaneously.
>>>
>>> Board info, ACPI, and ancillary device paths are not updated here.
>>> Board info would require an API change to accept an array of CS values
>>> and is left for a follow-up when we have a use case for this. Ancillary
>>> devices are by design single-CS, so multi-CS is not a current use case for
>>> them. ACPI represents the CS as a 64-bit integer with no established
>>> convention for encoding multiple CS indices yet, so any extension there
>>> would require a separate specification effort.
>>>
>>> Acked-by: Nuno Sá <nuno.sa@analog.com>
>>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
>>> ---
>>> Changes in v3:
>>> * None.
>>>
>>> Changes in v2:
>>> * Include Summary describind why the other SPI paths were not addressed
>>>   here.
>>> ---
>>>  drivers/spi/spi.c | 9 +++++----
>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>>> index d9e6b4b87c89..55fb96fea243 100644
>>> --- a/drivers/spi/spi.c
>>> +++ b/drivers/spi/spi.c
>>> @@ -1090,7 +1090,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>>>  	spi->controller->last_cs_index_mask = spi->cs_index_mask;
>>>  	for (idx = 0; idx < SPI_DEVICE_CS_CNT_MAX; idx++) {
>>>  		if (enable && idx < spi->num_chipselect)
>>> -			spi->controller->last_cs[idx] = spi_get_chipselect(spi, 0);
>>> +			spi->controller->last_cs[idx] = spi_get_chipselect(spi, idx);
>>>  		else
>>>  			spi->controller->last_cs[idx] = SPI_INVALID_CS;
>>>  	}
>>> @@ -2594,10 +2594,11 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>>  		spi_set_chipselect(spi, idx, cs[idx]);
>>>  
>>>  	/*
>>> -	 * By default spi->chip_select[0] will hold the physical CS number,
>>> -	 * so set bit 0 in spi->cs_index_mask.
>>> +	 * Set cs_index_mask to indicate which logical CS indices are active.
>>> +	 * Each bit corresponds to a logical CS index in the spi->chip_select array.
>>>  	 */
>>> -	spi->cs_index_mask = BIT(0);
>>> +	for (idx = 0; idx < rc; idx++)
>>> +		spi->cs_index_mask |= BIT(idx);
>>>  
>>>  	/* Device speed */
>>>  	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
>>
>> I have the same concern that sashiko calls out here.
>>
>> Existing users of multi-cs (not including spi-mem) follow the pattern
>> that a SPI device gets registered with the CS at index 0 and they later
>> create an auxiliary using the additional CS. This would cause the main
>> device to now assert both CS. Not what we want to happen.
> 
> Indeed, enalbing all CS for those cases would cause problems (like you
> describe below). AD4080 would be an example.
> 
> The devicetree property seems to be a good ideia to fix this and simpler
> to execute, but the composite device is interesting.
> 
>>
>> If I understood (and remember) the previous explanations of this series
>> correctly, we have a different case for this one.
>>
>> We want a main device that acts as a single composite device that asserts
>> all 4 CS at the same time. Then we also need 4 auxiliary devices that
>> only assert one CS at a time for configuring the individual chips.
>>
>> So it seems to me like we need a new DT property or some way to be able to
>> tell the difference to decide whether we just use the first CS here or all
>> of them.
>>
>> Perhaps another possibility would be to leave this code the way it is and
>> do it this way instead:
>> - The SPI device passed to the IIO driver is just the first chip (one CS)
>> - The IIO driver then registers auxiliary drivers for the other 3 chips
>>   (also 1 CS each)
>> - These 4 devices will be used individual to handle configuration.
>> - The IIO driver registers a separate composite device that has the
>>   multiple lanes and and multiple CS. Whether this using the same
>>   auxiliary mechanism with additional parameters or something new
>>   probably doesn't matter too much.
>> - In this way of doing things, it would not make sense to have the
>>   spi-rx-bus-width property in the devcietree since as far as the
>>   devicetree is concerned, these are more-or-less 4 separate devices
>>   (from the SPI point of view).  Instead, this new composite device
>>   registration function would be the one setting the number of lanes
>>   based on the number of chip selects.
>>
> 
> My initial idea was to use the main device as the "composite" because it
> holds the hw description, therefore the multi-lane would be handled by
> the existing flow (that's why the spi-rx-bus-width property was
> mandatory). This way each ancillary device would take the lane index
> from the main device. Using the main + 3 ancillaries for individual
> access and the new composite for simultaneous is a great alternative,
> but removing the spi-rx-bus-width kind of excludes the information that
> we are using multiple lanes for this device. Unless we document that 

I don't think it hides it. How the chip handles multi-lane is described
by the compatible string itself. So it will be up to the IIO driver to
call the composite device creation function with the appropriate parameters
to tell it that in this case we need to assert all 4 CS in order to get
a 4-lane device. I don't think we need any extra devicetree description
for this.

> "number of CS = number of lanes" on multiple-data-lanes.rst, the 
> assumption is:
> 
> spi-rx-bus-width = <1>
> spi-rx-lane-map = <1>
> 
> Also, it would make more sense to take the lane description from the
> main device described in the DT considering cases like non-default
> mapping. Or at least take it into consideration.

I think if we put the CS lines in a logical order, we don't need any
mapping. For example:

CS | Lane
---+-----
0  |  0
1  |  2
2  |  1
3  |  3

Would just be:

reg = <0>, <2>, <1>, <3>;

	
