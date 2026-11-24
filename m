Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525089;
	b=Z++XwwlgkQipsggcNUpQ7e7iOYboFR1/cghKBJ1W+Qn1C+KRncbhxaGGMvocAUNlts9e
	 j+BSXGunw8LqjD5TsXf7Rr9nno4MLSjVcfz99JA8OIVXXOvLg+PdAp/ZTOMos8VS/CLlJ
	 WSqP65EUBFIIE9nfISjbVDNUEvtiQh9DXTTHTlpW97dTL4fhPkTitz5ecylctMJ5ujWHO
	 QjU1KK7O/bvHa48VbjCZXS5oWfnXVHfjZGFqV+5gCU3spEXeZxbHF0IWJlfI2ygl3F5yi
	 adOiGieQbtT2uOgWzIOnNXaUf7YyFIOb0MDPXWvci+/1Z0Fvf12AmK31nPwZ+0FG00Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525089;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=3GoLK7bKkbAvZaEsXdJcS3QdjiazIMeeqd/ggtW1PeQ=;
	b=bURpxeqALv++kWiMLX8pQiskPEJwiM+ZpJBW0orWJBtylheFq+JVabdCQr28SeJwNIX6
	 IwFYO6o1ZqG/ZT3X/B+Hjy4AVwc0T9eokK95W1Pjr+hxvaeC1RmyXSNPfMtxTdbNLlvbS
	 XgvWuxCcWtPK5n0iAzh+8KkMhoASbDFhGqK1resbhOzx9trND85qEYSR9LqvFvR+j0MPh
	 zNGeA7ewGNmODVwegbhoUUazBb17OnwUJZqnJvdGmPicW0mLgNCiLIulml2w3lo2U5QNb
	 PKKiqGko8JuWOt7hpRfX2n3qCFgFf1D6zcSn9yN5gp1MBdaZirOAa/8MnFhCf9Uo2Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BS/Yn/sI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894E0606A331
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BS/Yn/sI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C368F1F000CF;
	Tue, 24 Nov 2026 12:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795525088;
	bh=3GoLK7bKkbAvZaEsXdJcS3QdjiazIMeeqd/ggtW1PeQ=;
	h=Subject:From:Date:To;
	b=BS/Yn/sIKYhMU1Rzsxkv3mZEgmZoMn/kou99FhZeWmCkR20iGxLC8z4CqdE6/i0nw
	 IY8qxliTMj/0do3s5LKacTvezS7DgmbhA+LsScOEGGz/2EzOHdp7aSMTQ3FBzyRWg9
	 pWL8sAuVxZHy7K4z/pBuoarE+Qcl1+zK8jmbjkzTh8MoX7UeesYKncb+opjx0g6jSp
	 ilby0W6vDwqHYmddTN7ivlB1shUwhvM/J56BIXHfaNpxQwqCjk/fxILzANBvjxrJxn
	 qdq3AjxR1wtWgHrBbRCj/GSezCsBYBWNkYDG1mpYokz4Vnm16OCOhMzKC0255QH6fN
	 Ei/ze8dIInqGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6A2E393107F;
	Tue, 24 Nov 2026 12:58:08 +0000 (UTC)
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
 <179552508742.3512110.16059770431127381617.git-patchwork-housekeeping@kernel.org>
Date: Tue, 24 Nov 2026 12:58:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: qcom-geni: Add QSPI support over GPI DMA (2026-11-24T12:15:21)
  Superseding: [v1] spi: qcom-geni: Add QSPI support over GPI DMA (2026-11-06T15:01:18):
    [1/6] spi: spi-geni-qcom: Add transfer_one_message() support
    [2/6] dt-bindings: dma: qcom-gpi: Add QSPI protocol identifier
    [3/6] dt-bindings: spi: qcom,spi-geni-qcom: Document QSPI support
    [4/6] soc: qcom: geni-se: Define the QSPI firmware protocol
    [5/6] dmaengine: qcom: gpi: Add QSPI protocol support
    [6/6] spi: spi-geni-qcom: Add QSPI support over GPI DMA

Checked 231 series in 3.08 seconds.
This project currently has 17168 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

