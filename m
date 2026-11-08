Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140243;
	b=II27uUSPDXZk+O2qsQ7ZGT1YOg8P4DYF64i70HIgEiy7Oqi2XzsAniz8MLhwFsdOwQpL
	 MJHGm7O7xj+6Mc9vpWybHITzoArov110IP7ESZ6a34eUWu2lvn1anS4XnaQb553Te8tKO
	 27LVSYpDschzwNfACbIJS9ighsyyc3BGSniofim4e2S4rpdAzlntJna2xtsk34aR3A+Gj
	 CnyrahZ1eun8qPTdJDF5NB8JuJxgUjChI/TMzcjGhRcci5pSnmo0drd9da+YTfXUTQxE7
	 BtxzwGaYxr3Gx9ep5ZiqgsZZHYWBFGb7uOGqH0B7lrcKWNCvzSqbT07OI0MfY3jnMhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140243;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Pjfgr+3mC8cRFNZ057iwMxj7yEQh8CXyv0+tSF6NOcI=;
	b=c2ypnt8Lo2EkyC0f9CWWmnHpoepQ1F0eeQdbdZBeTL/Xd+3JquzSk19zpnuuyZIRMuML
	 LLqWSa/7NqZYCxAvv6b2IucFUpC7vyabs6tNj+LTKwQjRsodsCOmYFwwAwCxBfCInSOiT
	 +SSLernb7vrqmfd+7G9lKGxltKIL7NJj6cSAQm9nVdoBZGmDSAwJag5hqzgOczJfrd1I7
	 SIFQpO4L/2WdmwPDou60B/0XL6yz93QRYxt+WZdNMaRtldmMfUdf5i2L522FkQgQmNRHU
	 +MKjVLR8zQiC4A52s//kgNkbbNuOLCGHKcrWHzTPI7Q9u3OOmcoYMVJdQvYICxLWJ/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xfry27Ef;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98EC606A322;
	Sun,  8 Nov 2026 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xfry27Ef
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1380E1F0089F;
	Sun,  8 Nov 2026 12:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140242;
	bh=Pjfgr+3mC8cRFNZ057iwMxj7yEQh8CXyv0+tSF6NOcI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Xfry27Ef/Ysol8bufUj6suzU5LrliMsuK88iHHmWrOdvrwTGNt4xppiDtr78HjCUi
	 Y9348v86EpxcywsR531vKiFiAkXaU20rA8slHrZV1/ndmf83HqqJvRBWhCMB75doP7
	 JpTFsh0cQ+hFhG5QZh5D/ZNjaY1x/Fta5r2TpkDtR9V9IPpiS76tMZwJW3K22sB8IN
	 EAG8+g4Gm4j0pl1f+AVKPz1E6xGcWNRFb41wizKJAbfIF2HMxLv4s3WigJhivf4+kZ
	 3OS5/BnuC014cUzCg608tCL4JhciovUdQm/5f5MRszqSieTe6CxeVbgF/rcrCDo+th
	 Mw9IbW4mz3Z+w==
From: Joshua Crofts <crofts@kernel.org>
Date: Sun, 08 Nov 2026 13:16:50 +0100
Subject: [PATCH 03/11] spi: cadence: remove redundant
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
Message-Id: <20261108-spi-dont-use-autosuspend-v1-3-3587b0183cbe@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794140215; l=1076;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=7ryTaWhNi8ChUqf0oxEn4I8b8j6TXrR69Y5MVmBHIzo=;
 b=XEy0GJpe6Ov4zqcALncuUT6jddNiwNeYVMZWThaB6PLrMi1hQwCv44EamxPFgI+3RNX1xg/dQ
 /suNNKO2Ze+AkeDwK1UbE3FGGfZpJXzzzDMVUFDtNKzToWkpFllvtii
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/spi/spi-cadence.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 50ef3a7871c2..ccab85a07d77 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -762,7 +762,6 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
 		pm_runtime_put_noidle(&pdev->dev);
-		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	}
 
 	return ret;
@@ -794,7 +793,6 @@ static void cdns_spi_remove(struct platform_device *pdev)
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
 		pm_runtime_put_noidle(&pdev->dev);
-		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	}
 }
 

-- 
2.56.0

