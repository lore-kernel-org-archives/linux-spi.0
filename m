Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008163DD872;
	Thu, 14 May 2026 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748361; cv=none; b=rLT219cBCKPYbEkEpO/GIFqAJSzjpnEntXPD9TW3iaLbwKiSCdYQ9Ek9WXjpCfxBy9jVO/C+EMahTnHgqyPh9c6Ahi0BFPdjJjnro6nqetvFTbdxRXT5G3uLUjpzI5FA9u7bP6FPjGjbgmiA53CtkCs6smDdxIvPNKc+KetS2sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748361; c=relaxed/simple;
	bh=RbpyetM4FynMkZqHk7V+ueMEboZEZgn4HBJh25f6mWY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XOxhN/bj7VxMmU86H6Z2vDXR3GKQPqAMzUcXa0DgLpWX1xYKtFANXZcdbTK1U75ORBG01aiEBoUExVLJWgzqHCoZL3S1fWhkTjZYjkyM2AMJGx8TwwNMgsfiSKlLL3fJpD8tsl2kuoXZf7TskqXRPZtbPI9nNuoT68gTHArz4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MAMlIEaE; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MAMlIEaE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1778748348; bh=KUx41ZXPHff3cVLJPj1mmyldiEL34bMc5LBoWFYZOk4=;
	h=From:To:Cc:Subject:Date;
	b=MAMlIEaEAtAAh8LG7S8IRt5bS3QscQ2NpmDOuUn2yWJ8e9gc2FT0MQKmp6K7DcAYS
	 xIrEqK+QJ6i6q7mH+6HPY94WHevfnMVhoGEQ+lSAr0qj52iwpQprCB7eq/DG7lZEAQ
	 k6MiNKeKfIhfOy9GJtwqZg/EcUBgSKQOXyLQafOA=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id B6EA0C37; Thu, 14 May 2026 16:45:46 +0800
X-QQ-mid: xmsmtpt1778748346tcndlgxrj
Message-ID: <tencent_4C5A0FCF387BDB37C5512E5D709FD557F106@qq.com>
X-QQ-XMAILINFO: NmRjDopJZVxOGP78SZch5zrZIWLhBxrdhmbsj8h56f3YeBC01g0svI5VYoa9gT
	 5TdnTPi6yT1gYKC+pxHORyPGkrBWlOP1Dd1B2Tlbzee+zmnDpGuBVc3zBdZHos6k144tTRNk7s3c
	 xb93EXnkVw90DGkKuIiFMNATHwFv7R8D0Fr1SWCmN8UCp3/HXhDtk8K9hmrdS/mRVphGSwrIbE1Z
	 2TdDsKLJ2LzvSMwfAElL2Ps2fH4BYxRE4ngqmBvlkdB2+bmAGJgQ1jFxmY1S8v3cU/9YVbaLTzSL
	 naoTXYuS8gyrrRKl9cjMCkCrs0RylFMHuYLa21fH6O2x/Zay1iUoBfDXcZxH2oMThYhuJ7k5ZHIl
	 BmMB0u6/s1+92siedIujgixLxY9Iv+1oelh5/tduOxGAFPfz5hibMSefvp8zw3HFZccpDctsNP/m
	 F9YyQFfLGjKwGmSdE4nVYXmvZvfTqApv6yu3IqCT0r2oKTpku2ZB5G8pz+eqgKECy+jEnkQkPmPe
	 8dLxN6EDw2yDyFuJoDmIcIwT5MWY+5cOrJUfPgQGEooX6V3LtBYigHJvLcqDBs0kYWyZJXYpY4gQ
	 zNgoqVWaYYqoJufgtwqpv8pVT58f9Ya8AfZgQeF79RZYeyP4Tts4TSPJRKfqtvzAZENsucVGz1B1
	 RBN8kd8XksPEnjQYXmyKPh80hB2q/ehxrTaXuXMF8vkSXy29/+v9zEoONQF1nt6KiTqB2oHraeZn
	 MTLDPw0RLwm7H0PPSCiUdng8BojXQ644O583I82ClGa/Pkb83CZnHFmvomzfalHOjj9Pu2OuAi4I
	 27Oybydca81RI8/o+dFPpvJqd1E2eGjyiuBg/8WBt7e4ZtqffpJHqCpP2b15axKV+EKalBgd3a81
	 BUGTa7kRKB0pu0G/nCZtOcPqYbdnJ5HNH9igtSUHteobn16YhXD6UUop0lM2VGA794198MV9zMMg
	 SmJA6aRTiM0VXqR5rlwVDSo4X6j0uB643LOE5oaAkai61TazWamwIODVKqmHNErnW8VjimGu53SZ
	 hftBHvnA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: ChaoHuang <958028483@qq.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chao Huang <huangchao@kylinos.cn>
Subject: [PATCH] spi: Add spi_for_each_controller() helper
Date: Thu, 14 May 2026 16:45:44 +0800
X-OQ-MSGID: <20260514084544.578388-1-958028483@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Huang <huangchao@kylinos.cn>

Add a new helper function to iterate over all SPI controllers.
This provides a convenient way for SPI core code and drivers
to perform operations on all registered controllers.

The implementation follows existing SPI subsystem patterns:
- Uses spi_controller_list with board_lock protection
- Directly operates on spi_controller objects
- Breaks iteration on callback error
- Follows kernel naming conventions (spi_for_each_*)

This helper is useful for scenarios like statistics gathering,
configuration updates, or debugging operations that need to
process all SPI controllers in the system.

Signed-off-by: Chao Huang <huangchao@kylinos.cn>
---
 drivers/spi/spi.c       | 17 +++++++++++++++++
 include/linux/spi/spi.h |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 104279858f56..7cd07b390a4b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -5116,6 +5116,23 @@ static struct notifier_block spi_acpi_notifier = {
 extern struct notifier_block spi_acpi_notifier;
 #endif
 
+int spi_for_each_controller(int (*fn)(struct spi_controller *, void *), void *data)
+{
+	struct spi_controller *ctlr;
+	int ret = 0;
+
+	mutex_lock(&board_lock);
+	list_for_each_entry(ctlr, &spi_controller_list, list) {
+		ret = fn(ctlr, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&board_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_for_each_controller);
+
 static int __init spi_init(void)
 {
 	int	status;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 79513f5941cc..8fcf3faf9739 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -934,6 +934,8 @@ static inline int acpi_spi_count_resources(struct acpi_device *adev)
 }
 #endif
 
+int spi_for_each_controller(int (*fn)(struct spi_controller *, void *), void *data);
+
 /*
  * SPI resource management while processing a SPI message
  */
-- 
2.25.1

