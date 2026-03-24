Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9AF27EFEE;
	Tue, 24 Mar 2026 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346089; cv=none; b=adagvfQxqdwg8O5QgHkYgTStj7dilwcddTFdUmj1IepDNQk6mw8vXFQ1XTcj/TH2uT8hU7iDHMH80OEjVcv6s2F8EfqyWFPFxAMka6tjlXlOI95+YO8uJM3kuEJT3lusFKUZC3KPrePwgUWDHCJO7aYI3+59/AMA1ZQoPsmau4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346089; c=relaxed/simple;
	bh=XaFzr+YEjUMzzdze01fC+C0a/ccH9sqXCsUIJsqKR50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urSxIe3xJw1CsC6Pr1JfDPi77jCkbD47pj+eGJ1+Wg/tGi0xS0CMU/YXZeuE+cVa9xscTPnY/pfvg+Gbz53D+ygu3QHUmhLGywbU0Xkxd889a1JpKwN4mfGkiIQErKIpIg4AY8/I/9DGIpu1YZVGPtBQK8tZnZZAj5AqGoElnDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBXX2HTw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBXX2HTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E61C2BCB1;
	Tue, 24 Mar 2026 09:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774346089;
	bh=XaFzr+YEjUMzzdze01fC+C0a/ccH9sqXCsUIJsqKR50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBXX2HTw/oCXSQFIgYluZ+o0MmrV7W3Fl5DKQ3DHsDdp1LhgYAngpJHutHkAbYBjt
	 7eCxSYZAbJb9V5/OQfYViaSPN18RWvIqWfagT6pyxTYC3IHhYpSH8wjB+96DmdjPK5
	 eeuqmuYOU23p99DyYy6aRN0sDVA8yBQ7bl+y1oIvdoAx72Ai/NFEC02kA6dGIMa4C3
	 lDZcrCerNd2yAybV0oxvr6qpiS5Fzli4PBVj+FYv097XaGDormfxq00TRqUYtmNSJK
	 oik0QoJqfbMDNEkQTE/WmDoc32cr6niN7kKNBZxRhnURp1W0Ej/p5uotyjCP/HYA1f
	 syyZdXf2trV3w==
Date: Tue, 24 Mar 2026 10:54:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Meiker Gao <ot_meiker.gao@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bayi Cheng <bayi.cheng@mediatek.com>, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, sirius.wang@mediatek.com, vince-wl.liu@mediatek.com, 
	jh.hsu@mediatek.com, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: Fix clock-names definition
Message-ID: <20260324-magic-camouflaged-albatross-6fdeb1@quoll>
References: <20260324032624.1708029-1-ot_meiker.gao@mediatek.com>
 <20260324032624.1708029-2-ot_meiker.gao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324032624.1708029-2-ot_meiker.gao@mediatek.com>

On Tue, Mar 24, 2026 at 11:26:17AM +0800, Meiker Gao wrote:
> Update the device tree binding for the Mediatek
> MT8196 NOR controller to require that the 'clock-names'
> property contains exactly six entries, in the strict order:
> "spi", "sf", "axi", "axi_s", "bclk", "27m".
> 
> Signed-off-by: Meiker Gao <ot_meiker.gao@mediatek.com>
> Change-Id: I0542d6d726f1af34ef76c1a58ba4e4b02ec45fe6

Please do not send patches which were never checked with tools. Run
checkpatch.

Best regards,
Krzysztof

