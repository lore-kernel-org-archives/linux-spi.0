Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21182E6CA6;
	Sun, 19 Jul 2026 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784444103; cv=none; b=H0hMqvpWwI57F4SRlOgblAdfG46Ig+6p3glyjXVHq6g8ae6wOxye6tcP682etdjsimGAbio95wQ2r9DM23ImIQx0xZg8hakBocG+bBvCtnSv680h4EPveyicRpDeH4BObS6rXk+p5VWPnPEeDZ49ljdekhIGlpZVO7VabInVKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784444103; c=relaxed/simple;
	bh=PZR2HJPqgaaFAaFfB40PssxTQ3EzwnZV5i73CkC8FiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh1PFfy1+I+ETm8HPk4xiHJGMjvN1tPi5SK/yV94CLf/bc6moPVkjT7b9WAHBzQPC0LR0cGPE4cuYgsiSMU1DIKts6/MUlTG+BARzTm1dX4OlsUqzDF+sGf05fk5HEgh9YPwIWJCS4+QBwKVH6dKgZ6Wav2FZpu3fiohKmjs1Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvsQ5LmI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvsQ5LmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8871B1F000E9;
	Sun, 19 Jul 2026 06:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784444101;
	bh=ADaFNJfHwQ0Bc31gt67kjh0oWg4Lmov10eqOPdTOBW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mvsQ5LmIK1ybgLBfxkagCDpx+tv8GcGrpTjH3Fp22wN57n7mSqPgZUk09JZlrZZOW
	 YPwyEfzlG6Kr0PPLkfNN5ziRcbxz1xluMJAez/2oDbwTI7qvnmDDiZGy+sldIUY1ex
	 quaUsuX1UwLO2fbpqdndYp0BUphPxOcE10aXttSwyD7aRyrzfeM2fXiOoyDUAw47Zp
	 caohHbUh3YTT06xatPkdjki9ltCl0rplW2/NHjF7ZLY8rlxKNzLbQ4Eahzw42bC5yM
	 tj2tu2x20V0faR2JA/clo3Qy7PRSbU5ZtfCMNOlZtr2fE3akRSBwI4/Y90d4vVvAIg
	 3aUwIOWzTZCRw==
Date: Sun, 19 Jul 2026 08:54:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	pratyush@kernel.org, mwalle@kernel.org, takahiro.kuwano@infineon.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com, a-dutta@ti.com
Subject: Re: [PATCH v5 02/17] spi: dt-bindings: add spi-phy-pattern-partition
 property
Message-ID: <20260719-nonchalant-formidable-yak-7c722c@quoll>
References: <20260717185116.2065505-1-s-k6@ti.com>
 <20260717185116.2065505-3-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717185116.2065505-3-s-k6@ti.com>

On Sat, Jul 18, 2026 at 12:21:01AM +0530, Santhosh Kumar K wrote:
> Add spi-phy-pattern-partition, a per-device phandle property on the
> flash sub-node that allows the DT author to directly reference the
> partition holding the SPI PHY tuning pattern. Used to locate the
> pattern data during PHY tuning when the device cannot load the
> pattern dynamically.
> 
> PHY tuning works by reading a known data pattern from the device
> repeatedly while sweeping controller delay parameters until the
> capture window is stable. For SPI NAND, the driver loads the pattern
> into the page cache once using write-to-cache opcodes, then reads it
> during the sweep. SPI NOR devices have no equivalent opcode, so the
> pattern must be pre-programmed in a dedicated flash partition. One
> partition per device is required to keep the procedure unambiguous
> when multiple devices share a bus.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  .../devicetree/bindings/spi/cdns,qspi-nor.yaml  | 17 +++++++++++++++++
>  .../bindings/spi/spi-peripheral-props.yaml      |  7 +++++++
>  2 files changed, 24 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

