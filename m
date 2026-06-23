Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D225B0BD;
	Tue, 23 Jun 2026 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199005; cv=none; b=j8EGx08RToJubdyizTizCvGwlx1EvI8lFRcwkhydSN+3rid/Jk9gDGe66Nei8m75TvzjFLDbJDLtCy/Zjt5jJAUrm/pwvPWUNQryVas2yGGc8Wwub7ov1hOLAXBvRxg8f5QClZff9J8JQ2PDm7FSMvxcl589+XcDWCxyLK1Ddi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199005; c=relaxed/simple;
	bh=gpnTGdcztncAjW8i8Gv7WMGY7xQWt1iK0mNs8BKETCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNnUibOHhEQ0GD9IA5i9iv12ppGUoG/Kv5XCThJe4izrclXtGJvlfmVKnMb3kA5dAZHt1VvKfLRdmbJEeiMZZveLpNqLU6agVPgx7L+JRXydGfKYO7BwS7GKvoTehInsV5tfoLgHKnT35y5Hhqb/Sl2DboZlPbQL1U7vutaU3yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5CfAzdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5CfAzdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DAA1F00A3A;
	Tue, 23 Jun 2026 07:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782199004;
	bh=/yBQWoIX0me/kOlOjp6A2PM4P/0tQRM9KzZq2kfCXQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h5CfAzdIb6VramPthISKStfJdMzxXg+18AJ1qlXC2q7je2HpqpaF7AxMnSdXQAIzP
	 Sj4JgJuAhM2B2/gKTSON9NbNyB5PcNuqQ41T6LqUjYmlc9kI/9kZ2N0ART/knO2nYn
	 1QLh9dhgmWH+4KmUXZ7Zlna1jXG365gxIt9KgVzyOXJkBtNOBXJ8sVrjMPJh0G2OVV
	 Ej0dBOMZ0wqMXgAdmP8LBva/Qp3iMD6khTIMuQHMV7/yus6q5Q11qvSseK7e6p9LjW
	 S0XonmfjLvUzFZ/JmQ8gWO7vnEFxckye+hNZXmxkQohwCPWmJzbNGfG7AbNTGkmalL
	 YzIesEIkM6SKw==
Date: Tue, 23 Jun 2026 09:16:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Herve Codina <herve.codina@bootlin.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] spi: dt-bindings: snps,dw-apb-ssi: add
 'power-domains' property
Message-ID: <20260623-banana-bettong-from-saturn-417cce@quoll>
References: <20260622174806.74450-5-wsa+renesas@sang-engineering.com>
 <20260622174806.74450-6-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260622174806.74450-6-wsa+renesas@sang-engineering.com>

On Mon, Jun 22, 2026 at 07:48:07PM +0200, Wolfram Sang wrote:
> On the Renesas RZ/N1D SoC, this SPI controller belongs to a power
> domain. Enable the property to describe it in DTs.
> 
> Reported-by: Herve Codina <herve.codina@bootlin.com>

No bug to be fixed here. Usually incomplete hardware description is not
a reported bug.

> Closes: https://lore.kernel.org/r/20260622132842.7e0d772c@bootlin.com

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Change since v2:
> * new patch (Thanks, Herve!)
> 
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index 8ebebcebca16..3896ee02d7b6 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -88,6 +88,9 @@ properties:
>        - const: ssi_clk
>        - const: pclk
>  
> +  power-domains:
> +    maxItems: 1

You should explain in the commit msg that likely other devices belong to
power domain as well or likely can belong. Otherwise based on the commit
msg I would suggest restricting it per variant... except that indeed
these other variants could have a power domain.

Best regards,
Krzysztof

