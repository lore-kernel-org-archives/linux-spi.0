Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B59136E468;
	Mon, 22 Jun 2026 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134787; cv=none; b=iPry6/hMYQz1Sp+YyPx6EsVHroav86HUq+4ux9PG6HGLqu8Cf++hGslmSeXAkKrc3ZEmB6XZfol8HCkH87r0GKmqzR38kDlZa+r53Hr5QS2GXirMWRdlErKGYdgAwnSFOddn1/NvZI6WL6mDLIOa3h/TPM3KkIfATGTOjFiuF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134787; c=relaxed/simple;
	bh=MT2fqqoSEWX/oZYqrPo31IJHqlA0R77vnQdFJYGcz3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzpGF8X4HcC30wvIJOK4zmjGs+ueVaKKRXciVqWi8ILXzky7Zdrxt0jKkCIIdB3LJTPhrwCsBCl97F0pbP798TUw/e509O/MiW3lDKDp/owN6Jbu1ZMDCDbDCj/bRkUKrmy2+qTuHJ9YOFmj3TVYVOs/GI3tiKwliH1Ky46Y6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2xnT+2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2xnT+2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B4B1F000E9;
	Mon, 22 Jun 2026 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782134785;
	bh=mNvAJ4vqqGIcu3OfuNyRNoQmCqh+htmYpa/S7+Nmfug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C2xnT+2OhYyQ3LJDjcK3ORSu0zpDg6bP/Bs+PRVaBjlTtYIdHGG+zumA2PTzqhLmP
	 ncTKu3QFBvQwwD0pVNbSEzDAiW2Of0ooNvOSB1/t3ptY7qNkyl4sDX15sx/bDWnzk9
	 exUx68UYqBkIls0Mk3jnJdzzJyeNmqENch7zx0MrjYElFVoRTvDOhUnKZPTP/Tt1wk
	 CkCwj4nuCUKdCTz4VWGyjbsrwM3fHVns041A4WGrFbm86McYQSn3F14f21pUjBRWc2
	 wLDoBnbUcx5XRuvGF8zliECIBtgPOP11EILTAiSl/8EmYLkvU533lFiVSlm/7cdZ74
	 FYVal2fpjWD4g==
Date: Mon, 22 Jun 2026 15:26:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Christophe Kerello <christophe.kerello@foss.st.com>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: st,stm32-qspi: Add power-domains
 property
Message-ID: <20260622-gabby-fiery-skink-dab9f7@quoll>
References: <20260618-add_power_domain_for_qpsi-v1-1-4d7e57bcfb9a@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618-add_power_domain_for_qpsi-v1-1-4d7e57bcfb9a@foss.st.com>

On Thu, Jun 18, 2026 at 08:46:35AM +0200, Patrice Chotard wrote:
> STM32 QSPI may be in a power domain. Allow a single 'power-domains'
> entry for STM32 QSPI.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

