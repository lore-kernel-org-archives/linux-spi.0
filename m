Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08BC10F2;
	Sat, 15 Aug 2026 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761172; cv=none; b=B2c1InHYNQ3UY63AILThQiMywP/rL/AGJZxraHHNCAwa/iDaVbKTgIAg0ns1Gihc4nawG8Fp098j/eodVV6g6mvfnnxldT2Tc90/xsFTed5nyl9ipE58kEYQXMXBCX0lz+BQs1GMyiQPQigzW6T4xE4oP9XcPKBqqvCdUJ1eng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761172; c=relaxed/simple;
	bh=coBX8vE1oP3dXhBWhX8r/5fMm6jnvtpL3zOeEuBtyks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVgri1epUg8hYaqtp60ej4NvfaX8IgJqecW7Oe4Ye/0TPiXKlKtHErnCRmRaDpXN+ZOALNXhAIZIwC7MaaOA51JeOj4aVzvQGDy54A8Y14jQ4HL2Ls8Eafv1RTOtvqK71j0A0sQPO8Wl7ny3u8BSKJFalgN7gaeB9fU7pdTK74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 028081EA93C; Sat, 15 Aug 2026 10:32:42 +0800 (AWST)
X-Spam-Level: 
Received: from [IPV6:2001:8003:8802:7000::9c4] (unknown [IPv6:2001:8003:8802:7000::9c4])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 9A92A1EA934;
	Sat, 15 Aug 2026 10:32:39 +0800 (AWST)
Message-ID: <f2f4be53-2cce-4517-9e37-518150b7764b@davidgow.net>
Date: Sat, 15 Aug 2026 10:32:36 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] spi: Add KUnit coverage for DMA mapping error
 paths
To: Honghui Jiang <jiang_hh2019@163.com>, Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Serge Semin <fancer.lancer@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20260814031419.43378-1-jiang_hh2019@163.com>
 <20260814031419.43378-5-jiang_hh2019@163.com>
 <an8JaNLIy4je-tiG@ashevche-desk.local>
 <93950eda-ee8e-4a28-8e3c-707d64c956fe@sirena.org.uk>
 <53943105.8b50.1a0015a531c.Coremail.jiang_hh2019@163.com>
From: David Gow <david@davidgow.net>
Content-Language: fr
In-Reply-To: <53943105.8b50.1a0015a531c.Coremail.jiang_hh2019@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 15/08/2026 à 1:38 AM, Honghui Jiang a écrit :
> On Fri, Aug 14, 2026 at 01:49:50PM +0100, Mark Brown wrote:
>> On Fri, Aug 14, 2026 at 03:27:13PM +0300, Andy Shevchenko wrote:
>>> This is a stray change.
>>
>> Well, one of the config changes is.  Clearly spi is critical enough to
>> be tested by default!  :P
> 
> 
> Thanks, both. I'll drop CONFIG_SPI=y from default.config in v3 and keep
> it in all_tests.config.
> 

Thanks: we want to keep the default config to only match things
otherwise enabled in Kconfig (via CONFIG_KUNIT_ALL_TESTS=y).
all_tests.config is the right place for this.

Cheers,
-- David
