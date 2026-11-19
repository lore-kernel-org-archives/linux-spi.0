Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105979;
	b=yuScRkLq6tBkLmbCW7fNWqb2OBkWBfe7z30f/RtDoQDUOOCGiaQ6YqZwwWEPIgvNo1Vq
	 /RPWsY3+ppLJ/cpuRX9A6joFxEdHhue/87jxQ5Q/kbRD8KfU8z6PAwjH2o4rX/kEmEu+z
	 mzlSNwctHM3kmK4Oj+Ifjr+EaGR5a3yH0gNaxgjevvlpbKDO1siXxO6rTiofaSwisS9Rl
	 Ua1jgzdOqdbPAzu9uUtzUts01fonKWSJ0yPrQRcctIxSUrGMYhplGCYUjA0PlLOOAP+fj
	 P3TCGUX3C04GOYIXBOWFMUOXUT5E+iyUGUNeoGV9xTCcXM83W5vwkDjKVnrC8xk6ESA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105979;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nLjjjqTetmcA6FDyF8CsIiB5RjcvEiBL2/mnOQviUt8=;
	b=ULASoNNDNXZwyjSDH+2eIRxIwZs6NQmniCbMQ07zuSBUMhX5pK4exf30AozaD9Klii5r
	 J4rMfV/oZ7Q4pmYkY5lCJEH03jSOGengApPWM2ipOhgmyMAQGY910iQr3+FSDJdWGDfVT
	 nT0bIC6A/H0TYkRaYYphuaJy2kACsjlfqyjSStaKiU7L7b/XZExQ2Yxj+lZphAw0xS93D
	 /mI0xT6d209DpQTtNf6BLjl70C/Niq9Cy94c2Sez6s7DvNX/W1bDB12y3NJDj6qBO6fn9
	 IyF5gC/JYajUlK7P00U5xIhUZqzFkjm3qt4NSBQH9LcIJHLQqoqbpgZlVjfg2w2oHuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bm2nwnjS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB8F606A325;
	Thu, 19 Nov 2026 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bm2nwnjS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7083C1F000C4;
	Thu, 19 Nov 2026 16:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795105979;
	bh=nLjjjqTetmcA6FDyF8CsIiB5RjcvEiBL2/mnOQviUt8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=bm2nwnjSavhStDMZBjmSRbz9dk7521JFcKyPXoxrXHgwAOcRLRGF07sDD+lZwLJYy
	 pBn29SDeb8SVD1BSGZ/TYCorA0lVDfYlUc4QG6Mc2W4FFobWkFi8wimP65nXIoT5jX
	 htwH0x8/YbeNIHUC8hsht2NcyJEvj+lZRUQDkR8Z7JKMQUFSmOP8lGhpJHTKJuy3bu
	 RNZppyQy9OjcFvz85GsNQtqgQcpjghC9DYi+zBxP25TwbOSKndNbDKgodoRrjLEIta
	 00MlHT3oL2N+5VIFtK83j3LjHoGvibZPICRTE9ayluCuOQ6JJ8KcfJdiYfZ7jkxk+I
	 Boo8WdD8rH1aw==
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
Subject: Re: [PATCH v2 8/8] spi: cadence-xspi: add ACMD mode support
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>, 
 Pratyush Yadav <p.yadav@ti.com>, Parshuram Thombare <pthombar@cadence.com>, 
 Konrad Kociolek <konrad@cadence.com>, Mark Brown <broonie@kernel.org>, 
 Jayshri Pawar <jpawar@cadence.com>
In-Reply-To: <20261111-xspi-cadence-add-acmd-v2-8-d339046ada8b@analog.com>
References: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
 <20261111-xspi-cadence-add-acmd-v2-8-d339046ada8b@analog.com>
Date: Thu, 19 Nov 2026 16:32:53 +0000
Message-Id: <179510597329.116416.10875562325040526605.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; i=broonie@kernel.org;
 h=from:subject:message-id; bh=b6QwiWuNP+bLZlmf+wbZCRpkSzZKG1Dl1KIO/M5EC6c=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+q2xTU7lpP++Be+e70z5zuKtuPzMuTX5utP72tVcfj
 Fvfvra93FHKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJ7NnF8Jtdtc5pobPlUZ2H
 3/gnNdzX0IhVK2XTOnCi/PplpgVxz8UYGdYwZjh8rBLlttkZ++ay4UnrzohnjVMWqbL3pgouCK0
 T5gcA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> So far every operation goes through STIG mode, where the CPU builds
> each command and drains the data. The controller also has an auto
> command (ACMD) mode where it runs a whole read sequence on its own and,
> with the internal DMA, writes the data straight to memory.

>  }
> @@ -710,6 +921,10 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
>  	struct cdns_xspi_dev *cdns_xspi =
>  		spi_controller_get_devdata(mem->spi->controller);
>  
> +	/* The ACMD transfer length is a full 32-bit field, so no limit */
> +	if (cdns_xspi_acmd_can_read(cdns_xspi, op))
> +		return 0;

This needs to limit to dma_max_mapping_size(cdns_xspi->dev) as well, an
IOMMU or something could limit things.

-- 
Mark Brown <broonie@kernel.org>
