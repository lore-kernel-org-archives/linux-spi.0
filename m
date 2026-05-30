Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBD32BEFF6;
	Sat, 30 May 2026 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780131165; cv=none; b=E/Qn60bhwQQsGKpAuybfrDQ+AYTdvtJdl/odlt4mFdhC0QRhmMDUwu1JWE6GbSw6OBjMhJjA9E5qFORcC/s2OPMk7lhOZcM9XPhpVaf4qX8ALcmKtbct/cAKBxfQAf2ijTjzaFKlKP+8rLkiGvfDu/ImFNvGqofQUcO7sttUqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780131165; c=relaxed/simple;
	bh=KvXSsD75wICQn9/zqWDk/t6cKTpMbOA/2ia4f7u8WbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8a9FaWJN2cUR2tfIOUZv2psagHMPaCO98RlT50cBFBkpVra/PcCMsZipT08HSGq+i3IiivbATFg+3YFlU7WhL874QEKMZecCAybsSYeHk85dCpyOboDfi2LDqxRv3/5/IUvuoDSnl+7eXpmGe6hP3euW8PJ/4bmqRqUnYBluq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUOE/JYY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUOE/JYY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3FA1F00893;
	Sat, 30 May 2026 08:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780131163;
	bh=/mT4btVGnimZ9Cv2QimGX1edcsMj9bhXopCVFXdF1jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GUOE/JYYD5ukPosFNGICnMEEXmC/PcIE/e/TdmLcyR0vCHekxgmLErsWQJfmMYHss
	 ypM9VKAGvxo11Bo5h7hD/Wb8S4thlGW2gY1UG7JFo1iSHvpad+j3ECxnpjZ1qAJyje
	 hPAzXsWK9gsDmxAfT5+Nbj4WaDh32qwPlRER45+CMGP9Pva8WMz+Aw3ElXaJRJ8e/0
	 XtetNTRBEPgRE10UVO4Lr8GuVBuh6vPcdKajZ9GqNmyK8yIQyQz9xiGwv0bmmDZrij
	 Xtx2XdOMstrJSS6jKHuIj6lABoa9wbUPsceWF8GpRTs/XA8nn0Ierzm2mYPp6cUtvm
	 /GtilIJ84WxrA==
Date: Sat, 30 May 2026 10:52:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	pratyush@kernel.org, mwalle@kernel.org, takahiro.kuwano@infineon.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com, a-dutta@ti.com
Subject: Re: [PATCH v3 02/13] spi: dt-bindings: cdns,qspi-nor: add PHY tuning
 pattern partition property
Message-ID: <20260530-original-peccary-of-cubism-af68ed@quoll>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-3-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527175527.2247679-3-s-k6@ti.com>

On Wed, May 27, 2026 at 11:25:16PM +0530, Santhosh Kumar K wrote:
> PHY tuning requires a known data pattern to be readable from flash.
> When no partition is explicitly identified, the controller must search
> all available partitions to locate the pattern by label, which adds
> overhead and relies on label naming conventions outside the
> controller's control.
> 
> Add cdns,phy-pattern-partition, a phandle property that allows the DT
> author to directly reference the flash partition holding the PHY tuning
> pattern. The controller uses this partition during calibration, avoiding
> the partition search entirely.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  .../bindings/spi/cdns,qspi-nor-peripheral-props.yaml      | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
> index 510b82c177c0..0ffcdf5b00d0 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
> @@ -39,4 +39,12 @@ properties:
>        Delay in nanoseconds between setting qspi_n_ss_out low and
>        first bit transfer.
>  
> +  cdns,phy-pattern-partition:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the flash partition containing the PHY tuning pattern.
> +      When present, the controller uses this partition to locate the
> +      pattern data during PHY tuning instead of searching all partitions
> +      by label.
> +

This should be used in any of applicable examples.

I also have doubts that this is per-device property. Your commit msg
suggests it is per controller.

Best regards,
Krzysztof

