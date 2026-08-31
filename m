Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43BC426690;
	Mon, 31 Aug 2026 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182978; cv=none; b=csm65no6pnGdS+Tv1JiC9+a1QA4olfkBRWh9/ygUbM6YCwcb27OVzJiiMUqBSDNS2Uo5XBmpupKc9Yo7qDuno9oCsMlI8YLBfraq4GIViKOl8iFCrOm4+rkwPCGgOC7+uwodV66U125FN+lCA4Z1fxN7fMjk8hqQMIBVafQXB90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182978; c=relaxed/simple;
	bh=73mSS0Tt6A1dF0wd+cp2ahK9NmE2qOPfwz+DR+7Whdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAvqBPrYonnsLwcbmfhJtxXZuEP0qLwVL1xVB7f0M79UUAVKc5rdyYcOoYCXIWBpDfOuOJjhg8gAMfjQwRwgisIvZcAaaVn+eqAv8KCGmCnLzvSovFVGnNLSyUNWLeprAWriJ3Gl546CeaX9eJHCC9pfDpkv0eIDJbzNzogRqww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Or94cuh/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Or94cuh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFEE1F000E9;
	Mon, 31 Aug 2026 13:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182977;
	bh=bSGncVD5qJeowyD9nhbZoeYdhb4eCRI1Fy+X8N6WL3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Or94cuh/gVo4Pfz9Y33b8l/4PK/nS1P8FN++kCjxZh3Kbv1W7JjXhW+6wXKAumXku
	 PTFPfgfakVQSLGzE5pg3pjPHOta7nZ4ZM9QnAVsQkAC/48pzYLkZt9cjbKTnsXpJ5F
	 VhbvO2V4gZvV5dDIzclI1yK9xPSg/Kby+r7coUfVXsFRaNWhYJ6nNwm02ilc5rpj+m
	 DkYm6kzwPDzFXm2mfalXnQ3aha4Tv2xoBPoR1dtU2O1eORR1QbkBYlXGbmHPOd8eVt
	 GBasDih2ioiOEoZIfSeZrDi/6zBmmo//q4Yb2c3Y/0R9AznCM2LpFAmYyaodemfUtj
	 VTxXdnoUugbaA==
Date: Mon, 31 Aug 2026 08:29:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: simona.toaca@nxp.com, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>, daniel.baluta@gmail.com,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, goledhruva@gmail.com,
	Nishanth Menon <nm@ti.com>, linux-spi@vger.kernel.org,
	m-chawdhry@ti.com, devicetree@vger.kernel.org,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: spi: ti,davinci-spi: convert to DT
 schema
Message-ID: <178818297576.700625.8066248525340534710.robh@kernel.org>
References: <20260816-ti-davinci-spi-v1-0-a7f57dfd5262@gmail.com>
 <20260816-ti-davinci-spi-v1-2-a7f57dfd5262@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816-ti-davinci-spi-v1-2-a7f57dfd5262@gmail.com>


On Sun, 16 Aug 2026 03:19:32 +0530, Bhargav Joshi wrote:
> Convert the TI DaVinci/Keystone SPI controller binding from text format
> to DT schema.
> 
> Changes during the conversion:
> - Create a separate ti,davinci-spi-peripheral-props.yaml schema to
>   properly define the ti,spi-wdelay peripheral property.
> - Add missing dmas and dma-names properties.
> - Add constraints to ti,spi-wdelay based on the 6-bit width
>   of the SPIFMTn.WDELAY hardware register field.
> - Add constraints to num-cs based on the maximum hardware chip
>   selects available on the DA850 SoC.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
>  .../devicetree/bindings/spi/spi-davinci.txt        | 100 -----------------
>  .../bindings/spi/spi-peripheral-props.yaml         |   1 +
>  .../spi/ti,davinci-spi-peripheral-props.yaml       |  25 +++++
>  .../devicetree/bindings/spi/ti,davinci-spi.yaml    | 118 +++++++++++++++++++++
>  4 files changed, 144 insertions(+), 100 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

