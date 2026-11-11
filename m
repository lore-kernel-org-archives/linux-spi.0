Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400827;
	b=ItxtWD/lsyW13XwLH+M8MAdUUhskOHBfL82G/M46u80FNhErf9wl2GtnQb/EBoA/3xAz
	 9gf++X2tFffeJWqrVTc1LTRtJSfyVzYvlApiIb+uJ1YFv2C3n+/xqnESKTxTcc8xQSR4b
	 +3Oo8wDU5O0AaPft8wZ88qDDaxtay7xgu+si+sKFEIU6Vaqt/oKs4I9HLg3YzLhA2Q2R9
	 ibgFitWDm9rGv9VLMPE+fh73hAFTzG388I2nWGhSExq9h8iNOx+reUQajEY/NFpMSV3zQ
	 dR+ZYMF2zr4gYvGzXd8rge15/jQ+G6+mCXbcDeivaZ273XztISo6FyeJciJOd3VfxtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400827;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=IioqyPu9oMhuDn5aD5FumUcxVaNJW1Pvw20up7ZUlLo=;
	b=oo/Qvcyl0516KPURhNp9RE7IITyRcdvvloh+2ThrTM6RoUw5v/prJLqA0vXjryPsRKio
	 mysy8NdJPcGv/n+j8AEHQbguhxlIdCQE4m6BAvBebqu0kR4qXCRbRjsmxLQarc3HsKf7g
	 XWN5dCvQ8EmoxFwg5JyvR6trsc2tRzxyfVfJo53gAz08bx0Oitg+5TxHuRKI+SjUHW6QM
	 WySZJszBGN6rjSCKzs6kJoJW9lty4Klp8OpQqT0s5ZdS81z6aa6hrI5qUwoaCP4ts3bo+
	 6hN76qc79wP5GdZBOTgxQ2wU3w68O9Ist0l6mvTz4/ypL8drwnXBCn1yLNNYpmahCnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEHk2nZX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBD606A332;
	Wed, 11 Nov 2026 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PEHk2nZX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EDB1F00A06;
	Wed, 11 Nov 2026 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794400827;
	bh=IioqyPu9oMhuDn5aD5FumUcxVaNJW1Pvw20up7ZUlLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PEHk2nZXfYf56iyHkNcmHVTaf2HKdTJcv3dH+gSpn9IqiIWkSmP6U6OFWW0E7KkSL
	 c5JusaI9EtYnZXC/at2ANSWsW7VlGu2m5aqP5nuodTe3kHu8gLWO0Z2m4PNMI3OQZG
	 c0MH2/81uuddpsqpWqy6kzEOYIpmmdHLf2nLUJQDaUPO+OOkAncuaizLA9924EMQL+
	 JAzXibbYrtZC+/bsJkXElGbMsTKR1E7bFIewQdWFdmig+dp7YXtQa49mEjZIUB1+mY
	 hpjQa76wUmXJJaK9rqsPXPkxzHWkvVk7alQC1cdlC/Ckqj8oOzPHXyZg/NV/GzH8w6
	 fwo6kmW8cse3Q==
Date: Wed, 11 Nov 2026 13:40:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/6] soc: qcom: geni-se: Define the QSPI firmware protocol
Message-ID: <20261111-prudent-polite-shoebill-add35c@quoll>
References: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
 <20261106-qspi_upstream_series-v1-4-21f43042dd60@oss.qualcomm.com>
 <20261109-stimulating-oyster-of-respect-620b7b@quoll>
 <61646f06-87f1-48da-9b88-8898bb488af7@oss.qualcomm.com>
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
In-Reply-To: <61646f06-87f1-48da-9b88-8898bb488af7@oss.qualcomm.com>

On Mon, Nov 09, 2026 at 08:13:33PM +0530, Jyothi Kumar Seerapu wrote:
> > > -static const char * const protocol_name[] =3D { "None", "SPI", "UART=
", "I2C", "I3C", "SPI SLAVE" };
> > > +static const char * const protocol_name[] =3D {
> > > +	"None", "SPI", "UART", "I2C", "I3C", "SPI SLAVE",
> > > +	[GENI_SE_QSPI] =3D "QSPI",
> >=20
> > Why are you creating holes in this array?
>=20
> Hi Krzysztof,
> The array is indexed by the GENI protocol ID. QSPI uses ID 9, while the
> existing entries cover IDs 0=E2=80=935, so the designated initializer lea=
ves entries
> 6=E2=80=938 empty.
> The added NULL check rejects these unused entries before accessing the
> protocol name. Appending "QSPI" directly would incorrectly associate it w=
ith
> ID 6.

And it should be 6. Just look at uses of this.

Best regards,
Krzysztof

