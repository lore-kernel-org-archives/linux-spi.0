Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640FC302140;
	Fri,  5 Jun 2026 02:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780625208; cv=none; b=Ok/ZX4JIVkCtx0kNO6WEb+sLLfQZugx7sraiY+Jf5dgyh/oG4FhyT9U3qM/3jv/xKtKRjG6oEj244nJua6WWpPtd7+8UTMsn4zeFY2pqwBOqsUiXBLXh0ZVZNaEiG8emgpWJG/fdw8hzFGZr/6yBKm+WjJ6iY6W266/H0Gk5fcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780625208; c=relaxed/simple;
	bh=jE4Npq6em1WBS7waE/hzJqPf9rm0iCj9sX3KLXinVCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMs382cE2mpEx/doL4YZUoiqEp7+sN31B3oRn1W39rEMSFFwQbj8qI+7XXdk1J9gVsG6DJ7Yr3z07S8RTCPCIoDKFmOOq/VToXXw0L68t0CoL/B6pJveiSvKRWDAnqIHC0SsPC7Q+lNi5jdsUdIbLYSWEviJ1RYThajMTPLELtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddupZtvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddupZtvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010251F00893;
	Fri,  5 Jun 2026 02:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780625199;
	bh=EJDDZY+aCIX+Qdil6BihzwAmuQMqkYNKi0ffLlpaX3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ddupZtvpuub0ZxmHVp+BlduXhwssMF9cpWl/3kmTQhTMJPkExiOWNJFyj0jjlmUun
	 P5Ol6OMyyVYMeOGH7r0zBhoailJvN5Zhbz/ZHMY1/aYcZ+g5i80wuK+ckoeAczs+ta
	 6q4HJGfhSt8dC3AORcY6Vl+H7EGKhDJAcmYXombP64tIvLwt0doMPlBTqKtRLbBhWv
	 CczaSczdRLaMMJ2iPE6j+iM8P4wXjexIw6CP/oaouJBqWO67hV6J/+PYCS3alQSKWN
	 5m5s6p+A6zP3wNUJim6gHnRBfIxH88ntvAL09elbqCaMA9slyMs9EvBY2lPSH0HE7p
	 /4aNEb49CthqQ==
Date: Thu, 4 Jun 2026 19:06:34 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] spi: cadence-xspi: Support 32bit and 64bit slave dma
 interface
Message-ID: <20260605020634.GA1820810@ax162>
References: <20260602235825.28614-1-jszhang@kernel.org>
 <e9259b2d-38f4-47bd-8816-3940c2314e9d@sirena.org.uk>
 <aiC98CaOgjs-q39m@xhacker>
 <f1cacc64-1f27-480a-8f03-4f4b0dad599a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1cacc64-1f27-480a-8f03-4f4b0dad599a@sirena.org.uk>

On Thu, Jun 04, 2026 at 11:30:27AM +0100, Mark Brown wrote:
> On Thu, Jun 04, 2026 at 07:51:12AM +0800, Jisheng Zhang wrote:
> > On Wed, Jun 03, 2026 at 09:20:29AM +0100, Mark Brown wrote:
> 
> > > readsq() and writesq() are only defined under CONFIG_64BIT AFAICT, but
> > > the driver will build on 32 bit.  We need to configure out this option
> > > on 32 bit architectures.
> 
> > Currently, the cadence-xspi has depended on 64BIT, the dependency was
> > introduced by commit d58ecc54bb09 ("spi: cadence: Add 64BIT Kconfig
> > dependency") for marvell sdma handling. So we have two choices:
> 
> Ah, the patch is fine then - I must have been looking at a fixes tree
> without the dependency when I reviewed it, I'd forgotten that Marvell
> update had gone in.

Your 7.2 tree has commit 0c5b5c40dc31 ("spi: cadence-xspi: Add
COMPILE_TEST support") in it, so this driver does build on 32-bit
platforms now. -next is broken with

  drivers/spi/spi-cadence-xspi.c:601:4: error: call to undeclared function 'readsq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    601 |                         readsq(src, buf, len >> 3);
        |                         ^
  drivers/spi/spi-cadence-xspi.c:623:4: error: call to undeclared function 'writesq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    623 |                         writesq(dst, buf, len >> 3);
        |                         ^
  2 errors generated.

which would not happen if the 64BIT dependency was there. If
0c5b5c40dc31 is to remain around, it seems like option A upthread is
needed.

-- 
Cheers,
Nathan
