Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBED23C368;
	Fri, 31 Jul 2026 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537549; cv=none; b=FFVM2DaYU2GMM4VWOWhueKwKU2x9sjXVS2rWXXlGUAFh371ZCTtzQv+RnKi5hIl8ts6TeJamY+yZC/8VMMGb06PvQeNph+3byMCSncBeH1AT7UcwRHk3teiM6NZt9gP2ofoBHzGAMIOV6jAULdiMmiRbLt6L2aFzAysB5iLwGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537549; c=relaxed/simple;
	bh=dn+G2E9DlxogEZvmLV1H/AGk4z4+bOZIZsvHDKExqnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ib8HTSNEQKHy/QSOK21NDpkX5xjfGkS0ywyhlIN1+ouEU+SKelAYho1h+MZxPk/uKyAnuvuLgscNHLUw7lmdYy5fZspooE+F24k3RqEtB6qsOjvIIs2hPJZK03XxFOxB0lJ1JsnnU6gugzj5I053m/gpah9cenCOrIW3RjFMUhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQJ8N3h0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQJ8N3h0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176571F00AC4;
	Fri, 31 Jul 2026 22:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785537547;
	bh=jux7hx94+9khlWlqKOsfS0KEOxmpe7YKL58EAhaSd/0=;
	h=From:Date:Subject:To:Cc;
	b=HQJ8N3h0Bb3vSol5s3/+sJKBaY4PXa6VmMn2YaSTQCfAXs34or6o2xf16K71CNEDX
	 AE/RsMxhYaMILcnupjJhRXMRnIW8cESX5ynWvTjt0ML8f27wt/YKzOnVIkVFdut+TU
	 SxQLrCWVSQysxkPgKODOum28sNQ+Bzi3wJNcbb53G290CVWf7oTYivzMOlov0DdPmW
	 iyXnmUWZfljr2FaZDK3o4BPftRJIHeqctWWhlL7Vdqdh4mAp+miX64a3lRyVyvmRCT
	 xM6KeSqY2zJHf59Ne7zYsuUqFFnsWEXUa3ffmqBEXTnHRcapuvGZ/igMigpxQ/ZAhc
	 j+fccukbEORgw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 31 Jul 2026 23:38:55 +0100
Subject: [PATCH] spi: Ensure we always have a maximum speed specified
 somewhere
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-spi-enforce-max-speed-v1-1-a1737b63a96e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAP4jbWoC/yXMywrCMBBG4Vcps3Yg6dALvoq4qOkfOwXTklEpl
 L67UZff4pydDFlhdK52ynir6ZIK/KmiMA3pDtaxmGpXt64Tz7YqI8UlB/Bj2IqBkcWFRqLvpZW
 GSrtmRN1+38v1b3vdZoTnd0bH8QEzv8M/eQAAAA==
X-Change-ID: 20260731-spi-enforce-max-speed-30c53f183635
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dn+G2E9DlxogEZvmLV1H/AGk4z4+bOZIZsvHDKExqnU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqbSQK3GD8YbvQA40+U4vMrpko4a577SqpKnoPb
 JL1txfp1ReJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCam0kCgAKCRAk1otyXVSH
 0L+YB/9oM2ut/JXVBh59WSyxMyKUfCHJPwkBFrfZzLEPGbrnA5NuOVNNiDxiGs4ZELm/lEa90Dw
 Kp9TqHOPAgGuquy95mMchwHyaDuIY/m6TS5SOh9Z7LOIyb31YylUoXwNRfymQO0wXM3Q9daJtDA
 DkEXOQ/c3EqRBPb9nONQQLd3DmSnawwjHUKYjT3cpasNAEQdLODEj4OqUyOHFklDwd+Nfr1LVb2
 Ai810c4F035rbTUHL/zlFTZUiwWguoreHReiYLMSjTclWW/tiHIj8vVuoelcctphCPwY0CBGwOj
 FFxjcMKsEP/xZNxEuCmHjjhqQqP6+w+ldv+k6s8zZy1aFHIW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently all the places where we might specify a maximum transfer speed
are optional, adding complexity every time we have to use the value
since we have to handle unspecified as a special case.  Simplify things
for users by providing a default for controlllers that is the maximum
representable speed.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d9e6b4b87c89..0a13d0bfd218 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3542,6 +3542,13 @@ int spi_register_controller(struct spi_controller *ctlr)
 			goto del_ctrl;
 	}
 
+	/*
+	 * Ensure that there's always *some* limit without us needing
+	 * special cases everywhere.
+	 */
+	if (!ctlr->max_speed_hz)
+		ctlr->max_speed_hz = U32_MAX;
+
 	mutex_lock(&board_lock);
 	list_add_tail(&ctlr->list, &spi_controller_list);
 	list_for_each_entry(bi, &board_list, list)

---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260731-spi-enforce-max-speed-30c53f183635

Best regards,
--  
Mark Brown <broonie@kernel.org>

