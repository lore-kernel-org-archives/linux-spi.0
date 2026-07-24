Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E1139CCF0;
	Fri, 24 Jul 2026 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784881996; cv=none; b=BuGHQl8OTvDGirIWGDZpsZMVN3FCqcvklHSFppdzK2jUpn++lJDjGll/SR+vAOs0KGxO1jWtAKd5XQwLRxXyEnhF4pfoQo11opW0UJGlaj2pY/20fQX6tZ0txoLj/v5TBzsBvEH1VHqX+8X1WV4hXBU0q4Mj03iosEQRZvUR3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784881996; c=relaxed/simple;
	bh=/9RfmRuOggqPh9qT3UvO1SJjQXAGr92NMgFkX2WD9XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICgHR3JnEan6LO+wt4Zpg2izG6dyq7Is3gxS/+gFdUGLpQLw237IiTQInNHZLYLJlXjRIZNz3dLekXV60qz8f0bHZ5VyX1ja9F3au+382UaLElSqbWlKp116GfzxeI8aNjT6QBMSZA/AK9UUVuyNLuce9vdTacnYI7snAp5Mo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ampYFdQn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ampYFdQn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2701F000E9;
	Fri, 24 Jul 2026 08:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784881987;
	bh=LN6epFAXj94W01ANju+cx76s5A6fmu89df6SvpZHcAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ampYFdQnT6olqGCEhZo/RwVQU+4bGJTM8lKFvk2088Qss5oDlvM/v+jZdn8xHTmqY
	 I8hhh2I9F4Ze3Akq+Qm1nvAHfLeOOCenl5Lqs8S4otbUwSm+mv/YlAO6gc4Ab4NV8o
	 yCyQfIqGokYYApoiQOou3A3kNuuoP+cq6TZYKMoDep8SA23alTBSC+CYlDNhPzO+nv
	 Q7dutGmeuVS3FIvjMZItw3buknaCbRv+Eo5su2K/KmgBsA/w8A3C2f2WjwsjmbBwJ/
	 htulQkMYpqi6Bsql653D1aqpT35+P+kS8Qms79+zgWtO/dL0tybECjMhypwvtT/JEy
	 sFm0G2pucN8pA==
Date: Fri, 24 Jul 2026 10:33:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] spi: dt-bindings: amlogic: spisg: Document
 A9-specific properties
Message-ID: <20260724-whale-of-fabulous-saturation-df4d9f@quoll>
References: <20260723-a9-spisg-v2-0-9fc39106b7e2@amlogic.com>
 <20260723-a9-spisg-v2-1-9fc39106b7e2@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723-a9-spisg-v2-1-9fc39106b7e2@amlogic.com>

On Thu, Jul 23, 2026 at 06:43:42AM +0000, Xianwei Zhao wrote:
> Document the Amlogic A9 SPISG controller and its additional
> Device Tree properties.
> 
> Add the "amlogic,a9-spisg" compatible string and define the
> A9-specific "amlogic,mo-idle-output" and "amlogic,word-gap"
> properties, which configure the MOSI idle output level and
> the inter-word gap, respectively.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  | 38 +++++++++++++++++++---
>  1 file changed, 34 insertions(+), 4 deletions(-)

If you are going to send a new version, please re-wrap commit msg to
match Linux coding style.
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

