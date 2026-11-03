Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746549;
	b=DHBttX18e9t6Zy74WN9SNrn/aF1FM5e71+MMEp4cfG3mjn7D/KNu8axxzSiHte4g2bdM
	 vPtGmr/yT94YyucvZHQKayFNL2Fwn07SBLhA/5T5ZHzqk0fEAygkkZy2MpDc8NsixUq/K
	 m9T0ZNXoNxtTKDn0ExwlKScE0C/6qPWFSIJwqgZW6n3lI2caVNwRREuJmjYg8UxtopHhG
	 /2ZCrV5SiKxSgfJGS4pOPEMs+ob6QnC+oJwVdoj0PUnRQeL1sNBYmOwIqNOlX4aXl32+v
	 C0UwczygiUQy0wL0MuXY8sTd+T+Op3rhFh9WxMB3G0Dl1fPb3cf3lOVzenppmggY9Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qt5gSewQUowbcK90nU+Vht4pAMDA/5T//zXpVT3JcNg=;
	b=QfeuGd5oKaraMOQgKZuxYE+4Nfl/vg5xjaM4UwygMya4kWg5v/58F2QgmGgEvOA1nAzo
	 l8ymIr1/+HQFRTrkSYM4bLPu1F6HlBUGZ34b616fmQIxwqbSuA2fhnrOA2rbl/X5rWScQ
	 GKIytcafEYKiSFK75bjVaNk9QHlEDMQclAKekyKrA/z205NFFgNCGFMeJwFED3dQk9U4T
	 clSeF8B8v4es2bb6BMypOVyjGKYgCIZE9uKkZLlWpBkX5RzPB0cKitktgrOCKTr2jcYqR
	 77C491fUJ/BsJiH9aiI5CAE+5zkvWkQNGmeBVFNLR11V58/Zt+ErxyurV6bD9EYSnMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPqcHaUW;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E316606A324
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E316606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPqcHaUW
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdb2893531bso75498a12.1
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746549; x=1794351349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qt5gSewQUowbcK90nU+Vht4pAMDA/5T//zXpVT3JcNg=;
        b=tPqcHaUW+/PZC1w1zMBOzgw2EKsR4sQJmzu00S4oJjm50iPt9vWkWVv85JLHYfWl2k
         QCp3w6fBErmBA0ULjvEw+Sm8wiOpDKWaGuXnm9T+56ReEUCieT7Uv6v8+veVg7YpGqW6
         Lsh29F7/2iksBXNVAedfJ/MxEy7lsTPwaXClV+q9OR53XCrM0xyOfHQ5luysuYZ9GzER
         V/yQp/y3pH2y0CPotv3qFzJS/w3bdA9knZUYAdMNuIOhrgPWt1VjwKFePOkIOvYddlQl
         PHZ+2m8KtSyQCXc4xLZjaUbarOHYzCjl+oTKpdJqWMNwBtJdGAqa3tZDf3SlpCPDPLBp
         NrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746549; x=1794351349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qt5gSewQUowbcK90nU+Vht4pAMDA/5T//zXpVT3JcNg=;
        b=N3+kecBWlV/NnYSBtU97kfa2IA53FQvFzLOcYtmbBNEj0y0JW+uLhaEEW66VdgBtl1
         aznbv8yTUCvaOjkahlHJUPrLu2mlZCv9OXSoR1gb3oBBwSL1HQC1oP7MC9OoSFYqF5L3
         SVDk13ilevT5OGSBlIMiRoKc+hGgxWkYFZVcHRyRgz6QTica5zu7/IYSzrs4D28Wdepx
         vLGvu3yGxD8iRq/NyvJF2aCaUU6xk92EiA0RkGb0GX4jw6z2YeDmXKNeRVamIkf5m28p
         FAtOkaBC2MVZY2vL3VnBBbiooqbMb9Bov6yUKpQB5zc8jm/+FS5fnLKdTZ13zAmNjsBL
         SrpQ==
X-Gm-Message-State: APuU4Z9e3uV7U3aCiCmA33Uuc6KRJueMRY4PnjLlpuJ+rFFPPZwnpiXq
	XOo8Y7XaQg1OELFr7jJ4x9+A589Cq0BstwAm2XbTACsxhoJKe4D1tHzj
X-Gm-Gg: AYBFou1ubxuET0z2rtj3g4iLKhBZ+veI8NXWN9i63MsROxDCKz1hZtL6Qj6qoGy1vQx
	MOy0+WN4ESobpCHwR9PVxoQ+FOulkieCuQmE91J4L31b9gHy01bQcl3+TPhE2uuMcdFY+iiLebq
	zOx3Gz6AQdD6pwbbqTx4+a8Ep+JcjPHuxtrqGvLqq8tdXDHpj/UucoSnfuSNYHuTGjueabQmWTz
	xNPwG4mP2SQLJY0gEW4mrchjBudZUFRlbbEhYaanyRecSHUSeNmQ376J6/9olmFD9VEyZ2/AZdY
	hGK9E0DwwL8w/GpAe4WRWz66Mik9JmC30m0GQ9KkRIoJfMR8l+uyZmiZ2eKzRUt1JUtbxNQoxDQ
	TyfvIBsOinNq0DWnyW5qOvzFKJS/E/ak7fNgFu4yJA0kyxVcUdM0ifSBX33bF4+/JHzVdWf/KOP
	E95w8BDh9WXVsaVqVhcwJm12lHC0j+wy0flkq2uINS8UrP7u5WBsA5D+uvHDLIqQgXmGhJ03oOr
	EMO915WfbIZp/selA99G0naFgM5gS+NzMU705H/340Px3ZYERIo519IzbMEYyU8fYfRUFKYZUA9
	LyEbtQjPy1Ct81KElFUtDXdFLzT3uP1HBHhwgcAUzJHb2IN+C2tON3Ap+gDjbfZuXCuoxTCt5pq
	rMLWHPbeMP/2QUUwM1m8EvzFcyXD9vsgTMfRBF1iDaY3TLzTHCVmkhzGHQgXLZow8jx1Xe8S33H
	EILbuA7v+XOq1fNJ4QgpjtSKpFBy9XU/c2ZqXhNacu7YZcMkCyYW68CbljhUSiBIAVmQ==
X-Received: by 2002:a05:6300:614a:b0:3e2:b561:2b23 with SMTP id adf61e73a8af0-3e92890c18dmr12082651637.18.1793746548961;
        Tue, 03 Nov 2026 14:55:48 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb467f6668sm272976a12.8.2026.11.03.14.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:55:48 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v2 3/5] spi: spi-mem: Add lock context annotations
Date: Tue,  3 Nov 2026 22:55:20 +0000
Message-ID: <20261103225522.3643901-4-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225522.3643901-1-jctchan@gmail.com>
References: <20261103225522.3643901-1-jctchan@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bart Van Assche <bvanassche@acm.org>

Annotate spi_mem_access_start() with __cond_acquires() and
spi_mem_access_end() with __releases() for both bus_lock_mutex and
io_mutex in drivers/spi/spi-mem.c. Enable static context analysis to
track controller lock ownership across SPI memory operations without
false positive lock imbalance warnings.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-mem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index b94680b60af9..f115ef6bf53b 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -297,6 +297,8 @@ bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 EXPORT_SYMBOL_GPL(spi_mem_supports_op);
 
 static int spi_mem_access_start(struct spi_mem *mem)
+	__cond_acquires(0, &mem->spi->controller->bus_lock_mutex)
+	__cond_acquires(0, &mem->spi->controller->io_mutex)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
 
@@ -324,6 +326,8 @@ static int spi_mem_access_start(struct spi_mem *mem)
 }
 
 static void spi_mem_access_end(struct spi_mem *mem)
+	__releases(&mem->spi->controller->io_mutex)
+	__releases(&mem->spi->controller->bus_lock_mutex)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
 
-- 
2.56.0.385.gac671c819a-goog

