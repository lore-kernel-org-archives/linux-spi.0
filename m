Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D682542A7BF;
	Tue,  4 Aug 2026 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827121; cv=none; b=iAC7UczcFBgoejP44wE3eNaF9B4U+6+gEPNeQyKQGKexJQeMybKWK3LPfR3ixRt9fiALlZkCBNS9hRCPIuoiDyHeQDJkP6cpguSN4OeL1rN/wdqVjy1phfs3wDk/SaBcVxYmf+fzWJv4MLUAXbz+OjU/fwcnAShEbtNtWxqjNhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827121; c=relaxed/simple;
	bh=fZoxxJ4x7NXh0pZaIaM0vmII88o2NUyW4opIw5tEX3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3RlvszhTRo6x6QSLYDNJ2ugHJVqs7eECK5FfVzGeUa0GBBpu7ujKgPInCim9zadERsXDNfEo08PboNe+9VDCSMR45FkEtaehl9EL3cTT1zIAmWVOpIigpFgcpj8LhmKlIUtneaD9ezHQdVwRFhDul4E5QIofIPeIHDM1BdsFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfJPEmk5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfJPEmk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA511F000E9;
	Tue,  4 Aug 2026 07:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785827119;
	bh=Js87OwqmTpS9sHRBiU0fT8MlwqmYlv79UzB9vD7n/gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KfJPEmk5lhn7Ry7aZYrcliqPckiu93PDB64UKbTIbbUIZvBwt08XWRI0VARMd+1Ht
	 TPnghCudxoFv5SZQY30r/cDbHV0U0SaGItHSZD5hX2Ouh/e/8Tl8gBUceB0UWGwbVg
	 9DyDVEOihqBYO36a3RdSJXCRDyJ5c03ist4Qig2mEkQ9Nm4EzobLLDkBd+dcXB6lAe
	 KBsheqqiODb8Ci6m5jS2WOGo3B/qbalLq5w7JMq04l+LjZHoB+3MLvYoFLgQKXvgyE
	 /2YWUeMiMbkSToPRmiYjqDe1fLMZ9lLBbVzOurmOpQPycqfVFZSfcPq0OeELJ64tVD
	 0QskokzevnlrA==
Date: Tue, 4 Aug 2026 09:05:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Allow
 additional GPIO chip selects
Message-ID: <20260804-smilodon-of-imminent-recreation-aa579b@quoll>
References: <5769eae0-1b40-419f-8311-0d919bf619fa@sirena.org.uk>
 <20260803074913.1656675-1-cwweng.linux@gmail.com>
 <20260803074913.1656675-2-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803074913.1656675-2-cwweng.linux@gmail.com>

On Mon, Aug 03, 2026 at 03:49:12PM +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> The MA35D1 QSPI controller provides two native chip selects, but the
> generic SPI controller binding defines num-cs as the total number of
> native and GPIO-based chip selects.
> 
> Remove the maximum value of two from num-cs so that board device trees
> can describe additional GPIO chip selects while retaining two as the
> default chip-select count.
> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> ---
>  Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
> index 377ccf4fb224..f837367e6d5f 100644
> --- a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
> @@ -30,7 +30,6 @@ properties:
>  
>    num-cs:
>      minimum: 1
> -    maximum: 2
>      default: 2

Isn't num-cs the number of native chip selects?

Best regards,
Krzysztof

