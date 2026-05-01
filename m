Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50EA13777E
	for <linux-spi@vger.kernel.org>; Fri,  1 May 2026 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777624257; cv=none; b=j2P3GiCtetki9FT2JIQuh6ecmNBRFvkfr2OdrHBKliBMKrOWWtTjFY0liY5Sat+Epcupv6CiZVoUFu7fDd9SjH+sh+eQzfkLKL1/dS2/QIfn8Y+hKXZIiEMcgg9W49LifDWd2++n9qGvi0IimixfbYlaiX0Vto+gOH+uqtZR8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777624257; c=relaxed/simple;
	bh=vi4Y4FrM2u7/NGWEpyOvXjv9CtvV21IppSt/L2UJ634=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWKytl275yGmKURl8As9hntjLJtBctDTEHxzBiOVhqgpbQj93nk0ECYhFSTq8xibtcF4/phgScnfSBOWefp3WSFebyDuZE6rdGPzBGZurwNqnUEKgvzexsjZRguPD1MnN2aO03hoYT+73JwfwJF3Aw1PhEQ5fORJGh3VoBVrxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOVcZ3hE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOVcZ3hE"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso990516f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 01 May 2026 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777624254; x=1778229054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvsqEGiRr2aMUPxm2PwD7DIcDzBPYJDFXn2qMdcwOC0=;
        b=DOVcZ3hEYm6Gtwl+SGtINr5b0rCungfOrPr/G1hxKsjuk2XTXWJTmuDCWqt0RHr7Uz
         T723fsKz20raPfwgfNOwIzd3Fix1xV/9YYLRzZcI27x/Hq3jEYorNdtauk+dvLqLhvo8
         4O7Qor2iyVuSLv2aVqnO6W2Qp9dSg/fvunDEHppmx/j/DC/zVs0lteQ6KpUH8JUo8N1J
         BvMJVfBlsGZ1hSz2Ad0qKdailaRrz/TL8gXKXsW+jT8gdLzYlqSnjqa7AEu59f+X7iiU
         QM6759SxxOkcWcZXxh/7v/Kjg6EI1Nd69AQz2uJdkZxwK/orjPmTchwq/SKGZOMwAGEk
         Ibow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777624254; x=1778229054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xvsqEGiRr2aMUPxm2PwD7DIcDzBPYJDFXn2qMdcwOC0=;
        b=Pb4m9FV7cpWgHIjJjfDXW31zYFo/nv+Y+Ozik+Szd6QMyyOpdULzb4XF6yWesaGCf6
         Q3iPJTHlsDbp5VE+uFJbPXeW5aXkfSNJNfBlAvwXbmncFJDu9UYYwLsPA7Nh84erNt0S
         8BqU9Rc3D9rY526iwQGMNiPJIkr/PjUkjdzEDXRjqXjbo1JzwhyLRDbyNAqxhUW5lOa1
         6rhISId8cZt8gdcJu04mcs4PB6B1Y++Q/ZSVGBWTEKwpd1/rLw4342C7Fm2Uh8UXIKED
         g4hWh1dxCpCI6jQ3Qv7lFSZOu9goC+MCe2fRQY/+XO0qKLUc0Fj0dY0lXTf7GOzW4WxJ
         OMdA==
X-Forwarded-Encrypted: i=1; AFNElJ9SdbgzG2j1xNse6/pckO1oywrrRHWnF8fsokZbUjtS3V1fi4T3BvEp/RENdjib4HrR3LZwpuTO/eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsucfXHl5yGePmnRm070F5jSRuKk3HTuXJHy8zI2YgqFLCFAG0
	sST2xxcNDKGcE1G8dwuQtB/pgrHh67BTh4+N9o5gMN+wYbPDrLKZk4Dv
X-Gm-Gg: AeBDietWnAZ+718R7aYIbkp5wBx73ikWpM5WOzrpLeQTIpA9brPhyMY9wFdMPa8q2sK
	KCydGDVblXHM/jjPEbWMVT0KuMxLs7BXFk7uxDv5Cmkx17R+gWLHvg0yHyfkMTnjrYHTFCcl+B+
	4zr2AGsy6p6BZFUOrg/py82bpsWIUyN8pSs3A8Kjx1TWrnpTqESv4xlEslxBewSMpfdczmi2bUo
	KaT1CM/tRxH1cGb8Fy8pQFZFb6wY6oHYaN0m9IBiqSz4M6Ey23OPi2Z8YvWV8NLVzQAXKub4iI+
	MizInazQ51/mF0gICTEsXm/oO+pRT1xkmw2aBlEjOSUowhV3RXZQpzG6VTUVTLoOc/ppRhAEbvq
	K1mjj0fXsH70FbAWk3KkYIYeiDTw7ZQQeFzB/Hfw00eqQbJESpwUpNPre74fdHBRq3qBOdIWSOn
	9LzAgBXfYGEKMastNBN4moQm3e6zKmiG5HdhDF70u1UGXg9FaWtVVnwzlV5DtL8F/L/98v34zlx
	6DjQbtVeRYwhQ==
X-Received: by 2002:a05:6000:2582:b0:44a:2cb3:b633 with SMTP id ffacd0b85a97d-44a2cb3b668mr6019597f8f.12.1777624252671;
        Fri, 01 May 2026 01:30:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981defbfsm3336950f8f.17.2026.05.01.01.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 01:30:52 -0700 (PDT)
Date: Fri, 1 May 2026 09:30:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hans Zhang <18255117159@163.com>
Cc: broonie@kernel.org, sunny.luo@amlogic.com, xianwei.zhao@amlogic.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, han.xu@nxp.com,
 haibo.chen@nxp.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, lhjeff911@gmail.com,
 hayashi.kunihiko@socionext.com, mhiramat@kernel.org, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/10] spi: Use FIELD_MODIFY() for bitfield operations
Message-ID: <20260501093050.3f97cd3e@pumpkin>
In-Reply-To: <20260430155456.36998-1-18255117159@163.com>
References: <20260430155456.36998-1-18255117159@163.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 23:54:46 +0800
Hans Zhang <18255117159@163.com> wrote:

> Replace open-coded bitfield modifications with the standard FIELD_MODIFY()
> macro across multiple SPI controller drivers. This improves readability and
> adds compile-time checking without functional changes.

I don't think these changes are worth the effort.
The readability doesn't change much - you need to know what a slightly
more obscure 'helper' does.
The extra compile-time checks are pretty unlikely to ever find a problem
and mostly just slow down the compile.
The generated code is likely be slightly worse.
And, with the best will in the world, it is easy to make silly mistakes.

	David

> 
> Each patch modifies a single driver, allowing independent review and
> application.
> 
> Hans Zhang (10):
>   spi: amlogic-spifc-a1: Use FIELD_MODIFY()
>   spi: amlogic-spisg: Use FIELD_MODIFY()
>   spi: cadence-xspi: Use FIELD_MODIFY()
>   spi: meson-spicc: Use FIELD_MODIFY()
>   spi: nxp-xspi: Use FIELD_MODIFY()
>   spi: sn-f-ospi: Use FIELD_MODIFY()
>   spi: stm32-ospi: Use FIELD_MODIFY()
>   spi: stm32-qspi: Use FIELD_MODIFY()
>   spi: sunplus-sp7021: Use FIELD_MODIFY()
>   spi: uniphier: Use FIELD_MODIFY()
> 
>  drivers/spi/spi-amlogic-spifc-a1.c |  5 ++---
>  drivers/spi/spi-amlogic-spisg.c    | 13 +++++--------
>  drivers/spi/spi-cadence-xspi.c     |  3 +--
>  drivers/spi/spi-meson-spicc.c      |  5 ++---
>  drivers/spi/spi-nxp-xspi.c         | 12 ++++--------
>  drivers/spi/spi-sn-f-ospi.c        |  5 ++---
>  drivers/spi/spi-stm32-ospi.c       |  7 +++----
>  drivers/spi/spi-stm32-qspi.c       |  5 ++---
>  drivers/spi/spi-sunplus-sp7021.c   |  3 +--
>  drivers/spi/spi-uniphier.c         | 13 +++++--------
>  10 files changed, 27 insertions(+), 44 deletions(-)
> 
> 
> base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b

