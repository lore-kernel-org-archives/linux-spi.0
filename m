Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2643BD25D
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158206; cv=pass; b=qFQhK3zGtRGY5JNhe1BurOcz4ZDY89/4qwGo56NWacuyJcYCby+P1o1llW4SOktBIagExsf0KWWV10kBvNCeLO11MePz5ub13ehmWoj9gKLDHnb3+L2WzmC3J/pF1L1Yneew23OQMqWgN06geN26EnudwF21dsOq05Fr9QTpq5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158206; c=relaxed/simple;
	bh=FY4GbFRdIg81eSH0lJ0AJPUloL7hXTDQSrueGrrhMVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4VScP00HXM5T4SFxnhnrHZBPmuYchaSuvVDECrkFTsa3jTL12fT866tPV5lOjHeufVoGSYTL2Dr7K65WhzlStDVoIBHh26kDicCjz0j/uoee2vRauMidNMExMPGPsmAc8JSgsHJXOi2HOjunzNbtQ55HXCmcxXSTGlfx2v5ziM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eK7DNFBp; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK7DNFBp"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8f97c626aaso817551466b.2
        for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 02:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776158203; cv=none;
        d=google.com; s=arc-20240605;
        b=eaaxSJ6gN6kdFQEE26w5QLfiJAknBbW2YlgJy70/6XDWJH3yOZYYOmh00c/4hkwA2y
         L007ZjR/jllAJDys+AZiWt+dE/52ABuKwaOAwLcm84o5qsdrj6mEJ7hx/WJ88yqGlp8T
         YZeYOUYe260HbtUVAkj0y6AU3AFbP7rV9C4SoT7H+zNkVYZ4DW7CeFmrK5p4Lp7Uq57a
         otqJ2CCo5x38aEyKzAAyoDoNbs8twPVHqxaLc4RtsvzEKeIzRscFks7xF9zFs4A/8qLV
         zw9tyIbXcKO8iDJqivif4FQMn8Zmjfl+7xVw+esdOaKxMxC9FWeum+cDwIi6t7sycGsD
         9G2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0SIly2zfbq/eYwM2WkiEicqWCe6uu1Y74Q3yJMzCBG8=;
        fh=Qu7UMvpGl2ua4Jluxgu4IsaNmbCHe0vwUdLxTzNiKTI=;
        b=E4n99EJF69w5Gw89b9OTsfWIjsGyNDxrRCB1omORLxv6+FzM8e+sMUaPMeWUav5XO2
         oiXiRbNGr74p0ts3LcbPlRRmr/qnNzgj2wP52f22OVa7uHJfsUjbN5iVzv0XU3te4/Hc
         UEnFp/ItWgcJHLGJdp/V3RGe6wKvOlHbeS8epC9VCsXEvJPvdqjkv0krSSMbkzayR7r6
         1grFdvidjuK/H0PSEeqhaXYmk0DP8dSpZ/w0UlRHzyTKr3mc1Iy0H4GdbV/6ZgNh83pM
         tGjJQu8edFR3RR0hsfI8qmdeflJi0u3WPpgDYb/wkKBIMXITsU5DTdTQp1qFgcPoqtum
         sMgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776158203; x=1776763003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SIly2zfbq/eYwM2WkiEicqWCe6uu1Y74Q3yJMzCBG8=;
        b=eK7DNFBp9fhHeAQt5Nyd6jWNhuvi146eokB7Bx/gJttXH/71bxpCZbFk+d/ZB2jMCR
         ewhcQSunBgdIf0I05oD6Wme89w16hdw0g1BlsWuEmm1HwBYa9lUVe4fYeSwYe/WRGWu3
         fGXPha07rjNVA0/scPB9xJG4Nla5gT5WT99VmS8QGSAob0D4EsE7iNj5dLFGipqN08hn
         X7RfwUzvp79SDKbHewNtBkEoQQjepV+AfFz9z+uyCJvWNkAOSJ7YNq9GXtrdTwOPSVlT
         F6R1/3JEwI1aH2YGP6QZc2SO3qhcQco2tr7MyZdOkehqf8fmp0PAXrCNL39x1Cnum9at
         4KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158203; x=1776763003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0SIly2zfbq/eYwM2WkiEicqWCe6uu1Y74Q3yJMzCBG8=;
        b=azSmDe036N4+O/xh8vqBjlb7YNUrESJJga+MGulpDDb8Ss/MRAbSQd8m7DUdLhPQPU
         L2Iebfyd2UYZ+cBOXGyJyE52X3Qr/QjH0N/hKrBbdiFXBTqE8zoIGA790i8kTeeIR+Gr
         9n6nY6Hq7it7NPKKPoc47RnICnv/ZwNe2KbfznlblYGP4N/FKquPY7++r1Rbbb73mEZV
         1e6U0TBj9vqcjsiTol0phtVkh3VlQbR9x9yC1BcTyjbTJNPsN6o5cy6IYx4SoydEz0xy
         m8tVMehQBCgNNogoj4ehYghTCPMJhqOZ6SEemiBSW/ZR+AGo2ZiLnv6a0YuygEVHlMRm
         X/Pw==
X-Forwarded-Encrypted: i=1; AFNElJ8U3jaNyFMUdb3qy6iUGdqvtkSANKkNEXHg9yRvFXxCIBDoQQQcJf95d47yhFb5nMl5Fl2D+QtxcZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPfGniQy26O2DTpYlJz3uluzmmueJNQ4jlUy7reLmkhorC7NnM
	v9DEE4g445uG++cJf2Rm7lvou7/jwdu2QHBTyzKKhTCzdKKHScgXmh5VOzpQLc8fRx2iOk0g1ui
	41A2Q7N4BqfvRgoc7fxduoNtgUBBpcmw=
X-Gm-Gg: AeBDieuAKhAutZ+Kc0KKr9EMlWV5jGqzJIgdva226wgVB/M/Jq7SptFYt2J+VRcjzkw
	TaxfsnkdVRRt+wYs6+Udrq7IJJd2bMkbnhpD2Sm/FXD5Uvzq6CBFVuDmm93rm1UPgxawjCgRy/l
	BaRFsa8NqHzkmUoiYiD/ZmH7NDFs40y2yjUF5/TwR7LS7QNE6UbxrmPEiUY5dGb89mwgZITrfw3
	gAuMHmvWf3QehFk1lugp2EldW0g5E0KoONIiVEtL7OybzcpLkuwzEiCHVM7HW26dZ8uEyOypytm
	KqktzbyeRzuwq6nRoTtLXA38Y2UBuaJPtnl4WnvHiOPp1C3sFIBsVkjj3/PI7ZG1eTXZktvYv2X
	G2yy9i64=
X-Received: by 2002:a17:907:1c9c:b0:b97:cbb9:2290 with SMTP id
 a640c23a62f3a-b9d7243e6eamr915863666b.11.1776158202848; Tue, 14 Apr 2026
 02:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413100530.580649-1-khalil@rentman.nl> <20260413100530.580649-3-khalil@rentman.nl>
 <6af0a67a-c028-45c5-b514-52570ecfcc68@kernel.org> <a451416b-80a6-439f-8340-e53e4b30d87a@opensource.cirrus.com>
 <6dea7a2f-5730-4fa4-a093-53f663c6a8eb@kernel.org>
In-Reply-To: <6dea7a2f-5730-4fa4-a093-53f663c6a8eb@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 14 Apr 2026 12:16:05 +0300
X-Gm-Features: AQROBzAYnOKPp6E9PRGHWIow9snUafoTvUXTrEoWd3EQel_RnOCNS48xiS6c_L8
Message-ID: <CAHp75Vcs68e_GtFmLyYxJXi5PFo-0LqWi-7j1ZSARxDQ6UkDWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] platform/x86: serial-multi-instantiate: Fix SPI
 chip select on platforms with incomplete ACPI cs-gpios
To: Hans de Goede <hansg@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, Khalil <khalilst@gmail.com>, broonie@kernel.org, 
	ilpo.jarvinen@linux.intel.com, Andy Shevchenko <andy@kernel.org>, linux-spi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Khalil <khalil@rentman.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 6:05=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
> On 13-Apr-26 2:51 PM, Richard Fitzgerald wrote:
> > On 13/04/2026 12:43 pm, Hans de Goede wrote:
> >> On 13-Apr-26 12:05 PM, Khalil wrote:
> >>> Some HP laptops with Intel Lunar Lake and dual Cirrus Logic CS35L56
> >>> amplifiers over SPI have an incomplete cs-gpios property in the SPI
> >>> controller's _DSD - it only declares the first chip select. The
> >>> remaining chip select GPIOs are defined as GpioIo resources in the
> >>> peripheral's ACPI node but are not referenced by the controller.
> >>>
> >>> This causes the SPI framework to reject devices whose chip select
> >>> exceeds num_chipselect with -EINVAL, preventing the second amplifier
> >>> from probing.
> >>>
> >>> Fix this on known affected platforms by:

If I understood the problem correctly, this should be fixed in SPI
core. And I tried already a few years ago to push the patch for that
[1]. I have locally an updated version which I need to revisit again
and probably submit.

<SNIP>

> >>> +/*
> >>> + * ACPI GPIO mapping for the chip select GpioIo resource.
> >>> + * Maps "cs-gpios" to the GpioIo resource at index 0 of the ACPI _CR=
S.
> >>> + */
> >>> +static const struct acpi_gpio_params smi_cs_gpio_params =3D { 0, 0, =
false };
> >>> +
> >>> +static const struct acpi_gpio_mapping smi_cs_gpio_mapping[] =3D {
> >>> +    { "cs-gpios", &smi_cs_gpio_params, 1 },
> >>> +    { }
> >>>   };
> >>
> >> I'm confused here you say that the chip-select for the second amplifie=
r
> >> is missing, but I would expect that to be the GpioIo resource at index=
 1
> >> not 0?
> >>
> >> I would expect the GpioIo resource at index 0 to be for the first
> >> amplifier which does have a GPIO already in the _DSD cs-gpios property=
 ?
> >>
> >> Since this is a multi-serial device ACPI node, there is only one
> >> set of resources for both amplifiers (with their also being 2 SPI
> >> resources in the _CRS list).
> >>
> >> So I would expect there to also be multiple GPIO entries in the
> >> _CRS list, with the order of the chip-selects GPIOs resources matching
> >> the order of the SPI resources.
> >
> > You can't assume that. There is no ACPI reason why the GpioIo should be
> > in order of chip selects. In fact, some manufacturers scramble them
> > (e.g. CS2, CS1, CS3). You have to remember that the ACPI is written so
> > that it works with Windows (which is the reason we need this serial
> > multi-instantiate driver.) so it may contain Windowsisms.
>
> Right, in that case maybe we do need the DMI quirk and the DMI quirk
> needs to point to a specific struct acpi_gpio_mapping for that model
> laptop ?
>
> Either there is some logic and the code can be generic, or there
> is no logic and then we need to not pretend that the code is generic.
>
> And in my mind the current code at least pretends to be somewhat
> generic.
>
> Thinking more about this, I do not think that the current patch does
> what it is supposed to do at all.
>
> According to the commit msg there is 1 GPIO listed in the _DSD
> props and the ACPI lookup added is using the same "cs-gpios" conid
> as the _DSD dependent code in drivers/spi/spi.c and it is getting
> the gpio with:
>
> smi->cs_gpio =3D devm_gpiod_get(dev, "cs", GPIOD_OUT_HIGH);
>
> which is equivalent to:
>
> smi->cs_gpio =3D devm_gpiod_get_index(dev, "cs", 0, GPIOD_OUT_HIGH);
>
> which is the same lookup as the already succeeded lookup of CS0
> in drivers/spi/spi.c .
>
> for CS1 the lookup should be:
>
> smi->cs_gpio =3D devm_gpiod_get_index(dev, "cs", 1, GPIOD_OUT_HIGH);
>
> and the struct acpi_gpio_mapping should point to an array of
> acpi_gpio_params[[] with 2 entries, with the first entry
> duplicating the GPIO from the _DSD info and the second entry
> pointing to the actual CS1 chip-select.

In general duplicate is not needed, the priority is FW, so the dup
entry won't be used, but since it's an array that leads us to the
necessity of having all elements being included. So, yes, in this case
we have to duplicate.

> Andy, you know the ACPI gpio-lookup code better then me, can
> you confirm that since the con_id between _DSD props and
> the added acpi_gpio_mapping is the same that calling:
>
> smi->cs_gpio =3D devm_gpiod_get(dev, "cs", GPIOD_OUT_HIGH);
>
> aka:
>
> smi->cs_gpio =3D devm_gpiod_get_index(dev, "cs", 0, GPIOD_OUT_HIGH);
>
> will just return the GPIO from the _DSD again ?

I haven't refreshed my memories, but that's exactly my understanding
of how it works. I can check it for sure if it doesn't work in
practice. But see also the link I shared.

[1]: https://lore.kernel.org/all/20190326212918.18541-1-andriy.shevchenko@l=
inux.intel.com/

--=20
With Best Regards,
Andy Shevchenko
