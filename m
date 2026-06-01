Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36150282F38;
	Mon,  1 Jun 2026 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314460; cv=none; b=m+J3mRCILQA6Myz0hFnhn3H6TvMhFI2iCpkMSpraybNRUJcJ+fg0wZjvKaltgBpw/4b2Ugazxmm/nqhEub4FoT64ARE/GdlrEo3DblU6vpAyCXPdulgcI7UF4fk9TzdNykHl216icxRzBk6niQeUeA5md9QtGzaYNfvIA8PbQ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314460; c=relaxed/simple;
	bh=pn2bchjT26ccbec0CsO17/q5ATOvyJcKpCj6Q8IWhl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6sgwfDV0r6KBrXB4pWkOOkrzj336vV5KNjPmSrB0bqdfFpNrT6ABXEK+AvvkccD9A/ncRslsqg+fCpEudmwVfzpacHlKt6CPmFSO4HTW87b3W8BRaA4YRVoiMrzSA+QADwDAbutnTlpqPl/it5pMF7MN6ai1QtS+YojM6MT8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLBPIPfr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLBPIPfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AE61F00893;
	Mon,  1 Jun 2026 11:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780314458;
	bh=t1bK4cZQhsY0Yrq3fi8QJnWtjpMyyN2oQtBqaMvH3f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iLBPIPfrUmMFBfBo/9hPnVur6xSB/U4GS1TQHQ5ioN1AMCU9Agmv2FBfJ4ubCsO7o
	 Km3tCnbDZfZ0660St9fhIfUCrcH1M1LKZc5T3M/+7tLXGSVAVfRcWpEIXb7AmWHXId
	 QKZSxPZjxbiHUkPcg2nVCHi72JwdBIXHGaWmMuQd9uP7cM8rYVrGedF3vmZu+7E7n3
	 fQw5BPVREIWrXBIdBJrSsK7QIuEGS9JRZwz5QHWM/9o2XRGLoTo7t065OUREXoopA1
	 VO060BmGvzANgBbVEs9ez0OKuY4AvlhnbM2CyAhk2tBzzuFo69Z7I2vCMDpfuAfoE/
	 /w5oSfrm0KiZQ==
Date: Mon, 1 Jun 2026 13:47:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	pratyush@kernel.org, mwalle@kernel.org, takahiro.kuwano@infineon.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com, a-dutta@ti.com
Subject: Re: [PATCH v3 02/13] spi: dt-bindings: cdns,qspi-nor: add PHY tuning
 pattern partition property
Message-ID: <20260601-stirring-tested-mayfly-e97c14@quoll>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-3-s-k6@ti.com>
 <20260530-original-peccary-of-cubism-af68ed@quoll>
 <2f091813-fa28-407f-892d-bbbbe3cac4e4@ti.com>
 <063fe976-9a28-4670-90df-921fbc1c3a8c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <063fe976-9a28-4670-90df-921fbc1c3a8c@kernel.org>

On Mon, Jun 01, 2026 at 01:26:27PM +0200, Krzysztof Kozlowski wrote:
 >>
> >> This should be used in any of applicable examples.
> > 
> > Please refer to the DT changes included in the repository linked in the
> > cover letter, which should provide a clearer picture of how this
> > property is intended to be used. [0]
> > 
> > I'll also add a DT binding example in the next version to make the usage
> > more explicit.
> 
> Why do you new a new example? Why existing examples are not applicable?

typo: "Why do you need a new example?"

> 
> > 
> >>
> >> I also have doubts that this is per-device property. Your commit msg
> >> suggests it is per controller.
> > 
> > This is a per-device property. It is consumed by the controller driver
> > only to locate and retrieve the offset of the PHY pattern partition
> 
> So with two devices on a bus, you need two separate partitions for tuning?

Best regards,
Krzysztof

