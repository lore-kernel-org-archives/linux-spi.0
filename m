Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728502;
	b=RX1w+Z7xCqAe8K1cjJm9OYgGCtk1xAuZDB5SVspV6UyS9T06hGLL1ham9RAs7fRGlKNf
	 JqG5bWIReTJML7IiUudB08Pn4P6s9V0OoVBsqXber0oDqhE3VKnndAwqYuIf+R9EhE0Ui
	 hUPKw9RgS6xeoGChkJR+gHdlACP/xZKlY2vz56uba1yRW8JQa53PvcOs5RWL0+Zd0gwyT
	 5c5qDEyWszUWyVvPRw1MZWBOBAFna2JRTohdM8Sx7uZSSOwZlsCGV9rxJdeLV0X3qfw2B
	 iPbT9orrUWNZHLl/hrCkSFIhp2HMgjmZ3XgywvSUtYEQcqvk49oRC+NvQzYIHyQcXtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728502;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=6GLhuMbXegNOyHoLyDWvfiTzxggOMPvvXd+1vKENFmU=;
	b=ELGea4MO3p/n2QrQ37Q483buLJ0K/44SCSLzZGdb37F4WjxW7LK4LCoTDGN+fIs0C0Mu
	 mTHMhPzBbaRMCENR5ebTrICQNqkNXUHW89qbWwIFhkk6kUNMcgPEx3pLX/8u76Dr9sKZP
	 TKnOtu8b62ZPMbeo9tuT4WqGpF8RsuRHQvzea/N3WgehcNcVZh22b5o2YRuOYsTGSqtT2
	 EcCe5IYS/cuipsyDNSh2/UeMq+KWtIDl/RGq3JyWFYKNgyV5FvHik6vLrUN0IxSS6k6P8
	 r8c7RY7QLXEFKYMCmM8vamt6/vOCwtjLzvtFuDSFQbMsSd+z4fM5MQKRkGU5g7d3LvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e8uuMufo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82472606A31C;
	Thu, 26 Nov 2026 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e8uuMufo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0DE1F00898;
	Thu, 26 Nov 2026 21:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795728501;
	bh=6GLhuMbXegNOyHoLyDWvfiTzxggOMPvvXd+1vKENFmU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=e8uuMufoZZJAAQrzd8HyU5U+ybgGQsilFZTR54gz63MDayzI4gWQIDlWmyxPQesRZ
	 iOAF6GQn4A+kiaNF0wCG0J216bmAHUyVeinfoBlm3OmqjZdkU5Rq6lR5lgDLFhm8rz
	 DYobmZZPOfIgcoe237MM9IbvhmZl/YoFBh332SF8GIcfb4h9RNxY+BKyVqBuVpnSdx
	 LMB2FpCCcnERZTSAymFuL3WUWEgT1HK7IRuvTKx8BoCDUoVL91ipUQcwqndSKQw8FC
	 Jb9QRhaH1B/8YIw2IzAdWBfwthWb4C2bZWBlnfpstAEbZ0I5W+5fWgAxCdclaypkjP
	 pjCoCu1G7Gcuw==
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
Subject: Re: [PATCH 1/2] spi: rockchip-sfc: add RK3506 support
From: Mark Brown <broonie@kernel.org>
To: ZhuXiangyu <1194781887@qq.com>
Cc: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Morgan <macromorgan@hotmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_B239E24A7651B43AC21C4769D1E75FA0A505@qq.com>
References: <tencent_B239E24A7651B43AC21C4769D1E75FA0A505@qq.com>
Date: Thu, 26 Nov 2026 21:28:16 +0000
Message-Id: <179572849657.838304.17453642107387470092.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602; i=broonie@kernel.org;
 h=from:subject:message-id; bh=17xmrTkEbfk8M9MCDD02uxzPPUZzmo258y4i5BQ+1rc=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI5lhS6bNORXfl9/uyUko1XfgS5VOZra8xbE+gnOK3+w
 Mn9qspnO0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRwBiGfwoT1mi71b6OqQl7
 zvv7W2/Wu7hYx2M9ogVv9mWs/OJvdonhfzjnsdM/V29ctTl3xdHMg9wzdmXL75xewie9cvmvCeG
 FWUwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The RK3506 SFC reports version 9 but is compatible with the version 6
> feature set. It needs a power-good handshake through the PMU GRF and
> DLL delay-line training for clock rates above 50 MHz.
> 
> Add the version handling, DLL cell detection and training, and the
> optional power-good poll. Parse the rockchip,max-dll property so boards
> can limit the DLL training range.
> 
> Tested on an RK3506B board with the on-board SPI-NAND at 80 MHz.
> DLL training selects cell 64; read and write are stable.

> @@ -375,6 +427,15 @@ static int rockchip_sfc_xfer_setup(struct rockchip_sfc *sfc,
>  	dev_dbg(sfc->dev, "sfc ctrl=%x cmd=%x addr=%llx len=%x\n",
>  		ctrl, cmd, op->addr.val, len);
>  
> +	if (sfc->data && sfc->data->powergood.valid) {
> +		if (regmap_read_poll_timeout(sfc->grf, sfc->data->powergood.grf_offset,
> +					     voltage, voltage & sfc->data->powergood.bits_mask,
> +					     1000, jiffies_to_usecs(HZ))) {
> +			dev_err(sfc->dev, "wait for powergood failed\n");
> +			return -EIO;
> +		}
> +	}

I note that the callers don't seem to check the return value...

> +static void rockchip_sfc_delay_lines_tuning(struct rockchip_sfc *sfc, struct spi_mem *mem)
> +{

> +	if (rockchip_sfc_exec_op_bypass(sfc, mem, &op) ||
> +	    (0xFF == id[0] && 0xFF == id[1]) ||
> +	    (0x00 == id[0] && 0x00 == id[1])) {
> +		dev_dbg(sfc->dev, "no dev, dll by pass\n");
> +		rockchip_sfc_clk_set_rate(sfc, sfc->speed[cs]);
> +		sfc->speed[cs] = SFC_DLL_THRESHOLD_RATE;

Shouldn't we use the safe-frequency fallback?

-- 
Mark Brown <broonie@kernel.org>
