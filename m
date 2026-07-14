Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994747DD6B
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041335; cv=none; b=E3mRQkSdjHoAetMBGZXwivc+fuWQdUPgjWTLIPzzbPfiOY3RKcvVMvpyEMh2Tz6WmO0IGW1Xpq83NKqrR06kNyrV2tWhdMZdVVixToGr/nZnjWzUEymmsoL43LdIVp5khyNK41gl0lxs5LioWZnFYhkVTSpHe6Xqeb5rkI5HFjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041335; c=relaxed/simple;
	bh=CzPwwTGtwKKlUoMuy9C+LBMvDHA7sdhjrS9JB/w/ric=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxtyiStnQ34TiDyLUYVHfwKjQCmv3OwQrrQz0paXfOHhinCWf5E7SYYURR3TG7F6Z9p9q1OoLWm772+tlq+ej3em7O7KzXOGFSZbvVDX8LUguHTWPV7ovE8D92QIxrJXaJi/byy02El/pyreHXcSVCPsYDxPOkBnpiXZvfGwOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Vry9ee41; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Vry9ee41"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7eb6573bd52so2424324a34.3
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784041331; x=1784646131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UId+sMQ0S31GDuUH4mmvayQsO9inN0IgYMoufwbOOhg=;
        b=Vry9ee41K6Jhi5wQDQ19INlEdgVqAxHdh8LwtSlVeejNj1+0sWJDiR4Vk6oZjUoOq6
         jM3Kkt7UJogHzuSDdHZ5X2gwneXx/9+LXAHmxQGIwxSTbxQTuNMev1PZ2jobCsIOpdA7
         E/jdUI/Vl4sv12RWQg3O06y3w1Tgk2HJZwxTIQ/Ak506T6Eho8Qz5N5ebM7vC6iNaqQj
         +MLV2OdX+xdh2jg2TktS1A9ei2B90Q7dfmTEgfQTjvQgbFaL7TpartE3Qg7sNfB1ETkQ
         HdGagyw7uE11/eK5t2IbGWgvLGr9iHc049JSTEvhkHX4c9rh8iZITOEt1OscfeIZAGEK
         SZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784041331; x=1784646131;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UId+sMQ0S31GDuUH4mmvayQsO9inN0IgYMoufwbOOhg=;
        b=CkNnSG6LKvIfU3yn3mMkeU1/rFBUJo9LQ2v10P3hZV3CZ3OB83VbXFS4OOoHVp+/O2
         knBCTZm2BvoVlbgTS/PfUpmH0wF8oyhFnBTkLMp6Sj9CbivL+ekSbs+dkHtNVIIifSLe
         nOtN78LglwhrkfzwShEKLiyxA39BhNcqYCyEH5HvROptHDTvucL+R7n563lhlzajMxFS
         edkBB8ufs+bu9amf+CFk0B8UYxEDDNJ8Y2yKVwcRKquLWNrefYrrrVDFRrbAtV/rmDQ/
         B3E57hjlPIh7m/pghNiaemGkJ++bj0QKpO4pnQGwoVoHKAXoAu8cM4quguuMF0LmBfQu
         ReKA==
X-Gm-Message-State: AOJu0YyMxGlTBvH75aNdPKUt9jVc+XAe8cMdvyxedPYpfVJXR7L/2Vxj
	qsI7UyYB+ZABNtiVxVSvPPKerOsgN1fxVBrFDnxlTSxOJuxD23UhticTMmtdQ588avk=
X-Gm-Gg: AfdE7clRp8CHl+kY3TtozFXHDW4qCFlRd4m3ZdtIM9dvtkrnW60UjGSdZ/VuLtJBq6D
	JL8gbFi0Y6GnbUI0YxHbvAs0hwFVloPxOikm8uFgHFazjSoRl4vSQnJ419mbmVLmKY4G7VlWii4
	nyVcJdehg4d3yy9/m52vgc+QRsvRa2OJCgdRioUuSX9RsBS0gUe2C5BoqzRKb6K97dcZ71/iOAA
	wFz8yWcdyb2OCMcqXAy8a3hr1THHj5pbYzgkvxNHBu8dV548EuVRYaKVPK1EWh6NwJIXs+b33vl
	6CJoOLKUe9IgZG67Cebjzw0px+GINkh6LbyUJr+7kd6nTWMGX1os2kr8HDM1Ds66GwuxfUxrt0X
	MlOqqFqunwhLnGGbPLVZfRS2lw2NyFiMs3karXFpo8nIo8GEKNNGV8XHXzZddToxkE00OYkQDML
	wklUtXvmuZLQ1L4LQ728RwCPyUU2lxRZSdfWWwGOqHATTix9dFE+gGPUsO6t1BqMM=
X-Received: by 2002:a05:6830:67db:b0:7e5:f957:a61f with SMTP id 46e09a7af769-7ec4ab3eb13mr1505503a34.18.1784041330446;
        Tue, 14 Jul 2026 08:02:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:280e:69fd:7612:d5a9? ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb262da7sm15225137a34.17.2026.07.14.08.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 08:02:09 -0700 (PDT)
Message-ID: <6576af52-19d1-4b79-879e-bbd09df40a7a@baylibre.com>
Date: Tue, 14 Jul 2026 10:02:08 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] spi: add multi-CS and per-transfer lane mask support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, michael.hennerich@analog.com, broonie@kernel.org,
 jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, andy@kernel.org
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <eplbtsrc2rojtpuxdtcy7vp63fhzl4ckb5cobs45y6fmcjy3wj@g3ccws2qeg2d>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <eplbtsrc2rojtpuxdtcy7vp63fhzl4ckb5cobs45y6fmcjy3wj@g3ccws2qeg2d>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/14/26 5:29 AM, Nuno Sá wrote:
> On Tue, Jul 14, 2026 at 02:55:31AM -0300, Jonathan Santos wrote:
>> This series introduces two SPI subsystem features: per-transfer chipselect
>> masks and multi-CS device support. Together they address the multi-device
>> setup described in [1] and the limitation noted in [2], where no SPI
>> controller completely handles logical chip selects beyond the first one.
>>
>> The first part of the set addresses multi-CS support. Some SPI controllers
>> can assert multiple chip selects simultaneously, but the existing code
>> hardcoded CS index 0 in both spi_set_cs() and of_spi_parse_dt(),
>> preventing this from working.
>>
>> The second part addresses dynamic lane selection for STRIPE mode. In
>> SPI_MULTI_LANE_MODE_STRIPE, all available lanes are currently always
>> active. Some peripherals need to select a different subset of rx/tx lanes
>> per transfer. New fields are added to the spi_transfer struct to allow
>> drivers to specify which lanes to use for each transfer. The documentation
>> is also updated to describe this new behavior.
>>
>> [1]: https://lore.kernel.org/linux-iio/af0EGv172ZMl%2F6N5@JSANTO12-L01.ad.analog.com/T/#t
>> [2]: https://lore.kernel.org/all/20250915183725.219473-1-jonas.gorski@gmail.com/
>>
>> Jonathan Santos (6):
>>   spi: support simultaneous assertion of multiple CS
>>   spi: add per-transfer CS mask
>>   spi: spi-engine-ex: Add support for multi-CS devices
>>   spi: Documentation: multiple-data-lanes: describe rx and tx lane mask
>>   spi: add rx and tx lane mask to spi_transfer struct
>>   spi: axi-spi-engine: add support for dynamic multi-lane selection
> 
> It would be nice to include an actual user for this in the series.

Agree.

For context, here is the scenario from [1] (with arrow directions fixed):

+---------------+                                                 
|     ADC 0     |                                                 
|               |                                                 
|        SYNC_IN|<--+---------------------------+                 
|          DRDY0|---|------------------------+  |                 
|               |   |                        |  |   +------------+
|          SCLK0|<--|------+                 |  |   |    HOST    |
|           SDI0|<--|------|--+              |  |   |            |
|            CS0|<--|------|--|-----------+  |  +---|ADC_SYNC    |
|          DOUT0|---|------|--|--------+  |  |      |            |
|               |   |      |  |        |  |  |      |            |
+---------------+   |      +--|--------|--|--|------|SCLK        |
                    |      |  +--------|--|--|------|MOSI        |
+---------------+   |      |  |        |  |  |      |            |
|     ADC 1     |   |      |  |        |  |  |      |            |
|               |   |      |  |        |  |  +----->|DRDY0       |
|        SYNC_IN|<--+      |  |        |  +---------|CS0         |
|          DRDY1|---|------|--|----+   +----------->|MISO0       |
|               |   |      |  |    |                |            |
|          SCLK1|<--|------+  |    |                |            |
|           SDI1|<--|------|--+    +--------------->|DRDY1       |
|            CS1|<--|------|--|---------------------|CS1         |
|          DOUT1|---|------|--|-------------------->|MISO1       |
|               |   |      |  |                     |            |
+---------------+   |      |  |                     | .          |
                    |      |  |                     | .          |
       ...          |      |  |                     | .          |
                    |      |  |                     |            |
+---------------+   |      |  |            +------->|DRDYN       |
|     ADC N     |   |      |  |            | +------|CSN         |
|               |   |      |  |            | | +--->|MISON       |
|        SYNC_IN|<--+      |  |            | | |    |            |
|          DRDYN|----------|--|------------+ | |    +------------+
|               |          |  |              | |                  
|          SCLKN|<---------+  |              | |                  
|           SDIN|<------------+              | |                  
|            CSN|<---------------------------+ |                  
|          DOUTN|------------------------------+                  
|               |                                                 
+---------------+  


And the proposed DT from the discussion in [1].

spi {
    #address-cells = <1>;
    #size-cells = <0>;

    adc@0 {
	compatible = "adi,adaq7768-1";
	reg = <0>, <1>, <2>, <3>;
        
        spi-rx-bus-width = <1>, <1>, <1>, <1>;

	/* other properties */
    };
};

As a refresher, the idea is that this is considered to be one big ADC
with more channels (for simultaneous sampling) even though it is
physically multiple chips. 

Currently, this series is treating CS selection and mutli-lane SPI line
selection as completely independent. However, clearly certain spi-rx-bus
lines are tightly coupled with certain CS lines.

To reflect that (and easier to use in peripheral drivers), I think we
could bake this correlation into the SPI core code.

So struct spi_device.rx_lane_map would become a 2-D array where the
first index is the logical CS (following the pattern of .chip_select)
and the second index is the existing one for the data lane.

The trivial implementation would be to assume that reg and spi-rx-bus-width
have the same length and there is just a 1-to-1 correspondence (first data
lane is associated with first CS, and so on).

And we could add a new DT property for more complex mappings (multiple
data lanes per CS or wires not connected in logical order). We probably
don't need to do that right now though if there are no expected users
at the moment.

Then we would only need to add the CS selection to struct spi_transfer
and the controller driver would just use the map to pick the correct
data lanes based on other parameters as it does now. (So no need to
add .rx_lane_mask to struct spi_transfer.)

This way, the ADC (SPI peripheral driver) can set 1 CS in order to
configure individual chips and then set all CS to read sample data.
And all of the data lane selection is all handled transparently between
the core SPI code and the SPI controller driver.

(And obviously everything above applies to tx too, I just wrote rx
everywhere to keep it shorter.)

> 
> - Nuno Sá
> 
>>
>>  Documentation/spi/multiple-data-lanes.rst |  30 ++++++
>>  drivers/spi/spi-axi-spi-engine.c          | 106 +++++++++++++++++-----
>>  drivers/spi/spi.c                         |  97 +++++++++++++++++---
>>  include/linux/spi/spi.h                   |  12 +++
>>  4 files changed, 206 insertions(+), 39 deletions(-)
>>
>>
>> base-commit: 093239070573637ad2b4cb56abc9c4c7ee109294
>> -- 
>> 2.34.1
>>

