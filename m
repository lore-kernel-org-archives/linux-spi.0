Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EABE477999;
	Tue, 21 Jul 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629101; cv=none; b=bqWvayc642afB6bknpggQ+duARJzqQktq3G3Z9GFoF8Q+lVQfsLKNOzWUA1LpQo/I+zs+5kjCBUOf8LGK5ZDlWE6M1feAZVJmVRuEsT8sPNoGctglJcLmcoqTIah/YaP/zb7oRU2jj3tQIl4xXvWG2sCpHGNFNFhbSuJ326RR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629101; c=relaxed/simple;
	bh=S0BFgDd3Dcq+vxv0MAWLFvTce0rMVWp3+v+vvmmcBsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldg2SWYhNs3QLCwspbce2zu45U7Er8dSP1vf2kk9M1slLcABzuEazEWBtqN3ik69cgGPztIPSo18E7qKBPIJHGCZumvs0SNdJhIXrNO20Z0myru903Go1yitmI0+yIA6QEmvpw9anY39BziP3n/XbdHonWb75W4jkm3e3WQfI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9HJc6UK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9HJc6UK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2351F00A3A;
	Tue, 21 Jul 2026 10:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629095;
	bh=r5RopncFPg5QRigLJNMgc9wUVIR6ORq/KvFLSj474Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M9HJc6UK0ovXEHl6kBjrN7Imtv7NCZKFRoaFp4VcHjxMMizJneVvSjy1z5L4yp1oN
	 xshdlOIXuKbSw3fRJAHEnZ+wngaxxYlAtnsukGx7Zn97Edo0x4tPQzYEJlRqAy6tBy
	 vR4WUKhKFTghsUOtovyPUqVA+KpecjauoSZ73cIvAGeXTM3hEQP0QTvkGT+sfXh1EW
	 oGc20ZFIpZvqZv8X5fsBTujormRpvMfTtYu+bV33MsuF9XWhagJ4Ak0O504H7MvQ1a
	 d0CbtlZIDsNGt+PASALZKgNntwYOceB045vlYyR+9Irf4EPqm8JNN6ueOpLfa9Ko1O
	 DC5s0D79v1nvw==
Date: Tue, 21 Jul 2026 12:18:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: dt-bindings: amlogic: spisg: Document
 A9-specific properties
Message-ID: <20260721-determined-melodic-boa-c379fb@quoll>
References: <20260717-a9-spisg-v1-0-2eeea77be19f@amlogic.com>
 <20260717-a9-spisg-v1-1-2eeea77be19f@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717-a9-spisg-v1-1-2eeea77be19f@amlogic.com>

On Fri, Jul 17, 2026 at 07:49:33AM +0000, Xianwei Zhao wrote:
> Document the Amlogic A9 SPISG controller and its additional
> Device Tree properties.
> 
> Add the "amlogic,a9-spisg" compatible string and define the
> A9-specific "amlogic,mo-idle-output" and "amlogic,word-gap"
> properties, which configure the MOSI idle output level and
> the inter-word gap, respectively.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  | 36 +++++++++++++++++++---
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
> index 9bfb8089f7ea..7efdc748d566 100644
> --- a/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
> +++ b/Documentation/devicetree/bindings/spi/amlogic,a4-spisg.yaml
> @@ -11,12 +11,11 @@ maintainers:
>    - Xianwei Zhao <xianwei.zhao@amlogic.com>
>    - Sunny Luo <sunny.luo@amlogic.com>
>  
> -allOf:
> -  - $ref: spi-controller.yaml#
> -
>  properties:
>    compatible:
> -    const: amlogic,a4-spisg
> +    enum:
> +      - amlogic,a4-spisg
> +      - amlogic,a9-spisg
>  
>    reg:
>      maxItems: 1
> @@ -42,6 +41,35 @@ required:
>    - clocks
>    - clock-names
>  
> +allOf:
> +  - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,a9-spisg
> +    then:
> +      properties:

Properties MUST be defined in top-level. You only restrict them here.
See writing-schema and example-schema.

Best regards,
Krzysztof

