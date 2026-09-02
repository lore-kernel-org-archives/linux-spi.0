Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845F53EDADC
	for <linux-spi@vger.kernel.org>; Wed,  2 Sep 2026 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338946; cv=none; b=PW0lEbIKy4x0XkBqIKoRBS7vJusRnll9eE+vFz/f6ZUAjxAs5AEhTvBlEEHpdGdEAhIblyeSpplWdTjX0B39JPfNotu8JB2YkwToXNbOZYld4SezsEaGB8INMpTnuvbS5iMYUOv8IPcCI0AOp/+cKVkQQMoMdZHGEugCesGNj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338946; c=relaxed/simple;
	bh=ss5xROj8OM3lYj+pqG6TTIF5SBt62U9/oUBoQLswgBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyTEoYbmIqWK/RvL6urU1rwjYKfTUGdWPKuhkrsJJ7S/3JcvkFmf/vmJBrlmJ7qH8vyKqM3x+pQDf2XV/y9Z02QRXaCBUJBTvSwEDgYeCSQSMIay0zULxSi1+oVTh/crJhk6yEXlXdbKOM+KWadpTlzTVwvuvOr50b3T7+OSz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRGhUyVe; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRGhUyVe"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a6868f18aeso662973a12.0
        for <linux-spi@vger.kernel.org>; Wed, 02 Sep 2026 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788338942; x=1788943742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7aqc1YiIFFi2S/7+a4K7uWSUn18PjZkaszy4zjXDoY=;
        b=FRGhUyVeZHhqIQy7V+2OH9vwODwXTRs47UnHugrTgp+LSOzcThFqsRm2bSfBJMwhBk
         199eI9nSLNaLiHNvQEMwpmT0gpKbAzwHhN7wqzLBlykqSHwCMXCrF6cXhYR3fiC0tX72
         2J9XYkRWq68ZDFW4+MxdKrdDPS2FRzLnZuskT7IirKoyI8ysnZNo46D72xxdOyz5EDnD
         0H3JcRfYn/vmWl59ZTXEHfOeLzzb4ELjTwLPeyyKnk7w8uBlCJtOSvytm6rAy+1f6Xe7
         VxRrKYJrF4GcM2ZVCIp+gNMeEUCF4h7Wpu5MCZhU6mYcXgR5UdXplfMT1J+mZOP9DuVa
         AjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788338942; x=1788943742;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f7aqc1YiIFFi2S/7+a4K7uWSUn18PjZkaszy4zjXDoY=;
        b=tAMGKnfoP6OmeLovlrkc0HDdMj9YHg9tzWLMnfeWvQhN7DOSLXB3vBZ506+w6VzDDY
         lKiMWW0U14V8zkVKLwIs22qa54zBRMfAu871z0sqQtDC56P0joAY4qhvXldvt5QAANIH
         H71BlGtZyVa3ASAh8n3/mM/TM/sNxzHSXu8iQsAWswXu+X1D4HNTGCeZUaOHVZ+ACcrc
         E8C0yJRzNIGsKdtBNgnKfpE4NQpv7bwKpKENuI05lloaDX5ODq5+Xh/rC4B3x8vUN0Q8
         Q2tN6HNEQK8HSorUejHK5XHWiFeJI610ut+L357l2jYtODKwaYMB/cGqZ/IZzC1qvzm6
         brRA==
X-Forwarded-Encrypted: i=1; AKwUvBw9n+84GDcEtRNDd+fA0+xdyueO0rJ1AR8zyj+3chDXNp/AwhSW7sO067J1A8mdVI7AFJ6hlM7tGtg=@vger.kernel.org
X-Gm-Message-State: AFuF++lH6JrGZLWospgOpHItyBSo81bs6YjT6CPZ57OC3F8pHVi8ytdK
	SHAKvY8D0Y8KOM5GbXDChN7/YkloBRUJkJ6ybcqEXBaZ1x4F0U1fhvhx
X-Gm-Gg: AYBFou0mp0sVw4xUb7B5VjWxjkU4bNSrmZnC1pCDBSRE9XrRiOzK30R4uizPkLdsX+n
	RzuEc8Vn3LRRdF0h6mabdu66WoOsFS7FIDoPjSD4wt/gOAZo2AIZEnMAG9DitG3Cie5uX0nQP7+
	EBJoiUXLq17dwCXQF+R1gKZrmTAmhKQx5Tlkx42C2CvQA7tnJOri1vGEuA4jJXmZiHk0uX2GVZS
	QeGFYDx9CGXFLo3ToUjbgtRQtZPyO7WY0iFVPEsckkqYxp918fMm82wjgnlXa4Uvhf5Z871Du+Q
	A0fZ8fH2qpogNVOEWXT/S8bSc5TEIfMswU4+FaLRpArtqZOUuJHDfAvG0i/oaTeRNyOCj4+xwWi
	EjoU9EehJbKpOpQJe4vXnkAqy4ZM7RlPtPfHfXGKfs0UTUkwMhNwp3WrGa1lFHtgyCsjoKYr4fd
	Wt2wJiJy6/RM3NnlH+Tz+bzmWDyfZ0XwCVUHXX7KkYyAf188NPVrnRkeEk0A5Z3vXo4lBTvGAop
	bAz2DjAKjnpoYE+hFFv5Hls6Q==
X-Received: by 2002:a05:6402:21d4:b0:6a3:f63a:4997 with SMTP id 4fb4d7f45d1cf-6a682567131mr2048216a12.3.1788338942157;
        Wed, 02 Sep 2026 01:49:02 -0700 (PDT)
Received: from [172.24.138.145] ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f895f29sm764636a12.2.2026.09.02.01.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 01:49:01 -0700 (PDT)
Message-ID: <0c5a657d-e134-49a7-b2cd-82f293685cb7@gmail.com>
Date: Wed, 2 Sep 2026 10:48:58 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] iio: dac: Add AD5529R DAC driver support
To: Jonathan Cameron <jic23@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, Conor Dooley
 <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>,
 linux-riscv@lists.infradead.org
References: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
 <20260827-ad5529r-driver-v10-3-38f2be07b824@analog.com>
 <178813261957.2788519.4929586195765891569.b4-review@b4>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <178813261957.2788519.4929586195765891569.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/31/26 01:30, Jonathan Cameron wrote:
>>   
>> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
>> index 992f8930f95c..8dc644522b1e 100644
>> --- a/drivers/iio/dac/Makefile
>> +++ b/drivers/iio/dac/Makefile
>> @@ -18,6 +18,7 @@ obj-$(CONFIG_AD5446) += ad5446.o
>>   obj-$(CONFIG_AD5446_SPI) += ad5446-spi.o
>>   obj-$(CONFIG_AD5446_I2C) += ad5446-i2c.o
>>   obj-$(CONFIG_AD5449) += ad5449.o
>> +obj-$(CONFIG_AD5529R) += ad5529r.o
>>   obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
>>   obj-$(CONFIG_AD5592R) += ad5592r.o
>>   obj-$(CONFIG_AD5593R) += ad5593r.o
>> diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
>> new file mode 100644
>> index 000000000000..52601cbf28d5
>> --- /dev/null
>> +++ b/drivers/iio/dac/ad5529r.c
>> @@ -0,0 +1,536 @@
> Why do we need those outer () ?
>
> ...

The outer parenthesis are required by checkpatch for macros with complex values. The same pattern is also used by AD3552R_CH_DAC() in drivers/iio/dac/ad3552r.c

-Jan

