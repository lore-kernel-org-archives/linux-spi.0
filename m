Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794833155;
	b=quubJHhY6xRhCvVFngEZyr9emzKvMm1Y/pIHifw8PhM+4GcX8ywtiociXPy0NkXo4Rnm
	 h/pkMnUu9drwerldXS0sEkUa1cCgpbA7MW7DzTGCxtAprHWg4DKdZJWPFY17VzqhElo2n
	 Tqpiowtqy+lWuIdxWG/GRqbn+rkNvuB+JlKkQFo1OCZRaKrSHBwrSDnZzpH6BpRacQqZl
	 G2jsJz/zi7RT68s5WTPy/XVup4a8vlI5nj6c41KRKtSyyLzveXq5uQtJ0Y7rw1Ry9ipxN
	 P/szO83lM7ubKMx/v5lNcbFJdTeM53iJAc5jVyFFeEn5Bn8JYCAt0DqjYwbCeXa3smQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833155;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hkHTBxGxfzhbitUYWOK7qbxGcu2InRcFJvyZHNP1Rrw=;
	b=JtQMk+58EPTDrgbNB9jHYpxtCv/U3TOwqWg10MLbhgVAXb4H71Xxz831jowIHQtghpd7
	 gvz0ZJMe46HzKrXyfyeuak1Y75I/qmXy+TbUN70C6ELawnw+qUkJMARKzkKikmep9DALv
	 bNBCNXwe5ev/bVHAas7taQwbNfEfNs4ZC68pIFMWcXBKij2id1HgDqTQBi1DgvvfsJpCM
	 kF2l6aelmFfwyuS7ETyfszV3gXw22iXCrRK12c0BSIydjtVqa2IwCPBed3YvPnzoEIcMe
	 VX4zyQE0Ss/lNaB3BGp85PdFFPPV76jg/SasAHVZ3Lz/5vUik7W7hyf83xsjGeSyYsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ve9qBpbY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34407606A31C;
	Mon, 16 Nov 2026 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ve9qBpbY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9751C1F000C4;
	Mon, 16 Nov 2026 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794833154;
	bh=hkHTBxGxfzhbitUYWOK7qbxGcu2InRcFJvyZHNP1Rrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ve9qBpbYY4aKJRCPDX6bNSiuVuKciMkX7xzMK6WsXycEZIYl1Eh6tY+HsfPjE6qMR
	 +xYRhppQaFOurWLKmaPxCUM3za+NLhUCRq/HxPg0ZIUen4pYpBJu/Jd6x1X+zEgbw8
	 M/wpP6pqyehFSLHOO+6j0MQ18FF3Taz/0ytqm5YOjW7dJRzHNc77srqt812zqwLnn0
	 vFQ5ciNfdLdg+xrpJAiI0jERfAPa8C2BTg/JmlVBT5hFFGAkcfQ9NOGS2o4UPUylHz
	 ZEp09EGd96CkEXbzNUjeW9D02lTfr9kSIcMf2mKCQEsLZE26WNJrSSupifzDkBB1T8
	 Mh6x3bYga0lbw==
Date: Mon, 16 Nov 2026 13:45:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: sun6i: Allow Dual SPI and Quad
 SPI for the H616
Message-ID: <20261116-jackrabbit-of-strongest-exercise-d330d6@quoll>
References: <20261116-spi-sun6i-h616-dual-read-v2-0-e0c66eb71e20@gmail.com>
 <20261116-spi-sun6i-h616-dual-read-v2-1-e0c66eb71e20@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116-spi-sun6i-h616-dual-read-v2-1-e0c66eb71e20@gmail.com>

On Mon, Nov 16, 2026 at 05:55:25AM +0000, Arun Iyengar wrote:
> The H616 SPI controllers support dual and quad transfers (H616 user
> manual, SPI_BCC DRM and Quad_EN bits; only SPI0 has the WP/HOLD pins
> for quad). Allow them, as commit 743956bb9990 ("spi: dt-bindings:
> sun6i: Allow Dual SPI and Quad SPI for newer SoCs") did for the R329

Referencing other commit is here redundant. You document new hardware,
so why does it matter that some other commit did something for other
hardware?

You were already arguing you do not need a compatible. See writing
bindings first.


> and A523. The H616 keeps the H3 fallback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

