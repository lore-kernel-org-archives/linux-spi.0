Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870238F636;
	Wed,  8 Apr 2026 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633195; cv=none; b=hHW4Ksq/VyPjIJ8+NJ1b77LomfPmkiRkNUI5fI6PpPClWsnQ6a87Y7hvmiPTH8pwQocy97gBdkHAWV2PzSmIskacfO0WMcw2RKG9R1e72fHguombgpVtT6Ld32VX57PrYaUmM6qQJmtsnB2PSd0hzH1Ys7ftwPAqWGw3xRTVNWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633195; c=relaxed/simple;
	bh=4NBiShZ/h2rEvYcdoJUt8l7NgOqvM6MCvXi49uixGEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8hFXLa7d1goqxgw+uwt8aT/Hn6q3Cigfqsnwy0i2vPuoGUj0uYgJjHCyzm80VKZKqp4ztITKDhyMQpBD3oDT5wcTPwwFuNHfDWH/hErr00eG8/AUaeRunef2AdbMJZYM1TuQW9jwXgRNxqD8FCtWUgMAF566IkMwiuIHoH+jgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYuepcQZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYuepcQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFFDC2BCF4;
	Wed,  8 Apr 2026 07:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775633194;
	bh=4NBiShZ/h2rEvYcdoJUt8l7NgOqvM6MCvXi49uixGEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYuepcQZ742GyG0hrBPFyelTumZcGebfmbMOMSmRgwvaxAoGV7Pz7f/3QvWrITbvf
	 Z75LEspRe5aAFdTE7UAEJFP4BPO/HUeZ9nj1GSBag0gieYJWuyLnvFz0QLsXgEUovn
	 Hh4zcCoGv2VH0fXSnIdSntbVZSlXoxgNY+zjiD9pSAYD27s/B8d49WT1GEe4ku570q
	 MEBoyFv7Ne7Ae7lTVVQTY7/cfU3KNLGRqFKru4wxsqbPWybxThwimfpeSm6/4STcAs
	 zgry+KTGZBIuCu1QJMCTLK6v10y5iUaKREQlzRVT/lwPYqIgdd2h8imiNvPV3ChfyA
	 H6VHyRahyEDbA==
Date: Wed, 8 Apr 2026 09:26:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: renesas,rzv2h-rspi: Document
 RZ/G3L SoC
Message-ID: <20260408-outgoing-provocative-quokka-8dc4a1@quoll>
References: <20260407145753.101840-1-biju.das.jz@bp.renesas.com>
 <20260407145753.101840-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407145753.101840-2-biju.das.jz@bp.renesas.com>

On Tue, Apr 07, 2026 at 03:57:50PM +0100, Biju wrote:
>        - items:
> @@ -90,6 +91,33 @@ required:
>  
>  allOf:
>    - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a08g046-rspi
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 2
> +
> +        clock-names:
> +          items:
> +            - const: pclk
> +            - const: tclk

Blank line here, but no need to resend just for that.

> +        dmas:
> +          maxItems: 2

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

