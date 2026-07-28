Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D10B466B7B
	for <linux-spi@vger.kernel.org>; Tue, 28 Jul 2026 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785263966; cv=none; b=fXRz7mPmeO+VJFas4kdLbiAwQ047v1fvc4iM4/6rVSxONwgoCbkn5LH8k07VAhdbrteyJgUAwbaynU6p6Ih+7kMCfzLm73Ie2w0nDlhvsbuMskaoSdnVwf/t/BYyro6kSfOHj4FD0wQo/oanEm4u1KiWSznPc/6O2EW6ZPJq8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785263966; c=relaxed/simple;
	bh=RKr4sPw7yY59cnecNrMMRCBGIPohNGrdz5d9epxLmFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rf8orBhiqL8vlAozIfv9/yj2qBD5Z+mVaSX6cV62iRe4O41KNAbzV0TxvS0wTITehH6DnVB+lJnCNEXEsbye2rN2sdAwU6lxnOE05+YhX/C1m77zQTYcIfZ/UYXrKGBwHLhWKXLuhxna+DU2/KAxaO3yvLUh8PL/FECElr2Z0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LfB8KLug; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LfB8KLug"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4864ebb6268so45783b6e.3
        for <linux-spi@vger.kernel.org>; Tue, 28 Jul 2026 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785263963; x=1785868763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZ6KjfVMquoraO1Ezx1ttR0tE2SHYdbVoIEX1Kyjbc0=;
        b=LfB8KLugj2YxSi5Tcqp+57pn5TicfayF9BCYrbMPzlZfNYQSfdqgybl5hoIpKoYQ9s
         8+PB6pHbsa8v1kUeExycdGYz2u7FDbsyRLT0gNSG2A3UMac9/1EwrWCLIrWdg+EXHdZu
         c1h4jIjFA7cnfR3yG4XZ8/GGywvHOSGwd9agpuEGXUw7kJpUaMV7axQ52zRBW8cOy4Jt
         Bkyhe401J89xER3pErUa7hr5jDBhXHKHMhKHHAr7ZtmBqTVF+Uyur4iJ0NukKtHL26SX
         MbjyX2P+I2Ul6DuVtL774rTlomP8WzmY7evjNc7NtN9o5sNGaWphiVUFCO5Nk9TAOCVW
         n4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785263963; x=1785868763;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZ6KjfVMquoraO1Ezx1ttR0tE2SHYdbVoIEX1Kyjbc0=;
        b=X5VweSx/JKrVaxwA3Z1LPKKrokXBsmevcR/pmX8EKZ04Q4GALmgrMvXjgQxq0XCHzy
         G9UxJEoehH0cEuoHQ401O4bHjfsWuLTZ8STf8oG0TGjpJPz+3ZXhrqS461PjYChgATEj
         FqLK5JfPffvtlS08bcvJFRho0Xx0p+XGqIz+UpnhGN52P2H8F0y2u7ThOm1doTLuo7wE
         v48EQlUCf9MH4JZlDUyjQpdFk8pEKPqBiVglpQjmW/SRS7ak8w3bZIND07dcVLCUKQyk
         NsLnkBS6qc8gW0CUPhioJTaEuVa9JcSv3r72Lxu9sa0ZbW1xrKW5W8VsWRgEm+GLXRFF
         dBgw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1iExjtTerpaYtnjWlViCeUXnuBDtSR/bfYxnXvXvjsiMJ1DImeJs639XPbn9T5XYVg/p5dDOJmEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDw/SSK8Gt+PboJ41BRW5wVR6C4XCyP7WFuHCuiyo1NFGsMd66
	lKTPiEXKxN94hFtwXxi5QAo6g9QhKACx5obcYLmOOBEZvB9FyNi9gRE9X5dWjZ4Xy40=
X-Gm-Gg: AR+sD133nvOdEctNH24nTGnnS6qOibOWoj2OCdZuHBYcEJDH2hOWc9pzd8i7q2pdVHz
	WahLmceqQaHGz+6BXGn5m/99PgzjA0Y2kz2lFbrAqCiUtBjGOAGSTR7iZYyHiaKhSZHSOVCdLdV
	v+IHYajFbkWeL1YWcFCc0V9eDtgFzYwancO4Lc0lZ+i25X4eTxYBz6of5ZkHBzcty3XgiefKegn
	haV4sxmktVKM0PILSiEtzclFvKmHTMwsJK3E2sBNPblk4PHE9sWbEZdrrahEZLfOLF3xMvcFtBB
	ZTR4fM3wqWyfBsjQdVJFe5KPiTHS0nNlbDyHAMztCMoWQed3XEenTM6C34bhoE0Y6f1q5uLEuqJ
	nJBRnMLt4cfqFVK77vbEG3N+5wKjblgTgNEHXWs4jI5JJHshXos1Jhqhl9xS/QMOXHu/sU1ee32
	P2ZkezQnyoy/3Pqj5rQTWBWe/gbkhRSsgSTJ1TKWGA6Pr3Eu+/hWHH
X-Received: by 2002:a05:6808:2221:b0:497:da7f:179a with SMTP id 5614622812f47-4ad5bb442cemr2111452b6e.21.1785263962996;
        Tue, 28 Jul 2026 11:39:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3026:75d1:db9d:8984? ([2600:8803:e7e4:500:3026:75d1:db9d:8984])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6b3f025dsm409931b6e.3.2026.07.28.11.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 11:39:22 -0700 (PDT)
Message-ID: <e1f977a8-ab38-4dc6-a82b-b955545550a0@baylibre.com>
Date: Tue, 28 Jul 2026 13:39:20 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
To: Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
 linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
 <e2118cfc-feef-4843-917f-844834ef4e60@baylibre.com>
 <20260725230445.60a445a0@jic23-huawei>
 <20260728-barrette-rickety-788b47da503c@spud>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260728-barrette-rickety-788b47da503c@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 11:10 AM, Conor Dooley wrote:
> On Sat, Jul 25, 2026 at 11:04:45PM +0100, Jonathan Cameron wrote:
>> On Sat, 25 Jul 2026 15:55:01 -0500
>> David Lechner <dlechner@baylibre.com> wrote:
>>
>>> On 7/22/26 2:54 AM, Janani Sunil wrote:
>>>> Some SPI devices support sharing a single chip select across multiple
>>>> physical chips by encoding a device address in the SPI frame itself.
>>>> Add the generic spi-device-addr property for describing these hardware
>>>> addresses. The property is placed on the SPI peripheral node and may
>>>> contain multiple addresses.
>>>>
>>>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>> index 880a9f624566..b59d047cf117 100644
>>>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>> @@ -142,6 +142,13 @@ properties:
>>>>      minItems: 2
>>>>      maxItems: 4
>>>>  
>>>> +  spi-device-addr:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +    description:
>>>> +      Device addresses used when multiple peripherals share a single chip
>>>> +      select. The array allows one logical peripheral to comprise multiple
>>>> +      physical devices, with one address per device.  
>>>
>>> "per physical device" for clarity.
>>>
>>
>> We may end up relaxing that again if multichip packages start doing this.
>> Fine to add that clarification for now. We can revisit when / if it ever
>> needs that relaxing.
>>
>>>> +
>>>>    st,spi-midi-ns:
>>>>      deprecated: true
>>>>      description: |
>>>>   
>>>
>>> If there is nothing useful the SPI core code can do with this information,
>>> I'm not entirely convinced that this needs to be a common property.
>>
>> I think being common does make some sense from a standarization point of
>> view and it isn't obvious where to put it other than under spi.
>>
>>>
>>> And this only allows for one logical device. If we wanted to treat each
>>> address as a logical device (all with same CS), we would need #address-cells = <2>;
>>> instead where the DT "address" is two values, the CS and the device address.
>>
>> Ah.  Good point for the adc@address or similar needing to match a combination
>> of CS and spi-device-addr.  Conor any thoughts on how this would be done?
> 
> I'm sorry, I don't quite understand. Why do you want to support both of
> these representations? Hardware wise both of these things would be
> describing the same setup, so allowing this alternate "multiple logical
> device" typically is not permitted. What even is the use case of it?
> Does it matter at all if you have one or more logical devices from a
> consumer perspective?
> 
> I do have an idea of how to solve the adc@address problem (you can do
> adc@address,spi-device-address like some other devices) but as I said I
> don't get why it would be needed.

I would expect that if such a device was intended to be used as individual
logical devices that they would just be wired up each with their own chip
select rather than sharing one.

The only reason I can think of actually needing adc@address,spi-device-address
would be on a system that was really short on pins on the MCU.

So not saying that we need it right now. Just wanted to make sure we were
intentional about saying we don't need it if we don't.

