Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5F3DAADA;
	Thu,  6 Aug 2026 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001436; cv=none; b=E0pGWds1fY2CBsizHc68NhZf7mu4GdGnI/k8pn4VjzJrYe5e0E6uaA6X7+op5+JvSNHk4RMoQnCfaOakG0GnVE2RGvtrJb80b5urc5Do+Nev/wmAGJmjS2/rn5pYWgrRTx49h2OxGAeZzYTEHntuV09YeS70lXV1Wf6YzdN3nF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001436; c=relaxed/simple;
	bh=M5wCj5yMlzrvXhhMZjJHhH5pWVeg7pbTSfieKrduzVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isWRpq1Bn4A7rs73j8SicCFqLwbTke/1vz96ixD3Bvq1l7zQo5+ie8ILeI/n6wzW8jtvFGKrlxMDwh/ZfsHsA2rBpuhmsbMprK7x7Gkuf/7u1BhxsqxHB5QammltCvPtFH8WFT65p/zPgblhPHSk6NRQ+iTGR5/RsnQeexJVcyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRyOE1Mg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRyOE1Mg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BCE1F000E9;
	Thu,  6 Aug 2026 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786001429;
	bh=sriUDwTR46M4v2fi1V9MahMTpwr2gJtRvWz0j8MQg2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NRyOE1Mg/CqRf6+Hv0XADAWEJ1Qpja3BOFQotUgCPfKdHXh9hHWCneLF2RhRQCILT
	 QgbyvblSIgPt/go/LwSruefcwlZqPUI3kcdJWqukQKGPcrCZ63f+vkTT20ogZCdzUt
	 rqgt9a+TDCUKe2LsiZAcvIKvzJYrfWbw84ga1udtQ4yad6CzP4mvHvFl5XjlzuGxT+
	 fk0DApe2R+2bk0uEZwxTYEX0H5TPPTgJElFUBMYdTLkyFrxTtasbgbsX5sEjK3X2DG
	 zPCzv1L9BCDmWny9dI4vD2jqMAk0huMnlvlZeP/ytRYj/WqND9vXdU+uanntXl/7+q
	 sX/JvbumInMbw==
Date: Thu, 6 Aug 2026 09:30:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Swark Yang <syang@axiado.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] spi: dt-bindings: snps,dw-apb-ssi: Document Axiado
 AX3005
Message-ID: <20260806-annoying-golden-bumblebee-cd65cf@quoll>
References: <20260805-upstrea-ax3005-spi-v4-v4-1-5b8bc11cb841@axiado.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260805-upstrea-ax3005-spi-v4-v4-1-5b8bc11cb841@axiado.com>

On Wed, Aug 05, 2026 at 10:06:22PM -0700, Swark Yang wrote:
> The Axiado AX3005 SPI controller is software-compatible with the
> Synopsys DesignWare APB SSI 1.01a programming interface.
> 
> Document the "axiado,ax3005-spi" SoC-specific compatible with
> "snps,dwc-ssi-1.01a" as its fallback. This preserves identification of
> the AX3005 integration while allowing the controller to use the
> existing DesignWare APB SSI support.
> 
> Signed-off-by: Swark Yang <syang@axiado.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

