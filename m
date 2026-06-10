Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CDC35950;
	Wed, 10 Jun 2026 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076016; cv=none; b=IHuPRQMpzBtUtQ7gKgMzY97jvEUifqdAfGVH6Mg40ZkNwFc8iuniEbFzSiL6EQ5WnoL+OkdgteqJt7YFG6exDamlycW5095+RyfoajMvJzon7/DLypYIM4NQ/5EsAp2X8mS6LRTsSUvf2OYcdBaqtatEweZqAKGFwVZW3xZdtW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076016; c=relaxed/simple;
	bh=m1z0EBEsgLTuqJ7MJUeoSMkFEEqPzLbNyGT3/wGUGQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScC3PGTCZLkaUFiNxqWuOYQJUNKNRFe2eSDgTDQNcYK1mcjCSBN6uikRUKzrThJdI2Bu81fvxgTqaIZSF4I5pHROs5SYFCyiSoF+8kzKdVFjY1VkDYJP1SoklCajoGJlJByzASo4e5cHc0BtJDmPZUCb5Rhn9/w4IRPqlYE/vr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd6IYTCh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd6IYTCh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541901F00893;
	Wed, 10 Jun 2026 07:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781076015;
	bh=CCtSf4K4UeoThy86BYUBsZ/uQUCq2x1f4T70+U4q0Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bd6IYTChlH1Ys6Zyby8r6HWyEYpJXvpQClQ8GdOHlWqH3c6CaSvT/eOMVi3o8Gp2h
	 6brLwJb3atT40JgvqjOB0Wg+lrwxg+sYv5AbvwvQYxHMt5iFi2RaXF8IGLBLXION9k
	 fIOXiL46W3/6o4ohynRDzB0v+WkpZFxLIvN/X3LVMdgVm7bDY7QG29Ys/kviVcwjSC
	 esMZ1rGS/0YnkB6pP8hDeYFEAQ20dPykYh766aYctrGeYcTRlI85Ma9y9zXcCVkIPP
	 Uh5znHjCT648VfouQ8nq8SBdiDk5yAxSeYXtmHuIV6FxyeEzIpbkhlvMDj5eylzZT3
	 JYuX59omoCrGA==
Date: Wed, 10 Jun 2026 09:20:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: andrew@codeconstruct.com.au, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, openbmc@lists.ozlabs.org, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com, yuenn@google.com, 
	benjaminfair@google.com
Subject: Re: [PATCH v4 3/3] spi: dt-bindings: nuvoton,npcm750-fiu: Convert to
 DT schema
Message-ID: <20260610-competent-alchemical-chamois-275ddf@quoll>
References: <20260609163919.3321228-1-tmaimon77@gmail.com>
 <20260609163919.3321228-4-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609163919.3321228-4-tmaimon77@gmail.com>

On Tue, Jun 09, 2026 at 07:39:19PM +0300, Tomer Maimon wrote:
> Convert the Nuvoton NPCM FIU binding to DT schema format.
> 
> Document the required control registers and the optional direct-
> mapped flash window separately, matching the driver behavior
> when the direct mapping is not described.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/spi/nuvoton,npcm-fiu.txt         | 58 ------------
>  .../bindings/spi/nuvoton,npcm750-fiu.yaml     | 93 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm750-fiu.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

