Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF592ECE91
	for <linux-spi@vger.kernel.org>; Mon,  9 Feb 2026 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659113; cv=none; b=Cp8N3/fS1kVfAVSHqQyOEVI+MGfuO3j5aN1pCoYHITXQB7p2hAXbPG1rwiI6fWjxdpVmn0XAwtqqvQU1ogmcMAC0i88vxW9e/K6eUcbgBdwb2ySfR2t79B1zHCM7z8RotoG8OpljURVQrfQHR4DlrcxS7vNk1yfAS5FudWpW5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659113; c=relaxed/simple;
	bh=cP/aES/NTJjVDeOefporUKftVqdwwO/cWLa+8v8dHgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SIH8UKCAG8cyOPWpQQ2v1Dy2Ryq/4QrR/RHWXFu1Sq/AJOGUde3PCf6/ph40HPVgc1oMVX4ancC99HMlifMlnBhXUeSZlrneULPBHp0wIYw0aDvjS1sAUAIVcGMFEflx6f5iC1C0ZCcrB3IDrSdpn5R0E9iEYkvEvPVnHWxjP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXIeLWjc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXIeLWjc"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so40921085e9.3
        for <linux-spi@vger.kernel.org>; Mon, 09 Feb 2026 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770659111; x=1771263911; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cP/aES/NTJjVDeOefporUKftVqdwwO/cWLa+8v8dHgI=;
        b=kXIeLWjcKXz1h8eOJfl+yKM/oFMrXsv7l3k0WBurPswbX4ODT/2UtqqGRYaM85shdt
         UV1DhyQgabv9B4appezvMYr4NkNuBlPRagy5mpaszpolWRr+s8zVop6zQ9+giNofhxb3
         Vrvx8XH7/zyD9nq8lxS+1WJ6YhXxVnQP5Pa4JF2NO2F9QnimamV4W/sjX9vqyCNMCeXh
         PlE6VpAUqnxdEU9cI9JplOizDDZFRSclK6aUCYqjegDWZqdQUJ4f2roUd9p+QIkMFOns
         qEvdCYUHtvNsfsXlL+24aIgH9KqBgHc1aViqrc2dIeJQfKsXQEWQAdcTQaCLV2Es55vD
         bLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770659111; x=1771263911;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cP/aES/NTJjVDeOefporUKftVqdwwO/cWLa+8v8dHgI=;
        b=BFa+jikDXCVUimh/mU+kEZ0Cx6pl++j3rIjiMpuCer97h/VSMb1VkSowOBAX2zY/ZT
         SVlzC0i+MO/zmJQHPTiIzBjLuvSmIM5IHTkVcCyhKY+ZT1mjuZpvo0Nwc7oqRJ0oxJkb
         MKjzCLV/RswBUrujeu/ZSm4heNcVRSeuiQHE62q2puxOwRScB0cb11hH0of56qa/2ns1
         VKJDCjSEhaNr+o+vwFE7EwIEyxtTavXCtubaJSWbHk1qdzTeKlkwZm/+4uwOl8ABpqPD
         VuSu157MLiLZ6wbzHFTS3VqDlhQgMLNk0anP9Asa5yxhjOq/+mqLRgHRwY2rwTDq6DKa
         oL4w==
X-Forwarded-Encrypted: i=1; AJvYcCUwkSUKUbOpwwbTly2OhSe9QQbgdT7YK5agM5nsGwu2ZehMU+nrkLc6PsxHTGDdmTDqfq1DFYffcG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+5pYseLJRIPxbel3FCNMCWPwJbFu3g/mNV6N0R4/Cef5AiBIe
	Ed0//vxJhVfXlNGAo3YuFgvgkYv92f2DSTRy9adOaSe72LkSrdhCAiWx
X-Gm-Gg: AZuq6aLyABXPps9xwufzin6FSEZ/kt0aTfsDXPmEiku2bxTu3EbqveJd73JyD6V058L
	mPq3jwFXwHhmsTuvAwAu62gfFPL0zIMVSGCIjednays2XFfFdyXmkBQ7mqQEn1991QMrzfIYAGX
	sYReFgJjAqz1y9mLo1Eo+OwtRj3X8fsQpn3u4guZOjmD7otUyWexSSpqyCRLT9yiyAk1oOn+7eJ
	+xrWZESxGABgf6VwuzueplizwCaCj9Mko2MX2qc7MHDWxCGxNx1Qc6lIFPl4f08S/3aFUiD/9fY
	hdHb59oN4Ud2hs+Zv5GIHRk8/pzwiRgoZiR/BPPd6ge4x1p48nNPr0pMQjwRV91U0L03+B3K4fQ
	QDBz1eF0hzRaEfb29SR5xF7y9/L7iNLLnglDsg6je5DuPs+Wp9n5olY0Ov06bqI9Bq6mix793XP
	78+9Afe1Vvv0+ek9cJY6OvkZGY/Ze7pw==
X-Received: by 2002:a05:600c:83c5:b0:477:7af8:c8ad with SMTP id 5b1f17b1804b1-483202264f6mr166657725e9.31.1770659111039;
        Mon, 09 Feb 2026 09:45:11 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e1a5esm3867345e9.4.2026.02.09.09.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 09:45:10 -0800 (PST)
Message-ID: <10822a56a8d85d0b079a2a17fde403aca8d102c7.camel@gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Antoniu Miclaus
	 <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan	 <olivier.moysan@foss.st.com>, Mark
 Brown <broonie@kernel.org>, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Date: Mon, 09 Feb 2026 17:45:53 +0000
In-Reply-To: <79c21d77-32c0-401a-94e2-ba4349a7a616@kernel.org>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
	 <290f35bcbd2f1ee68333ff65f89b54ec7fbb9c53.1770393792.git.antoniu.miclaus@analog.com>
	 <20260207-evasive-mastodon-of-apotheosis-e663a1@quoll>
	 <b3571244f058133a7a0f3b5ca6ef7dc377e3fac8.camel@gmail.com>
	 <be3808e2-ef17-4191-8c1c-5acb53114863@kernel.org>
	 <6b33ddfce874006bd10e223701802dec52fdddf9.camel@gmail.com>
	 <79c21d77-32c0-401a-94e2-ba4349a7a616@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-09 at 18:13 +0100, Krzysztof Kozlowski wrote:
> On 09/02/2026 17:43, Nuno S=C3=A1 wrote:
> > On Sun, 2026-02-08 at 10:20 +0100, Krzysztof Kozlowski wrote:
> > > On 08/02/2026 10:16, Nuno S=C3=A1 wrote:
> > > > > > =C2=A0
> > > > > > =C2=A0=C2=A0 io-backends:
> > > > > > -=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 2
> > > > >=20
> > > > > Instead list the items with minItems, so the order is defined.
> > > > >=20
> > > >=20
> > > > Also looks like we now need 'io-backend-names'.
> > >=20
> > > No. Just define the order here.
> > >=20
> >=20
> > Things are still not really defined on the code side (I know bindings d=
on't care about the
> > driver
> > side) but io-backend-names is a standard property and we might actually=
 end up using it so that
>=20
> And names do not change that at all. Actually they might make it worse,
> because they allow drivers to fetch item by name which people think
> means "order is flexible".

Fair and makes sense.

- Nuno S=C3=A1

