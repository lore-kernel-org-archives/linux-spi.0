Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794893264;
	b=SGfWjP3R6mFfZGW4Qhjt+XpzlnRqelKIIQ6OxtI9h2cVp6myv8tLtM44hWffciXnfOyn
	 DoU9RHuYs1j1QkDzkGDcDTnAnlKFyF0KRkAzvRV46IUzD9xmpw1JX50bFZn6oYI/2ylML
	 SEDFjKo3WwWB/ezOPKSBFZ18piL+aAzexoAF61gzVnH/rpyGAVw49qoLss+/cjAELrhz7
	 YySqENU16UuRDbmGZc1RLZkcmVKsxajqfXhkVat1epk7xEcELVA6B2IJrDdVyMYpDFdIv
	 s7Bsrh/kAe9CfYVG0KuR5tzqnoCIn1pE7xW33bYJyCFwvedwgqXrNAuVCmHpvP343Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893264;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=eLn6ymFyC/XSk2JQ0sqZBZ7cxogTgQ5ibkxzebL4tco=;
	b=bgczIEsXib2pa5xLUPcLpXMrcmf17SehLlGbr7JHZBPA5wi2UJgytYsul91o4z4ctuc5
	 GKzBFyABJWP5NLu7NyadJZDv+6yNK1gh0uwH8mAO9coIstwRaPA2YoGP0RRyj39FzIvch
	 h3i7ko3BvJZmNBVV/j9RbeML/VJr9QlmxoZ0seO+JoLhG+ePTfX/edc5yBebAtaKyGSqt
	 V8hTWzlPhtGtnYB1tdGG3tltizzrX5YRn6iK+W74xV8mV2nkbqMGpwSzbGKogzCv98P6V
	 5zsfaum5fHhJu4TpVPln6TNvv5WRHypX7YR87122dv28QqpJLCnLo8CRdKuI/UoDqHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVaPaynO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0702606A336;
	Tue, 17 Nov 2026 05:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVaPaynO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E161F000C5;
	Tue, 17 Nov 2026 05:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794893263;
	bh=eLn6ymFyC/XSk2JQ0sqZBZ7cxogTgQ5ibkxzebL4tco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jVaPaynOYqm83VXDkpoTIxcOMpisy/oJmU2zwSlnJxlqbh66ZXy5i4MExDKHl7jRu
	 uDERwrz2Cleh62d6DF4f9HqNmu7f03qcD/rZtubHIlfqXyPxNiidQtL++a2fAsFqC5
	 53R/woxsTYWBs598B2u3DWLTH/k8EDYoxJmfmcnAtwkag538dEyqLt3Sp9+aZDZdhm
	 cpJV7u9o77ReGmGmN/iA0xpytmtTITilBCBon9lsJHaoEukrWoG/wNcf5tQgrAtt+f
	 Bn7zZ7xWN2hmIjMqeEDuEn5gCL/Wf2+muvyNSBeMnLZMD/XWoNVZwVIrMJi7ftwq7j
	 Ze4x6xWFjOCJw==
Date: Tue, 17 Nov 2026 13:07:28 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, Fei Xie <fei.xie@horizon.auto>
Subject: Re: [PATCH 0/3] spi: cadence-xspi: add DMA support
Message-ID: <avvhEI2gYHK6ayf-@xhacker>
References: <20261107072044.17574-1-jszhang@kernel.org>
 <avsRgCbjzFVdS9GI@nsa>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <avsRgCbjzFVdS9GI@nsa>

On Mon, Nov 16, 2026 at 02:26:33PM +0000, Nuno Sá wrote:
> On Sat, Nov 07, 2026 at 03:20:41PM +0800, Jisheng Zhang wrote:
> > This series tries to improve the cadence-xspi cpu usage and potential
> > performance if the allocated dmaengine is powerful.
> > 
> > But no matter the dmaengine performance is powerful or not, the cpu
> > usage is reduced a lot.
> > 
> > For example, on a dual CA55 platform, test with looping the following
> > cmd:
> > dd if=/dev/mtd0 of=/dev/null bs=8192
> > 
> > Before the patch:
> > cpu usage is nearly 50%, which means one CA55 is full loaded with
> > the sdma io copy.
> > 
> > After the patch:
> > cpu usage is between 0 ~ 1%
> > 
> > patch1 documents the dt-binding
> > patch2 adds the memcpy dmaengine support 
> > patch3 uses writel_relaxed for cmd regs.
> > 
> > Jisheng Zhang (3):
> >   spi: dt-bindings: cdns,xspi: Add DMA properties
> >   spi: cadence-xspi: Support dmaengine for sdma io copy
> >   spi: cadence-xspi: Use writel_relaxed() for cmd regs
> > 
> >  .../devicetree/bindings/spi/cdns,xspi.yaml    |  13 ++
> >  drivers/spi/spi-cadence-xspi.c                | 149 +++++++++++++++++-
> >  2 files changed, 155 insertions(+), 7 deletions(-)
> > 
> > -- 
> > 2.55.0
> > 
> 
> Hi Jisheng,
> 
> I could run some tests on my platform. Here is the dump:
> 
> MTD=mtd4 SZ=$((16*1024*1024)) RUNS=5 sh xspi-dma-bench.sh
> mtd4: mtd4: 08000000 00020000 "xspi0-nor", testing 16777216 bytes at offset 117440512, 1 cpus
> === STIG + CPU (use_dma=0)
> 
>   write                   14.32 s     1.17 MB/s  cpu 100.0% (1.00 of 1 cores)
>   write (read back via other path): data OK
>   read #1                  0.35 s    47.93 MB/s  cpu 100.0% (1.00 of 1 cores)
>   read #2                  0.35 s    47.93 MB/s  cpu 100.0% (1.00 of 1 cores)
>   read #3                  0.34 s    49.34 MB/s  cpu 100.0% (1.00 of 1 cores)
>   read #4                  0.34 s    49.34 MB/s  cpu 100.0% (1.00 of 1 cores)
>   read #5                  0.34 s    49.34 MB/s  cpu 100.0% (1.00 of 1 cores)
>   read: data OK
> === STIG + MDMA (use_dma=1)
>   write                   14.39 s     1.17 MB/s  cpu 100.0% (1.00 of 1 cores)
>   write (read back via other path): data OK
>   read #1                  0.37 s    45.34 MB/s  cpu  70.3% (0.70 of 1 cores)
>   read #2                  0.37 s    45.34 MB/s  cpu  68.6% (0.69 of 1 cores)
>   read #3                  0.37 s    45.34 MB/s  cpu  69.7% (0.70 of 1 cores)
>   read #4                  0.36 s    46.60 MB/s  cpu  70.3% (0.70 of 1 cores)
>   read #5                  0.36 s    46.60 MB/s  cpu  66.7% (0.67 of 1 cores)
>   read: data OK
> 
> The script is a LLM based one :). Might have some slop but given the
> results are more or less what I expected (the data performance also goes
> in line with flash_test), did not bother too much in
> checking it in much detail.
> 
> So, cpu load is where we have the actual win.
> 
> The test ran on an octal spi-nor
> 

Thank you so much!
