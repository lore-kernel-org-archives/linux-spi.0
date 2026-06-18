Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941753385B2
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776675; cv=none; b=oovCwY+ZJExA/UDjFzlA/NwRolrW3DQ1ehvt6xYRzUGdlMDqU5Vu1lwVVW7+WyOTjLixXy67uZzkGv5tIvDxsXY3v2kAbXZLTRtO0u6t+qKgF2/xYmR2zPf/L3iZBDnLWQIPz/zti5XVyJC6sZdhLUTxFvS1nlhBBfj0/AqIl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776675; c=relaxed/simple;
	bh=dst7drClg4p0yKdTk+fV77097/ViHdtIvg1LiSCf5Rs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=h0bs9nJX0GhNJBfeoQEr3Uo/du7QtjEWhnlHL+kPzu4jhS5aWJ5okD/uiGZuUhmP8mQPpbnYu+MRdiFTRNVhrWxhyuO5cDyqDGUVLPZMQYHv0VrDK5aytlKYSMD+Qm2tfml5c5ba6gpbmWR1immJmxoOrvYDqhIKuHJ84UakXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDGg6jhK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDGg6jhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB9E1F000E9;
	Thu, 18 Jun 2026 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781776674;
	bh=9B3ap63L5DvBGWoe5U8v/UPyIQ93avZpIFGzeNBgzE0=;
	h=Subject:From:Date:To;
	b=QDGg6jhKIryLwb3qUvn/cHPKnkFE18bjgz/VJnJex2rUPHO0aoXdLNz1E2KjXhRnw
	 K9dJUL5FsJxZipNo7QNF7V+s9aFk4TOGY10C6dshIQyUARlxVIRaWFcCv46RAVI7iW
	 BqMcRo+BddHqPRYzDRuHT5w2riBKfoxLRWp0wD0IzHyBQw+9xN6dT00OWwltC35Ybe
	 Nwri5DfFIUpH0ThUpop5D0C+CAV54IH+oWuHct9V6/yUzwLTfPgMzytxZ30B9HLq04
	 axhpioPE8P0Wa+VDNFSm66k/4iPqbUOCIo9FDnY8OpopIlZo0dOvCoZEe4k5kUF4jc
	 nlqiQh6DQ/mrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569E539E961C;
	Thu, 18 Jun 2026 09:57:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178177666794.1991937.7603813310460853870.git-patchwork-housekeeping@kernel.org>
Date: Thu, 18 Jun 2026 09:57:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Enable SPI on SA8255p Qualcomm platforms (2026-06-18T09:06:38)
  Superseding: [v3] Enable SPI on SA8255p Qualcomm platforms (2026-06-04T06:50:34):
    [v3,1/4] spi: dt-bindings: describe SA8255p
    [v3,2/4] spi: qcom-geni: Use geni_se_resources_init() for resource initialization
    [v3,3/4] spi: qcom-geni: Use resources helper APIs in runtime PM functions
    [v3,4/4] spi: qcom-geni: Enable SPI on SA8255p Qualcomm platforms


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

