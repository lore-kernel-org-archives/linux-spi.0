Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606725B0A4;
	Wed, 12 Aug 2026 02:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786500111; cv=none; b=dlIWQVB6dx1nMDcsEF8R/7tL5q84e9jshz2dO5klonD8sOjBnaWmQWiaaC/k1Qh9EHhuJoK1NUJKCOlGrijl8Yn7IkibJw1KiUns+VOU2z7W8PSjbutXO0u3oeIMM1zbC9rYwlgkwxvinll1OKFcdzuvy5ShyQxLSbuvP6bcuGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786500111; c=relaxed/simple;
	bh=kOX3rEh1bkl9f8Xxg3YB0WnXZVQiXIIQ1qyGGrAO6c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8Ll67XnmzWmXRYBUhR1q3b4yAX7dyMnQ7oFkKqoqpkKxz9RHDc2avnN0TPXJF2GPCDolwsi3sak67AvWVZjBo+ELCr7is2GgDfNERcNmeTLW35ntKKwRbK/mpWSWq/sIkNxlzuZ10cXtWBxoqsnxfGgOCbgbmrZGYtYPLzTHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um5xyhFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um5xyhFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1731F000E9;
	Wed, 12 Aug 2026 02:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786500109;
	bh=8o+3awIb8vPK4YsxA02n0PlQRtaXr9ob49IQPz4fhu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Um5xyhFzti7Ii9ra7/q9+bb+A966CsiQId/BnnMXMYhKqrc+xw9JnHRqLeE/hsZrN
	 GMrZM8KUu8QMecR5G/mDIFM6ff6Fd8ZbcVskaNczH39vASZCLmASLwy0QgO0F7IZcg
	 9369YgFRD5nPoErCEwoy7SFXN2s+L0QlExycrmvobCNCW2522hipu/yP8f7sv1Rr8x
	 kD7iEqy4ZbiFRTDrKqWy/7MwLzg8xP3sUUlEujgQLpIt+uuANXDSaSAJJ5SjPkupZi
	 2rT6qpal31wE5BF/TiXtBnkFqYUw3zBn1ss3S6a30IO5dfuO8X7zD0WhjnFxmd3jpB
	 a47JJ1Q7KiEUg==
Date: Tue, 11 Aug 2026 21:01:48 -0500
From: Rob Herring <robh@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: sun6i: Add compatibles for A733's SPI
 controllers
Message-ID: <20260812020148.GA515168-robh@kernel.org>
References: <20260805-allwinner-a733-spi-support-v1-1-7bfd1141ebc9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-allwinner-a733-spi-support-v1-1-7bfd1141ebc9@baylibre.com>

On Wed, Aug 05, 2026 at 03:53:26PM +0200, Jerome Brunet wrote:
> The A733 has six SPI controllers with the same IP as the A523.
> Like the A523, one of them (spi1) also supports DBI mode.
> 
> Add SoC specific compatible strings, falling back to the A523 ones.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> index 6af4ff233158..be47c6e00409 100644
> --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> @@ -36,6 +36,13 @@ properties:
>        - items:
>            - const: allwinner,sun55i-a523-spi-dbi
>            - const: allwinner,sun55i-a523-spi
> +      - items:
> +          - const: allwinner,sun60i-a733-spi

Combine this with the one above.

> +          - const: allwinner,sun55i-a523-spi
> +      - items:
> +          - const: allwinner,sun60i-a733-spi-dbi
> +          - const: allwinner,sun55i-a523-spi-dbi
> +          - const: allwinner,sun55i-a523-spi
>  
>    reg:
>      maxItems: 1
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260805-allwinner-a733-spi-support-e30a9ac057a3
> 
> Best regards,
> --  
> Jerome
> 
