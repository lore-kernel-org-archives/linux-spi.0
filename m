Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090726;
	b=X2mgxcVecg5hy9rF1vdrxbEo012NBsaMUioly9QE+i9F7+KaWgPGkgHzODDzM9McKz3z
	 zzNLZ/aN8FVzJ/JfXcAwVfmJupk+34v0lXDVKNg2geLdhTKPjTHfY5SX/tmuQH8xpSUNS
	 oFx7g+Pk5cuTydgGrz8BIHas2sZfbBS1A30/0vA7U6curL//bD0ChfdQapUKmV7WT2x36
	 RmGNWFLI0L8ferQz3zFaYxE2i/k2YWZjT00pJy2cM6XK54yANIY5nrfc73NeVeyAR3vFI
	 k8WU5EKt9VcuYrRlvQ38T6iSJJSblrNm07ytn3YR1Osm798K8bDMOTsgTcB+viGlJ3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090726;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=EJQTg5JhvHuIUn/1/qQhysiGCbqKFBLkf+Y+juVumq8=;
	b=m+JbACAjPtR6bbE4MP4wWIRRJa/hNrGGOdd+bG+JfXlmn4j+k/o7mqxeRIngCEgUfq1D
	 vgCW+GiH2siuyTgejigDNQuhkuxfStstPwAt+x7LN+b8faEy73dejqFydOuyZ4wn3/rhn
	 yUZ5Yki7OHPrgVBuJhmMJJE8oUFa8+mhPzimoApHCGzSH31kBljbirC73D9ZQnh+VLZui
	 w+sBz1LY/9RbHuJTtoncUpNKKJ8shxRE8JQD0DgSzuK58UiqixpGy9mTshFvsiGGVd9Pl
	 mShcVY/v5srYVoVMvCAEV97puXJ8i5yj/scNQTTr7rY0o3s0aqkZPVkaeBnVvwzw9NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkBu0pQw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D94606A33D;
	Thu, 19 Nov 2026 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkBu0pQw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1791F000C4;
	Thu, 19 Nov 2026 12:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795090725;
	bh=EJQTg5JhvHuIUn/1/qQhysiGCbqKFBLkf+Y+juVumq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nkBu0pQwjNdbp5A39UgvVvx92TNwUVkYq2VCNfVZgBusUKAzLxGaVQCZc41yoe7Xx
	 kAxqhvnW5AZnEocUSE9HmFpLsQuRjPEiAfSKdsnKdKiOIgkTG7WE+Rg+JWVy2dQrAE
	 7/R+C8yOMFKgMwctPGJqFuhvGw6se9m9Qi7KJ9OYz+oO6UNA5nzx9imGuaoX+z7lLj
	 Bwt/9l7Nm//zCesjz/1GzwsGgrupvpc1izENdaflUyamHr0VsLfMiZKWMDx+obSaVv
	 CEDr9EZUMyxqeHSz58yTILbpJ7FOX7gUneXHFp23MxDpN6GtR/fA6pO+zNtac2nUcF
	 Euy+dY5zWdaPw==
Message-ID: <a5f9e438-4551-458d-8df8-c8a902c01446@kernel.org>
Date: Thu, 19 Nov 2026 13:18:41 +0100
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] dt-bindings: spi: Document DWC SSI XIP properties
To: Prakriti Sharma <Prakriti.Sharma@synopsys.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
 Siddhant Kumar <Siddhant.Kumar@synopsys.com>
References: <20261119100513.433044-1-prakriti@synopsys.com>
 <20261119100513.433044-6-prakriti@synopsys.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261119100513.433044-6-prakriti@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/11/2026 11:05, Prakriti Sharma wrote:
> Document the optional XIP memory region and the properties that select
> execute-in-place, continuous mode, and prefetch.
> 
> Signed-off-by: Prakriti Sharma <prakriti@synopsys.com>
> Signed-off-by: Siddhant Kumar <sidkumar@synopsys.com>

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

> ---
>  .../bindings/spi/snps,dwc-ssi-2.02a.yaml      | 59 ++++++++++++++++++-
>  1 file changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml b/Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml
> index 7cccd627f809..efbeb59313fa 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml
> @@ -23,7 +23,18 @@ properties:
>      const: snps,dwc-ssi-2.02a
>  
>    reg:
> -    maxItems: 1

You just added this file, so are you saying that your previous patch is
wrong? ABI you just added is incomplete?

Please follow writing bindings doc and submit complete bindings.

Best regards,
Krzysztof
