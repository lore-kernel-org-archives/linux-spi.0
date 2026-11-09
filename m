Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261793;
	b=JXCF1QDdzr7sWNBVJDMrS1tY0hiTC5u5uvsVjbtoaKJ85XgluvjeVdAuKhpyJM5I+b7o
	 +J/2WIhalf1wQUndxJCftcsIPrmWUugIUT4ksleXOF6bDN7fP7I6aUU12dNUV2ORFi23m
	 5iTprM8E2ZzJXXnQDVZkH1waznt6JSIn+AbY6wb0oq8t2mng3IAL9k7OzM/NZYpoSnYA7
	 9h+aG9nGEiSh0qp6KwlB0bx1zTGgn1C1gfnS/4CDKbUISrBKc+5CLR8VP057NMxw0a0OA
	 e482dShehFjENKPlqvZ95WLhHXnghaS8VVYYzMJyxUdF8vrVwR+EmeZLQsKCvvSt/uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261793;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CidRQbh2gFHizXgn/3nltDcqC87nf+9JADmfwJgFtmU=;
	b=ZG9Zo+OmqY+6+0DmTJ6u7zkQ4e4DmllVyJjJdi1nsS5ujE7qQLW8xlA0CEDJH3xSRNwH
	 K5cWsCcUU/y2XgYKgQ1eRnPatMrZE5avDF/7k0WU596tA6e1ideWh9C5SpjHHdnmWXQxK
	 /4Siza0cXbxe8tVcIgKkhnQr1wtx2z5+NNXe56yV7CvQHGtcz3gsngkQi2hJ3z9x5z6fG
	 NLuD1zEDQMb7UBNQYG9FeZQSYXz4nuvvtAcycjtTR1fXy/des/12R8cu8ODxL46rQXMjK
	 1Y+RdwufzetTmcly1pipLVnSy79g9mzcENqv9IBcdDd4qpi+mj3+k4zau+iP/0DEkyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAmfgtHb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE463606A31C
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAmfgtHb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2941F008A1;
	Mon,  9 Nov 2026 22:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794261792;
	bh=CidRQbh2gFHizXgn/3nltDcqC87nf+9JADmfwJgFtmU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=IAmfgtHbahuGzrwt5S2CdtfDct24IdyI/F871t2gLdvbcQ+AEpi7VJeNnr2npNsnz
	 aa5bmAB0UYBFCgenmJYp7R8/m2M9So96P5oiC77kQ/ismwwhBuNQBNjAx1YE3aQI7R
	 BMnFCK+ZI/MwfeYcxrHrpQsrYvXgYvHILyE/ZCKiw0VAFE8eluxASb0iQ4t8a+cs4Y
	 BMnB2wdQYvtW/k9bHw1I4+9LHwxt+dw53BWShkGQR2ncaSoBW3lakC6o5BVnpPHVXv
	 lueCwILLcFZGlBbgz6qK44f8S0X9TsMZpXMUG66nZq+53aBvWY1FekSyBW5L3fZgye
	 ZhXC+eK7zvyYA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 58F803021CAB;
	Mon, 09 Nov 2026 22:03:04 +0000 (GMT)
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
Subject: Re: [PATCH 1/2] spi: Add infrastructure for atomic sync transfers
From: Mark Brown <broonie@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 quentin.schulz@cherry.de, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
In-Reply-To: <20261106181824.1361235-2-heiko@sntech.de>
References: <20261106181824.1361235-1-heiko@sntech.de>
 <20261106181824.1361235-2-heiko@sntech.de>
Date: Mon, 09 Nov 2026 22:02:46 +0000
Message-Id: <179426176654.3711751.13650000545363860741.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8xKsPk8JaGfgfmUb29t/RDu26Xy0LDupWmUhlaAY30w=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+ObNvfR+/817uz8PL1hzcrH1cv1/ocbNUVEu6iHWq3
 oqNTRP7O0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAnCTrzH8lXD7pL/kaXrA0U8B
 m6535QdI3HouG9gowKfs6lxWkTFdk5GhtbXsHcPV+J3HV99jKFv/Ji6krsziqWyz0zE3/r8+G30
 5AQ==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> There are cases where SPI transfers are needed during times without
> interrupts like shutdown when a PMIC should turn off the system.

> I2C already has atomic transfers for exactly that case, so introduce a
> similar concept for SPI. Similar to I2C, this is and should stay a
> corner-case, so is only allowed during the shutdown stages of the kernel,
> when interrupts are already turned off.

> So add a in-atomic check stolen from I2C and an optional transfer_atomic
> callback drivers can implement to do immediate uninterrupted transfers
> and let spi_sync() determine if the state is late enough to use it.

> spi_async() does not require a sleeping context for itself, so while it
> could in theory also be included, its called waiting for the completion
> can sleep, so would still cause the splat about it.

> +static int __spi_sync_atomic(struct spi_device *spi, struct spi_message *message)
> +{
> +	struct spi_controller *ctlr = spi->controller;
> +	unsigned long flags;
> +	int status;
> +
> +	if (!ctlr->transfer_atomic) {

We do have some existing users that appear to rely on using spi_sync()
to power off like SC27xx.  I suspect they are tolerating the splats, or
just don't work, but either way we should try to preserve the current
behaviour for them.

> +	status = spi_maybe_optimize_message(spi, message);

Message optimisation may try to do things like allocations that are a
bad idea in atomic context - it seems safer to just use the message as
is in this context.

-- 
Mark Brown <broonie@kernel.org>
