Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516349;
	b=3eFdxuf4A8p6Je9DgCa/gBFAumj0DoT83wHCOXzi3DCBcgJm9UW+wYj7szA/rkU55M8E
	 Sx6mHZ+5apu7nsyovfpHnliKopfNr/haTRaOsgwgyjsKU1f8XX3saPhXSoWNjn0v9kja2
	 LJ5UX121/EaCwvjfRpQGNNSqPj17HoO85eKskPjCN8fL9IuVWwIDw0TMxsqjxyZs8A4rO
	 D+22Ab672tXedK3XvUV2viseHZZqeq2KjQIa+2nocRyIepCTMP4PLyVy8Cu2MDoT+A5P8
	 SZQ/W6G8W6LNsvCLQOmRsN9EZu4EISz/qqV5JUoWMTIFfneQpRRaJ9VAGCNVXvez3Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516349;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vExIF6BLPxilcEzmeQ44C3+EI0WD/Najy1w9BlH7ZrA=;
	b=yXUnJY7rbpSrIkxvAFcAScLDAiK1QE3e+HbnCGjVcFmT+AfxtZlXZ8gaf9KNZdz28SmX
	 g/gUiCXApmfBqAa75aq4rw4okfk3XDsGFqbFxoQlpmPd6y1szA69bw27H76OC3x3U/Ljp
	 5zYOBojFgW/KHdAa6ZT43t2bIinS1DIwyx4QoorfeEOy5ayE25J4QnijUDmrFwZdrXwYg
	 i2RREFj2ruNxaxQwS9EAXMM5o8DzCDK0Pv5uxxyRaElMM+X70zWd1nOGHrHC7g4Xs/itg
	 epqZOf1R7Q6YPEm656tlKPnO3ssNpN/Gatnb8ABfV1B6EiO6VDWNfHUga4at1LB4QxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnTlgR2z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D779660A2622;
	Thu, 12 Nov 2026 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnTlgR2z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F951F000C5;
	Thu, 12 Nov 2026 20:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794516349;
	bh=vExIF6BLPxilcEzmeQ44C3+EI0WD/Najy1w9BlH7ZrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bnTlgR2zNej1/jMfIJfET7Ftvcp5O+JbEvwTIwChPZ7SkRsHdUJD58A3YopMYrBR5
	 3RmSFO7z9CLI/6CVeJasToJu2h0SYlnwUiHxwTq3pG17mSvsTcBw69kzs+EdqippEF
	 qPgrYDTbUlic/c4NWH45S05EPBgVslRBBN9JBfa4iABnBtHQ5kMR6HbdkCp8j5FHPb
	 ryKntZW2dO2BE5fyp5NexcrghC/k12C+XV1K3FWOUg+CwdZJMUcSu+Z/siXVOAIv0e
	 3W3gOdiHREXzjNBqXIcJjB3tDoNjpBbFQaBhqaJQEppmuZGD9ZVcIoJAlMxYoKZpC5
	 WmHSWNDLxlDCw==
Date: Thu, 12 Nov 2026 12:45:49 -0800
From: Kees Cook <kees@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Dennis Gilmore <dennis@ausil.us>,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	gustavoars@kernel.org, linux-sound@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	dlechner@baylibre.com, linux-spi@vger.kernel.org,
	miriam.rachel.korenblit@intel.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: start rtd->num_components at zero
Message-ID: <202611121234.8619E8D182@keescook>
References: <20261112025252.71375-1-dennis@ausil.us>
 <179448342405.66517.5463730214277229760.b4-review@b4>
 <f55dddf1-d745-471a-8001-8f9e5768d97d@oss.qualcomm.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55dddf1-d745-471a-8001-8f9e5768d97d@oss.qualcomm.com>

On Thu, Nov 12, 2026 at 02:34:17PM +0100, Hans de Goede wrote:
> @Kees, have you seen Dennis' remark about the same problem with
> devm_kzalloc_flex() changing the semantics with the num-components
> counter now no longer being initialized to zero in at least 2 other
> places? :

Eek, thank you. I will go look at these!

> 
> """
> Kees, the same pattern (a *_flex() allocation followed by code that uses
> the counter as a fill index starting from zero) looks to be present in
> two places converted by 69050f8d6d07 ("treewide: Replace kmalloc with
> kmalloc_obj for non-scalar types"). I have only read the code for these.
> I have no hardware for either and have not reproduced them, so please
> treat them as possible issues rather than confirmed bugs:
> 
>  - drivers/spi/spi-axi-spi-engine.c: spi_engine_optimize_message()
>    allocates p with kzalloc_flex(*p, instructions, p_dry.length + 1),
>    which presets p->length, and spi_engine_compile_message() then
>    appends with p->length++ through spi_engine_program_add_cmd().

Oh, this was from before:
69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")

>  - drivers/net/wireless/intel/iwlwifi/mld/d3.c:
>    iwl_mld_process_netdetect_res() allocates netdetect_info with
>    kzalloc_flex(..., matches, n_matches), presetting n_matches, and
>    iwl_mld_set_netdetect_info() stores at matches[n_matches] and then
>    increments it. The per-match kzalloc_flex(..., channels, n_channels)
>    has the same issue with match->n_channels.

Same.

I'll send fixes.

-- 
Kees Cook
