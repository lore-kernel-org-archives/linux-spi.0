Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C8233707
	for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528947; cv=none; b=GCpTSIiESOx4TsMArM2c+8obvlJO2XsNHyL2oA7hE1ZNPkD+Ftptf9B8qP+CoFPfJxTrD9w431s9ximCpTl9EdM8IgPT6zjF/qqptfG3sdxtSB5fU02XhYzfNpxvGE9JPuaeApQ1nSFFFx/uAeBi5iv3ETojgR9/yrHsvn2uHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528947; c=relaxed/simple;
	bh=JEK9mlBHe33L95MU7P9BEVnJ/X5Qs1vwsrOIySFXU6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWUDy4HIFui023E+eP53MzdfsW+gk/1wIdDsIEgz84Ku1MSJtePq54uFmZ4SUd2OQMf+ZHmRrMhmQvxBZJuhBmERtleGBPNjMvqFbDeVpqvS6Day20I9lENZAfZXS5aIFyE/YQ1MznBQfsYkLB+pwn15kD64KNlGHmQJ7GMA/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sp1xRRHp; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sp1xRRHp"
Message-ID: <b3b15c31-2e54-409e-86f3-3102c6ab95ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755528942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9v146V+CMDfR4H9bDDpfH4hxL2fknmgBAsXNipVc58=;
	b=Sp1xRRHpO2uHHYpxy7a2QHA4CWQyU4JH0x9iTAYVJo7c4t6B3ruN2a0SjuceXAE/NolL+U
	eAtREJZcTLT0bJTYgax9eVnAGVw3FlskO+Q/ZjZ9V6DZ3NnmAwtMRdbwIuj0KXG5nwLy0O
	vzrCGTEvbvF7jxl4CWxjJyOs/dt+usQ=
Date: Mon, 18 Aug 2025 10:55:38 -0400
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-spi@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
 <ded7ba99-089b-47a7-95b9-ca6666dc3e29@baylibre.com>
 <87frdp119x.fsf@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <87frdp119x.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/18/25 04:28, Miquel Raynal wrote:
> Hello,
> 
>>> +  spi-buses:
>>> +    description:
>>> +      Array of bus numbers that describes which SPI buses of the controller are
>>> +      connected to the peripheral. This only applies to peripherals connected
>>> +      to specialized SPI controllers that have multiple SPI buses on a single
>>> +      controller.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    minItems: 1
> 
>>
>> Finally have some hardware to test this series with using 2 or 4 buses.
> 
> Out of curiosity, what is the practical use case and intended benefit?
> Maybe an example of such device and an explanation of how useful this is
> would be welcome, as it does not seem to fit the initial spi idea
> (which has been greatly "improved", not saying it is bad, just unusual).

The idea is to model the case where there are several tightly-integrated
busses on a single controller. e.g. sharing registers and maybe even
clocks. Some of these allow you to drive both busses at once, reading
e.g. the high nibble from one bus and the low nibble from the other.
These sorts of things require coordination from the controller, hence a
spi-buses property instead of two separate buses. This also makes
compatibility easier, since new devicetrees remain more-or-less
compatible with old kernels.

--Sean
