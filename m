Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231742;
	b=RcgyrwkB+BUWsUypOFNxGd9pjq0U9hKg2KP2U8FKAJ8jt7iJuaMVzBqhuiIb8Xs8tjXe
	 bilCph0JGwDCzLHAOBf3oTCoJ3qWA5SjHIA/W3cUST1tD8tlNNmS8OrdbKhOnqbr5ajvE
	 41YWx57cDTpSo5zVLDQEEkzdLNuVWrFVT8USc9ITo/L9ZdYuVuY/iyNeldeU5eaimyTZY
	 f82dH78iNmzQvsOzoAiFfuclUTIalMk/hDl9/avUts6XXqyi7QMyf5LQQai3xDyYn4bCK
	 JT29MxPy6Gpyp8ss3B3mZQSxEFB6kQ/oe6Bv0xtPmsKMUJyyMp5K/Kdeoa5EyLzIttg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231742;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=V1VyfPRVQ6WKw+adqIpGNxRy4La6pXaOj9EXqKAAuxA=;
	b=QhadXVReW51ws2nTQnBvK6U1qFBU0c1/WX+jIDyz7hRvNc8vEbdnLXrK/5UdNlOocGQM
	 26TskF5RkAfQpgn1aj2ElWh/Ux9ogjEUiUEnAalL+LumBvMg3m19FMHKfOc96gYcDuomu
	 CsyGvhozc/IG7gemWu+n+ck6efgFj93g9HFsijQoNg/XMCyvAn4kLeuMznkjONWiC8kqM
	 I23qrIY7DcO0b8rryZFLAZ1U1JYdl9mLp+8MR8ag3UeGNr795JwiiZDnOLgFfPMZQQF32
	 4Rw6cECzjhFCmm6CedRAJiHxmMZZ7LA++Im22VKWcpLPOZxubkfG3gA5nwpb3cuXplw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kUNASCaE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DBF606A330;
	Mon,  9 Nov 2026 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kUNASCaE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEAF1F0089F;
	Mon,  9 Nov 2026 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231742;
	bh=V1VyfPRVQ6WKw+adqIpGNxRy4La6pXaOj9EXqKAAuxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kUNASCaEcxlf5t831seV1lc+5Tao81kCLLtM++XjpN1btQrk3q4GGEPVNbWOAH456
	 BxKeQDzb2NujGbJ462bl37iOISAGegDSltXto2X0J2OLWu7YjBwZ5pjc5SHfDZDsn7
	 uy6O8v0OedPCJnXGlNxuOMKYLYFbGpvqB5haufpyfofeZlgZIIx98+nBq+ZUqCx/L6
	 52Pe2604JbzKULeGK+A4yil5/F75wgu1oeZvMjnlGzzY5YONQK3XfDlS5Yf+sFatCt
	 aUSDjx4GLO3J9vfAD6Lt43BFMl0QkpOZZUT5jsPiRLBxbHPL+m1zWs+xWZ8H2tSiOQ
	 MXzVGsr9KEzgQ==
Date: Mon, 9 Nov 2026 14:42:18 +0100
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
Message-ID: <20261109-wandering-miraculous-mamba-0cf21a@quoll>
References: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
 <20261106-qspi_upstream_series-v1-2-21f43042dd60@oss.qualcomm.com>
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
In-Reply-To: <20261106-qspi_upstream_series-v1-2-21f43042dd60@oss.qualcomm.com>

On Fri, Nov 06, 2026 at 08:31:20PM +0530, Jyothi Kumar Seerapu wrote:
> Add QCOM_GPI_QSPI to identify QSPI (Quad SPI) channels in GPI DMA
> specifiers. Its value, 9, matches the GENI serial engine firmware
> protocol ID for QSPI.

What is GENI serial engine firmware? How does the Linux rely on it that
we add bindings for it?

Best regards,
Krzysztof

