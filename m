Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CBA3A380F;
	Tue, 28 Jul 2026 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220609; cv=none; b=Gp4pCHo4cUuTDLN1K5ASEUwoC1Iz2MkOkqMGxAxke89f6J7uDSO7YRl221Db15EabHasATAkklPHlCcg4Zn2m4MLeKrQh9gPUFz+TW2HWTEkyDHHPSi76BlVhALchJ0sa7Jr6gkB2Cu+E6O481evoPN1Zpa5wTPVwnYAbtqsa5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220609; c=relaxed/simple;
	bh=w0Bc4ct20J8zEDJKqqtQnKeYAp7cbRuQqk/n5x+2HQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP2Rz52/pGUDwt4eTgcxRppWS7CISV3+fRKX+BANw/Bs4WcVVtTLX14YEOp/DPvAGiRIvpBuDhA2IwahAJvtuC87y2xcp5Vv2f7TTjPscCAuMySI6tkx2G8KUURSDiZwfeidg28gLgvYoA0IoC3obJIH3Gqw4e8Pj74I8V6NfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYw6ZHMK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYw6ZHMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A871F000E9;
	Tue, 28 Jul 2026 06:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785220608;
	bh=dwbTck+tlWpY0kvq7ToJYGEkkVRqTe4Jou3Obf4YuVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gYw6ZHMKITiEvpaT0zLuH4FFtlAws7/hDelr87YxLfc0p9GBI4zwdrJPyLr/SXKHm
	 QRiaWNvRSkVExMDoQuc5K1C3xBBoTideC/67DxuuNTrQZMDoVUcye+tziSEwInMj/S
	 8wIxiNVbnxE7XTxKZaxXdoB7GmKdpsvUb9IP+BB72kWCYL6YnBzs5dDaAfYvuz9jIf
	 OuInptCHzAUJYqEX1c68LWeeRWKmO4fuKELxVpTv2sSoFIyRF5phWdga9UX2y4aDOs
	 WQ+75VwkBFaUce/okzbN/qzmbejUg+5TFQw5QXNXTNkIHnkvbFgW18NRW8GmHSQpYV
	 A0YhLQFJA22QA==
Date: Tue, 28 Jul 2026 08:36:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH v4 1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add
 Nuvoton MA35D1 QSPI
Message-ID: <20260728-boisterous-accelerated-oxpecker-149bc5@quoll>
References: <20260727091833.750051-1-cwweng.linux@gmail.com>
 <20260727091833.750051-2-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727091833.750051-2-cwweng.linux@gmail.com>

On Mon, Jul 27, 2026 at 05:18:32PM +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Add a devicetree binding for the Quad SPI controller found in
> Nuvoton MA35D1 SoCs.
> 
> The controller supports SPI memory devices such as SPI NOR and SPI NAND
> flashes. It has one register range, one clock input and one reset line,
> and supports up to two chip selects.
> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> ---
>  .../bindings/spi/nuvoton,ma35d1-qspi.yaml     | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

