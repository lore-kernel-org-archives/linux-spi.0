Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10163CFF57;
	Sat, 16 May 2026 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778926401; cv=none; b=F7mZ9qygU6uHAK9C3AwF/UkkDZXHuYMaCd7UluDIXmkqf3iaT2FabgqhN4eNudei+t11VV6Ep8gziO2VpS9cFtZxAj6v0Z3F08+ln46TFaBvFYhLEIucOmJnVUzdSf0FN7fRHb4UjPO4w9byVMCR/N9XKfpW6kI+aHa7DCrr0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778926401; c=relaxed/simple;
	bh=0z9y0efjB/u6lremUZZm22NCqH/uWoAMARIiO9P5lAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTOw5u3xiONZbQKIuanSyMkdAk6psA3RclW4fofcx/ZcS/tyfd1t8QiRfq/HsZaNaD3Plgvjq8bvrV7i8LXcFsT3j4+X2LBY97bTZ89Zy53sSi5+5nR0FVEpkZ3jvLX+MYuZSIodDwCFbjyEXLksQcoimu0TciIY1B1SbtnVGWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLeD3MRC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLeD3MRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2021C19425;
	Sat, 16 May 2026 10:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778926401;
	bh=0z9y0efjB/u6lremUZZm22NCqH/uWoAMARIiO9P5lAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLeD3MRCAk5bA6hszIk0YjX/da0tgtuImIwfhbCR7Fay334594RRF8KMrVXtbYxpN
	 +XBAqlEuxyK9Kr/hSAEPtA1cxyd0HjRVw8ciNbGuh9OelSWOCnS5+xW54NwIFoMnmt
	 dIr+5p/yHrGo2c0wG69LgYXorXigY+Tvx8sJ9oISVtTPwUJSixxJ51DYs057FtuVBn
	 VAI5ddWonVPZkpiWyn86UlabWqgaE390a5bBD5+ZzHPNtiokBAiNWhzkjl/BgU6Y1I
	 88auXfyizQZB9y5cjK9cFhhT3AJTxZCbTCPSkq3ECC4azdKRzJXoBYBvfleXOOv02O
	 l5j5sB72NSI7Q==
Date: Sat, 16 May 2026 12:13:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: dt-bindings: tegra: Support dma-coherent
 property for QSPI
Message-ID: <20260516-heretic-chinchilla-of-memory-0a5fcf@quoll>
References: <20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com>
 <20260515-tegra194-qspi-iommu-v1-2-57dfb63cd3d6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515-tegra194-qspi-iommu-v1-2-57dfb63cd3d6@gmail.com>

On Fri, May 15, 2026 at 03:35:28PM -0500, Aaron Kling wrote:
> DMA coherency is supported by at least the Tegra194 and Tegra234
> controllers.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

