Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726183537D0;
	Sat, 30 May 2026 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780131262; cv=none; b=PqGbprBEXcdKaJiMjSNatAL1T8D5lTS4cC35hFEvEalWK3HhWhXCnq10Z1829t65Yb6maXYbWjL+fwVqx5PQr7skqwr9mYhu2/x6J7POFE0u0fsD6b5xbmmjPALos+8APRL0ZCbq3laIFm22Sld1Aanf5asUbWEkhlpOpT7ewHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780131262; c=relaxed/simple;
	bh=ALak2iGU2vL9VpRA29lMsenoQwE/u2+TIXdrQy9k3n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+GZw58h57627bBsa97Wrrn9dNuoLwVHT7/0WEAYjWcjYt4hxTyjTyqhOIAVLvUwrBJ3rWuqy/ckwoAm22kf/zf1Xh3PExwPaAh7vtP9iZmv3V0/z6yw8W1AyyxJ4a5O2XM5NaRf5WJeauZzNM64cOs/ZQonrnqG7einf/biDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6KFv3Bw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6KFv3Bw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E0F1F00893;
	Sat, 30 May 2026 08:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780131261;
	bh=CXpgVm9FxGfdae5u6tycGwxDHBkrtPMkQwMJjdDB8gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q6KFv3BwM6JMSJwQcqUKvrjKu16gTjCSqGmn8Qi0ILzyQf/8U9XQjtMYl0508qdue
	 QmfEkX4COYHW7zpK5La9eWyDvhsrNq3CENfkWN1yW66RtARad4S9aqbmtqdvb3T96+
	 JEzDEdqa0HjN+lVq7X9Cp5BRSELn1yw7i8SubKlFaKRzp6yjBoDterDYEcbyKd7vBY
	 6DKcWdq8llzS018We8Ozoib3T7eT2BIu8+45dNRztwlKpSLhfFQYPQ0m6nx4LN0oDL
	 8RoBMKr5Tb8sGF87O1mKAVhHkVLjJH1M3Rodvkc3Z0MQKABwc9Y9aAjLkRQmXH3QI5
	 1ssobfUStmUIA==
Date: Sat, 30 May 2026 10:54:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Santhosh Kumar K <s-k6@ti.com>, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, 
	vigneshr@ti.com, pratyush@kernel.org, mwalle@kernel.org, 
	takahiro.kuwano@infineon.com, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com, 
	a-dutta@ti.com
Subject: Re: [PATCH v3 01/13] spi: dt-bindings: allow spi-max-frequency to
 specify a frequency pair
Message-ID: <20260530-precise-practical-jaguarundi-81faa6@quoll>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-2-s-k6@ti.com>
 <20260528-clergyman-kindling-20971775ba78@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260528-clergyman-kindling-20971775ba78@spud>

On Thu, May 28, 2026 at 06:36:57PM +0100, Conor Dooley wrote:
> On Wed, May 27, 2026 at 11:25:15PM +0530, Santhosh Kumar K wrote:
> > Some SPI controllers support high-speed operating modes that require
> > controller-side configuration before the device can be driven at its
> > rated maximum frequency. In these cases two frequencies are relevant:
> > a conservative speed usable without any such configuration, and the
> > maximum speed achievable once the controller is set up accordingly.
> > 
> > The existing spi-max-frequency property accepts only a single u32,
> > which cannot express this distinction. Extend it to accept either a
> > single value (retaining full backward compatibility) or a two-element
> > array [base-frequency, max-frequency], where base-frequency is the
> > conservative operating speed and max-frequency is the highest speed
> > the device supports after controller-side configuration.
> > 
> > Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> > ---
> >  .../devicetree/bindings/spi/spi-peripheral-props.yaml  | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> Pretty sure this hasn't been tested, dt_binding_check cannot even build
> processed-schema.json with this applied because there are multiple
> definitions of spi-max-frequency with it applied.
> 
> The sashiko makes the point that this breaks every binding that uses
> minimum/maximum to set constraints too, because these properties do not
> apply to arrays unless applied per item.
> 
> I also don't get the point of this property, why can't you just set the
> max that the device can do and if the controller can configure itself to
> be fast enough it will do so, and if it can't then it'll pick whatever
> the fastest it can actually do instead?
> Seems like you're abusing a peripheral property to encode information
> about the controller.

Yes, commit msg speaks about controller but patch body changes SPI devices.

Best regards,
Krzysztof

