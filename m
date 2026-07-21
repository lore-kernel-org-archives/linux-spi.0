Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF03BB12F;
	Tue, 21 Jul 2026 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625624; cv=none; b=AAnTythC/xUAe0PPg40E+D9F9CntoJmO+cb8j+85IniHDT5yUuIrmt+t7t6MxXmtP8OiLQd+dE0YT4ZJE/883nHQx/yl+1bqoDjB0oTkmzN512UE+Clqw6zvvPupc8zuWPoWpQHxMOfLI75IBFG4X4S01zc0URktDVweBjEoQAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625624; c=relaxed/simple;
	bh=qGl/pLf89OIbfHE2GVKxVQ0J8Z+UUJcy0M/ab/hc+Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGcYIoIdSYG8jQsu8mBl8c7Eh6TqsYTbHt+/FYvkR5E1Cv3CAqATik6MDR0+63rKDGfUPnuHRDfUf1WvULGcJtsLBv9cVCzVbdiEXXu5mfQeGwS7oMGcEID79BvH69ocm8MocWKdG+T1zTvC/QW8Slaymn7cIxlNuyFhh6valDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efYBWNq6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efYBWNq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9441F00A3E;
	Tue, 21 Jul 2026 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784625623;
	bh=1BzWx3Iuo3Hr4NPySjXIVVT+qekLZW46dc2svWyGqug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=efYBWNq6OuSv7aU9hoY7Xg4ItL/NCIYn9C5gTUV2N/b0HOdry5uRoQpE7FdY1h30G
	 4HsIMPdB67M/IMOMzZUdR/U9QoqaaBX3YGD883/t4VcNIwNDRgGxqmzSixHyOWFjcq
	 M/hLWwFYruiCgqEb0zW+Mc0aOAwVLSdMRmiRgus5aPyvVOlw2Iuko/2sbCH1w+22u6
	 lpYPApPK+X486UTI3mn8KPCrXuNZamdxvZBmbeqi7ftUV4q68KdVT90T815R2Zctzl
	 +GZGI4MaRt5WWppTjr/xVNR8v2pPs61FQ2c697T3nUSjsdO+R5Asw0ipQlajB/67DS
	 lvFgq8vh5XRvw==
Date: Tue, 21 Jul 2026 11:20:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: qcom,sa8255p-geni-spi: Add compatible
 for Nord SA8797P
Message-ID: <20260721-convivial-onyx-mandrill-736abf@quoll>
References: <20260714120226.1788391-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714120226.1788391-1-shengchao.guo@oss.qualcomm.com>

On Tue, Jul 14, 2026 at 08:02:26PM +0800, Shawn Guo wrote:
> Document Nord SA8797P QUP GENI SPI controller, which is compatible with
> SA8255P controller.
> 
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml      | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

