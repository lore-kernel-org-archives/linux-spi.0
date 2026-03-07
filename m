Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236C6330B30
	for <linux-spi@vger.kernel.org>; Sat,  7 Mar 2026 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772868293; cv=none; b=DajtOwARA7bZFaUOUp7XX8pwgsdojZAejs4ota7yQtwUH6C0Mg6+/03pFo0XeB9g8z98YAeqW3nr6h8HqJ9hG2kkxU6nWHhwOejQR/YL4ZED0fJ8cIvg6hTQPYqS0wQeDjekJgrIBhvcn/CPIlJubqOAIFFX4sOVqb9hwKKPnw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772868293; c=relaxed/simple;
	bh=DnhrfTpoqQP0Gz7wQMlEMENHf6+HnkuBCFqW+aSeYnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HOx5IDhvATuuInumwvlowLDj+saqD/H/AQldM7HBJkJ1UcldPSxTu7BWh/JHt3jx0BjiHx0zu04GmPT1UIvwllvLdg+7NB8WHHFkPQtXIWeuc36roo5Mhl+JPu+HfN2dPh78ozEYTGXfzKKQODOBfiCDr6IQWJbBEhCm06Z5Npc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1NtuXyM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1NtuXyM"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-359a5d8b3f8so2462508a91.3
        for <linux-spi@vger.kernel.org>; Fri, 06 Mar 2026 23:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772868291; x=1773473091; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/X3H2rOzzx5YHCEmX+zODgRnC+Epx7QrZClKaRyRVk=;
        b=E1NtuXyMjMHGzqkkoWZ4umzEZ0OgUXcjZiRodJz5YrLxqzxCKuQSRA6oPMdMYod7NP
         oJtLMSE1bQE5K97V7ZAaVyfhUwCblWuwXpQSQ+E6w+wH+Pmqef+g4kjSQ9Xetuk1fiVN
         4aIN90SgadeHe3BjRIBvch6OWBX48DY1gqp6iYUb4V7LYN1/ps0/kWNEspj/YUxeadLI
         QSo4GM+XZvDvl3aNLaRGW4IuVS0rQOIaw0t1y4A4OZy9FEvyqoKCWtLiGivn6niHpkSZ
         5ioCFxwGdAqzoB5kdYt5nL37XI0bvCV+/b/4/M7nVaZJPtFeGEzT1aSl1HsFVElJBdcf
         LUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772868291; x=1773473091;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/X3H2rOzzx5YHCEmX+zODgRnC+Epx7QrZClKaRyRVk=;
        b=CuxU4fJiKjfykp5EPi66yOFO6NpusgK2Sn0Mn6H3WNnIZ7PbbbbRh0QzyHziAvPdvf
         KfOnEO64L/fCAPc+E3Tk9bho0HO7JAp7CElxVjK3dh0n7A7HIkqLUlbvrzfaQ69AS5TX
         Kw7S6FhOg/1UxwlzLLygtyj7jNe/XLSvqADm3SJ1rl6zNO0I8DgF7zjIZk00p/+woOcW
         M8wQoH2VZ0brbPeIDj90EVMiRpY3SfCEyvX+WoK192jDUPoOo2GRterXwmi3FhCzyjMf
         ExXjTZpwsIL2YRePBzuG6i4i/h5k29NGGnA7DgO1vmOJzVIbLQGF+rHFilCsDfjORv6T
         Hlag==
X-Forwarded-Encrypted: i=1; AJvYcCWi7K3EWhYNSEw9ieWae408nEwJr7oHvDYLX3jXt9lF0OYhXMyc/JZ1bmkJFJRDtbJ1Xi4UTjv5BXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzHy6RVdxZpJkX7pJil1CVIgkfTLD4efC9c12W58N9S3NI3n4
	ix48y5vVCJfPwYZs5ppsURlvIeyPzxKRrRJcIbz+M1VUCAdiP1HtwuMeNnI6iCeeF7g=
X-Gm-Gg: ATEYQzyAG6UlUEzb119b8F1UaIO924GVb9hm/Nl3BS3XQKSxcQaeKp2icfySOdfLIjK
	wth0O89KAZSH667O9URDYnmiMd1vO1r6XDOOMUra8fhawxpUptU7jX2RvMMbfP7Jdaz12inPh65
	/Hp6UqpFby+JBQ6GHlINNLiyP9BAwUoGTKpcEujR1BdQEvSA1JuMCFP2UIZ75Vdn8niR4zHfAN+
	MgkdOAXuwGSFVa55sikjjhiU/7ZqLOe00gd44fQzwgGCaI1C7+ss5QvsvTrRpsU2Z56qWch+eNT
	vrlJhOTO4n2X8tUcqig4YA0d6zfgzanEZwTcQ9G6Ga0pBsUfuWsUkyVY5h4irUTWXYSrdbvkBRr
	ua6q8SnXLty/zfFUNFyvlFTHYsxTsYRG6N8tN9GkR7DEGHbsMg9S4dlWPYHHTOWxb5gGpjlAGQe
	1t6tJr7QYGqT1HxIs+ljg7/E62cROApizwja8=
X-Received: by 2002:a17:90b:268a:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-359be3217ccmr4437933a91.23.1772868291381;
        Fri, 06 Mar 2026 23:24:51 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:59cb:c81:de53:1143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2de7932sm8771067a91.10.2026.03.06.23.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 23:24:51 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 07 Mar 2026 15:24:45 +0800
Subject: [PATCH] spi: tegra210-quad: Remove redundant
 pm_runtime_mark_last_busy() calls
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-quad-v1-1-f103515db501@gmail.com>
X-B4-Tracking: v=1; b=H4sIALzSq2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNz3cLSxBTd5BSz5MRUUwuDZGNjJaDSgqLUtMwKsDHRsbW1AMePXvl
 WAAAA
X-Change-ID: 20260307-quad-cd6cae580c33
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Vishwaroop A <va@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772868288; l=1684;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=DnhrfTpoqQP0Gz7wQMlEMENHf6+HnkuBCFqW+aSeYnk=;
 b=IEraBS2OLNJDNH+FaVM/+ejP3HTtIK1IW6JwxK8aw9S99xwDsO5H3Q62bsDhfM+YJGWUbWi6P
 P+iRp84xfXiCrIU+fEkHdbPxBbTZh9+Hmy48A9+itlDqJP5x7pdG0Sq
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

pm_runtime_put_autosuspend() already internally updates the last_busy
timestamp before scheduling the autosuspend, making explicit
pm_runtime_mark_last_busy() calls immediately before it redundant.

Fixes: 7c12f6ead467 ("spi: tegra210-quad: Add runtime autosuspend support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-tegra210-quad.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 7fac695b5142..7cca5578eba3 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1000,7 +1000,6 @@ static int tegra_qspi_setup(struct spi_device *spi)
 
 	spin_unlock_irqrestore(&tqspi->lock, flags);
 
-	pm_runtime_mark_last_busy(tqspi->dev);
 	pm_runtime_put_autosuspend(tqspi->dev);
 
 	return 0;
@@ -1790,7 +1789,6 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	tqspi->spi_cs_timing2 = tegra_qspi_readl(tqspi, QSPI_CS_TIMING2);
 	tqspi->def_command2_reg = tegra_qspi_readl(tqspi, QSPI_COMMAND2);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	ret = request_threaded_irq(tqspi->irq, NULL,
@@ -1851,7 +1849,6 @@ static int __maybe_unused tegra_qspi_resume(struct device *dev)
 
 	tegra_qspi_writel(tqspi, tqspi->command1_reg, QSPI_COMMAND1);
 	tegra_qspi_writel(tqspi, tqspi->def_command2_reg, QSPI_COMMAND2);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return spi_controller_resume(host);

---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260307-quad-cd6cae580c33

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

