Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611682;
	b=c0udejsAEoB+1SKXsOy20E/off73r8GSKoD58p/INEftjVRG+peYAamXpjEtW09anYN+
	 DNG33+yA/X769Qp4IVEz7a6NFinP3eXJziiTSzsV7YvPUpC7pWTY/ELtffeV8g/WSE6mw
	 bG3CVei4Ori/LDLQxIj87ZRBnTBzVCdfWS7XJnDhB8r55i3lLB5yo0eFw82//x7AMqf5o
	 M+LdPk7y/B5n4so/1BQnQY9Na4Nen6A+yR0F+dEfqU/kiBsMiK93+Up2vE5b4aBaqyyPR
	 WwceuxuE+X0pUUrk/jJwEmNJfoXqnF7SQ9OAh6tdUO+pb3dSjG+wNNgkg57YwPhwmFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611682;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pXGSM9Y3EpP8jnrBzAJoxv43kXDNPaxem0R/Fx5BGmM=;
	b=0EHelChS28p2SY9Z8h65GOyw/QwZWsyIwFAQdhm2ZvEi9FBNYqmC9o+Fq1urV7iEEIDi
	 ImEEHsk3/kS8gKNiYhE5I4DQ9+KN3Xlj0SFdh+rhlcEbM9tVXop1en15K5C2KX+spLQeo
	 w/b0WT0qQwmtgwvA9wCar9a8G8tKTiEX2NQCA7E9lah1j5t57vB4AhpyFYa4NJtSYiZLj
	 OMs0A0lVeNLkWzuf8EQ6Get8Nmwtim5YQS4jMx4GSFpgil0vxnv2IYwx10MkVYXOxOHFw
	 9PwZf0+JXzmSAXwqg2jqe97DvLq1VQOIG49vnramj59reJweGVAbUIPgPru/dBEPuWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVHrIAPA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C2606A335;
	Fri, 13 Nov 2026 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVHrIAPA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2461B1F000C4;
	Fri, 13 Nov 2026 23:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794611682;
	bh=pXGSM9Y3EpP8jnrBzAJoxv43kXDNPaxem0R/Fx5BGmM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=EVHrIAPA8Wn6pkqAi/ZJrxxnCngTzoj3f9VE7VrK5fQqQtpk3Vk+H50eYTjek62Vb
	 rkuPr4HAka6aT/QEzVS14ihKp4AVkV5n46BZnN4K+E5tFhOugKbJoZ7J8XaQGV82Mp
	 pD5j8zOc3lGY4n9V1YJZO80cQPx39ae8GP4gdbkgXwxDr8QxmQVOZCTncHhkY7XvR4
	 woDxioWwlHY9ycLUdUtvTYQlBP/yWXc7q03HrLrPqlgGC9kDlu1nvi7qryK/xddYcC
	 mPfeOY6Dk+COgktruhoKFA4uEN96yh5iTNJF/LBpet2i+9LqU68+tibm2tvVtd1Gd4
	 IYcJiNgBXOtmg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 5498C328C243;
	Fri, 13 Nov 2026 23:14:37 +0000 (GMT)
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
Subject: Re: [PATCH] spi: sun6i: Add dual read support for the H616
From: Mark Brown <broonie@kernel.org>
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261110-spi-sun6i-h616-dual-read-v1-1-59bea5a897d4@gmail.com>
References: <20261110-spi-sun6i-h616-dual-read-v1-1-59bea5a897d4@gmail.com>
Date: Fri, 13 Nov 2026 23:14:36 +0000
Message-Id: <179461167656.590303.12402709871115244251.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=789; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rr0+rqD3HhJ16MSAH8jAU6LM9LnKj9iXMGerOv/Xe6k=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+z7y79hmDSpxcRO3Lgh3ts9fdW/34mcq1FV9bp3Qeb
 N638egum45SFgYxLgZZMUWWuCzul/Ulr9fwHVzYBjOHlQlkCAMXpwBM5N0lRobPh8pUWG86us72
 KvAOWBaedufA7Yd/VQs18jcELY19+LWG4Z9lVk9+2DXFVJ9r5gJZkheL92zg/8j2QWqprv7X/bl
 HJbkB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The H616 SPI controllers are bound through the "allwinner,sun8i-h3-spi"
> fallback, whose configuration advertises no dual or quad modes. The

> @@ -785,6 +791,7 @@ static const struct sun6i_spi_cfg sun50i_r329_spi_cfg = {
>  static const struct of_device_id sun6i_spi_match[] = {
>  	{ .compatible = "allwinner,sun6i-a31-spi", .data = &sun6i_a31_spi_cfg },
>  	{ .compatible = "allwinner,sun8i-h3-spi",  .data = &sun8i_h3_spi_cfg },
> +	{ .compatible = "allwinner,sun50i-h616-spi", .data = &sun50i_h616_spi_cfg },
>  	{ .compatible = "allwinner,sun50i-r329-spi", .data = &sun50i_r329_spi_cfg },
>  	/*
>  	 * A523's SPI controller has a combined RX buffer + FIFO counter

This new compatible needs a corresponding DT binding update.

-- 
Mark Brown <broonie@kernel.org>
