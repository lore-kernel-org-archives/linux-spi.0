Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CCF1F099C;
	Thu,  5 Mar 2026 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718323; cv=none; b=AxfccWpzCb5W3RpEk/8F0VpikVu0gFYIptM+cxf+1BtbC1hZFsHwcx0seJiC/RJ+f7LXALiFb3wGnsTVGr92FECMEBYA7Sno0Bs9kwTl6xEkuqEufavNpiFmoU0PSsU5R0GdBrRfq779puBo1+RhWj6j9ZpZlEKBT45h5QRcrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718323; c=relaxed/simple;
	bh=OItzwbM1kWf/k111FzhV0ryoidvsVkmrmFKOuyzTRBA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lvGRphIgUM71XGZr2gzassvN5FEnisKKChxnk/yAkBSESJc29OJWtKVKAkJ3PR/4M+zRDBiQzHM+aObzlNkHT/2l89zcLRmFCrQ0YMGpwOdEicOmMZOlQ4jk96DZ077q5x7uaNKfK59mP8jEtNmsMQoA/xcsfdR/DDDS1CL5y9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB//sRAq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB//sRAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F620C116C6;
	Thu,  5 Mar 2026 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772718323;
	bh=OItzwbM1kWf/k111FzhV0ryoidvsVkmrmFKOuyzTRBA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=LB//sRAqF22s63HNrBHamLSG8+BH0+Cws/VmCppeOuyzHovaM84NrUtkJsx+88eMG
	 Kvy7oUUO/Gg12APg9N8DkBlWImapQBu7dMHKgBJYtvB28KLJjr5jDtxmBqrUqHyQZ+
	 4U1ZcaYZk0WmqFuQJwX0RfhS4zcfd1vacfTFEO7I+/D5qd7qklmBBEqFUgJ49I4Wl/
	 ySo0JzoulrRF3VGczcDCsYTbOVvu9gMamxOM+loEdhxA0RGIIVJ9p+jT1Ho6e6Iyob
	 WalmR0IgSb/JqAvs0dVVhdifrH4lIOHrXvqlOj0tvB4vynmKdRhTC+emWryJQ+lgt1
	 xuNUqq5FPr66A==
Date: Thu, 05 Mar 2026 07:45:22 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Chuanhong Guo <gch981213@gmail.com>, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 Bayi Cheng <bayi.cheng@mediatek.com>, sirius.wang@mediatek.com, 
 Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, 
 vince-wl.liu@mediatek.com, linux-mediatek@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 linux-arm-kernel@lists.infradead.org, jh.hsu@mediatek.com, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Meiker Gao <ot_meiker.gao@mediatek.com>
In-Reply-To: <20260305071546.2603378-1-ot_meiker.gao@mediatek.com>
References: <20260305071546.2603378-1-ot_meiker.gao@mediatek.com>
Message-Id: <177271832061.3486624.7931849295651115643.robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock
 bindings for mt8189


On Thu, 05 Mar 2026 15:15:42 +0800, Meiker Gao wrote:
> Update mediatek,spi-mtk-nor.yaml to add conditional clock and
> clock-names bindings for the mt8189-nor platform. The mt8189-nor
> controller requires five specific clocks and corresponding clock-names
> ("spi", "sf", "axi_f", "axi_h", "axi_p"). This change enforces these
> requirements in the device tree binding schema.
> 
> For other platforms, the minimum number of clocks and clock-names
> remains unchanged. The patch also adds an example for mt8189-nor,
> illustrating the new clock configuration.
> 
> This update ensures correct hardware description and validation for
> mt8189-nor, improving compatibility and reducing configuration errors.
> 
> Signed-off-by: Meiker Gao <ot_meiker.gao@mediatek.com>
> (cherry picked from commit c3180d35e52b5213764a89403e71f9a34d7bb842)
> ---
>  .../bindings/spi/mediatek,spi-mtk-nor.yaml    | 69 ++++++++++++++++---
>  1 file changed, 58 insertions(+), 11 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml: allOf:1:then:properties:clock-names: 'oneOf' conditional failed, one must be fixed:
	False schema does not allow 5
	[{'const': 'spi'}, {'const': 'sf'}, {'const': 'axi_f'}, {'const': 'axi_h'}, {'const': 'axi_p'}] is too long
	[{'const': 'spi'}, {'const': 'sf'}, {'const': 'axi_f'}, {'const': 'axi_h'}, {'const': 'axi_p'}] is too short
	1 was expected
	5 is greater than the maximum of 2
	5 is greater than the maximum of 3
	5 is greater than the maximum of 4
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml
Lexical error: Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.example.dts:79.32-50 Unexpected 'CLK_PERAO_SFLASH_F'
Lexical error: Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.example.dts:79.64-82 Unexpected 'CLK_PERAO_SFLASH_H'
Lexical error: Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.example.dts:80.32-50 Unexpected 'CLK_PERAO_SFLASH_P'
FATAL ERROR: Syntax error parsing input tree
make[2]: *** [scripts/Makefile.dtbs:140: Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1597: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260305071546.2603378-1-ot_meiker.gao@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

