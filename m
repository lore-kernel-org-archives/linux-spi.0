Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064672;
	b=TQ+VzTsZIA7T8KTam/MviB+ZF7pypwMkAVn+4fxwlGFiF0tYZXmkPdkL+zOj+PsBj4ck
	 4SQN6JKfP/+fqm6utI2b+XwjdJgIYWFB55FF1NXhKrbNUGz0K6GxugNGTGQsvk98F6cC4
	 bZ2dHNK30vFs+NB6ITxNolYoZBdcum0nglwubtLpzn0pNeBXv4KG3iq3P9sg7M8Kv+vIq
	 TG47ip02IAYQhlXu6tXrTcy1aIxoCX/ej+qOP4Qeib6wLMD9rw+8K2HuNM/Txiap/QzR5
	 U7X0HAzhkAcwmI9OREsmcmLu8bxXF7qNRg0vivbmaHhpODBd8veMuE79u+xDLR9nYxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064672;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IUb+651YdzCoQqSqdigH/XKlBS5eKbTWBJ1e/5wjJ2I=;
	b=g/Tp3KD902sCQ4NBhM/IK50sAuKGS8Mc+DeMIOvq89fmMrWgh6JYNECCjOjnuHK1QSuW
	 mxhRMqgIDcziFBK+4zeC5cv0t1+Il6Ad1N8SCMJgBZlAgvdxAkPSMWh8QOFUOvajJDbsY
	 6pj0di6ksrGE7qdLikxy8iVSDlwimM70FfqpML1jTfzk4aetPrBq2niRRixCq+ZEXP8Uv
	 DielGr9uGki1lyBFR9EdPeng4xCdznU0CEr7bBvYh7Fi3PlUIr2F20CG1JuknBBTakS3D
	 WYtEcNPjGgaqbPVkg14nuWRxeXjzO35K7WjqoTHjV7mypyUFqBP6myhD/+nEgYktrRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k54bNoxr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE5606B890;
	Sat,  7 Nov 2026 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k54bNoxr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765961F008A1;
	Sat,  7 Nov 2026 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794064671;
	bh=IUb+651YdzCoQqSqdigH/XKlBS5eKbTWBJ1e/5wjJ2I=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=k54bNoxrhWAieKkADb9M15mFGlbftkOqB7BLaZEWQyJMCWt1Sy/SvtlfXDttH/mgo
	 Rn8ni1PQVUlSKC7GO48I3WK2A+nqhoCieN0Sj0xb1QK676BeymattrobNZAQSAAJpB
	 Vnm7covhdwjt7ISxVUZo+X+XY8Cf7LqBuV4nxy9uLKKeCyA7hAyBdGnb0IRiWLWx2W
	 Db88j/4tKvtZGPKRHPtox2Y/D3NfxilU4GgvOyfJ8pfsW6pCoOwRjaQkEYcx7c1sIw
	 bTG+sl/q9gaSjtju+2poozmqC3pSYh+s1wMTBkHcj7npiLFs/M98r+WoxtXZZ7BJ1o
	 d96qJJ+NRVm/A==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id BD75F2AB31C4;
	Sat, 07 Nov 2026 15:17:49 +0000 (GMT)
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
Subject: Re: [PATCH 4/8] spi: loongson: Fix clock divider calculation with
 explicit table
From: Mark Brown <broonie@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
 Huacai Chen <chenhuacai@loongson.cn>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Mark Brown <broonie@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
 linux-spi@vger.kernel.org
In-Reply-To: <4b36ba4220b30e5dcc1dccf4db3a49a57c65122a.1793689461.git.zhoubinbin@loongson.cn>
References: <cover.1793689461.git.zhoubinbin@loongson.cn>
 <4b36ba4220b30e5dcc1dccf4db3a49a57c65122a.1793689461.git.zhoubinbin@loongson.cn>
Date: Sat, 07 Nov 2026 15:17:48 +0000
Message-Id: <179406466807.3424803.15440704784819901040.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=broonie@kernel.org;
 h=from:subject:message-id; bh=F7zgLPzOg3wBi9aOTA5eCNeKcsTLrFj4rC58A+YeHNg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeO8oyfur89YR/397/zbJcDS6Ffga5jg8jGuSc1wpYN
 eTV/nvWUcrCIMbFICumyBKXxf2yvuT1Gr6DC9tg5rAygQxh4OIUgIlsMWX4Z3v+zFw+i2revrat
 Lya8kTE0ubfs1gLGT87vuy8Eal9bvI7hf9mLM7rz4rjKMj9deZpoLcC00v5kwvp5MW2KP4QW3Jx
 2kQsA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> loongson_spi_set_clk() previously converted the requested divider into
> SPCR.SPR/SPER.SPRE using rdiv[] and fls(div - 1).  The rdiv[] mapping did
> not match the actual divider encoding, so the programmed divider was
> usually one step larger than requested, and the maximum divider could
> index past the end of rdiv[].

> -static void loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int hz)
> +static int loongson_spi_set_clk(struct loongson_spi *loongson_spi, unsigned int hz)
>  {

> -	div = clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2, 4096);
> -	div_tmp = rdiv[fls(div - 1)];
> +	if (!hz || !loongson_spi->clk_rate)
> +		return -EINVAL;

Does this DTRT for ACPI systems without the rest of the series, where do
we learn the clock rate from them?  This is tagged as a fix but not all
of the series is.

> +	if (i == ARRAY_SIZE(loongson_spi_div_table))
> +		return -EINVAL;

The driver should really set a min_speed_hz so drivers know they can't
lower the speed too much (though it's unlikely they'd want to).

-- 
Mark Brown <broonie@kernel.org>
