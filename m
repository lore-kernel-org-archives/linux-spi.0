Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400629;
	b=Yks3jpPC4wEtpyhZJePeiGzAEF4pRkTDuPiw8rT0/TCxhb68xlu2sCBhgkcGoFRIpkTu
	 OeeYnk4J4MFMgwYfkM9x4KOHtA46kqLWUbGZ+UhIe5OMgoPKjQBAZvTFyKVOi8sRLDojj
	 gy7Z1bUnzoe+ULlCE92Cg3Qf8TyxIUlEnt3OOlApnLDJyLo/paeSCTqqriGTE6OKfWiDg
	 DUuIBdewOtWQ4xEXe7yAf3vF9a6LIjVv2Moc9bqq+1lQ6R1lrdxR/1Ab7aWir9RxDwcAz
	 +O0OcMEZn7L2WNRhdNrGiVfrw41r5a1YaC+hurS+QdxAa4EiLKsO17/vH+lK0s0ALkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400629;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=DrEyZ9Dy/vdt9Enxk47/lufRYYKMANPK/dWOzZVfB0Q=;
	b=3V2kMgtZqOcRKjwOi9vyb7bF/aboFaTL9pFCcEZ90soUAcd+sP6TWuc1MWUpMMwruV6n
	 iNvpHtJPhlroXAoK+kAD6mnG/Ce664gOB+CzcS6kNstynqqh9VfrdnH2JPCigyNOEgLwJ
	 6c3vUgNzlMQDiDO+D13oFEJwdn+jJRpR70mohrNGdGd38Cvyl0b+WRp+pT7aukijSRngO
	 Xxga5z3qLq6oaPYFiECknuBWUrZ/ACiATbenBjh/jycI4Ubfd7T/M/bBo4jaLj1PNbzfW
	 BmNvcpzz4/vQ+WQUVPrg8LD0aeWi8Gr52bt7FS6dBuWNX7Un94vX5bg6oa1WV4Uc80w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fm8TTeVI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0E606A31C;
	Wed, 11 Nov 2026 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fm8TTeVI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5654C1F00A05;
	Wed, 11 Nov 2026 12:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794400629;
	bh=DrEyZ9Dy/vdt9Enxk47/lufRYYKMANPK/dWOzZVfB0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fm8TTeVIKgELMl8vk3ebBz7NjeNXK0VYlflbnvI+1DhF7tIPs8mjFhfsCxu4SsCEC
	 dZj5z/6m0WsxBJK8mNC/CKIelsRlDPZdTa/pY7f0UXzHHt8WfrwUmxE9lglxm2Jtzy
	 ius5pA6JqZ9CZAaURmR4YUp0cICYP8cHohV5iTpnxTi5YmKzzykZdIlMaAN0TRnmYd
	 Zxzr5OmMoCKOA8mBYNhaX5S/A7N19hoWoLQBvBH9PJz6uTXVtIKiSKOWwV5aPYIwXo
	 y8K+aQpIJIsvL9F+8W77GqC4igMTpEEwNnrjNb7YCtMZsInr7OcxaULuCk0CQzOWS6
	 ScuUbS0ZJToZw==
Date: Wed, 11 Nov 2026 13:37:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: dma: qcom-gpi: Add QSPI protocol
 identifier
Message-ID: <20261111-daring-salamander-from-tartarus-4c72bd@quoll>
References: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
 <20261106-qspi_upstream_series-v1-2-21f43042dd60@oss.qualcomm.com>
 <20261109-wandering-miraculous-mamba-0cf21a@quoll>
 <2fc8f7ea-651e-466e-9346-c47e0a38c5bb@oss.qualcomm.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2fc8f7ea-651e-466e-9346-c47e0a38c5bb@oss.qualcomm.com>

On Mon, Nov 09, 2026 at 08:03:29PM +0530, Jyothi Kumar Seerapu wrote:
>=20
>=20
> On 11/9/2026 7:12 PM, Krzysztof Kozlowski wrote:
> > On Fri, Nov 06, 2026 at 08:31:20PM +0530, Jyothi Kumar Seerapu wrote:
> > > Add QCOM_GPI_QSPI to identify QSPI (Quad SPI) channels in GPI DMA
> > > specifiers. Its value, 9, matches the GENI serial engine firmware
> > > protocol ID for QSPI.
> >=20
> > What is GENI serial engine firmware? How does the Linux rely on it that
> > we add bindings for it?
>=20
> Hi Krzysztof,
> GENI firmware runs on the serial engine=E2=80=99s programmable sequencers=
 and
> implements protocols such as SPI and QSPI. Linux configures the engine and
> submits transfers to it.
> The existing GPI DMA specifier includes a client protocol ID. Linux progr=
ams
> this ID into the DMA channel and selects the corresponding descriptor
> format. QCOM_GPI_QSPI adds the QSPI protocol encoding 9 to that interface.
> I will clarify this in the commit description in V2.

Does not really answer. I see no reason why GENI firmware needs ABI for
Linux.

Best regards,
Krzysztof

