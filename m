Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4B224AF9;
	Fri, 28 Aug 2026 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910939; cv=none; b=g5udTupvi5bsbE7nVhPfU2Uv50/8EDfpbihbomYm5bF7ilOXwoy0Udz7WURegirbenwEGELh4xIrXMe/IjphXz0XSnMUoKC7PnZhepB6iyUJiwmi5PollTgVK2AgpM2jKHUxOB5BV4FYBM0geQva7kEFa2ChLOPYuuy2pOyJX3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910939; c=relaxed/simple;
	bh=Oiv1fjwE0fPV25G5MaQnpthHmH1NJ4nT1lnP2cUqPYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1iT4WWrcc+6rXqzyHfkYxcPcdZxIGoFP/uG48Wm1+7XINgdKFzJpvAyWah7VdbvOPNZSyOstcign9HPxw3VsZlny0JYKDWYnd6FR01V2qVdLG2dntQiObmk0DUBd7OPkZTf7NDXLe14trvT/2UZ+s3BiXrjqovX5kJ8x+hMcYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdyweBkM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdyweBkM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1521F000E9;
	Fri, 28 Aug 2026 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787910938;
	bh=SSMioLvP13rH7vJ6xy9EE9Tee9tSJjfjWuEz//5SyOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PdyweBkMNT/MnU+hZuFpiTG0pN4bWJ3wyNuG8vrKdlbUejUqbMM9+L9M5qg4CDdMu
	 EEEcdS4FFsO69PB/zO8GWH3bfoSJTiaQNOGWjcCYAlOmnq8dT/uS7Hx/IMZYsAlMZD
	 pOVhA+hO31UX79npR+7L5EzWn8vxrLwm1gZuViCykbGvFU2GZ4QHdZkBeSv4Pm1nIA
	 hTDLAtN5fgdIL646uge+j+/WI4sq3aqrTGwaez/rqnLgIQYZZkwz2cg05YyMeYEPVD
	 8CgChy1w5PqeQOJWr8jsYFL5MNnwBGj596JV9v18KBhOEex1+bzkuSlqmnexqtVXS7
	 aP11ZdK+CMafQ==
Date: Fri, 28 Aug 2026 11:55:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, chandana.chiluveru@oss.qualcomm.com, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] spi: dt-bindings: Document ready-gpios property
Message-ID: <20260828-tremendous-honored-dragonfly-b54f7e@quoll>
References: <20260824-use_gpio_to_notify_master_of_spi_target_activity-v4-0-fde2ebf043db@oss.qualcomm.com>
 <20260824-use_gpio_to_notify_master_of_spi_target_activity-v4-1-fde2ebf043db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824-use_gpio_to_notify_master_of_spi_target_activity-v4-1-fde2ebf043db@oss.qualcomm.com>

On Mon, Aug 24, 2026 at 07:55:59PM +0530, Praveen Talari wrote:
> When operating in SPI target (slave) mode, the GENI SPI controller can
> use an external GPIO to notify the SPI master about the target's
> active state.
> 
> Document the optional ready-gpios property for the qcom,spi-geni-qcom
> and qcom,sa8255p-geni-spi bindings, restricted to spi-slave nodes.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml | 9 +++++++++
>  Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml    | 9 +++++++++
>  2 files changed, 18 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

