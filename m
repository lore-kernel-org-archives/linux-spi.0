Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15D73A783E;
	Wed, 13 May 2026 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660555; cv=none; b=lhZ3MQZkRgE/GykKVCAlsnS96JF/PwxTe2TOaqAVB75y7hqEmnK0N3Xc6A5lSrTljTbeLrPyr7/PF9+9ujRXzuGIRbVEGSBu4O0azBTsWtQ0KkpJPzjFDq5k3qlc5yxWt9Wm532VMXP/2sxiEo5LLZAolQnyXiN68wMG9cpKux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660555; c=relaxed/simple;
	bh=IRcBtVVf0aiqAc8MbpnoxdYYdE8xYEJIxc4vAPNSvdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl9DZrtXp6U0edJHjrSOW0LoQbOMtoklNfg1N4b0gCXD92H9mY35CquIfgxcIPwjEMXhmNN9x35yoUXWPNtI7sNZdS5v9f9sj7RZZYNdDkrjfaGMDspTl/mLV3/DT/upPfXSSjC2pCoU9jIhufpyayo+PMa+gHBnHRtKu0BEOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSxa5TrL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSxa5TrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D244C2BCB7;
	Wed, 13 May 2026 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778660555;
	bh=IRcBtVVf0aiqAc8MbpnoxdYYdE8xYEJIxc4vAPNSvdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSxa5TrL1BULHQroC+/wB7yAQEWNe6HcSWf7RJROtWzfHIpV+K/GBmNJpmHd64TqH
	 mmrG1q+cyvxP0jF1o5pKduIF4b9K75nQWCYBEQWZJ1iSa0UXha5KOU9dVGXRS/FedX
	 21ovFZ5hGDBskGXDZjdNLS5fXS6IQVAEu+RgTkHtd9c5CyOy195R24wDGh6/CWopFJ
	 mBXcy8vUyTLJfTmmAgm6rCaRStnxUSsca6WrmRWA9MvWRmwQS+OpEbyW6550YDk4Lt
	 1xLChBbEGRYHq24eXTrrPf7PFZevcO3UhKy0A98O5JTWV9MRX3OzeWu8Iba0q/EKog
	 gnCwKVBLeIEyw==
Date: Wed, 13 May 2026 13:52:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Liu Ying <victor.liu@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mirela Rabulea <mirela.rabulea@nxp.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Heiko Stuebner <heiko@sntech.de>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Parvathi Pudi <parvathi@couthit.com>,
	Mohan Reddy Putluru <pmohan@couthit.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michal Simek <michal.simek@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linusw@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	"Andrew F. Davis" <afd@ti.com>,
	Hussain Khaja <basharath@couthit.com>, Suman Anna <s-anna@ti.com>,
	Ben Levinsky <ben.levinsky@amd.com>,
	Tanmay Shah <tanmay.shah@amd.com>,
	Erwan Leray <erwan.leray@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Roger Quadros <rogerq@ti.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Consolidate "sram" property definition
Message-ID: <agQ0xZGrZJDmNFsX@vaman>
References: <20260511165942.2774868-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511165942.2774868-1-robh@kernel.org>

On 11-05-26, 11:59, Rob Herring (Arm) wrote:
> The "sram" property has become a de facto standard property, so create a
> common schema for it and drop all the duplicated definitions.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
