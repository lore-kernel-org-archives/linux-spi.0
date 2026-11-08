Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140289;
	b=w0OLXgl9ceJI6Xr1yOUnkD0izgZyf/XhhHlsK3oTQHJJnJQenLOXFvaVXtTfd8qNjvXZ
	 mlCqDoE69XhNWbguE6gn7NTwnlVMumPQGSFrcTqG2gBB7y0E4+poCzMKxEwn/m/+IRaga
	 pALWkcCPNCc1A9t0r0Yyp/Qc/ehq8GF697BWtySj+HhbOf1LWlQTGpWoJiBAX4SuoFuVj
	 Hti1NtTIx6wt+bq0bfUCPMezgnGKB4klJMhiHPM1A81xPRvxWQfVlH30ex1MAPFJ8O+xI
	 HW+qjDIPg9SBdhf/vhj6h5TTXwdgJtu7+kZeQT6mDJp7AXVVsymIeF7tSCZIh0CJWvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140289;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QUocQK84XuKehbT6QRvrwNg6WeMz5D75e4/9O566HHs=;
	b=G3ytYK3oxiGPwvi+IMXw6eV2Jt9Or5T8C0R+qwLGlYxdaUx8PNoWNl/z9CiW6/Tud6zf
	 Gyna5oB00cLOb7kJJU/Rwpjyo2PYYMyvQKX/uhpuFfa6qDyVgYG2OdepPjAqsS+At2QGc
	 dd/PpkEJ1TT2z/A4+yZh+4tH9zQt1vGXdIoBzaVmGcJc6j8cZ4xTtQN3lS585AVlDlVG8
	 zyE97Wgfmye/9i/F2bNwgLZq/ge67zwStcdg+O2HaSQ7IOV+kqY10xe+LsJVF//CSGBc6
	 02Gw8FQGRWLDeMsuM4Nwh77gVsZCFmezMSR/p0lisnm+dl14SsBdcdW7G2TI15HKCtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZvR0Ff5V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F26606A32A;
	Sun,  8 Nov 2026 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZvR0Ff5V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1BC1F008A1;
	Sun,  8 Nov 2026 12:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140288;
	bh=QUocQK84XuKehbT6QRvrwNg6WeMz5D75e4/9O566HHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZvR0Ff5VhH/w0Tk4IPX7qLBDUpl/JP50R9TNox8GVZKMZVqozRI0KmgNZdVAU43Jm
	 GapdX/YPafgiQUnWdZHPa5PiDrvh2Ty7DqZR9Uq0KHxMOSyRr8pRIvOJe5r4Lo/uIG
	 J+yYyY+JCPwFed9Zy4/4DW1+t/Awqu/R0bVlzvEHhAmeXj4P2jOnF56lKxpWbL3Z8u
	 gnafwPa8WVaVzLoxi9vPJzqmLlEExlXxjOKvOrYoxeam5cmsvT+qAGg5OTu7GfeNzB
	 XkKbOMC/P7wZx//BTfTZWKmEsnkwl0tsbJgKbnwItt+l2p+sE1uB2uxEHQe/IymHLW
	 3RFQ956pkH2YQ==
From: Joshua Crofts <crofts@kernel.org>
Date: Sun, 08 Nov 2026 13:16:57 +0100
Subject: [PATCH 10/11] spi: rtk-nor: remove redundant
 pm_runtime_dont_use_autosuspend() calls
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-spi-dont-use-autosuspend-v1-10-3587b0183cbe@kernel.org>
References: <20261108-spi-dont-use-autosuspend-v1-0-3587b0183cbe@kernel.org>
In-Reply-To: <20261108-spi-dont-use-autosuspend-v1-0-3587b0183cbe@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Mark Brown <broonie@kernel.org>, 
 Karthikeyan Mitran <kmitran@axiado.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Jyan Chou <jyanchou@realtek.com>, 
 Yu-Chun Lin <eleanor.lin@realtek.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-tegra@vger.kernel.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794140215; l=1130;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=yxPOrISayM8bL3DLnc5ik5mB53YTY7CgHkogAOII6dM=;
 b=1QQe9sRmxV5WjW2Sa2dbmrIQXv9rVY2P0fLeIkby9HrB1PfQ6/R/HIh9nOl8LKwkUT4xuryHg
 4tdT/mR9K7UAk/VGyuolOwD96AaLprIf+HArgu4eAPZW8uqIye9ROIY
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/spi/spi-rtk-nor.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-rtk-nor.c b/drivers/spi/spi-rtk-nor.c
index 75856c31d2e6..202f9df8739e 100644
--- a/drivers/spi/spi-rtk-nor.c
+++ b/drivers/spi/spi-rtk-nor.c
@@ -539,7 +539,6 @@ static int rtk_spi_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 	reset_control_assert(host->rstc);
 	clk_disable_unprepare(host->clk);
 
@@ -560,7 +559,6 @@ static void rtk_spi_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 	reset_control_assert(host->rstc);
 	clk_disable_unprepare(host->clk);
 }

-- 
2.56.0

