Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.56.87.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793291286;
	b=PQIBz0FFD9DGzT4plerFxT3hLOLSbq/9osyRlHYX4SsH+01NaIP0X+NhlYrW2jnGOKuX
	 0aWfi9S5QWm33SufMG0F8ufckfhMQ8nwQFUO+jZoVnp2mjdIsulIHP+hOh1Rp93lasNLg
	 OEX/AF7q13WewJ6Nt6hGEzhzysAslpEcCobukYYIMzkTXD4rwCLfJqF/VRji3tUT++59P
	 iu5fkzyN+0pyj7iFr33TbkMWQUOKgtvPoCFTLj08yX5s3KK45bgztfJ9yk0vbfkx1jEyv
	 Cv1qw0hQ1e26O5m954GMfw8nXJbqtGEAuSFifsBWZW6BhXAoxM0HQXdrLdItENEiEWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291286;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=1thP92GAsnoEoj5OjQ6bprJ+2HRz52udeXPZhEvDBmc=;
	b=2rji+ea+XCJAQI7njHf0jg4QmqxUhhayPgaKf+LEoYmuXR2PxA/jc1/qTduZWj7AGALN
	 7z7keFEgNeoKeY6KqPs3B+oO9y0ulmMkCiV4lun//R4N6gvPcxv+HLAwY3zgozyYV9sXn
	 26YsWW/5/zrS66nCMNUJWqj3o5zzHfIUTP84nXdKGNc7iR5Enr9ZVoIX+PGSOIC+wvMHd
	 9SIiQJvkH+OTPoxBa79wActC2ZrNMAPqtLA+40hbJEO4YusbS9wyp/lYD2FzF9ISUCtZ+
	 XBT+8VS0XDKhBGDHJdmqkpLiYbW23DSPNTXfmr1tWpXIHm4Gd8/f3xUtYLn9N5GfYCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=RvnlXCS7;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b="jNg1FV/7";
	arc=fail smtp.remote-ip=185.56.87.6
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDF606A331;
	Thu, 29 Oct 2026 16:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BDDF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=RvnlXCS7;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=jNg1FV/7
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-8v6p.prod.antispam.mailspamprotection.com; s=arckey; t=1793291284;
	 b=wKU53zxOi1HBc8uQ21lLBbvLTgP8ueva5CorSjqebdv0nl3PjIxUNGeRqBfiuuvZkKoSpxfCY7
	  8osW++IocJkVNitqG3g+OPpNkqkeeKWN6ReKZb1U9l9pABnR+zczZai7AdsPBcXdVuhSwJglCu
	  6oFRxTIRNCzNMhmucD1s+IScAypxxPiHu395REe3tmRJ8pjvMFh3StKrhEKG1JaJoYcaCByWrc
	  Wbidy8riO/15nQ/j54aSvGv7KiWKUgSDThf+R2Qlh9GyStyBDwJ69J5EUczRix9efXcZKzhqp1
	  4YbVc/tcWaFthl+KxJi17h3pgCb48V7khg4lriV29nEHdg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-8v6p.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-8v6p.prod.antispam.mailspamprotection.com; s=arckey; t=1793291284;
	bh=zOojZt68/zZaw2L6iq+EX6j3FuHkpId/jG61pRsqZQI=;
	h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	  Subject:From:DKIM-Signature:DKIM-Signature;
	b=yrheYucypZcftpSJM9RTQt9ZUuHKZhaLe5BZxFUzCvf20fRF0I+wzjpLai6REULhhu4i7uh5GY
	  E4L2AH7R7bVjxMS9knxw97VA+Q7cgpdnsz356J94wCj60I7iS2J0Fnus7DBHk3wS1c/CLAVvMx
	  Mmvhml0/AWCuAUnlsoHVAN7crA556qepOQjavHP/b/eUcYwzdATyy9A6fOjb/VLNhkPl8MwAlx
	  FTGBA+fAqh40wXs5wSdXxKOxnFZXnlLiWiUEzFnlEY1aPM/NTM9R53X3vHxGHqQkhlrUWynhvI
	  jOmEV76LEyOHvctjDQ1PGqPxvvtCusUDM+N5LCdXsfXROw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
	Subject:From:Reply-To:List-Unsubscribe;
	bh=1thP92GAsnoEoj5OjQ6bprJ+2HRz52udeXPZhEvDBmc=; b=RvnlXCS7dndcsZ4otBSc/BBSrW
	qeZA/8jHkgwoXDU1aYugVhxn5yZ2coyNLT1bkVMbKPcKyC/2Ej3oAXratmcAj9Z9pOGhdrzNlIWrl
	LF4oYI/woZayBn1PF2xs5p5b04njXSlFXSR+JoU7VbgBUtitz/q7/AcaW1uDvxcBCTzE=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-8v6p.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xMSyr-0000000A9VQ-0bf8;
	Thu, 29 Oct 2026 16:27:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=1thP92GAsnoEoj5OjQ6bprJ+2HRz52udeXPZhEvDBmc=; b=jNg1FV/7kFgQ9c90Kwd5XHLVH4
	WOrJofPT7y9MAO1nKx/bNYTqbKO4gFNhnnaya+/L+AWEHDSZ4LM/O0I72EGzH1CG4elMy8RaMAAMj
	rqJsWAz19tqCAJNf8rrAsFZSZDAxcW8hBB4VRAmVIzmY++Rom6P/vGq7atLAFkR1qrHM=;
Received: from [87.16.26.129] (port=60224 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xMSyl-00000000LSm-1VkP;
	Thu, 29 Oct 2026 16:27:51 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH v3 0/2] Add devicetree bindings and maintainer for
 spi-virtio
Date: Thu, 29 Oct 2026 17:27:42 +0100
Message-Id: <20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WPyw6CMBBFf4V0bU0fCKkr/8O4aGGAMaSQtjYaw
 r/bYjQudHmTO+fcWYgHh+DJsViIg4geJ5uC3BWkGbTtgWKbMhFMVEyJmvoZaUQXcKIGbYu297Q
 rQR6YETVTmqTL2UGH9416vryyv5krNCGjcmNAHyb32LSR597boH4aIqeMVpoBdFJwaeQp6nHUe
 wwkC6L4IDj7MzKKjKjTD0aURrXlF2Jd1yd9lhEVCgEAAA==
X-Change-ID: 20260927-spi-virtio-bindings-f4e350b2709a
To: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Haixu Cui <quic_haixcui@quicinc.com>, 
 Jason Wang <jasowangio@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Francesco Valla <francesco@valla.it>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2630; i=francesco@valla.it;
 h=from:subject:message-id; bh=zOojZt68/zZaw2L6iq+EX6j3FuHkpId/jG61pRsqZQI=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmPSxgCimcr8HAz/Kh8EM4pVXhz66wVrqbP3qt8fhJ5e
 krqlN+TO0pZGMS4GGTFFFlC1t24t2eu+be0DYyPYOawMoEMYeDiFICJvHvMyNCS2npRwGg9179P
 QZq7XpYG3l4inm/1xc97Un6d1JRvOqYMf0WvCwUK7drguUq5TErhpGHJ1WNzvl3i+uxYdVqr/Za
 6Hg8A
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
X-SGantispam-id: 670b91eee72ec329c7f516dd81e54542
X-AntiAbuse: ID - 670b91eee72ec329c7f516dd81e54542
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xMSyr-0000000A9VQ-0bf8-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-8v6p.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

When a virtio transport exposes a non-discoverable bus, the devicetree
can be used to declare its child devices (if any) and/or other
properties. To allow for that, the virtio framework searches for a node
with a suitable compatible in virtio_device_of_init() when registering
a device [1]; such compatible takes the form "virtio,deviceXX", where
XX is the hexadecimal representation of the virtio device ID as defined
by the virtio specification.

This patchset thus does not introduce a new functionality, but allows
proper validation of nodes tied to spi-virtio devices, aligning SPI to
what is already being done for e.g. I2C and GPIO virtio devices.
It was sent initially as part of a different patchset [2], but since it
complements a functionality that is de-facto already there and is useful
beyond that specific use case it was sent separately (also following the
maintainer's feedback there to separate it from remoteproc-specific
changes).

This was tested both with virtio-mmio using qemu-system-aarch64 and with
remoteproc-virtio with a Zephyr backend (with relevant remoteproc-virtio
parts still not upstreamed - see [2]).

On top of that, I added myself as maintainer for the spi-virtio driver,
since the former maintainer's e-mail bounces back and its owner (Haixu
Cui) did not update it after changing employment.

Thank you!

Regards,
Francesco

[1] https://elixir.bootlin.com/linux/v7.2.8/source/drivers/virtio/virtio.c#L488
[2] https://lore.kernel.org/linux-remoteproc/20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it/

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Changes in v3:
- Add Francesco as Maintainer of the spi-virtio driver (instead of
  Reviewer) as replacement for the former maintainer (Haixu Cui).
- Link to v2: https://patch.msgid.link/20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it

Changes in v2:
- Expanded the commit message to better explain the functionality and
  the chosen compatible.
- Redundant pieces dropped from bindings.
- Link to v1: https://patch.msgid.link/20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it

---
Francesco Valla (2):
      dt-bindings: spi: add spi-virtio
      MAINTAINERS: replace spi-virtio maintainer

 .../devicetree/bindings/spi/spi-virtio.yaml        | 46 ++++++++++++++++++++++
 MAINTAINERS                                        |  3 +-
 2 files changed, 48 insertions(+), 1 deletion(-)
---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20260927-spi-virtio-bindings-f4e350b2709a

Best regards,
--  
Francesco Valla <francesco@valla.it>

