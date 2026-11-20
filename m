Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208817;
	b=mZaQGPAZi/4yBioF0+BX+fTS37oF6Psy0cLhDHsoYEvi9+KSlrQXqtWmMTFPMnGgT+Fg
	 MFaqIFo5W4Xfx/iFo1cTdmqW6IAes7NsYzh4+aJgYZke6tr4gcFNPF9cWNrVMN/aoHSi5
	 sLx4b7hGjD3EO4ipXgOUdWY6OK80Ws7vmeuTNKNBS8ogIetIafl5f6vHZc0pSh9IArVuY
	 olZvkq/7KB4yQh6/u8yWE0i2XCJ2AmVP/ouFalIlZVQWljRMwD1/ODEvmR+MzV10LJK+R
	 DBUWw4aM1fySAs5toqc8VqD8kJ2C5Rhaitsceitn3rVeDxjM1axyuEYzmfaH650YQZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208817;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=f0Frvtc3rQG0NExg9Mw0J8dfjyuDCwgCUzKtXvIL0uE=;
	b=KLVzMp4Xrh6qHQyOmsnlEk8J1sUQdrg/jtdcOqeXdguIli3smoB3iIiHeSQ+TGO+f2x+
	 qAxzUrUoPqe5hBffA5Gs9s9hRqnpy+2NQKFtjuYYyPMLWnnZoBJoKtGVBQ1ZnH9Fe7UWg
	 Y+kUEkl7ZXZXLd3iUSyM2HGZ51WvpXQB7yMPdSIH/h7dSY33msHAg7RdOGyEWVQo+1/fV
	 /cs+48V5opt//O/ZwO5jA0iN9BecTLlOvEHcZbDhOx7FB0Ntsq58AcyJdZT8/XpLquE/4
	 sy6/KwrJXhNViUMOqCTB07WoMLuWYR5ZCZ6IRnQu2Xqh61z1ZeIbC6oyddrdNGzzrow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBMb4+Vm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1789606A69E
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBMb4+Vm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897C91F000EB;
	Fri, 20 Nov 2026 21:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795208817;
	bh=f0Frvtc3rQG0NExg9Mw0J8dfjyuDCwgCUzKtXvIL0uE=;
	h=Subject:From:Date:To;
	b=XBMb4+Vm3wVCB1JqXdm44/wLUPC954opF+30thWZzuelV6CkdYhL6f0mCXUEAv7Ul
	 8H0XpiWqDYV3WcIeSzWp/2ho9ulNi73BsV8dr5tLTEnVq8Na0ruNeR+K1iTxJVp+/b
	 yKwY0qksdLznZV1MZ8ctApkvdkYz+hJyOHAamgIl9TB25m8gcUQb9cfKCzvpKXFMZM
	 XftpTJfVh62MLJ9GK6UrHfnRyzbjPGwCr1/HyLPSml4A27J7sNVVKD6dZ7+HIEu7Ix
	 lrLnHfoFuAyC8HuAiPPYdlMMgPkenwyHo3t7iHxC+xpkvlfaNyMjrIlHuRnkT9lfKj
	 RfDQc2aA/VLbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774ED380A964;
	Fri, 20 Nov 2026 21:06:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179520881604.782371.12462574391248837305.git-patchwork-housekeeping@kernel.org>
Date: Fri, 20 Nov 2026 21:06:56 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: spi-ti-qspi: finalize message on transfer error (2026-11-19T19:10:00)
  Superseding: [v2] spi: spi-ti-qspi: finalize message on transfer error (2026-11-03T22:51:14):
    [v2,1/2] spi: spi-ti-qspi: finalize message on transfer error
    [v2,2/2] spi: spi-ti-qspi: add KUnit tests for transfer error finalization

Latest series: [v4] spi: Implement a atomic transfer as a last resort (2026-11-19T13:58:03)
  Superseding: [v2] spi: Implement a atomic transfer as a last resort (2026-11-13T13:50:15):
    [v2,1/6] spi: Allow spi_delay_exec() to be used from atomic contexts
    [v2,2/6] spi: Export spi_set_cs() function
    [v2,3/6] spi: Add infrastructure for atomic sync transfers
    [v2,4/6] spi: rockchip: Fix runtime resume error handling
    [v2,5/6] spi: rockchip: Move to pm_runtime_resume_and_get
    [v2,6/6] spi: rockchip: Add an atomic transfer function
  Superseding: [v3] spi: Implement a atomic transfer as a last resort (2026-11-17T23:50:15):
    [v3,1/7] spi: Allow spi_toggle_csgpiod() to get called from atomic contexts
    [v3,2/7] spi: Allow spi_delay_exec() to be used from atomic contexts
    [v3,3/7] spi: Export spi_set_cs() function
    [v3,4/7] spi: Add infrastructure for atomic sync transfers
    [v3,5/7] spi: rockchip: Fix runtime resume error handling
    [v3,6/7] spi: rockchip: Move to pm_runtime_resume_and_get
    [v3,7/7] spi: rockchip: Add an atomic transfer function

Latest series: [v5] spi: cadence-xspi: Fixes and ACPI changes (2026-11-20T11:59:18)
  Superseding: [v4] spi: cadence-xspi: Fixes and ACPI changes (2026-11-16T14:49:03):
    [v4,1/7] spi: cadence-xspi: Properly handle errors in .transfer_one_message
    [v4,2/7] spi: cadence-xspi: Reconfigure to STIG mode before SPI message
    [v4,3/7] spi: cadence-xspi: Inform SPI core about size transferred
    [v4,4/7] spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling
    [v4,5/7] spi: cadence-xspi: Drop useless cdns_xspi->cur_cs
    [v4,6/7] spi: cadence-xspi: Rework resource discovery
    [v4,7/7] spi: cadence-xspi: Add workaround for old Marvell firmwares

Checked 230 series in 5.62 seconds.
This project currently has 17143 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

