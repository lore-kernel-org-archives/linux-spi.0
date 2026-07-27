Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94A3DAAAD;
	Mon, 27 Jul 2026 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135492; cv=none; b=pU6WT5Pd3qnubUtFm//bsUayUw6s6+RuyNSfXqbom4uc4KfZvDVqtJuXRhwAK4OONSVWO8qcwPXO7/0Z0EmoaGwWEzdZKtq2RIWa3HdC3tQhF+utwa1pPO5fO5r31t8Mxsx2TUNstxnOB0/OdaMOa3DBosM60x1G/E5OY0YhE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135492; c=relaxed/simple;
	bh=iFgUb9zLyxn6wD3GJA16W2RwUp7qBvx4HDEcEMwXyuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvQFxZSm5NNhGz4XdZPcZVdh/9HTWLsLwu1/WswXOKgMotLv7GadJQt534bZ8XeASa9/5fPtkDTeanro/X576JjlctY7IxUenMNI7+H5cFNmPSEZUQj/U8m5xklP1eJMfAV5w+8d23owQcGTImX/8QECcV3W1XtJD7xZfpm/oWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B601A1F00A3D;
	Mon, 27 Jul 2026 06:58:06 +0000 (UTC)
Message-ID: <b3bbf0b1-051c-4652-96d8-c141b585a1c9@tuxon.dev>
Date: Mon, 27 Jul 2026 09:58:05 +0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: microchip: lan969x: add QSPI nodes
To: Robert Marko <robert.marko@sartura.hr>, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 tudor.ambarus@linaro.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr
References: <20260709112006.390742-1-robert.marko@sartura.hr>
 <20260709112006.390742-6-robert.marko@sartura.hr>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260709112006.390742-6-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/9/26 14:19, Robert Marko wrote:
> Add the required DT nodes for both QSPI controllers.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Applied to microchip-dt64, thanks!
