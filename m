Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3BA26B777;
	Wed, 11 Mar 2026 04:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773203032; cv=none; b=eP2yP2dwMQJQ6iUPHjWjl9z6bONBI1+rg31316hiKTKtaoGKNN5QIGTf2dZEvNULz6+W22WqEWD1plp2WoYU9JvOzxXautA1fy/ikTiKDLegxdoj/AQuSYJGFhzrj2OjuinaQ7+55EbE+fTzNRIYTk/GmkLqkRGAA5K7qGRq1Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773203032; c=relaxed/simple;
	bh=UsrotKtwTPcsPEv1FN54h8Xs4K6jwjLX+66h7on1sRY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=L102Pgj8f2gFOod9iocs0Z6QtCKlmFe4M2UxlYppWb8pqCBq/+msp4icUd7kznxVlhTOoBBF7W+QJdePsAV+5shU+Ji1DboHMS1Dy33STArt/Lf1CNJZKYoURsH6YAzWrTEYSu4hTBuBrpmo3qDWZEbqaPaHLHuqUDFn3ZM2g/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV+Z4wJK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV+Z4wJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB66C4CEF7;
	Wed, 11 Mar 2026 04:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773203031;
	bh=UsrotKtwTPcsPEv1FN54h8Xs4K6jwjLX+66h7on1sRY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=kV+Z4wJKA8Ip0GTxo7dHaCritcT2LWejYaC6Ggmw+G81Rk+mlG4CEgd+9X00Xw3bt
	 Xdb1I1dXBj/RQfvsP7RIfCj70ToWDSeZotcJ8xL2p3YxFxucStaTwz4xQBf3RQNzA9
	 MJ3TMhU3PZ2XB9QyRamjwTsrBtw2I1bQsTSWmijZy3JCHGMRgVMF+eScumkTuleQAl
	 ihrLzf0Z5yyiIxaaykYD5bYs/10Rjg5OnVQwUv/RFJJuRIsMN4pNSlvyQIr7o0vpyx
	 u1cxVNUPO2H3ckXNpRiuW2g2aQBX36LrRSbbqZ03fVG9T5acon3hyJlKSWTtMtZ0ud
	 YubliWOcX8e9w==
Date: Tue, 10 Mar 2026 23:23:50 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chuanhong Guo <gch981213@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, jh.hsu@mediatek.com, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Bayi Cheng <bayi.cheng@mediatek.com>, vince-wl.liu@mediatek.com, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>, 
 sirius.wang@mediatek.com, linux-mediatek@lists.infradead.org
To: Meiker Gao <ot_meiker.gao@mediatek.com>
In-Reply-To: <20260311034342.721583-1-ot_meiker.gao@mediatek.com>
References: <20260311034342.721583-1-ot_meiker.gao@mediatek.com>
Message-Id: <177320303066.1741798.2429672153678774846.robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock
 bindings for mt8189


On Wed, 11 Mar 2026 11:43:40 +0800, Meiker Gao wrote:
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
>  .../bindings/spi/mediatek,spi-mtk-nor.yaml    | 46 ++++++++++++++-----
>  1 file changed, 34 insertions(+), 12 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml: allOf:1:then:properties:clock-names: {'maxItems': 5, 'items': [{'const': 'spi'}, {'const': 'sf'}, {'const': 'axi_f'}, {'const': 'axi_h'}, {'const': 'axi_p'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260311034342.721583-1-ot_meiker.gao@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

