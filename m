Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9ED3A7F41
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065375; cv=none; b=THnZm8EHECAhH1y5cY2dJZpdgwBpP/unTsp2qyo5Qmo7ClN1k9Of59AZFqpmwuAAdGWEb981BM2CCd4rZxKtP2T3i/LvT2I+aCeYqfj5mfhdhFJnaYRW0jQdMknpLJOvnVavXGNB1cPPJE+CCIN1OBZcdDH+fCuaSLJJvG/riw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065375; c=relaxed/simple;
	bh=AVCKJ2KI6lOS9ewHzp0fzn3SoI1G2URutkKytAOPii0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COLmUdrdRGQoN0edy7CleJLFCA5+Kw7teMxaRuNsUYmiEnLwzvI3exS58ixe1eHwcFzSJ1CIrHZHhp56cAEAH3r3/s3IGq2vlFxwKvlqqY+9L08FiicujeHl4l7jy5HJWTXIemr77CqaCRkpnlLSdFt74vkiQOQaHZMjgIze5tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=eXHhZuqA; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="eXHhZuqA"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so2826531a34.3
        for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 08:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787065372; x=1787670172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mpAVvulMzSQ0FUBRucWx6hh0hGsb5H2T0tEafS5S4TY=;
        b=eXHhZuqAOydN+mGiyic/78kZJfc2qJF2haDUcplA+G/obQRpei0nQJrYW4ax2C8htt
         hIYEW3nPddUmvaoKpxAYvFQmXaaR37SeGRE5wxDboHvbtQPKT+mc4i4WVPZoPW9c/7Mc
         Xcd2LSvdk2ZIGj342hGi3SLnV+3LiJ1GOFiAQBwYcvkB9a5t55zGT3MTxsoYTbbsqRQo
         BlL6mGhtfNlhkIrT7BHP9I+37SvFPf2wGfhMb16/qcNU7vsMMtncZooocT8DolCXTmjo
         it4+Ad4xHaDeK/HmhgbqDJhsnCXEjKsGZND8vGDnaOsIleAOd3LbTPFzPeAHyggGhL/q
         3E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065372; x=1787670172;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mpAVvulMzSQ0FUBRucWx6hh0hGsb5H2T0tEafS5S4TY=;
        b=adx1/TgioXFcKCZxSnLEK5+sZnMAG3ys1y4dKdWmDrJiPnVqI1PlZOasa75LS+lIdj
         Ok8ePubEVfBnXxh7s8hrFWyZU8eSY5fvhQsGlvndFZDHOQfrMijrYgMkDahMtUuhF4/E
         ccNEdKvIGeaUxmyOkji93a3HGuW31BlRMdbNbYLVvqdf63QlR6JN/U6WVyGxAIG9V2n5
         +RlTZBGZmgsPaczUAt+F2v4fpsEBuwnoV8eJ3IVYeaIhstX8VWSuxylAfeZJFR/lfUl8
         1Ft5M8jOhqll4s2W34OrnG31OruqOoMg0IsIm7+FXDCnZr03J3Tm794WZ/fGv0BILEyT
         In8g==
X-Forwarded-Encrypted: i=1; AHgh+Rr209gIJYeqtnRnR1InJSdXFONisfi+2iCumg9ppkUft/aysNHf2pdip3muvDNIVI4iD133gctMp00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBokvChu22xNkZUYaSx1ZJRzV8gxHda9gyYnqZYaiV7iVTCWuN
	lc4MQuw8+zXygGufqpgCWNhysHyLMsf5jQPE6IQ6TThnxOLb+CV0+egre1+MiNDZDHc=
X-Gm-Gg: AR+sD120NKOmsG/WzFjjyECiWhjGxPIe9lHY/l3Xy+aMqM+bd5nqtagiP145OGI4e0j
	r2baxSOcnjFdAg2JWudIL0meWAa2gICWFOF/PUUt8OBEJ/RZjzf7xxVTCtAFwcpXHPIUts6DSYc
	XdsitsnVt11Y38Y1PmRCUiNRcN8+CDshmorH1Z/uxixGgy5aZ/X+pHqnZDZEeR9TdUwrdUptqDE
	araRqXsUxMD9lLIgYHEB7oomarzPokFwfn6UoSI6iovVedKH1QUeHXGzzddfSY14X5fUrXjUrdC
	5qKT0Mr2d+UierMbrBxg5LFSuTMk/RzmOpWfBfgQqpQmIpdy9qeWQuauh6qF/ZrkSn2D7tdFpzY
	SRozsleOta7d6jC0B32Qr8AIWeOsvmEjGTkUWNuxRHKcoL+OdYygZXUyPMu8V+nm8+MWvApWPAS
	nVzZnb/q8a281xqErLq8DOFg0iQfIaby+1QgOcDZ4ylOEBE5R0kx6KlgQzbbYxmUvFwFRA/Xait
	L4ZtdK+nGSW7Uy//pbgs0/7DeqxGL0kwG+q2xE=
X-Received: by 2002:a05:6830:43a0:b0:7e6:fdea:7ab1 with SMTP id 46e09a7af769-7f3de56e390mr31339954a34.8.1787065372489;
        Tue, 18 Aug 2026 08:02:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1cf0:fc72:ac61:29db? ([2600:8803:e7e4:500:1cf0:fc72:ac61:29db])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41c0f4a10sm4330412a34.22.2026.08.18.08.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 08:02:51 -0700 (PDT)
Message-ID: <9841fd2e-434f-48f3-90c1-d62718d6d4d2@baylibre.com>
Date: Tue, 18 Aug 2026 10:02:50 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: iio: adc: ad7768-1: Document
 multidevice support
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: nuno.sa@analog.com, michael.hennerich@analog.com, broonie@kernel.org,
 jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, andriy.shevchenko@intel.com
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <d19a27738ac13307191dd09cd4a3ac5df7f7ba32.1786973376.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d19a27738ac13307191dd09cd4a3ac5df7f7ba32.1786973376.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/26 6:32 PM, Jonathan Santos wrote:
> The AD7768-1 family supports aggregating up to four devices on a single
> SPI controller, with each device occupying a dedicated CS line and a
> single data lane.
> 
> Extend the `reg` property to accept up to 4 entries (one per device).
> 
> Add `spi-rx-bus-width` property to declare the per-device lane count.
> Since each lane is bound to one CS, the number of entries must match
> `reg`. Make it required when `reg` has more than one entry.
> 
I don't see why we should have to require the spi-rx-bus-width property.
It seems logical that if it is not present, then we would assume one
lane per CS. This is already how bindings work.

For example, adi,ad4080 and ge,achc have multiple CS lines and don't
require any bus width properties.

