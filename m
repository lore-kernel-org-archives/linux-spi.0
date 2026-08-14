Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DA4908B5;
	Fri, 14 Aug 2026 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734482; cv=none; b=iUnJDxD7BEg3j73FVMAscxqJaKt29KWfmrAauiQLt9D+PFOZPCQ/nxnGxDwOH14eUlMo01I5gXpiCWE25DqDi+G3/0eQo2fzBfM0Nf5L0n074/qtUeJnLJ9lkbRu9p8ZgxrnqQYrU1/RRhFOzF/wqg3Ybd9hLAwzhDwwl+0FHQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734482; c=relaxed/simple;
	bh=DfwN4wUJYIBH4+mWePMH+NwRLqUAC5YZ3yzUksIO5Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXXWZ8cmps+P5r8JvwhyT2Dpqwm2Xce6yksum+kqHRPUKfJyN0DmMxS2Svpqyb5QTxUT0pTQ9RxqKMOKsV795Sye2SIwG9qN3Sy6NOhvwZte4rfKJcvbAU53MwiQ8/CU6WbjjvFsZ2bvXFKsKyZNfMBzG85N+JsP6soGmekjOCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku2v2QXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku2v2QXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFB61F000E9;
	Fri, 14 Aug 2026 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786734480;
	bh=AlFnFinqOG+lpIH46M7c3gdq1dWVIKx/tZ41es1dxCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ku2v2QXI2Jd1TCZiZMEuvSed/TdPGnfIcyxUvPXC0fMJD7YKu4yL7lQjQBC/rqhIK
	 G97Azcmt2t6xPce8OAhNA1WzuK27N5U4TFg8VzZFMgLF+qNtoimXghpzmcBMsTXxQX
	 TrqaxlItBb/SYhTV1jVtcRZIOB7Hrd0gLNHK+1musSKxFpecWTHorZuth+X+8TZDPT
	 WrK+AYL86QkOT4y/WllsLhAEQIckKisQZZwSJtuvle1E6AXR+iZZgk+TCUQxUMfLDb
	 MLfCIds92gXv8EwEglSnk4I0yUZGlwg7Rcft0H7Px9MLwxs2IFt4S5zlRzEvFvmnlB
	 Z9puJVSUzOGfQ==
Date: Fri, 14 Aug 2026 14:07:59 -0500
From: Rob Herring <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Udaya Kiran Challa <challauday369@gmail.com>, krzk+dt@kernel.org,
	conor+dt@kernel.org, skhan@linuxfoundation.org,
	me@brighamcampbell.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4] spi: dt-bindings: microchip,pic32mzda-spi: Convert to
 DT schema
Message-ID: <20260814190759.GA2496807-robh@kernel.org>
References: <20260814083221.34606-1-challauday369@gmail.com>
 <e7efc91b-9d8f-4344-982b-c2b5014985b6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7efc91b-9d8f-4344-982b-c2b5014985b6@sirena.org.uk>

On Fri, Aug 14, 2026 at 03:54:55PM +0100, Mark Brown wrote:
> On Fri, Aug 14, 2026 at 02:02:21PM +0530, Udaya Kiran Challa wrote:
> > Convert Microchip PIC32 SPI controller devicetree binding
> > from legacy text format to DT schema.
> 
> > +maintainers:
> > +  - Mark Brown <broonie@kernel.org>
> 
> Try again!  :P  I think the DT people had some default they used for
> cases like this, but ICBW?

I'm the default, but really I wonder if pic32 could just be dropped. No 
commits from a Microchip person since 2016 on arch/mips/pic32 or 
arch/mips/boot/dts/pic32. Almost all generic cleanups otherwise. These 
chips appear to max out at 32MB (SiP) or 128MB DDR2. 

Perhaps I should send some AI patches against it...

There's this[1], but no updates in 5 years.

Arnd, Thomas, any thoughts on this platform?

Rob

[1] https://github.com/jjr-simiatec/Linux-LTS-for-PIC32
