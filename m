Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794151096;
	b=O/985EevcqfUDif2wf+cn811S9/N2mQ6ERdlK4BVpEQehfN1dwjrFeklZ0hDJ14WP6DH
	 VSOFqcvOo2Rf01g8D/mNSKk6accCEXzL6uvd+1M+2GPbX/q6wh3AhASCzTNOJw7BwuPeU
	 qn/7iAm/qFjyjpC923qY4Z1i88cxbbLK4Ftb8+aDrXmWa7VXkc0GU8vDaz4TjPPAmUheM
	 1THPCVpBeUPoApJPI5OSgyvqEgUV/3QiQ5fmtJhdHR7aJE8E4PGqduF90ewYApZKI5cUP
	 90LjJVjTY+x/LvdZnoqhfqZ2a0NOL5Cj18CIwVrf7weY70Qrz24TDPw5tZIsKFZPokQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794151096;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=p8GDyyVt+Sq4mGVsXFtFYfgdYn2hgnSQOtYzD9assbs=;
	b=ViuuUsIFvA9a/Z+hqWUDzQiXecjPD/oe7KUhtKdg6PueijDDqLe3SJE93mW7bh1Tw/A9
	 oqPAtoTKSSABIpXNyt39OIxMy+V9IUc14R8qgsioz3p8i106tsUDlqQ6ipLjMRLJaliez
	 RuqutdS/EDVVYgeWWQzuIhMAL55riRZl9uHdAk+s+YflZt4UnXWNlrpOZ8dopfPhroNpC
	 WcvkVuBusiJ6zDwEaIzdJX9qDXEDGrXPURjV5MCdP/eQQL1L1erK4ZZaqq/x6g/kBo0CF
	 TxEOuufwTFTv/LZJmZK3+15wsF/u9q6dDImAWFgwSRDzEa4Gw5gY2YWO/cv/5n+uoIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFXVr5vV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7466606A31C;
	Sun,  8 Nov 2026 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFXVr5vV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4296A1F0089F;
	Sun,  8 Nov 2026 15:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794151095;
	bh=p8GDyyVt+Sq4mGVsXFtFYfgdYn2hgnSQOtYzD9assbs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=MFXVr5vVHnzbN5472BnBdKg/D/bN9BKzknypQXcMueX3Rhdkv82YvxUt/vIJym8ZL
	 TTAtaZIplb/uW6f1Uuex78g0TCKYa2mb+bduTJ7BMtA7WEkKl9KqcKH4SQXItaWT4g
	 R78VB5AE3x8GAIwhYebk6l6FWyRpOF7GcbNRUa8CqE8I9QEu2OcAH8pqAGEJE0XAUy
	 zgFvuzrW2J4cebqLoj6py87Xdf3YnF8SnCr0hNvZ6e98C898tfKFv25L64CUPj//jb
	 EChO/UUPL4RJ3rxLHZANxfNNCH9jozO9iWhz5ChqgZCcUXvOarkLXvS0/N3zAc34WY
	 3w+h/Rv1ZV3qw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id EECD82CEE620;
	Sun, 08 Nov 2026 15:18:12 +0000 (GMT)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/6] spi: qcom-geni: Add QSPI support over GPI DMA
From: Mark Brown <broonie@kernel.org>
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
References: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
Date: Sun, 08 Nov 2026 15:18:10 +0000
Message-Id: <179415109036.3711751.6859082995940422062.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=421; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LaAlc+ErhOxT3MacrK1VduFBzN3l5WzRUYavGhSGNbQ=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+TNoSWxXFeOn3pVlM6cEhtkutux78Xpf7zpb/rb3vc
 UuneR9nd5SyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAib2cxMvwrnjPBW9J+pbi0
 bX3WjaMV7Q5NEz5N9bD+PU3E29T0NTsjw2UndTOvxesfpeRn3twbn7KhdWUZS2b1vBMxV58pvp0
 exg4A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> This series adds QSPI support to the Qualcomm GENI SPI driver using
> GPI DMA. It supports single, dual and quad SDR transfers in controller
> mode.

This doesn't apply against current code, please check and resend.

> ---
> base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
> change-id: 20261021-qspi_upstream_series-850249e432f5

That's a random -next commit...

-- 
Mark Brown <broonie@kernel.org>
