Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216503DB339;
	Mon, 10 Aug 2026 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.193.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364184; cv=none; b=OX7EKE+Iv4HqNkqZ6FhsmcXOT9GT6tCveTAXvMkWWY/1oD67DvnhlO1CexEBZ908hkvDrehLOKqoTGCYaFHNnJiv9AElDXeFWYlSOp3szcG0bVWsXdXu3Zr3pHEG6p+YDl6fs7tVZitZ9F2wUJnvyOKWmSWUiP4RkL9rFDJ9zjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364184; c=relaxed/simple;
	bh=MrSpY5EZAN3FEtuBbH+EmJm2SMcGm7j0LyDLHqnge94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuBC+YS+zt6J5zP+SxRu65kuAje9O67iIOlcEQlMs6GTswyv7TwW24iMXcclV3rT/ocTEdMvhmgQwt4jaAY80AqmpxGmFzjobyEDiAjHoeRqIoWVSX7Fby/OEjhawSl+l257bdpqEcCxfwwDL7o2n8XIdGdHHAUU+kbhA59ZGa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su; spf=pass smtp.mailfrom=zlab.su; dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b=N2+uw0Yr; arc=none smtp.client-ip=109.73.193.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zlab.su
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b="N2+uw0Yr"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D023AC0519;
	Mon, 10 Aug 2026 15:16:19 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
	t=1786364181; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ljDGBtz+ECPARFnAYybal9Xk5SoydAvNr02UpW+gUnU=;
	b=N2+uw0YrWpAznT6QUje+zq98tMayjw1+FZqN5pbWXi9R0wli+JgY4WMlGZBfyHcQK4HX/N
	jW3oexTHLs0xyfKuBQCEXvnOPAv3/6XPqV/chabvBcuq7/LQFlMlpaho3TZKhCpjryGJDK
	ZOS09MhJoaE808AOguXunn5CWqhCiWVjK6r7YADwGPi4QSmNuRbg+lTyzyyDSBYaMFRrrc
	HXXY1GVE7RFe6odL+odm1Shz2+kJBVSJmw6qGYqh+edD1dvUD+3Oq4yhwmM7YfLpL1xuLq
	kum8Si7YxSkdfv8FapPG+RfpPMkSuKLFN+THmvQSyDPcn3rS7iLndXjw6QRmFA==
From: Vladislav Leonov <vlad@zlab.su>
To: linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	Simon Glass <sjg@chromium.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Leonov <vlad@zlab.su>,
	Heiko Stuebner <heiko@sntech.de>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH 18/25] spi: rockchip: Add support for RV1106
Date: Mon, 10 Aug 2026 15:11:09 +0300
Message-ID: <20260810121121.210040-19-vlad@zlab.su>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260810121121.210040-1-vlad@zlab.su>
References: <20260810121121.210040-1-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add the "rockchip,rv1106-spi" compatible to the match table. No driver
changes are needed beyond that, since the controller behaves like the
other Rockchip variants already handled by the driver.

Signed-off-by: Vladislav Leonov <vlad@zlab.su>
---

 drivers/spi/spi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 231fbcf0e7aa..447e6ff47c53 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -1021,6 +1021,7 @@ static const struct of_device_id rockchip_spi_dt_match[] = {
 	{ .compatible = "rockchip,rk3328-spi", },
 	{ .compatible = "rockchip,rk3368-spi", },
 	{ .compatible = "rockchip,rk3399-spi", },
+	{ .compatible = "rockchip,rv1106-spi", },
 	{ .compatible = "rockchip,rv1108-spi", },
 	{ .compatible = "rockchip,rv1126-spi", },
 	{ },
-- 
2.47.3

