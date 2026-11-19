Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119104;
	b=pmOGqgOM9jopFkWipP+64DVS8/hC7cUuQ8AKKPy8EmWvBGXwtXehGWNvTqkz7D/TVfro
	 3T5XAjZJFOfRM/1kVyhd1exHHaD4k2RvIOf+dAXnFchEjR3Nz74OHPQhankLaXHvT512Q
	 NDwnEG+tGde6ZUhuLLyUBM/gRnif0EYliEHBDBapJFVi4f+bR2AatVNlRgnkmRXYmvB9U
	 KIvpVI+AbNjGBfU1mxiTeXAvz9oYr5MoTgmpZTxXs7O2/W8wwQSi9cqS/9bB3ayr3KfoB
	 qFxUSMFwHEoJJx1+SAD9f5IOH9ygkMaGHD3n2zjZqMIvZYiRXuXJgyoXF5a8y+wuxnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119104;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pFxF6NLDn4YFi5c/gPbxY2BsnOxIFijcpkJTs3Ec5/k=;
	b=pc+iLTH3x7sEXt9IXmqd79oEK6hDH92PsuLLT8B4xjpnOkyQSJk3yYD+pCixeUxJmYbi
	 Gp6jnFJ8yNPWlEMfPBq/5Oc/fD9n263N1L39CxqdDwOlbsQEx5InywgRvk+BVgae/Ilbx
	 ga2AQY/QL2pGQVq/FackO2d1HHsfaT9mznfk3MkXza5o8GAFmv5xStzhawycJBOj3S5uw
	 3px6ytbKrOb2mMR0wsa8m+9qbWZr1Bj4Toj9Qdmhc0KZEMGqCYeU7nfHBCjt7tEX5d3dC
	 l+SUzvXYhuQanfwapTehsUkhgfVyM3mSBIsog58K6N7q7nyE+/889qk6EI6Zhysoh/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=at11472n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127DB606A330;
	Thu, 19 Nov 2026 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=at11472n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E401F000C0;
	Thu, 19 Nov 2026 20:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119103;
	bh=pFxF6NLDn4YFi5c/gPbxY2BsnOxIFijcpkJTs3Ec5/k=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=at11472nDaFVGNSVxIilCjfXOuWH/dtohJ9Kc3Ec/L8jTKZwInsB00Pqkf/21YcAz
	 gTY5zWZtTGisSAdfc3KO+UDhHjDz4rBMvvcM7cEGa1RS7vUZxsNd6nu7QfkZN/q+zX
	 g4mE18f8yMSoqEOvLJS0jheNAoKSt1e0aPlI9nzMdpxzxsEzV1H6jDg4BUn+7AJEaM
	 mXi+juzuEtyTJRr8SCfRsifnPJAibRwzHVNg9l5n+AM7xB65dpPZrqHuT2+vDQSpGn
	 KxaP+ZuV5Jc+7HZPOpFCBMpBYv49T+3i1KYd5S7gfyXIpacEhwPNdSxqERHBNVbgiM
	 HIY54XFOr98XA==
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6/6] spi: dw-g2: Add XIP support
From: Mark Brown <broonie@kernel.org>
To: Prakriti Sharma <Prakriti.Sharma@synopsys.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 Siddhant Kumar <Siddhant.Kumar@synopsys.com>
In-Reply-To: <20261119100513.433044-7-prakriti@synopsys.com>
References: <20261119100513.433044-1-prakriti@synopsys.com>
 <20261119100513.433044-7-prakriti@synopsys.com>
Date: Thu, 19 Nov 2026 20:11:34 +0000
Message-Id: <179511909434.116416.7980842980021055081.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wn2KQMRVwRn7IbAXni+bc58Hjan01FFaV6Wj0SDmhkg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+h3+vk/RM2tDz4o5WXnXnsm3zMlXZD9aUbTm7KpZjH
 qf43sl1HaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZiI33NGhmf8c6QXnNgZ8a6g
 si/29NLoOF2ntJtufyTrrkbPr5x27B7DP7sQ3Rlej8szLBNlq2Wt7pvZfBEV/ZF2S27dS6Gftya
 ocAIA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Add memory-mapped execute-in-place through the spi-mem direct-mapping
> helpers.

> +	*val = dws->xip_continuous_mode ? 1 : 0;

Please write normal conditional statements for improved legibility.

> +	dws->xip_continuous_mode = !!val;
> +	dev_info(dws->dev, "XIP continuous transfer mode: %s\n",
> +		 dws->xip_continuous_mode ? "enabled" : "disabled");

Don't log normal operations at anything above dev_db(), and consider if
they should be logged at all.

> +	if (dws->xip_continuous_mode)
> +		dev_info(dws->dev,
> +			 "Requires flash command supporting continuous read (e.g., 0xEB Quad I/O)\n");

Shouldn't this be an error then?

> +/*
> + * Module parameter: select transfer mode at load time.
> + *   1 = XIP (memory-mapped direct access)
> + *   0 = indirect (default, FIFO-based, uses exec_mem_op path)
> + *
> + * Can also be changed at runtime via sysfs:
> + *   /sys/devices/.../xip_mode
> + */
> +static int xip_mode;
> +module_param(xip_mode, int, 0644);
> +MODULE_PARM_DESC(xip_mode, "Transfer mode: 0=indirect (default), 1=XIP");

No module parameters please, I see you have other interfaces for
configuring this anyway.

> -#include <linux/spi/spi.h>
> -#include <linux/io.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
> -#include <linux/irqreturn.h>
> +#include <linux/io.h>
>  #include <linux/iopoll.h>
> +#include <linux/irqreturn.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
>  #include <linux/spi/spi-mem.h>
> +#include <linux/string.h>

You were using a bunch of these headers earlier in the series.

-- 
Mark Brown <broonie@kernel.org>
