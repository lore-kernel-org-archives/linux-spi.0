From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [RESEND][PATCH 3/4] ARM: davinci: Set proper SPI prescale limit
 value
Date: Fri, 24 Jul 2015 17:20:25 +0530
Message-ID: <55B22681.3060000@ti.com>
References: <1437568344-18889-1-git-send-email-fcooper@ti.com> <1437568344-18889-4-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <khilman@deeprootsystems.com>,
	<linux@arm.linux.org.uk>, <galak@codeaurora.org>,
	<ijc+devicetree@hellion.org.uk>, <mark.rutland@arm.com>,
	<pawel.moll@arm.com>, <robh+dt@kernel.org>,
	<linux-arm-kernel@list.infradead.org>
To: Franklin S Cooper Jr <fcooper@ti.com>, <broonie@kernel.org>,
	<ssantosh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437568344-18889-4-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 22 July 2015 06:02 PM, Franklin S Cooper Jr wrote:
> SPI Davinci driver has been updated to allow SOCs to specify their minimum
> prescale value. Update the various SOCs board files that use this driver with
> their proper prescaler limit.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

in case Mark is okay to take it through his tree. It does not clash with
anything else I have for mach-davinci.

Thanks,
Sekhar
