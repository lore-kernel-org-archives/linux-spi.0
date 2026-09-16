Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A1233945
	for <linux-spi@vger.kernel.org>; Wed, 16 Sep 2026 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524057; cv=none; b=B8EA+Dab2BR2RHFYP5xOO2QBLn5dZTpVabQ8CZ/1mZPAHbD9GqiQ1TVVn8UUKMs2TxipS1xBy91djVeOCq62ReRtAAbAYcaL4Mo2s4LZNlUd+az6tKUu6UYyiuYj3n/NPMiLgIp+rSDHWUyAnnGqtlQdfunjayk+cRnnXGehaqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524057; c=relaxed/simple;
	bh=z2vnxYECfe/CK+/EmMjMDlztEhbtnFjpr0RMVFWdXpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVqLU9TR1If+TG9Fc8YsTXUa2Lqc/UhW1cCzOUd5CWU4e9/I0iBHpsYiinFmJdem4n7nMk5NAB+pJE+vwmRzoNNbeyfNE5l6doVeqqoRu3qqrD2S/sjVD2R/FDLjl8UPD9mtTx8xMd/yjXHgcPUFRwO0yeP3RU5wHkaaIbnZWnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com; spf=pass smtp.mailfrom=matician.com; dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b=gEleu3h0; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matician.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b="gEleu3h0"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so316071a91.0
        for <linux-spi@vger.kernel.org>; Tue, 15 Sep 2026 19:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maticrobots.com; s=google; t=1789524045; x=1790128845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RR+WtBbiVNxPAorgDWRwyWsfbjTaY0Xp64w0w7OzUbY=;
        b=gEleu3h0gGxsdrFJ97soKyZVnLiR1bob7fv7FwkLxPX1RR+aYOPcyRBXohdv5Y+iFf
         oWQbqE9owW1iyQWlpnmV3gAJEspdIOea/nruKOL6buLlnq05W+41NEFZmERpNT94JfwB
         IPQSKVctOy+3ytJWf4hCDXk21PqMmwV64Z+g/oVhvQCbaWQpVcN0pA5bjgJ7mBR1GcM8
         bVypl6L3Wdndt3os7pWyKu2XYLH3vrnZcEcf/i3T1DDJNi/teK8Mvw/b0NKhM7U4IYKv
         WG5buB6cYZuvYW+bj8kLlFD8+nIzSWUvCDauZKvZL4Rh2gOj7rXFuUsnpCDvMy8IOllx
         e59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789524045; x=1790128845;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RR+WtBbiVNxPAorgDWRwyWsfbjTaY0Xp64w0w7OzUbY=;
        b=ZM4K9P0zD15ItVPZZboN5KZlpGeUlVXQ7W57k8vLgOi/UWUC0TNBU+g+7tO78ptDgc
         S3inpRH3my4jC3pyGvx5p5lNAsQW1/0lMo7JcRsDfMvTAq7BmJ5XuiFz6bbA6HpqGgQV
         1+rcqmlO8fgpKObs6r2lvdU4ItcV2hE3kzZkGPQPZFltMCTiC/LZ0cLPeHIj9EymKhdg
         Gud4bmjUOH9pmqhe0job7QNsi35H8XIbk8Psua2j6OXpn8VKhZsejAJQqC3aWaJYapcC
         qBo4hSbah4URuaNGrpTHaU3ZS08pfrwCYxJab9s/4YFXoD+K3k1VDJ2F8k4YfQ2Vh0jq
         CAUg==
X-Forwarded-Encrypted: i=1; AKwUvBxsCu7Ze1vfH4dGaSpgNiTs8xCAhqOkm7xfvBZW2xYcsxuuVO33MHlGKNVNnBEfiKXD+M4xebM6hUY=@vger.kernel.org
X-Gm-Message-State: AFuF++mjopcdxEXTdK94935Dt65BtlSNWBXic0jQm0hBcNyO957sl2t1
	Y0FC5aWt00Eqi02U7SsTsyI1dsJBm3EJUIdhn2rwb4suFBr76zDkmMoHDDLVKkDpfLs=
X-Gm-Gg: AYBFou0Y8oJE/3xfQckv1w+p/Xz8ZJIrmTtPGM7ZrcWLIQNTfH8W6q1gak/D2BIp0l1
	DUgtDGIZMRtdhpC7Wl495VSgsKTcbYn/l4mnfXhhS7kHwJ1nmA7MECUCa2Yg8PVLXZbbFr85maT
	BZJG1sretyWIXvvAVsF4T/TpWA7LVelwE5yh1vdJWavW3kugkoMPKs5lCg5E1gat8GNJ2YnUUNK
	lr9Xqe2gwKwGCOdn3zNjhk6B48GLqyXp+9L5AAg/VsObSD5g10NNT/96fFfQhujavqgzrzvd7Qg
	v4kgiaTg8uarKv0FepvuDbESkcY0qRkNZRZAY7E7M6rdxPT1vgNCVvuOVlDgJh0du4RFx0kFk+6
	TDF64ArgC8zbTx3aBZ8s4A1EgZ8kG1sCmnuZSM0LMQUsRP0cxpsoHs1IiHxdtss89FaWF6CR5Ah
	4suC/oOk+Qpdzd2fzjyuev59eFhjXQexoorgGCUKcXxkutEAyq+ovd7q30Y7KY5llBq0Gdaold+
	+z3g7aFxv/zTl8lIb8bDWwf4CajVLpx5sSACrLqpACIji+2+5g+3UYJMss=
X-Received: by 2002:a17:90b:390d:b0:39d:f66e:1720 with SMTP id 98e67ed59e1d1-39e1e4907e8mr1658967a91.13.1789524042128;
        Tue, 15 Sep 2026 19:00:42 -0700 (PDT)
Received: from abeMaticDesktop.1020marsh.offices.matician.com ([2600:1700:471:807f:c09a:1c02:505f:9e4c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b1d335sm3056984eec.28.2026.09.15.19.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 19:00:41 -0700 (PDT)
From: Abraham Zukor <abe@maticrobots.com>
To: Mark Brown <broonie@kernel.org>
Cc: Abraham Zukor <abe@maticrobots.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] spi: tegra114: initialize native chip selects inactive
Date: Tue, 15 Sep 2026 19:00:28 -0700
Message-ID: <20260916020031.161347-1-abe@maticrobots.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <c6868d2a-f55f-4196-9914-f096420cbabc@sirena.org.uk>
References: <20260826000517.631736-1-abe@maticrobots.com> <420de339-53d2-40d9-b04a-a54428450830@nvidia.com> <c6868d2a-f55f-4196-9914-f096420cbabc@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Aug 27, 2026 at 04:38:39PM +0100, Mark Brown wrote:
> I can see a system having multiple variants with the bootloader
> selecting which device is active in the DT based on runtime
> enumeration.  Not sure if anyone is *actually* doing that, but given
> the state of the world with overlays...

I think we should handle this per native chip select:

If exactly one node is enabled, use its polarity, ignoring disabled
alternatives.

If none are enabled, use the polarity specified by the disabled nodes
when they agree, including when there is only one. If they disagree, log
a warning and use the polarity of one of them, since no inactive level
can satisfy both polarities.

Multiple enabled nodes using the same CS are a configuration error that
the SPI core already checks.

My v3 needs adjusting for the first case. I will implement this as a v4
if no one sees an issue.
