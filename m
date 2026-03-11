Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8789B36F414;
	Wed, 11 Mar 2026 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199420; cv=none; b=hdr1DvCiwCLXesXuSiAP6fvIVp/w9i8wgHvrVKMu+3VkZCCk4e133XqU1/y/z+jdM+G1cU4q6nAPq1+qvmpOxOXhX9Z1K02R9zqEwVM1DVJzI6tnnKDmmXdGNI4uLGXJ4AuDh0nBABFT7mrQ/Nl/7trFjalqEn9oFLkykT9l5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199420; c=relaxed/simple;
	bh=NBn0HGzyHP52LXSlQhHyifFtjrmW5H7f6XcjknWW90k=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=VtL4H2DEJWe6hRNQqLL1F6oKYREYwWoDFN4JOA6pzUJQaAulo2Cjb9KcqhT7nrkIHneL0GgP8/gBfgPrFQUlC7R+WSMrLAe3FNa0Cz+8JioWPx48UUWdEmGUipMjCKlTRbHLt0Vok5tbnhh9uuPXgKKT1CdCr3sLZV1YFGIb3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxBlbMBI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxBlbMBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F23C19423;
	Wed, 11 Mar 2026 03:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773199420;
	bh=NBn0HGzyHP52LXSlQhHyifFtjrmW5H7f6XcjknWW90k=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=cxBlbMBIncnf930kfnUyfiTCT6c8YGOHfEzNbbA/Sse3vIypMbbZnmghAGNkxGmk1
	 SLjdijmFRuNjKe2NqKZ4x30fWpJ5sjU47shqIetjRYYD6HlGqwgFRugr0eUssv+KD0
	 JuFf8o4ATxkiGo9KgEX5mGw3VtW44lqCmJybtQ5YsBoq6jxIp9t0m2oP6u3m265TZp
	 LpJCFunonm6pQjUMvcZ01EhuzzLfDKzzDurJ/9Fz/1twjJWGUJqEQ+pjR5NRwbG+e3
	 6SnCmGcRziajGc0IYz4C7WrLCkrbgPGej7MkXm5QnYE2P+yZW4yr8RcGSHV6dhuxYf
	 dOT60RP92oOhw==
Date: Tue, 10 Mar 2026 22:23:39 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, jh.hsu@mediatek.com, 
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 sirius.wang@mediatek.com, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Conor Dooley <conor+dt@kernel.org>, Chuanhong Guo <gch981213@gmail.com>, 
 vince-wl.liu@mediatek.com, Bayi Cheng <bayi.cheng@mediatek.com>
To: Meiker Gao <ot_meiker.gao@mediatek.com>
In-Reply-To: <20260311015214.655555-1-ot_meiker.gao@mediatek.com>
References: <20260311015214.655555-1-ot_meiker.gao@mediatek.com>
Message-Id: <177319941914.1664906.9202491314151419048.robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock
 bindings for mt8189


On Wed, 11 Mar 2026 09:51:27 +0800, Meiker Gao wrote:
> Update mediatek,spi-mtk-nor.yaml to add conditional clock and clock-names
> bindings for the mt8189-nor platform. The mt8189-nor controller requires
> five specific clocks and corresponding clock-names ("spi", "sf", "axi_f",
> "axi_h", "axi_p"). This change enforces these requirements in the device
> tree binding schema.
> 
> For other platforms, the minimum number of clocks and clock-names remains
> unchanged. The patch also adds an example for mt8189-nor, illustrating the
> new clock configuration.
> 
> This update ensures correct hardware description and validation for
> mt8189-nor, improving compatibility and reducing configuration errors.
> 
> Signed-off-by: Meiker Gao <ot_meiker.gao@mediatek.com>
> (cherry picked from commit de637a2fea765a92d4b06efef34671c74f8bc109)
> ---
>  .../bindings/spi/mediatek,spi-mtk-nor.yaml    | 71 +++++++++++++++----
>  1 file changed, 59 insertions(+), 12 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml: allOf:1:then:properties:clock-names: {'maxItems': 5, 'items': [{'const': 'spi'}, {'const': 'sf'}, {'const': 'axi_f'}, {'const': 'axi_h'}, {'const': 'axi_p'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.example.dts:69:18: fatal error: dt-bindings/clock/mediatek,mt8189-clk.h: No such file or directory
   69 |         #include <dt-bindings/clock/mediatek,mt8189-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:140: Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1608: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260311015214.655555-1-ot_meiker.gao@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

