Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EC93C3F4D;
	Tue, 28 Jul 2026 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225911; cv=none; b=SYMHAeyx3DgAtqD32UjvO5767/8uZueOMwewyCFMkA50VaMeSDUgMZk9fjvTi0Tqaksru8747ogAO9XiMDJ/Wvx2IoCeDg+oQxOFqsg6FnVuhdHZdJUE6g0XeBnjRRyKtKsTKzzgo6DSjysbY0qIxk/q45TNDigxVb3P+Q4K94I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225911; c=relaxed/simple;
	bh=mQFuqEFFth+e0qj02d/6kczo+lZicUnSuR1wPm28z8o=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=AKzLTvQ+BAsb5HuMawUqa1u8kyHfBkbJNJlAqmCwc2hOSCoBH8RJWgJ5o3VqOFBCfR8Zeve+IEd7jVQiHJXy7oZZjj7skJLU8/jdLcw9v+n9IpQwlVNhTd+rxkKh8SQIGS9D2CjfQTksYdBRFfhsBQCBylajyC16c2XaFgljHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=e5NxZ2Ka; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="e5NxZ2Ka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785225899; bh=Fu0INKYKZjqUteEg1PtMuJMDl9DZDK1/jtKO+4im4rg=;
	h=From:To:Cc:Subject:Date;
	b=e5NxZ2Ka0WGTjh8IL/yB8VZmI+h+fSpAUolxS7OCdB+lJoAHHHpsJoU+ZyF2Ygk9m
	 VwX257wu/8Hw+PVKF/UZFxtYd5GI4iwRiIVsQz+EDoRwz5WuBLka44IMBrVMuAtRfL
	 YKEhGBgH0Sh3TOHZ/qqWCSyNxIytSs5iqXT+aPlQ=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 12B9D80E; Tue, 28 Jul 2026 16:04:43 +0800
X-QQ-mid: xmsmtpt1785225883toj5ulopi
Message-ID: <tencent_B3AF7EA2C812124397C0691BD0F0B7B87205@qq.com>
X-QQ-XMAILINFO: MqG4KXyEKpQypOro+WZYOGH1HBHV4zT9UcLZ27RDopaYstsvMUhFXNDgzYXxBd
	 ixrctHHwrDPsEZXB6w9/1iZyMe7zKk91RJvff1ytiL4287T9V3NvXXSvXNfM85Ih5arckv/x01G9
	 hCAjR/NRcf+DVO6LILBgmGBAwkLWxSW7det/TqAeyA07UbbYjGB8sLNaUww4eRYBURnzoKYmX79q
	 Txfz8QRlRbnEuxDEABOsM3GBAThjtCRhs/uF5G3nq6NRwwgLvhSQFkiSzCLwB9ORuI9u3UDYPowO
	 4Cvyqth3FBfawYHuXd5+FVu8S28Y4pOCpDLjZ/pFL88F653PcmjXosk9O50wtlw8BEMr98cpSfgd
	 fB0m1tBLNfO2N+wqQDfe4OGanE1hw77pHs1AjEfM7+6pm0lifDDu4L6dQxrtqM0g5aQsG6f+nz2S
	 BDvVri97bSksVppVXm1fNqU1cqmcIXvJFrqUrhvh16xwbk2hBe80/B42bUWqDduKPUhylVrdyICC
	 IVCJVWWEA8vTe6GECyyiSOVq6Fq5a2UqAOYsYLotNKIPhXfLX4ZVUqd6AUOMYsF2oL+QCuOn+5LI
	 zWNHLx8RYc1oiTJMeBzAg5NZ3ORLVKNzTMDLDjvuM1igwJtT13JiHHWQGIR63BGm5OhEuHnBlLi+
	 J/PejCRp2n4b7lTgPK48zdjY/bj2mdQcMv8Ps0xAy53L0YMhyrP/+BjqCPWI2w30S2XpOkiLF/zp
	 NDe/2nnSB7xw8xKB8fc5cb48Hu3XIlbAMbUFdfRK842NSNwHJpygelBKqdEUlTjDhRbKoYyCJA9w
	 ALeywD7fQ9QNumolUgQmb6Lc+vBmu67bVN/dI9nk6qpQFi8OURgKi+7QzPVWtA/YU2+gOyfF5f1j
	 NvXsyb+k1XmnHAyXZ7uiuM792PeAa9RHVShcPXVDdNp97WiFhHZIxeWzVzg9j+U6S0K5bBAdaPDX
	 tyBitzTscLwx0S95tgYCA32ZIB5gKqjt/K4EOrThXixsB01iaOLlVfWruYPXOhRi/roMwbA2bxiA
	 wfPLALLdXwBzpDritH+m3hbijXF4I=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Jiawen Liu <1298662399@qq.com>
To: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH v2 0/3] spi: nxp-fspi: fix runtime PM error handling
Date: Tue, 28 Jul 2026 12:04:40 +0400
X-OQ-MSGID: <20260728080443.153827-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series reworks the previous probe-failure fix for nxp-fspi to use
the newer runtime PM helpers, following the pattern used by spi-nxp-xspi.

Patch 1 converts probe to devm_pm_runtime_enable() and uses
PM_RUNTIME_ACQUIRE_AUTOSUSPEND() for the initial register setup window.
Patch 2 propagates nxp_fspi_default_setup() failures from probe and
runtime resume.
Patch 3 checks the runtime PM get in nxp_fspi_cleanup() before touching
controller registers.

Changes in v2:
- Use devm_pm_runtime_enable() and PM_RUNTIME_ACQUIRE_AUTOSUSPEND()
  instead of hand-written probe error cleanup.
- Include the additional default setup and cleanup issues raised during
  review.
- Split the fixes into three patches.

Jiawen Liu (3):
  spi: nxp-fspi: use devm runtime PM enablement
  spi: nxp-fspi: propagate default setup failures
  spi: nxp-fspi: check runtime PM get in cleanup

 drivers/spi/spi-nxp-fspi.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

-- 
2.34.1

