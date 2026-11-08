Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140440;
	b=MstQCsH6ip9V/yZ8e3k4aD/ub8g6+pijFmRBRDXi4qv31nnsj7nvk3ZpVdpBXU6z+1yH
	 JeqejLNSJJSFSiXRfp/vo9U0e2VzMgh/6iVl3F6MZm+Zj0OcRb9lbxnrZFJKsizcUhkP8
	 RA4asFftFdYRyH79rj8knidMD4/SVIesg5cneGDm8LLljRphVegm0ahTHNblplFqUeXZQ
	 yWwBFMCx2P/hT6j+vu4bQ5bnMUcen7XNO8kVNF3z1k6+yHnz2faxgxH9H2S2sDOtBvicf
	 1dpMAA7jAlexOu8aT5IJLpg9wTs+kmDz9LqEjBOmGlNjZDeZMY2Rm3eRW0bFlFRF9rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140440;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Z0y6eaBsxzUThfzx9UP13uc1XtIr/6AqzMc/qlXa2WE=;
	b=puuJwLH4jAuEYH9N4RSUPUt5a9qkWzxgrMi4R8vmTDOP+srDbdV4fm0zNOy0lKXFQD00
	 XGxwi1xNxx5y5rNlOVSqBgXM3rAHfxPo9+BnNb9lr6J5tU4UAzPxpghRn5oN44+F+x18k
	 TTgSNgZhdjiozgcrQM2Vagw7HteipvPAtdACSyZGTChVmpwziEN6F6IRqvKmnwwFFpD4D
	 afBFZCbYG2bpqMfA1GxVaXMSWdGl70iaZ7eV7v7O3pv+GabhwF/TfXnLH7SCPoCYjC2xP
	 DTe7Xy2jtYqtz8bsb5kjU+rsvTYGZzMzfMnZtAxiqooBZMQZAn/oXRh8gf/fUWzNR0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXcXN9RA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A706D606A31C;
	Sun,  8 Nov 2026 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXcXN9RA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286321F0089F;
	Sun,  8 Nov 2026 12:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140440;
	bh=Z0y6eaBsxzUThfzx9UP13uc1XtIr/6AqzMc/qlXa2WE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=WXcXN9RAtzVke8mAk+NZ62s5rEXt0za8/W82KKoak73ZciYuzzw5+pDAT7UdtSRuN
	 STz54XAdR8CsX2SZtv2jMvTu8aXUHaZAE5UQIk885OyloLtVBS4HDauEJXIUOT7nXY
	 05ckNTPOTriPijyjbLdNzBQHCq/QdZgm5d6T31FKBLd1OCw387jXXNN8a5/cQ29cJF
	 do4nLjJgiF6gBKSBtTF2RG6dXJux+2gogJC7I7ufZ5ptfwmXBG8wE/kWomOmXHVht4
	 n280NRnEsVz05UhIJ7YGIrHwEXfzEPzCKdBWmCfbr49oyIyLDJPnF12FGGYYSiZRhW
	 i3AOXngAfCeJQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 6C9CF2C2C473;
	Sun, 08 Nov 2026 12:20:37 +0000 (GMT)
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
Subject: Re: [PATCH] spi: intel: only check locked opmenu for SW sequencer
 operations
From: Mark Brown <broonie@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Mauro Lima <mauro.lima@eclypsium.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Lee Jones <lee@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261101200313.16411-1-rosenp@gmail.com>
References: <20261101200313.16411-1-rosenp@gmail.com>
Date: Sun, 08 Nov 2026 12:20:21 +0000
Message-Id: <179414042181.3630016.5337245544547078214.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ffvScCYWLP1l8GMZTbXJdOrsNZ+RBwcDgIF/1Uc9frk=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+ZLJ/6RSbeci6Y0YSv3m5Q9ydtjmh9n5PBXjeHTy+r
 aHk3Mm0jlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEzkyy6G/47LzD9LB8soyt8t
 vDRll0CNEPua9ENNSuu3fL+weNPO3AUMf7h89fldQy855yUzl86c/Sr/eFykA/Pd+6kihikNLJO
 ecAIA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> On controllers that use the software sequencer for register access (LPT
> and BYT), intel_spi_supports_mem_op() rejects any operation whose opcode
> is not in the BIOS-locked OPMENU. However the check is applied to every
> operation, including normal data reads and writes which are always
> executed by the hardware sequencer and never consult the OPMENU.

> +static bool intel_spi_op_uses_swseq(const struct intel_spi *ispi,
> +				    const struct intel_spi_mem_op *iop)
> +{
> +	if (iop->exec_op == intel_spi_read_reg ||
> +	    iop->exec_op == intel_spi_write_reg)
> +		return ispi->swseq_reg;

This will match for SPINOR_OP_WREN and SPINOR_OP_WRDI, should this be
something like this:

 	if (iop->exec_op == intel_spi_write_reg &&
 	    (iop->mem_op.cmd.opcode == SPINOR_OP_WREN ||
 	     iop->mem_op.cmd.opcode == SPINOR_OP_WRDI))
 		return false;

Sashiko has some analysis:

   https://sashiko.dev/#/message/20261101200313.16411-1-rosenp@gmail.com

-- 
Mark Brown <broonie@kernel.org>
