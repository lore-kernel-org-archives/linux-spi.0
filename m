Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A813B3BF7
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589048; cv=none; b=ZuJoNzbK0Mk9C5D0pLPs0W9wXTgI9sdKW5hQdr/PUZM3nUlABz7FpYCOCi/z2Z8sKwh6UgkPsPmw4ct+CWreqmAFD26mNC4js1sUhkL7HtYMFAeJ9XX20xqhM0Fc2jLXkQduQFxss873CDRcTDY4HXDOiLU3VzUC6R/zk/wwJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589048; c=relaxed/simple;
	bh=RWwUU8+StI4RcN5JSQsdBtN58iISvspR6zPUK1aFVws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtD+a32mhjmMocaWWX5mBhYhLGVkH6kFsw6zbyRtV1S28IyixdPAF1YZ+oNFGjdkMINdSbPB4BbGjr7EiUsyfXfwCLsv7REh45L3afhtu2TiYqvTXnp+UCNXh01S/8jtdX8pLPCgOLBfuL33YDD0ItZa0IdG6UQDp+8Ac0EQcTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=fnIFxdET; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="fnIFxdET"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb64085c45so7020734a34.2
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 16:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784589045; x=1785193845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AyvMF+8BBY2qBbRKTRVXrJXUC+8irQA5S2jNC2A/XOE=;
        b=fnIFxdETKUcac2/YI2V6QlijQ2V0dLVxDAfo7odF/regmd7Iim1vYftTINmtiQL/wp
         ISUzNR0k6Sx3xcPk9Ik1eCH7yPvyjx/jWzQZATD7T+4zo3iF10w0q4d5avpRTFn9NJ1E
         F9Ixp0UDHYTw6BBlnCY3mDcQiXDqYnFE1M2FDieJ5aWbvpWJ5TZYG7fTsw9/se6HmdIr
         e+D/AnztxVp45W83JP+Up7N6z7bKZLj6/AtoR5tR9ZZlQ1kq7brpXSarMMSzfJ+LgsEB
         q3+0H0CIgKrGS93s6MTg3zgD8sEyHIafTbkgmYWo7Vi2t+E7cBzephkMUuO+vSIBQYT1
         QQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784589045; x=1785193845;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AyvMF+8BBY2qBbRKTRVXrJXUC+8irQA5S2jNC2A/XOE=;
        b=ZyHw/Tgh4KG8GC0pU+zJOPiGuR/ZyjJYPcsSTD5JB8W7t3ZMRXvzpHzXLF4fa8DHtE
         6WTEMPnF6plpjyuwXyuL0QzwMCXQU5DiFio38pG3IldT+WB2aQVm0cCkpPUQXFAbgYqA
         Ro/mexCCVePmSAPEmdEIJ5p+GjwTy/SFIPetKnn9yzqEg/sz+ZOekGaL86eBgWIIDZ+q
         iQoaRyR4WPTfMsy1M9h03ZeyJmWfnEVLlKN5C97GTfxIiTWbDQ7RQZuVSz3BT74JcmBk
         cwrxWkK7VIZ6Zzu7JUdoB8oZRBnont7McidZigaza3HrleDbOQICVC5haR/JbPuzJdru
         sEbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpix3oqTD++R+fa2NHb8UU+e3zRSfGeu+i4SD9NQRfk5l4abdgJeFKqV2TgdqbmJ6R46+99WUIPnYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUINCTH6JVQYQhXJmg/ClSc1YkOlxNsvxrnI7rIcoyXrUQDQJH
	Z8riJhRzUmqiAtnxTKOKiBezecweWERN4c1JHNZpcYliiARFfPYE1/onPSRGTp+RpSc=
X-Gm-Gg: AfdE7ckG4twazNCIPFvGEXJkSMOlxxGU2Ig0BCBmn8KpB+y/K2deQDci2gCVq+f7xkC
	uCBgzJSwzhMfNBWNXWJenyuhqHk71blCEWZxsWDaoW9G4U/L4PRGKbslmDc/aJviISNBu38+yyE
	Ty1O+aPy/H+KJw5aBkLgaLqNOACxNwRtWIoQOUjMWzuwx89teVRIzRlvvYPILS0HruyCZSQQ6wa
	oXH7O1sI6ST+JBE+VpJLsPMerIeJ6XyBtPXQpVG7GfO9a08wJnbtJoliv4BVaHXLoe/jbgJsg8q
	0FNxR7p/56y9vswWSA3dvs05TW2wqy0ZL7bUWT6nVqJiAJ9+AjUHJjU7z6IVd1vXXkFn82/zaKK
	jkzUTf8s97uuUhcHR2CqgdneV5YNB7BW9+/XpVKGFZcqWL3ez9FjUpaOztbKJ2THO4cTd0LQJsC
	KmBi40AhEu8aBTOdTMfgOnKze5eJH0GQq4wLlSckekPrJstqL1jxPO
X-Received: by 2002:a05:6830:3c03:b0:7e6:6f9f:7455 with SMTP id 46e09a7af769-7ed9aa390f7mr8437015a34.10.1784589044696;
        Mon, 20 Jul 2026 16:10:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8ce6:b98e:1126:f7f0? ([2600:8803:e7e4:500:8ce6:b98e:1126:f7f0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edad965130sm9333830a34.11.2026.07.20.16.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 16:10:42 -0700 (PDT)
Message-ID: <9bede50d-294c-4b89-a069-804881c5cbab@baylibre.com>
Date: Mon, 20 Jul 2026 18:10:42 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] spi: add multi-CS and per-transfer lane mask support
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 michael.hennerich@analog.com, broonie@kernel.org,
 marcelo.schmitt1@gmail.com, andy@kernel.org
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <eplbtsrc2rojtpuxdtcy7vp63fhzl4ckb5cobs45y6fmcjy3wj@g3ccws2qeg2d>
 <6576af52-19d1-4b79-879e-bbd09df40a7a@baylibre.com>
 <alkL3Sh7kmq7Yr1c@JSANTO12-L01.ad.analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <alkL3Sh7kmq7Yr1c@JSANTO12-L01.ad.analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/16/26 11:50 AM, Jonathan Santos wrote:
> On 07/14, David Lechner wrote:
>> On 7/14/26 5:29 AM, Nuno Sá wrote:
>>> On Tue, Jul 14, 2026 at 02:55:31AM -0300, Jonathan Santos wrote:
>>>> This series introduces two SPI subsystem features: per-transfer chipselect
>>>> masks and multi-CS device support. Together they address the multi-device
>>>> setup described in [1] and the limitation noted in [2], where no SPI
>>>> controller completely handles logical chip selects beyond the first one.
>>>>
>>>> The first part of the set addresses multi-CS support. Some SPI controllers
>>>> can assert multiple chip selects simultaneously, but the existing code
>>>> hardcoded CS index 0 in both spi_set_cs() and of_spi_parse_dt(),
>>>> preventing this from working.
>>>>
>>>> The second part addresses dynamic lane selection for STRIPE mode. In
>>>> SPI_MULTI_LANE_MODE_STRIPE, all available lanes are currently always
>>>> active. Some peripherals need to select a different subset of rx/tx lanes
>>>> per transfer. New fields are added to the spi_transfer struct to allow
>>>> drivers to specify which lanes to use for each transfer. The documentation
>>>> is also updated to describe this new behavior.
>>>>
>>>> [1]: https://lore.kernel.org/linux-iio/af0EGv172ZMl%2F6N5@JSANTO12-L01.ad.analog.com/T/#t
>>>> [2]: https://lore.kernel.org/all/20250915183725.219473-1-jonas.gorski@gmail.com/
>>>>
>>>> Jonathan Santos (6):
>>>>   spi: support simultaneous assertion of multiple CS
>>>>   spi: add per-transfer CS mask
>>>>   spi: spi-engine-ex: Add support for multi-CS devices
>>>>   spi: Documentation: multiple-data-lanes: describe rx and tx lane mask
>>>>   spi: add rx and tx lane mask to spi_transfer struct
>>>>   spi: axi-spi-engine: add support for dynamic multi-lane selection
> 
> Hi david,
> Thanks for the suggestions!
> 
>>>
>>> It would be nice to include an actual user for this in the series.
>>
>> Agree.
>>
>> For context, here is the scenario from [1] (with arrow directions fixed):
>>
>> +---------------+                                                 
>> |     ADC 0     |                                                 
>> |               |                                                 
>> |        SYNC_IN|<--+---------------------------+                 
>> |          DRDY0|---|------------------------+  |                 
>> |               |   |                        |  |   +------------+
>> |          SCLK0|<--|------+                 |  |   |    HOST    |
>> |           SDI0|<--|------|--+              |  |   |            |
>> |            CS0|<--|------|--|-----------+  |  +---|ADC_SYNC    |
>> |          DOUT0|---|------|--|--------+  |  |      |            |
>> |               |   |      |  |        |  |  |      |            |
>> +---------------+   |      +--|--------|--|--|------|SCLK        |
>>                     |      |  +--------|--|--|------|MOSI        |
>> +---------------+   |      |  |        |  |  |      |            |
>> |     ADC 1     |   |      |  |        |  |  |      |            |
>> |               |   |      |  |        |  |  +----->|DRDY0       |
>> |        SYNC_IN|<--+      |  |        |  +---------|CS0         |
>> |          DRDY1|---|------|--|----+   +----------->|MISO0       |
>> |               |   |      |  |    |                |            |
>> |          SCLK1|<--|------+  |    |                |            |
>> |           SDI1|<--|------|--+    +--------------->|DRDY1       |
>> |            CS1|<--|------|--|---------------------|CS1         |
>> |          DOUT1|---|------|--|-------------------->|MISO1       |
>> |               |   |      |  |                     |            |
>> +---------------+   |      |  |                     | .          |
>>                     |      |  |                     | .          |
>>        ...          |      |  |                     | .          |
>>                     |      |  |                     |            |
>> +---------------+   |      |  |            +------->|DRDYN       |
>> |     ADC N     |   |      |  |            | +------|CSN         |
>> |               |   |      |  |            | | +--->|MISON       |
>> |        SYNC_IN|<--+      |  |            | | |    |            |
>> |          DRDYN|----------|--|------------+ | |    +------------+
>> |               |          |  |              | |                  
>> |          SCLKN|<---------+  |              | |                  
>> |           SDIN|<------------+              | |                  
>> |            CSN|<---------------------------+ |                  
>> |          DOUTN|------------------------------+                  
>> |               |                                                 
>> +---------------+  
>>
>>
>> And the proposed DT from the discussion in [1].
>>
>> spi {
>>     #address-cells = <1>;
>>     #size-cells = <0>;
>>
>>     adc@0 {
>> 	compatible = "adi,adaq7768-1";
>> 	reg = <0>, <1>, <2>, <3>;
>>         
>>         spi-rx-bus-width = <1>, <1>, <1>, <1>;
>>
>> 	/* other properties */
>>     };
>> };
>>
>> As a refresher, the idea is that this is considered to be one big ADC
>> with more channels (for simultaneous sampling) even though it is
>> physically multiple chips. 
>>
>> Currently, this series is treating CS selection and mutli-lane SPI line
>> selection as completely independent. However, clearly certain spi-rx-bus
>> lines are tightly coupled with certain CS lines.
>>
>> To reflect that (and easier to use in peripheral drivers), I think we
>> could bake this correlation into the SPI core code.
>>
>> So struct spi_device.rx_lane_map would become a 2-D array where the
>> first index is the logical CS (following the pattern of .chip_select)
>> and the second index is the existing one for the data lane.
>>
>> The trivial implementation would be to assume that reg and spi-rx-bus-width
>> have the same length and there is just a 1-to-1 correspondence (first data
>> lane is associated with first CS, and so on).
>>
> I like the idea of binding the CS to rx/tx lanes. I have a concern though: could this 1-1 correspondence break the current implementations where we have multiple data lanes per channel and only one CS? (and in those cases spi-rx-lane-map is ommited, so it is used the default mapping based on the spi-rx-bus-width). 

I don't think it should break anything. The logic can be something like:

	if (spi->num_chipselect <= 1) {
		/* Existing behavior */
	} else if (spi->num_chipselect == spi->num_rx_lanes) {
		/* New 1:1 mapping behavior */
	} else {
		/* REVISIT: add new firmware mapping description if needed */
		return -ENOTSUPP;
	}

> 
> Also, could we extend the ancillary device framework to deal with the multiple data lanes? Maybe it is easier to bind the logical CS with the data lanes in there because there is the assumption of sub-devices with multiple CS (even if we don't use the ancillary device for this case).

I would not make the change if we are not going to use it (other than
perhaps returning -ENOTSUPP if someone tries to use it).

> 
>> And we could add a new DT property for more complex mappings (multiple
>> data lanes per CS or wires not connected in logical order). We probably
>> don't need to do that right now though if there are no expected users
>> at the moment.
>>
>> Then we would only need to add the CS selection to struct spi_transfer
>> and the controller driver would just use the map to pick the correct
>> data lanes based on other parameters as it does now. (So no need to
>> add .rx_lane_mask to struct spi_transfer.)
>>
> 
> Yes, this is less prone to mistakes.
> 
>> This way, the ADC (SPI peripheral driver) can set 1 CS in order to
>> configure individual chips and then set all CS to read sample data.
>> And all of the data lane selection is all handled transparently between
>> the core SPI code and the SPI controller driver.
>>
> 
> Another concern with the CS selection is how to handle this in the
> driver using regmap (i will add the driver patches in the next version).
> I Created custom regmap write and read handlers and a regmap instace for
> each sub-device. Each instace have a context data with the corresponding
> CS mask, but it looks overcomplicated. Dealing with this correlation in
> the ancillary would be simpler. Don't know if this makes sense.

Could we just have 4 regmaps since we would have to do that anyway if
we used ancillary devices.


> 
>> (And obviously everything above applies to tx too, I just wrote rx
>> everywhere to keep it shorter.)
>>
>>>
If we did go the ancillary device route though, I suppose we could use
that rather than adding a cs selection to struct spi_transfer. Instead,
we would just add the ancillary devices to struct spi_message (either
allow .spi to take an array and add a new array size field or add a new
ancillary device field). The controller driver would then check this new
field and use the additional CSes and data lanes from the ancillary devices
during any SPI_MULTI_LANE_MODE_STRIPE or SPI_MULTI_LANE_MODE_MIRROR
transfers.  This would probably also require a new flag for controllers
to say that they support it. The main SPI device and the ancillaries
could be used individually like a normal SPI device for config using
the default SPI_MULTI_LANE_MODE_SINGLE.

