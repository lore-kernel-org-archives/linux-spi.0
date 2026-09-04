Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48924A8A2F;
	Fri,  4 Sep 2026 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529239; cv=none; b=QaMTxSJ/lc2cK5TRaJouNsmoh8rV4xp1VoL/vgYbjAb4r7wiIhaWfkgQke//+UyJz+zRq4+mqnNBmGmei+LEgLQJfEemsbhkIyNl+kYeo6Phj2LvEXnpmL7C6BxNNlYxmUsIony3W685rYVo7jZMTA+6E8zuTjKaeQmby7JMCFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529239; c=relaxed/simple;
	bh=oDTUjGw+6W/laJihCaI/nHIVNNBRUwU1ZUguXF7ceNo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=nrfJKhoNebXvTkB3gjugN5GlAJDnudeip9FgwGtWJA/9jzH1N8bulld6+3+MU9z0DLspEv5hzESjaOI1QwH+h2I+SZk8fqOoOlILlhotyeFfF0AFea2sfeZX0Z1Cg0JcvN9OcV/kUYu5lOrucP7YOE/a75vpHZCszJWXJ5zomSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QowOtgL7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QowOtgL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ECF1F00A3E;
	Fri,  4 Sep 2026 13:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788529237;
	bh=qSvx0dH2njZ5k/zFksKTcMGlm2nSFiXEvYGqs2t+ybA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=QowOtgL77QVimOnRTCXdrXfBmc83w2GgoSYbfiQsdp3TRdT91e55tt8kx/1SgoDZf
	 pYNfEXF6S7V7fC3mwvN3h3Rb0DV1yWA78Z4Mb9wMbLE9Wm5rNpNif2I8jwEa6IQIWe
	 DGs+x+85+VhP1QxBX0nbHxwqZw6O9E1ZUiDuMVsxaJZHhuw9iV2ctqk/Lr9uPPAte3
	 UWrl4r3lKO137HOaZROWzS3MsWvMeZd2ibAwVNP0fsnDXHEK21emIQDdUXhqSCvzFY
	 Tfde95Xpix+MOEZW+rAWt0a4TuF6dEDnmTt0Ml3/UoMH7KQOtlpK4QhF50FPVlsQVD
	 eemSoxeSsWt8A==
Date: Fri, 04 Sep 2026 08:40:34 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, stanley_chang@realtek.com, afaerber@suse.com, 
 bartosz.golaszewski@oss.qualcomm.com, linux-spi@vger.kernel.org, 
 conor+dt@kernel.org, cy.huang@realtek.com, devicetree@vger.kernel.org, 
 broonie@kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-realtek-soc@lists.infradead.org, 
 jyanchou@realtek.com, james.tai@realtek.com
To: Yu-Chun Lin <eleanor.lin@realtek.com>
In-Reply-To: <20260904031252.244280-2-eleanor.lin@realtek.com>
References: <20260904031252.244280-1-eleanor.lin@realtek.com>
 <20260904031252.244280-2-eleanor.lin@realtek.com>
Message-Id: <178852862340.96570.7431727982828977183.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Add Realtek RTD1625 SPI support


On Fri, 04 Sep 2026 11:12:50 +0800, Yu-Chun Lin wrote:
> From: Jyan Chou <jyanchou@realtek.com>
> 
> Add DT binding schema for Realtek RTD1625 SPI Flash Controller
> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> ---
>  .../bindings/spi/realtek,rtd1625-nor.yaml     | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.example.dts:18:18: fatal error: dt-bindings/clock/realtek,rtd1625-clk.h: No such file or directory
   18 |         #include <dt-bindings/clock/realtek,rtd1625-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:140: Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/linux-dt-review/Makefile:1717: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260904031252.244280-2-eleanor.lin@realtek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

