Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919931578E;
	Tue, 23 Jun 2026 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197448; cv=none; b=VLkxbvEQ39euFVcq7l1MVTyjoyo5Fptk0cqDcrDhgLG7BFCApKcT5RsAP/zm846ZtFGKouwKD+VJHfoINtsy0Yy4QvD/Vqap3EyYLjYaloZKQVrJM411MuLgWCIKsNH4wC/ss/Q3TNoB6c0XTY5tGeWBuj69CuZzhugo/mRlzEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197448; c=relaxed/simple;
	bh=bk1D7Hv2j5LlFxzJPfk4eEz1qtWqPt73+9vzRO6kQjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qchmK0EnVaFKKWzSWEZnLPk7Qh9zWak/WThPFqe64pUN/d60rhfIArB+OekLY+E5ilib3zVduQhBUPjLG+UvRUIRLS9vzq8AZ2pTCHjfoYur1PdzFOs1fcgqrpWygPiqIujW+MvDsB+ATxm1Smln6PZr7jQy9dhvNlDZuuWNUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z/xELTxL; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z/xELTxL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 628F41A0839;
	Tue, 23 Jun 2026 06:50:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 22C46601C2;
	Tue, 23 Jun 2026 06:50:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E149106C89D0;
	Tue, 23 Jun 2026 08:50:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782197442; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=L/lBbAF7XdZGIhYkOZjtkdbea2sZjVKjUy3nHeAK2II=;
	b=Z/xELTxLErzhUdG9d/ub0GxDPQ4cFiRuCKHaqk5+km0hZJHurnA7K6NZdM1QtXjy+UdUB4
	JF6l98q9YL0UdwZIpwp5Di0MsNTqxHBvNk+CBA7IJWbC9Ptj6CxOeyrUoHATmbDu6hBxKE
	Xojb4GgI3KYL3tcnNoZ0ys8QTMWtmv+XHaue5E0st0P5RX/Tz97vrQBa6hWK2Iv9zsuJL5
	bs3wPamDFZhdGS94b1EgTYAU/KCIkVhrK9q+MAt0EChjp8nC7UcMRYkJB9ogdPE4YlaZf1
	i+LUuElHv0CdZ4T6Ijj+gY0aj99GFuJPzJqF1fGUiHSze9TLZZHTqEx6fjJACA==
Date: Tue, 23 Jun 2026 08:50:39 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] spi: dt-bindings: snps,dw-apb-ssi: add
 'power-domains' property
Message-ID: <20260623085039.315235c3@bootlin.com>
In-Reply-To: <20260622174806.74450-6-wsa+renesas@sang-engineering.com>
References: <20260622174806.74450-5-wsa+renesas@sang-engineering.com>
	<20260622174806.74450-6-wsa+renesas@sang-engineering.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Wolfram,

On Mon, 22 Jun 2026 19:48:07 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> On the Renesas RZ/N1D SoC, this SPI controller belongs to a power
> domain. Enable the property to describe it in DTs.
> 
> Reported-by: Herve Codina <herve.codina@bootlin.com>
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
> +
>    resets:
>      maxItems: 1
>  

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
