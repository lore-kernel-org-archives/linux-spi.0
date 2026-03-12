Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC439BFFD;
	Thu, 12 Mar 2026 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313988; cv=none; b=FOuSf+zwgpd6VJVVjkoU19Riha5FHY+oUf1u9oEpb+VvqCyHjF/PvSEx3OQ88H/zLgF2kLiNCXeiBuXqDhe/IIvw/wJchSkQPh/g2BZazVUuZEU/fnTNnEW7qAzI5esmDO9MG2ag5gQBjPi31/1apuxzec6L/wvr5hoy28q9/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313988; c=relaxed/simple;
	bh=AC0IDDuAlaA4ziUusDW9SF8bfRYW9xHgT8y0P/18zVw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dp4rCdXzZ/J238hB4wEAWDzcsC2cFwmnngx3VUCa8Epg1m2lHXK0QQfnFXke/uYzc4RdfgMQilsMcIz014ZvFSKYYGhzYQtZdMMmPQoBrflldE01BTXXvDeeOI748TZ3Xv9Y71OhxtuCC8PxDFTGzI0rjP23L3XEH9VpizPDjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmEmnljU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmEmnljU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A35AC4CEF7;
	Thu, 12 Mar 2026 11:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773313988;
	bh=AC0IDDuAlaA4ziUusDW9SF8bfRYW9xHgT8y0P/18zVw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bmEmnljUwavVnYSwxSLMfnobWi85zxqiFdo7XtrxXzo/6ILA8NRXXizHOxwUt2GKv
	 q2pX/A0Om293RF/ATS+XK4plP6zQTDy83cUncuk7g6Y3WHKc8q7yA6BpdUvk4b0+lv
	 Xu51O2e1omggrMB+HEW9MqZeAsh4KHEhiITyEwy6lqbPCR6vSlCL0PGEOcIRWwmCcH
	 46j2SVyv4tLlI5nLpsZ31xBw7tMJ9Q8e7zFKRZY2uzan5N/OH3GdktPYJkPqa9DuVB
	 2JRSWp+EAauLDCQC9yKWnBV2Ss9WWUEfGVkVkQ40MjKWRAWMtAdO4urx7ybPPwR1WG
	 RdWHziw2D+QdQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 xiaopeitux@foxmail.com, CL Wang <cl634@andestech.com>
Cc: kernel test robot <lkp@intel.com>, Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <20260303024737.1791196-1-cl634@andestech.com>
References: <20260303024737.1791196-1-cl634@andestech.com>
Subject: Re: [PATCH] spi: atcspi200: Handle invalid buswidth and fix
 compiler warning
Message-Id: <177331398703.10426.13819230822561395709.b4-ty@kernel.org>
Date: Thu, 12 Mar 2026 11:13:07 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-68380

On Tue, 03 Mar 2026 10:47:37 +0800, CL Wang wrote:
> The kernel test robot reported a compile-time error regarding the
> FIELD_PREP() value being too large for the TRANS_DUAL_QUAD field:
> 
>   error: FIELD_PREP: value too large for the field
>   note: in expansion of macro 'TRANS_DUAL_QUAD'
>   tc |= TRANS_DUAL_QUAD(ffs(op->data.buswidth) - 1);
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atcspi200: Handle invalid buswidth and fix compiler warning
      commit: f879365c5bb210ed0d0b0aae1a0202d0c0b4b9d0

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

