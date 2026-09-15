Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A2332601;
	Tue, 15 Sep 2026 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505258; cv=pass; b=FqcdZYX3mF/RN3nczDnJ4mUky0PMQ1umdxupBcdohYwVGJ2z/T4sueM+UPLf+Gct/U7+Vdtj+vdLaCMsKET7KgPtoy7eWTSfLtDnUcaMihDZpQQ210Nvrc3vlo/7SccyzgEoTHDD63QOuuRkVxxvyAQuDGntWQkVjjKKcSy1Gxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505258; c=relaxed/simple;
	bh=ntNiylShBzGcB5/5rfpspjPgxnjmU8ThnIg9OlDoZD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3glu0Jx/iNqXpqjdmtNEtepmulP5kayG6/4EDrznlmzXTaTfA40ZuFTnvzMpcF/FLlWAjKqoCn6mr0fYke3yTSF5/Ff1BGUKYVQDrpx8LQM34Uek7QaDaIm9lnBTy5jk2OLBVvOM/W2i99jU8wT/v5yp4yxVw0pxHJwj278AxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=jLO2Gfab; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=dOYYzIyd; arc=pass smtp.client-ip=185.56.87.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="jLO2Gfab";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="dOYYzIyd"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-3zv2.prod.antispam.mailspamprotection.com; s=arckey; t=1789505256;
	 b=eLV8HIW+DjQvYRNgI8S1S0gRdITGdsU1vEruTs9MJJFJ8dvp+oYsDRmNFze7gdukEODM8yZopS
	  QYOWrTPixH52SqDV+U/IYRNRqbUDGKyHt+omViTnRXwt/yQ/SXgY1w4Or9E/uLxNqIeBk6GFrt
	  L3fWiy31pBsYQ/uZEIILV0nxIFUYH+wuMEpyw097/rsPyDbeFGYMhuJLNw45kVGBoCLvk+68l7
	  gKeRsF7zljNbnGBGy/TtgxIM16Yf/4LUxlB6YmDkbpit5z5x+Yazv2Xs/ORIUq2q3volEKVUKi
	  jVxo6J87IAbUehWRA97HZxBs55BicsmcjddncpLdZ9UfTQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-3zv2.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-3zv2.prod.antispam.mailspamprotection.com; s=arckey; t=1789505256;
	bh=ntNiylShBzGcB5/5rfpspjPgxnjmU8ThnIg9OlDoZD0=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=qB5LHPoNYnt4ylfh0l4g5u4m2s+9Nc0cqXfnXoDGPBGnIC+6cFy7aNQ/3NimNGpY5NB8iY1q6z
	  XdpDRTPMIy4N268UMX5sWD3oDjri0an16OnFJ1Jce7QAnJA/d1sx8UeFEi94FEvEUyfZykZKwG
	  V2W2FDV3vf9/JuL6hcqtd2KxtmK0ToMkbzHOtAq0v8ph7MpO7XsBR2NPC9ZZ9uoJvvBVcRLb0I
	  aRglMihyTvok8PkSm+h41J0ufDhakn3EV1KJVHWpSOf5MO+546PHuSxWx2lSUHh9FPci9SkFum
	  Lmi2M/fzZkjaAyLP28y57lkHSymUBMap7DiEZ1FVn3nQvQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=wm+I9snef4pclMeBCfkCtB56yKFNZvRgPCZYc0fCzO0=; b=jLO2Gfabhf1bsnJFxG91ehSaeb
	M/s5M+jGa71e4aiQxGdZfmeea64aQR5UuVriz3M28wEuB7WVvOZjuKVz4R6Fpm+7xftH1vZq7miNH
	sVvubnfG2UTF+lUMmyXohfezzoprsGNWidTQPSnbz6U+bueWPdb80qPu9bMmUWbiroes=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-k0hs.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6Zhx-00000002dcD-2TNo;
	Tue, 15 Sep 2026 20:24:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=wm+I9snef4pclMeBCfkCtB56yKFNZvRgPCZYc0fCzO0=; b=dOYYzIydIQ90uoiCxrNhg+eMNW
	sJ2WoTVHBgxN2e8d958BlJdu1UK0yGR7lubSjTO1BxomUlJJV6ulvZ0c4EWpyecxxXXBlf8th14JO
	3TFUISbuO9ao67lsX48FpF8I4jlTLUWIfmqNOc+505R4WR0FfSxC9qy0xrqBwH7I0CoQ=;
Received: from [95.233.221.121] (port=64541 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6Zhs-00000000HDi-3iBa;
	Tue, 15 Sep 2026 20:24:44 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 15 Sep 2026 22:24:37 +0200
Subject: [PATCH 2/2] spi: virtio: drop unused field from private data
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-virtio-spi-fix2-v1-2-7a474cb1b13b@valla.it>
References: <20260915-virtio-spi-fix2-v1-0-7a474cb1b13b@valla.it>
In-Reply-To: <20260915-virtio-spi-fix2-v1-0-7a474cb1b13b@valla.it>
To: Haixu Cui <quic_haixcui@quicinc.com>, Mark Brown <broonie@kernel.org>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2452; i=francesco@valla.it;
 h=from:subject:message-id; bh=ntNiylShBzGcB5/5rfpspjPgxnjmU8ThnIg9OlDoZD0=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkrV3b3e/sU3Przy7ydMfrr9h3Bjw87aGcxLs27lhdYd
 P8ji7VqRykLgxgXg6yYIkvIuhv39sw1/5a2gfERzBxWJpAhDFycAjCRXE2G//F7fh2TqFj9Yt51
 ebO4Z9O7Dm8Nci9cPTP922b9xtoc5jiGf2bZh1/FHVmdZKJypPSC6IUD3VXJZhNfCX6/dNVS7bG
 eIhsA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 377f1d07a2e083c79fd3a4b8d255957d
X-AntiAbuse: ID - 377f1d07a2e083c79fd3a4b8d255957d
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x6Zhx-00000002dcD-2TNo-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-3zv2.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

The mode_func_supported field is read from the config space into the
driver's private data, but then never used outside of the function it is
read in. Drop the variable from the private data and parse it from the
stack instead.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/spi/spi-virtio.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
index 033268908bca..489970ed7eae 100644
--- a/drivers/spi/spi-virtio.c
+++ b/drivers/spi/spi-virtio.c
@@ -31,8 +31,6 @@ struct virtio_spi_priv {
 	struct virtio_device *vdev;
 	/* Pointer to the virtqueue */
 	struct virtqueue *vq;
-	/* Copy of config space mode_func_supported */
-	u32 mode_func_supported;
 };
 
 static void virtio_spi_msg_done(struct virtqueue *vq)
@@ -256,7 +254,7 @@ static int virtio_spi_transfer_one(struct spi_controller *ctrl,
 static void virtio_spi_read_config(struct virtio_device *vdev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
-	struct virtio_spi_priv *priv = vdev->priv;
+	u32 mode_func_supported;
 	u8 cs_max_number;
 	u8 tx_nbits_supported;
 	u8 rx_nbits_supported;
@@ -266,18 +264,18 @@ static void virtio_spi_read_config(struct virtio_device *vdev)
 	ctrl->num_chipselect = cs_max_number;
 
 	/* Set the mode bits which are understood by this driver */
-	priv->mode_func_supported =
+	mode_func_supported =
 		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
 					      mode_func_supported));
-	ctrl->mode_bits = priv->mode_func_supported &
+	ctrl->mode_bits = mode_func_supported &
 			  (VIRTIO_SPI_CS_HIGH | VIRTIO_SPI_MODE_LSB_FIRST);
-	if (priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPHA_1)
+	if (mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPHA_1)
 		ctrl->mode_bits |= VIRTIO_SPI_CPHA;
-	if (priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPOL_1)
+	if (mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPOL_1)
 		ctrl->mode_bits |= VIRTIO_SPI_CPOL;
-	if (priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LSB_FIRST)
+	if (mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LSB_FIRST)
 		ctrl->mode_bits |= SPI_LSB_FIRST;
-	if (priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LOOPBACK)
+	if (mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LOOPBACK)
 		ctrl->mode_bits |= SPI_LOOP;
 	tx_nbits_supported =
 		virtio_cread8(vdev, offsetof(struct virtio_spi_config,

-- 
2.55.0

