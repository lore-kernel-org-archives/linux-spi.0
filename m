Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA85E2DE6FF
	for <linux-spi@vger.kernel.org>; Mon,  9 Feb 2026 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661245; cv=none; b=UloVbHq+3cbXkCn7P8n9+0R1ZYhGERN78QVSJANKWkgmgwghOJzEqe2uqLeFUz3TbMrqGD3rxtxKtEylwf6I5DZPEfzj6d5zXsaMueqqVDRUDiBj1KX56zBk9iPkIdojytK1XkkM8mhGpOn83+Wjnhdi7fdBa/X7NxMa9ZXsiMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661245; c=relaxed/simple;
	bh=nHvEOtk0p/bx0nGCHDaxJahqOxGYrkQfZxMGweFLXmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u2bgYqkS4gQq3Mm0BnEzLEcbl50xpXuraqxtrGEw4mQGd9vGvneisJoMXP6OhnDwlxKf2zKDwy6BQ8WMGrCs2XQAOQ87ryj8Xf1bacrKK+mWWeFECIfVO3RZT20Wmr/vuCtJ9lIQNQjk/q4o6Q2CbpWylVDqhusDSp9aezgqToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vTThX6qp; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vTThX6qp"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d18c654458so1735132a34.3
        for <linux-spi@vger.kernel.org>; Mon, 09 Feb 2026 10:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770661244; x=1771266044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EqLmn4mbdLcrRVXVKVq2iS1TAqysNFH2oGNdN4Z4ID4=;
        b=vTThX6qpgrFYCEsMMT6mHDZZEUJGWsnAJiXAd37TOdqw8S0B99qipvohLk3IZyBm2u
         jHvcQHav3ksljMIpg1jfqwX5phCO8AsEm8nfma+ZrpFvy8S2tEpUfUACAodebf/WmMc4
         4q4Y93mqOAhFZoeaOhfsCNhwgv0AEPy5E3BZ7PbXYVye1bpCk+LjJfw3Z1oGfartOj+Z
         09HDmvsmcLqpulI5/uy/mUF/5Chl5/EMBZKSdO3cmoX4XQHxZlnaa5tpx7a9YohDe4/v
         Yrtk0/n+0PtLFUda8zF3qOCvEprLWFx4FvEAQ4cFAPtXHbgpjDyF43Gdy9tWxwTY2xKU
         aO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770661244; x=1771266044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqLmn4mbdLcrRVXVKVq2iS1TAqysNFH2oGNdN4Z4ID4=;
        b=iKZ56QgUbZCLVpe1jbJkDUCVjQQbwbXdUdLQwjOJEUPYzzVQhtYuCQB1ienhthRBTw
         NR5evlFugSWjoShVr+Hz5WEppTHJbnfU7oFoOxc7088OPQTDoj0usqP/R45uHn0hqOW3
         9U9sLnJST/awyHTkbwWYymW9R1H8HLN9SFrL/FVVcffNW01pB3IcUl7bnvCLsv2HtQNj
         Tixrkq7gF4bI2dVMtT8Ok4VryEjLk7QBj61ZIRH8DwHrh0OqdBZ1jU48yFb1KYaDkpf1
         vK425VngFP+gHiN+lHY4oxcc9aHPgg+UmcVf1jHNTHnYRTbzGlIOOTEsPq/Dr0MP2q4T
         Grfw==
X-Forwarded-Encrypted: i=1; AJvYcCUHEcmkhW3j1JULelAm3xe6M2TqunfnX4umJDwIoq3QgZ8rxdg6HznhWiZgNms5LY7PCZHWiBtSeEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YytXv3Z6zUuae+6EdUHWpYJLDnrXt99W+Xxcm1GFRg2vlAdgRRp
	r0fLOle80/Ma/vtWtwCKU9hrVAhNFOWgt9sLs4/PeWDs8xgsADqMqw9j0bjsG0sStpg=
X-Gm-Gg: AZuq6aIvm+TzKYbsC4ISB2qXnI1oXHKJO4oBMONfREjAT3JSTHojhJkFwKWyQ+ZG5yL
	NCr3REaQfoe66bPdDrnyRqztb8TLKU7sQDGYLQGCMOqQHtWB0fYZG4KOesFvTgJZTYIvoddVGBh
	vEsJn6IP4nfvB94QrGTUuBhJHqOJMsrqINgRk2+uU7kfHHj+gQgsadPC+2nHSn3Zu33rw3yESFl
	KgSsa5adQTmR949V4IAEojvCi5FwE/u9TmVUMwxPxsMF4H1+9bMaCZMq+w0osHS5CBBf+t+cKpy
	sUxW1CKqWfu8H+Xw6ol25rm4/eGmOXEt2tseXvzjKWrE4ST/DH8c+LW2gYE5UKRywR+Zj7QT1yA
	ga6Hi11h5I7dH7eV+KFRtSvQDvtwijvs3GDZTZ7/xZDoriJYQ8KjnZUujJurZqXwOxjovXJqY04
	atFgBKImYb8s6dhcn2zeEIJc4kj0kXnUQf0LeUCG5hfcBmm9loES4AkmOl8B+I
X-Received: by 2002:a05:6830:6319:b0:7c7:2df4:faa3 with SMTP id 46e09a7af769-7d464679084mr7705868a34.33.1770661243787;
        Mon, 09 Feb 2026 10:20:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:cee0:eb0c:b683:ad1d? ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d464710c95sm7791470a34.12.2026.02.09.10.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 10:20:41 -0800 (PST)
Message-ID: <7842eb25-9d6b-4218-9a23-f8758b819987@baylibre.com>
Date: Mon, 9 Feb 2026 12:20:40 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iio: backend: add devm_iio_backend_get_by_index()
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
 <550323d752213f177b7673bdd42e667f1d2228cb.1770393792.git.antoniu.miclaus@analog.com>
 <c731b6fba72286707821ea6e7722835ba45f089c.camel@gmail.com>
 <becd9db1-818f-4aa8-8362-91a711861839@baylibre.com>
 <be8457799b32d420228df5e2841c5547023ec515.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <be8457799b32d420228df5e2841c5547023ec515.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/9/26 10:47 AM, Nuno Sá wrote:

...

> uHu? Maybe I'm completely missing your point but what I had in mind was just something like: 
> 
> 
> // from the frontend:
> 
> static const char * const names[] = { "adc1", "adc2" }

Yeah, that isn't so bad. (A "why didn't I think of that moment").

And I saw the other replies already, so a moot point anyway.

> 
> for (c = 0; c < ARRAY_SIZE(names); c++) {
> 	back = devm_iio_backend_get(dev, names[c]);
> }
> 
