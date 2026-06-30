Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD5C14B950;
	Tue, 30 Jun 2026 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802232; cv=none; b=FpvqTwQtiYcyqNRLQAGhkDCJDN5zVp34R5HU2NrQWJLzxUT2Sbo/kvJI3nGSCRu9cBngALxpW2z+q7NYtc7CBGiwRal5TGlqVIPiRq9/kIzbON/wM0eswJzkfNo2igivoQt+8JvaKc5KZSbY77ugQLnuhWKl2d+4aSy+2qHLs9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802232; c=relaxed/simple;
	bh=G7v7cBPUKqlgp44fRi3PxwZNj+P2y90iupApGhHuggA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II7eDWV5APCYFPM8DdoBk2L3LJsUqyczTz5KDBe7YVnH9E2IgYvQAE75KCYuS0rK/GXF0TskNSaVyln6saIjEXP4F0u2FvA+S7YNpdilXAthYW2ddYA+9JYm3LUAd7Yhkb4YqSi54+SX6R5/xHY2f0L/gtM7ZykHLjSHgLdNaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIAnuMkT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIAnuMkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1111F00A3A;
	Tue, 30 Jun 2026 06:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782802231;
	bh=ay88Qn/lwQGvSYdaDHFtsULqFx1kYYE6vJyZMTjxAiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jIAnuMkTS6R6ar+PXcSXTj3MyhFhxHeUCrjfsiXHhY5SAqCbVr3QP6n7vVUswJ51/
	 CFcs6pMME2DkoljWhrmaksfKeZ5hlYhxKG3aL8ZzJ7RYWznt8O7elY/nWj8Ql+LptG
	 iHBTJWCpQEprEZBCF4KXPx7t3AKgXStX/+zara0mbLtIF9J9lS/dM6CsP/loS9ciZ1
	 +y9dwlGm5USypei7/GRz1Dea3Wym/epv3SkKA88MhGWu0P2kITXdlQW37nQbOnRgvD
	 UgHJmlssmsItPcwb4QzbFA4EaCa9i1GNqMgN+dc/49hulhssikrrJ7U4uZsBNDwZuq
	 g4JgfcM+zcfoQ==
Date: Tue, 30 Jun 2026 08:50:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Herve Codina <herve.codina@bootlin.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] spi: dt-bindings: snps,dw-apb-ssi: add
 'power-domains' property
Message-ID: <20260630-formidable-strange-parrot-6cfbfb@quoll>
References: <20260626180326.9593-1-wsa+renesas@sang-engineering.com>
 <20260626180326.9593-3-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260626180326.9593-3-wsa+renesas@sang-engineering.com>

On Fri, Jun 26, 2026 at 08:03:23PM +0200, Wolfram Sang wrote:
> This SPI controller likely belongs to a power domain for all the SoCs
> listed. For sure, it belongs to one on the Renesas RZ/N1 SoC, so
> enable the property to be able to describe its power domain in DTs.
> 
> Suggested-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> ---
> 
> Change since v3:
> * reworded commit message to make clear other SoCs likely use a
>   power-domain, too (Krzysztof)
> * change Reported-by to Suggested-by (Krzysztof)
> * add Rev-by (Herve)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

