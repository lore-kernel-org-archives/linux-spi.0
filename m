Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460665;
	b=DjAfJBCsUN7MolBxjHMIvBjPn9biGhUTU0v/jFM2FyefEAypda83GTUf9WQg/3EiXiWk
	 71QJ5fBo7d/6M2X8y/HcoQ6dbuU2VcwWxgSCc5OATUmvwAsXj9YXeyztesjwtn6Dz4xSq
	 e1gfOYilQU9KxDE94yLmZ7agLEQyIgab7NEOeljf1DJdMcmehHtAfU6MQya94+sj8ZoUE
	 WoslKVTHYyOP8K+PE5mkx9hkrVPTTN52gqR5JyFDmVdE6WBfoHJmQsQAh9jO2sufijOA5
	 3b1A+CfA6BE/TsnxOJMTB0m9bHXDaDyRPprlD97iRnVczHtPpbEW7cPzP00HyV8Z+6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460665;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UxLUxK2Bj2Hah+1W4IvnMCJg9pItMlb0NA+amZkkOkc=;
	b=ONuPbMTFcBLErx7wI9V5PQZtzcohaUo47VTaLmFcv+cfKP+EYw8sD7cJPPMFq+7zS9Tc
	 0IcAxyvVSRewW3lC5ziRpqDDqZQdiqfL0YvYnm3hi3vM7Wg//Ss+X+imiy8wp13QBI5YH
	 c32nyOawejP4Yrmtm9eA+nhjj2I2Tr+kwDcCRifLXDbZIzVg0LqSGfjXNqdb/VhR+R76h
	 jdPLh4dYTPvSD8X5mYUhif9BmHrK99y3svfHbr/K4ojxoiuoJGNINLxfVECEVSZA7i+G9
	 zSOWQpqKYSootvYXgeYSYGL2F3Fozp7KgCY5zdk2dFhhtgQe6UoCrY9WJSdBA8qiraw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAFMNOID;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3B606A31E;
	Mon, 23 Nov 2026 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAFMNOID
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABFB1F000D8;
	Mon, 23 Nov 2026 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460664;
	bh=UxLUxK2Bj2Hah+1W4IvnMCJg9pItMlb0NA+amZkkOkc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=DAFMNOID9vMzU0vYOFuL1Xz3Xke0tVRzaORGHNG/frKMoY98uFaRd4XHIDQmXT0d8
	 yGDRUnUIichRGxU05Z76vXJsJKQ0G290Wf3cb2GHQFmb/Q+/OJfZrDguJQmqQBBrpZ
	 G/T0mszHbO+eNhcNPT4avUeabnWfXdhprnPy/HAT892FklPz6NwL7e+GDDVQjejtuq
	 a9nzMxghzPhLXr1zG23bsRPf4PDVlGVFonUWcxKmVTxBNTdHWAJFk2NdadLTjJ2d9h
	 wfBd3WddBFP1tVNl4LME6V7Mwv9ra2aaN56MggmjknlJa6m3Lvl3IsgUJ8SLTNI63J
	 HPn1/bCra/u9Q==
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
Subject: Re: [PATCH 5/5] spi: spi-zynqmp-gqspi: Use IO mode if RX buffer is
 not cache-line aligned
From: Mark Brown <broonie@kernel.org>
To: Srikanth Boyapally <srikanth.boyapally@amd.com>
Cc: michal.simek@amd.com, ranjit.waghmode@xilinx.com, broonie@kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, git@amd.com
In-Reply-To: <20261115-qspi_14_11-v1-5-23425ed177bf@amd.com>
References: <20261115-qspi_14_11-v1-0-23425ed177bf@amd.com>
 <20261115-qspi_14_11-v1-5-23425ed177bf@amd.com>
Date: Mon, 23 Nov 2026 19:04:19 +0000
Message-Id: <179546065952.25092.7376341777366576138.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6J5LbQXDLSxrlIn/vwqRS5ku7TEEOJ8FFvjaAbWH1Mo=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJZ+kxtr4R1T/W5bxasHxy6sU36Ic/cj0dORqtmPlysY
 rvRfN3sjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEzkViQjw7xXb5bLHa34N/Ol
 6hHnwC/ndzUnyGWw8XEw+Uc7ycq9/s3wv2BltqH1tQ/xi1rz1/dNlroj7eYydU3lMh6lwD7zd/9
 n8wAA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The QSPI DMA maps the receive buffer with dma_map_single(). That API
> requires the mapped region to start on a CPU cache-line boundary,
> otherwise the cache line can be shared with unrelated data and the
> received data can be corrupted. The 4-byte alignment check does not
> guarantee this.
> 
> The ZynqMP QSPI node is not marked dma-coherent. Fall back to IO mode
> for the whole transfer when the receive buffer start address is not
> aligned to dma_get_cache_alignment(), in the same way as the existing
> short-transfer and 4-byte alignment checks.

> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -871,7 +871,8 @@ static int zynqmp_qspi_setuprxdma(struct zynqmp_qspi *xqspi)
>  	u64 dma_align =  (u64)(uintptr_t)xqspi->rxbuf;
>  
>  	if (xqspi->bytes_to_receive < 8 ||
> -	    ((dma_align & GQSPI_DMA_UNALIGN) != 0x0)) {
> +	    ((dma_align & GQSPI_DMA_UNALIGN) != 0x0) ||
> +	    !IS_ALIGNED(dma_align, dma_get_cache_alignment())) {

Note that we have the same requirement for the end of the buffer.

-- 
Mark Brown <broonie@kernel.org>
