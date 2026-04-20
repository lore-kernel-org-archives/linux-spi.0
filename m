Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF83C13F0;
	Mon, 20 Apr 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694774; cv=none; b=fER9H7UAbPBec0vCcERcz0rHKDcBWytDReE28LwpuyWVD55E8sO5lmLD9Z1pscA3l8P9zRhFKvfC9C5Kbo0Fl7w7ELEphEq4aryG4dmhLuQ8n6IgIWfh5AjmffTs7nLLGYBsn4//xKQSJetA6oLeII4ri3IR7wWbiJB0ESkXH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694774; c=relaxed/simple;
	bh=vYuteQOqncFKuZDg/hkzqreA4qSBcyQX/zTweLXdQY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fxntfkf0wHiJRX7SMOse32kII0b1yf9v3yj99s/asOjOn+7MISMhQ8Up3Pt4WahbgBcO5q5sHfDumgALYtfsdVbpr50mufxQCbXg17BOk5bVxobeonpAKV8BqQv9ItbC1GW/fVlJchF33aoXL05l7qaTS9cFD8EQJEmO6i23rMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3tT5Cj4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3tT5Cj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B148C2BCB4;
	Mon, 20 Apr 2026 14:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776694774;
	bh=vYuteQOqncFKuZDg/hkzqreA4qSBcyQX/zTweLXdQY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3tT5Cj4laZVdePRqkCywpxfNx3azCQR3bhLlbDZx2TzOR4M6D6YZpTiMRZCQw/SW
	 mVVOs1hSWjLs7NxhNYiSUUgHTH9WZGfD9/zlgjVeTONNJW+5QsJ2GIKpkHsykaMNNd
	 ebg2tIamen+x5c37o/a4UccOSNCMO/fef2iEPcWWuZz1jI8W8wMFL8h9NT1X/KpM0m
	 j+jCXO6FPSZhO6Cadid0GmMstI1Y0wOtJbe5xsdiiv0Tw9AGEqd3+D5TXFfsqPFStk
	 2MfADh7CpB9Hts6VayMypG8xS5NPm7Q/3NtAbBrHZN0QFytkL0yYTPgNj8vaOspn4N
	 6g4gI8FMy7kbQ==
Date: Mon, 20 Apr 2026 16:19:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: spi: qcom,spi-qcom-qspi: Add
 qcom,qcs615-qspi compatible
Message-ID: <20260420-flashy-shrimp-of-courage-acdf7f@quoll>
References: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
 <20260420-spi-nor-v3-1-7de325a29010@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420-spi-nor-v3-1-7de325a29010@oss.qualcomm.com>

On Mon, Apr 20, 2026 at 11:42:48AM +0530, Viken Dadhaniya wrote:
> Add support for the QSPI controller on QCS615 SoC.
> 
> Move allOf section after required properties and add if:then constraint
> to require minimum 2 interconnects for qcs615 variant.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

