Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795744468;
	b=Er3lyC6gc4qqRDDwRP32GrbnP2mECtEMER3fvs32HJeokf+yryrzoDZWh/SbIBfrNXwG
	 DL30pzjqnlp8SqnzzBpuVK26RZVcmu40NyvC1IhN1kWptMQ0b3oTnW6k0UrzyYS9u/902
	 YgT3Fh0WuHyX1TCBli9F51OLMkkF327w4xDsA+LS6sPJLmBGJUpnxrtk7QRPgOmBs+amb
	 ykNShFIwKxZyBNEp2lvlzscz8Bpd3tOKVQKuXf6aJHypnRnynAeXSg4N1TeX3Fb4VWroi
	 7D+76kmyJS/735l6+pmH/07Tln/7fgcUiYVx4xK8a2V1Mc8tu/L3zcc+XnkxdFndemQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795744468;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ffGpf5doUGFfN44Br0XFD5t5nQWp6LjCvVtOu3wJuBw=;
	b=hLnNUshxK7RRtOiPGO8O6QqpOwWvDm2DW35jK13LcpaZd3VuhiUYQHBzOOjwsafSW4Lb
	 mtWdR0nbO3zAS8Nn7BTn4Snwiv3qmeHE8IzS8NWvoC3wG+w7I/ltuJlr3wCE5umuTDnni
	 QkdelJ1tjQsOY6FcU7qupQfxG3PmO3FBxHlMEDi4TlJljtYobSNDaKxAgj2EAiOvWzzvf
	 jXFT5N8oQZOzvfJb64kvBAGzsUvtrx8sTCjySUaFFRwaBMAHsl9Sm1jq5MCWA+i1r7vBk
	 vxaE8UF86lgK7ogdg2P4mEpBSx+/+qaH+Ra9EeO7VQePzzluvAixMAKOfEUz1eCmeoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNqoG3dr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E7606A333;
	Fri, 27 Nov 2026 01:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNqoG3dr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568EE1F00897;
	Fri, 27 Nov 2026 01:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795744467;
	bh=ffGpf5doUGFfN44Br0XFD5t5nQWp6LjCvVtOu3wJuBw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=bNqoG3dr0Qw1AKM5EB7f5KyIbEY5pXUhOF0xtLM/u52dHrAzOSlEC95RwO6cw0gIk
	 v2Iy29kcBEUQBfv2i/ZWNnAYnfMG11IRZnkS2OMCtg7VYs3JpXMQgOM6TAnRt8+ooM
	 ovU4Nx1bA8wLF2tQHEmVm/rCBHY0E7MC4F373BLIDlNLMwBSvTL4YjzIhNrrPL6YJB
	 pSqYaAF8oCAFFVB2U/HLLgv39SnDkyPBPiAdY/bx2fVI9ZvqATyARKs2+ToG2jEr/1
	 VF86NugpW1AWwrIYCCns3PyDUYMbHw2HR1OTPceRlHKLZyZoNrg7sO8O4I1jnkFGB3
	 7RDM/eliaf3bA==
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
Subject: Re: [PATCH v2] spi: ljca: Do not wait for an ack after every write
 chunk
From: Mark Brown <broonie@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 Lixu Zhang <lixu.zhang@intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20261126201346.21258-1-pmenzel@molgen.mpg.de>
References: <20261126201346.21258-1-pmenzel@molgen.mpg.de>
Date: Fri, 27 Nov 2026 01:54:22 +0000
Message-Id: <179574446234.838304.4318467965198855165.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=492; i=broonie@kernel.org;
 h=from:subject:message-id; bh=g3mrUWcDu9lsnVk9bYqD26Ypi/sJ8BJrRcSGQb8nniM=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI5Hl3QX7LZR8iwakYi/0TpHNvXjmlmPbbst0+82/Ayc
 V/Xvp75HaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZjIIXZGhh+f/dY2mZ2qkww/
 cLfxUpvocYvITK5W/p9GM1ULzxjvzmT4w6NaoNX/RdryyZkDZZ+ite6azZDSd7j2NXPGPPkZZyc
 c4wEA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Only request an ack for the last chunk of a write, and send the others
> with ljca_transfer_noack(). Bulk messages arrive in order, so the
> transfer still completes only after the adapter has handled all chunks.
> A write chunk then takes 112 us (median) instead of 279 us. Reads and
> full-duplex transfers are unchanged, as each of their chunks returns
> data.

What happens if there's an I/O error somewhere in the unacknowleged
writes?

-- 
Mark Brown <broonie@kernel.org>
